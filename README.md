# Akamai App Platform curated Helm charts

This repository contains a set of curated Helm charts that are available in the Akamai App Platform Catalog.

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

## redis-cluster

The `redis-cluster` Helm chart can be used to create a Redis master-replica cluster.

## rabbitmq-cluster

The `rabbitmq-cluster` Helm chart can be used to create a `RabbitmqCluster`, `queues` and `Policy`s.

Using the `rabbitmq-cluster` Helm chart requires `RabbitMQ` to be enabled by a platform administrator.

