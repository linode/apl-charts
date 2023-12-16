# Otomi quick start for creating a regular workload with OpenTelemetry instrumentation

The `otomi-quickstart-k8s-deployment-otel` Helm chart can be used to create a Kubernetes `Deployment` (to deploy a single image), a `Service`, a `ServiceAccount`, an `OpenTelemetryCollector` and an `Instrumentation`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` can be created.

## About Otomi quick starts

The Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Otomi to get started quickly, but they can also be modified depending on your requirements or be removed from the Catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the platform administrator.

## How to use this quick start

1. Create a Build and copy the image repository name of the build (see list of builds)
2. Go to the `values` tab and fill in a name for your Workload
3. Add the image repository name of the Build to the `image.repository` parameter value
4. Add the tag of the Build to the `image.tag` parameter value
5. Add the `instrumentation.language`. See [here](https://opentelemetry.io/docs/instrumentation/) for all supported languages
5. Optional: Change other parameter values as required

## Prerequisites

To use this Helm chart:

- Make sure the administrator has enabled `OpenTelemetry` and `Tempo`
- Enable `Managed prometheus and alert manager` in the Team settings

## Parameters

### Required parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `image.repository` | Image repository for the image to deploy                                                                     | `""`            |
| `image.tag` | Image tag for the image to deploy                                                                                   | `""`            |

### Otomi controlled parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `fullnameOverride` | Used by Otomi to set the name of all resources using the workload name                                       | `""`            |

### Optional parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `pullPolicy` | Image pull policy. Choose between `always`, `never` or (default) `IfNotPresent`                                    | `IfNotPresent`  |
| `env` | Environment variables for containers                                                                                      | `[]`            |
| `podAnnotations` | Additional Annotations for pods                                                                                | `{}`            |
| `podLabels` | Additional labels for pods                                                                                          | `{}`            |
| `commonLabels` | Additional labels for all resources                                                                              | `{}`            |
| `serviceAccount.annotations` | Annotations for the service account                                                                | `{}`            |
| `serviceAccount.imagePullSecrets` | Image pull secrets. Only add when using external registries (not the local harbor).           | `[]`            |
| `livenessProbe` | Container liveness probe                                                                                        | `{}`            |
| `readinessProbe` | Container readiness probe                                                                                      | `{}`            |
| `podSecurityContext` | Pod security Context                                                                                       | `{}`            |
| `containerSecurityContext` | Container security context                                                                           | `{}`            |
| `containerPorts` | Configures the container ports to listens on.                                                                  | `8080`          |
| `servicePorts` | Configures the service ports to listens on. Exposes on port 80 by default, using the http port of the pod.       | `80`            |
| `resources` | Container cpu limits                                                                                                | `{}`            |
| `nodeSelector` | Node labels for pod assignment                                                                                   | `{}`            |
| `tolerations` | Tolerations for pod assignment                                                                                    | `[]`            |
| `affinity` | Affinity for pod assignment                                                                                          | `{}`            |
| `secrets` | Set secrets as container environment variables using a secretRef (secret reference)                                   | `[]`            |
| `command` | Override default container commands                                                                                   | `[]`            |
| `args` | Override default container arguments                                                                                     | `[]`            |
| `volumeMounts` | A list of volume mounts to be added to the container                                                             | `[]`            |
| `volumes` | A list of volumes to be added to the pod                                                                              | `[]`            |
| `replicaCount` | The number of replicas to deploy                                                                                 | `2`             |
| `autoscaling.enabled` | Enable autoscaling for deployment                                                                         | `false`         |
| `autoscaling.minReplicas` | Minimum number of replicas to scale back                                                              | `2`             |
| `autoscaling.maxReplicas` | Maximum number of replicas to scale out                                                               | `10`            |
| `autoscaling.targetCPU` | Target CPU utilization percentage                                                                       | `80`            |
| `autoscaling.targetMemory` | Target Memory utilization percentage                                                                 | `80`            |
| `serviceMonitor.create` | Set to true to create a ServiceMonitor for the Team Prometheus                                          | `false`         | 
| `serviceMonitor.endpoints` | Configure the endpoints for the service monitor                                                      | `[]`            |
| `configmap.create` | Set to true to create a configMap                                                                            | `false`         |
| `configmap.mountPath` | Path to mount the configmap to                                                                            | `/etc/config`   |
| `configmap.data` | Key value pairs stored in the configmap                                                                        | `{}`            |
| `instrumentation.enabled` | Enable instrumentation to create instrumentation resources and add required annotations               | `true`          |
| `instrumentation.language` | The Language libraries used for instrumentation                                                      | `java`          |
