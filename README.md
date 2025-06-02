# Application Platform for LKE Catalog curated Helm charts

This repository contains a set of curated Helm charts that are available in the Akamai App Platform Catalog.

## Team Helm charts

The following Helm charts are added to the Catalog and are available for Teams:

### Quick start for creating a K8s Deployment with Open Telemetry Instrumentation

The `k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

### Quick start for creating a Knative Service

The `knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

### Quick start for creating a PostgreSQL cluster

The `postgresql-cluster` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

### Quick start for creating a Redis master-replica cluster

The `redis-cluster` Helm chart can be used to create a Redis master-replica cluster.

### Quick start for creating a RabbitMQ cluster

The `rabbitmq-cluster` Helm chart can be used to create a RabbitMQ `cluster` with `queues` and `policies`.

## Platform Helm charts

The following Helm charts are added to the Catalog and are only available for `platform-admins` using the `team-admin`:

### KubeFlow Pipelines Cluster Resources

The `kfp-cluster-resources` Helm chart can be used to install the KubeFlow Pipelines CRDs.

### Kubeflow Pipelines

The `kubeflow-pipelines` Helm chart can be used to install KubeFlow Pipelines in any Team.

