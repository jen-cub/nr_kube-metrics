ifeq ($(strip $(NEWRELIC_LICENSE)),)
$(error NEWRELIC_LICENSE key is not set)
endif

DEV_CLUSTER ?= p4-development
DEV_PROJECT ?= planet-4-151612
DEV_ZONE ?= us-central1-a

PROD_CLUSTER ?= planet4-production
PROD_PROJECT ?= planet4-production
PROD_ZONE ?= us-central1-a

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
	@helm upgrade --install $(RELEASE) $(CHART_NAME) \
		--namespace $(NAMESPACE) \
		--set cluster=$(DEV_CLUSTER) \
		--set licenseKey=$(NEWRELIC_LICENSE) \
		--values values.yaml \
		--version $(CHART_VERSION)
		--set infrastructure.enabled=true
		--set prometheus.enabled=false
		--set webhook.enabled=false
		--set ksm.enabled=true
		--set kubeEvents.enabled=false
		--set logging.enabled=false

prod: lint init
	ifndef CI
		$(error Please commit and push, this is intended to be run in a CI environment)
	endif
	@helm upgrade --install $(RELEASE) $(CHART_NAME) \
		--namespace $(NAMESPACE) \
		--set cluster=$(PROD_CLUSTER) \
		--set licenseKey=$(NEWRELIC_LICENSE) \
		--values values.yaml \
		--version $(CHART_VERSION)
		--set infrastructure.enabled=true
		--set prometheus.enabled=false
		--set webhook.enabled=false
		--set ksm.enabled=true
		--set kubeEvents.enabled=false
		--set logging.enabled=false

destroy:
	helm delete $(RELEASE) --purge


history:
	helm history $(RELEASE) --max=5
