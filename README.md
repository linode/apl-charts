# APL Catalog quick starts

This repository contains a set of Helm charts that will be made available as quick starts to all Teams in the APL Catalog.

The following Helm charts are added to the Catalog:

## apl-quickstart-k8s-deployment

The `apl-quickstart-k8s-deployment` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## apl-quickstart-k8s-deployment-otel

The `apl-quickstart-k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## apl-quickstart-k8s-deployments-canary

The `apl-quickstart-k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## apl-quickstart-knative-service

The `apl-quickstart-knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## APL quick start for creating a PostgreSQL cluster

The `apl-quickstart-postgresql` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## APL quick start for creating a Redis master-replica cluster

The `apl-quickstart-redis` Helm chart can be used to create a Redis master-replica cluster.

## APL quick start for creating a RabbitMQ cluster

The `apl-quickstart-rabbitmq` Helm chart can be used to create a RabbitMQ `cluster` with `queues` and `policies`.