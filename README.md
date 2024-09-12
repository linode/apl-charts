# APL Catalog quick starts

This repository contains a set of Helm charts that will be made available as quick starts to all Teams in the APL Catalog.

The following Helm charts are added to the Catalog:

## quickstart-k8s-deployment

The `quickstart-k8s-deployment` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## quickstart-k8s-deployment-otel

The `quickstart-k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## quickstart-k8s-deployments-canary

The `quickstart-k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## quickstart-knative-service

The `quickstart-knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## APL quick start for creating a PostgreSQL cluster

The `quickstart-postgresql` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## APL quick start for creating a Redis master-replica cluster

The `quickstart-redis` Helm chart can be used to create a Redis master-replica cluster.

## APL quick start for creating a RabbitMQ cluster

The `quickstart-rabbitmq` Helm chart can be used to create a RabbitMQ `cluster` with `queues` and `policies`.