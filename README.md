This repository contains a set of Helm charts that will be made available as quick starts to all Teams in the Otomi developer catalog.

The following charts are available:

## otomi-quickstart-k8s-deployment

The `otomi-quickstart-k8s-deployment` chart can be used to create a Kubernetes `Deployment`. Optionally a `HPA` and a `Service Monitor` can be created.

## otomi-quickstart-k8s-deployment-otel

The `otomi-quickstart-k8s-deployment-otel` chart can be used to create a Kubernetes `Deployment` with Open Telemetry `instrumentation`.

## otomi-quickstart-k8s-deployments-canary

The `otomi-quickstart-k8s-deployments-canary` chart can be used to create 2 Kubernetes `Deployments` to deploy 2 versions of an image and use the `Traffic Control` feature in Otomi to do canary or blue/green deployments.

## otomi-quickstart-knative-service

The `otomi-quickstart-knative-service` chart can be used to create a Knative service with a scale to zero configuration.
