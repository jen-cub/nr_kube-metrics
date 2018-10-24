# Planet-4 Helm chart NewRelic Infrastructure deployment

## Ingredients:
-   helm client [https://docs.helm.sh/using_helm/](https://docs.helm.sh/using_helm/)
-   an accessible Kubernetes cluster running Helm Tiller

## Preparation:

```
LICENSE_KEY=<newrelic-licensekey> make dev
# or
LICENSE_KEY=<newrelic-licensekey> make prod
```

## Dining:

Visit [https://infrastructure.newrelic.com](https://infrastructure.newrelic.com) to view server data

## Cleaning up:

```
make clean
```
