ifeq ($(strip $(NEWRELIC_LICENSE_KEY)),)
$(error NEWRELIC_LICENSE_KEY is not set)
endif

NEWRELIC_CHART_VERSION	?= 0.6.0
NEWRELIC_NAMESPACE			?= kube-system
NEWRELIC_RELEASE 				?= p4-newrelic

DEV_CLUSTER=p4-development
PROD_CLUSTER=planet4-production

.DEFAULT_GOAL := status

.PHONY: clean deploy status

clean:
	helm delete $(NEWRELIC_RELEASE) --purge

status:
	helm status $(NEWRELIC_RELEASE)

dev:
	@helm upgrade --install $(NEWRELIC_RELEASE) stable/newrelic-infrastructure \
		--namespace $(NEWRELIC_NAMESPACE) \
		--set cluster=$(DEV_CLUSTER) \
		--set licenseKey=$(NEWRELIC_LICENSE_KEY) \
		--values resources.yaml \
		--version $(NEWRELIC_CHART_VERSION)

prod:
	@helm upgrade --install $(NEWRELIC_RELEASE) stable/newrelic-infrastructure \
		--namespace $(NEWRELIC_NAMESPACE) \
		--set cluster=$(PROD_CLUSTER) \
		--set licenseKey=$(NEWRELIC_LICENSE_KEY) \
		--values resources.yaml \
		--version $(NEWRELIC_CHART_VERSION)
