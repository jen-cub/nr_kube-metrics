# Planet-4 Helm chart NewRelic Infrastructure deployment

## Ingredients:
-   helm client [https://docs.helm.sh/using_helm/](https://docs.helm.sh/using_helm/)
-   an accessible Kubernetes cluster running Helm Tiller
-   NewRelic nri-bundle chart https://artifacthub.io/packages/helm/newrelic/nri-bundle
      configured to include infrastructure and kube-state-metrics chart
-   NewRelic LicenseKey


## Preparation:

As we do not have a license for Dev, all changes only go to Prod.

- Create branch to make changes and commit and push to for circleci job to run
- Create pull request to master, get approved and then merge for production deployment

## Dining:

Visit [https://infrastructure.newrelic.com](https://infrastructure.newrelic.com) to view server data

## Delete the deployment:

```
make destroy
```
