# Akamai App Platform curated Helm charts

This repository contains a set of curated Helm charts that are available in the Akamai App Platform Catalog.

## CI runtime

The Helm chart test and release workflows use Node.js 24-based versions of
`actions/checkout` and `azure/setup-helm`. GitHub-hosted runners manage the bundled
Node.js patch version used by these actions; a package `engines.node` constraint
or `actions/setup-node` does not control that runtime. These workflows therefore
do not enforce the patch range `>=24.22.1 <25`.

## k8s-deployment

The `k8s-deployment` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## k8s-deployment-otel

The `k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount` and an `Instrumentation` resource. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## k8s-deployments-canary

The `k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount` resource. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## knative-service

The `knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## postgresql-cluster

The `postgresql-cluster` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## pgvector-cluster

The `postgresql-cluster` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster` with the pgvector extension for AI/ML vector workloads.

## redis-cluster

The `redis-cluster` Helm chart can be used to create a Redis master-replica cluster.

## rabbitmq-cluster

The `rabbitmq-cluster` Helm chart can be used to create a `RabbitmqCluster`, `queues` and `Policy`s.

Using the `rabbitmq-cluster` Helm chart requires `RabbitMQ` to be enabled by a platform administrator.
