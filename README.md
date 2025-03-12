# Application Platform for LKE Catalog quick starts

This repository contains a set of curated Helm charts that will be made available as quick starts in the Application Platform for LKE Catalog.

# Team Helm charts

The following Helm charts are added to the Catalog and are available for Teams:

## Quick start for a regular K8s deployment

The `k8s-deployment` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## Quick start for creating a K8s Deployment with Open Telemetry Instrumentation

The `k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## Quick start for creating 2 K8s deployments with one service for canary and blue/green

The `k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## Quick start for creating a Knative Service

The `knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## Quick start for creating a PostgreSQL cluster

The `postgresql-cluster` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## Quick start for creating a Redis master-replica cluster

The `redis-cluster` Helm chart can be used to create a Redis master-replica cluster.

## Quick start for creating a RabbitMQ cluster

The `rabbitmq-cluster` Helm chart can be used to create a RabbitMQ `cluster` with `queues` and `policies`.

## Quickstart for creating a Spin App

The `spin-app` Helm chart can be used to create a `SpinApp`. Using this chart requires the following Helm charts to be installed by a user with the `platform-admin` role:

- [Kwasm Operator](https://github.com/KWasm/kwasm-operator/blob/kwasm-operator-chart-0.2.3/charts/kwasm-operator/Chart.yaml) This chart needs to be added to the Catalog first.
- `spin-operator`
- `spin-shim-executor`

# Platform Helm charts

The following Helm charts are added to the Catalog and are available for `platform-admins`:

## Spin Operator

Using this chart requires the following Helm charts to be installed by a user with the `platform-admin` role:

- [Kwasm Operator](https://github.com/KWasm/kwasm-operator/blob/kwasm-operator-chart-0.2.3/charts/kwasm-operator/Chart.yaml) This chart needs to be added to the Catalog first.

## Spin Shim Executor

The `spin-shim-executor` Helm chart needs to be installed every Team that wants to create Spin Apps.

## Kfp Cluster Resources

Install the `kfp-cluster-resources` first before installing `kubeflow-pipelines`.

## Kubeflow Pipelines

Using this chart requires the following Helm charts to be installed by a user with the `platform-admin` role:

- `kfp-cluster-resources`

