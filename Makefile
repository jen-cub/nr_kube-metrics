ifeq ($(strip $(NEWRELIC_INFRA)),)
$(error NEWRELIC_INFRA key is not set)
endif

DEV_CLUSTER ?= testrc
DEV_PROJECT ?= jendevops1
DEV_ZONE ?= australia-southeast1-c



RELEASE := p4-newrelic
NAMESPACE	:= kube-system

CHART_NAME := newrelic/nri-bundle
CHART_VERSION	:= 1.7.2

.DEFAULT_GOAL := status

lint:
	@find . -type f -name '*.yml' | xargs yamllint
	@find . -type f -name '*.yaml' | xargs yamllint

init:
		helm init --client-only
		helm repo add newrelic https://helm-charts.newrelic.com
		helm repo update

status:
	helm status $(RELEASE)

dev: lint init
ifndef CI
	$(error Please commit and push, this is intended to be run in a CI environment)
endif
	gcloud config set project $(DEV_PROJECT)
	gcloud container clusters get-credentials $(DEV_CLUSTER) --zone $(DEV_ZONE) --project $(DEV_PROJECT)
	helm upgrade --install --force --wait $(RELEASE) \
		--namespace $(NAMESPACE) \
		--set global.licenseKey=$(NEWRELIC_INFRA) \
		--set global.cluster=$(DEV_CLUSTER) \
		--values values.yaml \
		--version $(CHART_VERSION) \
		$(CHART_NAME)
	$(MAKE) history

prod: lint init
ifndef CI
	$(error Please commit and push, this is intended to be run in a CI environment)
endif
	gcloud config set project $(PROD_PROJECT)
	gcloud container clusters get-credentials $(PROD_PROJECT) --zone $(PROD_ZONE) --project $(PROD_PROJECT)
	helm upgrade --install --force --wait $(RELEASE) \
		--namespace $(NAMESPACE) \
		--set global.licenseKey=$(NEWRELIC_INFRA) \
		--set global.cluster=$(PROD_CLUSTER) \
		--values values.yaml \
		--version $(CHART_VERSION) \
		$(CHART_NAME)
	$(MAKE) history

destroy:
	helm delete $(RELEASE) --purge


history:
	helm history $(RELEASE) --max=5
