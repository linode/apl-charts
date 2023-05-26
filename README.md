# Introduction

This repository contains Helm charts used by Otomi workloads. When ArgoCD in Otomi is enabled, users can create 3 types of workloads:

1. Regular application
2. Function as a Service
3. Bring your own Helm chart

The first 2 workload types (a `Regular` application and a `Function as a Service`) use the Helm charts in this repository. Some chart values can be configured in Otomi Console. For advanced configuration options, see the values.yaml of the chart.

## Testing

-  `deploy`
   ```
   cd deployment
   helm template -f minimal-values.yaml . # test with minimal options
   helm template -f full-values.yaml . # test with all options
   ```
-  `ksvc`
   ```
   cd ksvc
   helm template -f minimal-values.yaml . # test with minimal options
   helm template -f full-values.yaml . # test with all options
   ```
