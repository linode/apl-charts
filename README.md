# Introduction

This repository contains Helm charts used by Otomi workloads. When ArgoCD in Otomi is enabled, users can create 3 types of workloads:

<p align="right"><img src="https://github.com/redkubes/otomi-charts/blob/main/img/otomi-workloads.png/?raw=true" width="100%" align="right" alt="Otomi workloads"></p>


The first 2 workload types (a `Regular` application and a `Function as a Service`) use the Helm charts in this repository. Some chart values can be configured in Otomi Console. Use the following values for more advanced and custom configurations:

# Values

## Generic (values used by the `deployment` and `ksvc` charts)

| Key | Type | Default | Notes |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| image.repository | string | `""` |  |
| image.tag | string | `""` |  |
| image.pullPolicy | string | `IfNotPresent` |  |
| serviceAccount.create | boolean | `false` | By default the SA `sa-team-<team-name>` is used. Set to false to create a dedicated SA for the workload |
| serviceAccount.annotations | object | `{}` | Use to add custom annotations to the SA |
| serviceAccount.imagePullSecrets | list | `[]` | Use to add custom pull secrets to the SA |
| podAnnotations | object | `{}` |  |
| securityContext | object | `{}` | Read more about Pod Security Context [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)  |
| livenessProbe | object | `{}` |  |
| containerSecurityContext | object | `{}` | Read more about Pod Security Context [here](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container)  |
| env | list | `[]` |  |
| secrets | list | `[]` |  |
| command | list | `[]` |  |
| args | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| affinity | object | `{}` |  |
| labels | object | `{}` |  |
| files | object | `{}` |  |
| secretMounts | object | `{}` |  |
| serviceMonitor.create | boolean| `false` | Set to true to create a service monitor for custom metrics |
| serviceMonitor.endpoints | list | `[]` |  |

## Chart `deployment` specific values

| Key | Type | Default | Notes |
|-----|------|---------|-------------|
| replicaCount | integer | `1` |  |
| resources | object | `{}` |  |
| readinessProbe | object | `{}` |  |
| servicePorts | list | see [values.yaml](/deployment/values.yaml) | One service port is always configured. Adjust the default service port, or add more service ports |
| containerPorts | list | `[]` | Configure the container ports in Otomi console and optionally add more ports |
| autoscaling.enabled | boolean | `false` |  |
| autoscaling.minReplica | integer | `1` |  |
| autoscaling.maxReplicas | integer | `10` |  |
| autoscaling.targetCPUUtilizationPercentage | integer | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | integer | `80` |  |

## Chart `ksvc` specific values

| Key | Type | Default | Notes |
|-----|------|---------|-------------|
| readinessProbe.httpGet.path | string | `/` |  |
| readinessProbe.httpGet.port | string | `http` |  |
| readinessProbe.successThreshold | integer | `1` |  |
| resources.limits.cpu | string | `200m` | Adjust if needed |
| resources.limits.memory | string | `64Mi` | Adjust if needed |
| resources.requests.cpu | string | `50m` | Adjust if needed |
| resources.requests.memory | string | `32Mi` | Adjust if needed |
| containerPorts | list | `[]` | Configure the container ports in Otomi console and optionally add more ports (but do not use `http`) |
| ingress | string | `public` | Set to `cluster` to add `serving.deployment.dev/visibility: cluster-local` label  |
| scaleToZero | boolean | `false` | Configure scale to zero in Otomi console |

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
