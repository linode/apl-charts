# Introduction

This repository contains Helm charts used by Otomi workloads. When ArgoCD in Otomi is enabled, users can create 3 types of workloads:

1. Regular application
2. Function as a Service
3. Bring your own Helm chart

The first 2 workload types (`Regular application` and `Function as a Service`) use the Helm charts in this repository. All chart values can be used as values for these 2 workloads. For advanced configuration options, see the values.yaml of the charts.
