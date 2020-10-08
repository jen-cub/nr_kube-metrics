# Planet-4 Helm chart NewRelic Infrastructure deployment

## Ingredients:
-   helm client [https://docs.helm.sh/using_helm/](https://docs.helm.sh/using_helm/)
-   an accessible Kubernetes cluster running Helm Tiller
-   NewRelic nri-bundle chart https://artifacthub.io/packages/helm/newrelic/nri-bundle
      configured to include infrastructure and kube-state-metrics chart
-   NewRelic LicenseKey


## Preparation:

```bash
LICENSE_KEY=<newrelic-licensekey> make dev
# or
LICENSE_KEY=<newrelic-licensekey> make prod
```

## Dining:

Visit [https://infrastructure.newrelic.com](https://infrastructure.newrelic.com) to view server data

## Delete the deployment:

```
make destroy
```
