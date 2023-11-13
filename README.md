# Introduction

This repository contains a set of Helm charts that will be made available to all Teams in the Otomi developer catalog.

The following charts are available:

## otomi-k8s-deployment

The `otomi-k8s-deployment` chart can be used to create a Kubernetes `Deployment`. Optionally a `HPA` and a `Service Monitor` can be created.

## otomi-k8s-deployment-with-otel

The `otomi-k8s-deployment-with-otel` chart can be used to create a Kubernetes `Deployment` with Open Telemetry `instrumentation`.

## otomi-k8s-deployment-with-canary

The `otomi-k8s-deployment-with-canary` chart can be used to create 2 Kubernetes `Deployments` to deploy 2 versions of an image and use the `Traffic Control` feature in Otomi to do canary or blue/green deployments.

## otomi-knative-service

The `otomi-knative-service` chart can be used to create a Knative service with a scale to zero configuration.
