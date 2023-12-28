# Otomi Catalog quick starts

This repository contains a set of Helm charts that will be made available as quick starts to all Teams in the Otomi Catalog.

The following charts are added to the Catalog:

## otomi-quickstart-k8s-deployment

The `otomi-quickstart-k8s-deployment` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## otomi-quickstart-k8s-deployment-otel

The `otomi-quickstart-k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## otomi-quickstart-k8s-deployments-canary

The `otomi-quickstart-k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## otomi-quickstart-knative-service

The `otomi-quickstart-knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## Otomi quick start for creating a PostgreSQL cluster

The `otomi-quickstart-postgresql` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## Otomi quick start for creating a Redis master-replica cluster

The `otomi-quickstart-redis` Helm chart can be used to create a Redis master-replica cluster.