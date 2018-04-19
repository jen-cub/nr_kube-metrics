LICENSE_KEY ?= replace-me

RELEASE 		?= p4-newrelic

NAMESPACE		?= kube-system

VERSION			?= 0.0.4

.DEFAULT_GOAL := deploy

.PHONY: clean deploy status

all: clean deploy

clean:
	helm delete $(RELEASE) --purge

status:
	helm status $(RELEASE)

deploy:
	helm upgrade --install $(RELEASE) stable/newrelic-infrastructure --version $(VERSION) --set licenseKey=$(LICENSE_KEY) --namespace $(NAMESPACE)
