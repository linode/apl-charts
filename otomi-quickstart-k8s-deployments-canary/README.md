# Otomi quick start for creating a workload with Traffic control

The `otomi-quickstart-k8s-deployments-canary` Helm chart can be used to create 2 Kubernetes `Deployments` (to deploy 2 versions of an image), a `Service` and a `ServiceAccount`. Optionally a `HorizontalPodAutoscaler`, a Prometheus `ServiceMonitor` and a `Configmap` (for each version) can be created.

## About Otomi quick starts

The Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Otomi to get started quickly, but they can also be modified depending on your requirements or be removed from the Catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the platform administrator.

## How to use this quick start

1. Create a Build and copy the image repository name of the Build (see list of builds)
2. Go to the `values` tab and fill in a name for your Workload
3. Add the image repository name of the (blue) Build to the `versionOne.image.repository` parameter value
4. Add the image repository name of the (blue) Build to the `versionTwo.image.repository` parameter value
5. Add the tag of the (blue or canary) Build to the `versionOne.image.tag` parameter value
6. Add the tag of the (blue or canary) Build to the `versionTwo.image.tag` parameter value
7. Optional: Change other parameter values as required
8. Create a Service and configure Traffic control to split traffic between the two versions

## Parameters

### Required parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `versionOne.image.repository` | Image repository for the image to deploy                                                          | `""`            |
| `versionOne.image.tag` | Image tag for the image to deploy                                                                        | `""`            |
| `versionTwo.image.repository` | Image repository for the image to deploy                                                          | `""`            |
| `versionTwo.image.tag` | Image tag for the image to deploy                                                                        | `""`            |

### Otomi controlled parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `fullnameOverride` | Used by Otomi to set the name of all resources using the workload name                                       | `""`            |

### Optional parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `versionOne.pullPolicy` | Image pull policy. Choose between `always`, `never` or (default) `IfNotPresent`                         | `IfNotPresent`  |
| `versionOne.replicaCount` | The number of replicas to deploy                                                                      | `2`             |
| `versionOne.autoscaling.enabled` | Enable autoscaling for deployment                                                              | `false`         |
| `versionOne.autoscaling.minReplicas` | Minimum number of replicas to scale back                                                   | `2`             |
| `versionOne.autoscaling.maxReplicas` | Maximum number of replicas to scale out                                                    | `10`            |
| `versionOne.autoscaling.targetCPU` | Target CPU utilization percentage                                                            | `80`            |
| `versionOne.autoscaling.targetMemory` | Target Memory utilization percentage                                                      | `80`            |
| `versionOne.configmap.create` | Set to true to create a configMap                                                                 | `false`         |
| `versionOne.configmap.mountPath` | Path to mount the configmap to                                                                 | `/etc/config`   |
| `versionOne.configmap.data` | Key value pairs stored in the configmap                                                             | `{}`            |
| `versionOne.secrets` | Set secrets as container environment variables using a secretRef (secret reference)                        | `[]`            |
| `versionOne.command` | Override default container commands                                                                        | `[]`            |
| `versionOne.args` | Override default container arguments                                                                          | `[]`            |
| `versionOne.env` | Environment variables for containers                                                                           | `[]`            |
| `versionTwo.pullPolicy` | Image pull policy. Choose between `always`, `never` or (default) `IfNotPresent`                         | `IfNotPresent`  |
| `versionTwo.replicaCount` | The number of replicas to deploy                                                                      | `2`             |
| `versionTwo.autoscaling.enabled` | Enable autoscaling for deployment                                                              | `false`         |
| `versionTwo.autoscaling.minReplicas` | Minimum number of replicas to scale back                                                   | `2`             |
| `versionTwo.autoscaling.maxReplicas` | Maximum number of replicas to scale out                                                    | `10`            |
| `versionTwo.autoscaling.targetCPU` | Target CPU utilization percentage                                                            | `80`            |
| `versionTwo.autoscaling.targetMemory` | Target Memory utilization percentage                                                      | `80`            |
| `versionTwo.configmap.create` | Set to true to create a configMap                                                                 | `false`         |
| `versionTwo.configmap.mountPath` | Path to mount the configmap to                                                                 | `/etc/config`   |
| `versionTwo.configmap.data` | Key value pairs stored in the configmap                                                             | `{}`            |
| `versionTwo.secrets` | Set secrets as container environment variables using a secretRef (secret reference)                        | `[]`            |
| `versionTwo.command` | Override default container commands                                                                        | `[]`            |
| `versionTwo.args` | Override default container arguments                                                                          | `[]`            |
| `versionTwo.env` | Environment variables for containers                                                                           | `[]`            |
| `containerPorts` | Configures the container ports to listens on.                                                                  | `8080`          |
| `servicePorts` | Configures the service ports to listens on. Exposes on port 80 by default, using the http port of the pod.       | `80`            |
| `resources` | Container resource requests and limits                                                                              | `{}`            |
| `nodeSelector` | Node labels for pod assignment                                                                                   | `{}`            |
| `tolerations` | Tolerations for pod assignment                                                                                    | `[]`            |
| `affinity` | Affinity for pod assignment                                                                                          | `{}`            |
| `volumeMounts` | A list of volume mounts to be added to the container                                                             | `[]`            |
| `volumes` | A list of volumes to be added to the pod                                                                              | `[]`            |
| `serviceMonitor.create` | Set to true to create a ServiceMonitor for the Team Prometheus                                          | `false`         | 
| `serviceMonitor.endpoints` | Configure the endpoints for the service monitor                                                      | `[]`            |
| `podAnnotations` | Additional Annotations for pods                                                                                | `{}`            |
| `podLabels` | Additional labels for pods                                                                                          | `{}`            |
| `commonLabels` | Additional labels for all resources                                                                              | `{}`            |
| `serviceAccount.annotations` | Annotations for the service account                                                                | `{}`            |
| `serviceAccount.imagePullSecrets` | Image pull secrets. Only add when using external registries (not the local harbor).           | `[]`            |
| `livenessProbe` | Container liveness probe                                                                                        | `{}`            |
| `readinessProbe` | Container readiness probe                                                                                      | `{}`            |
| `podSecurityContext` | Pod security Context                                                                                       | `{}`            |
| `containerSecurityContext` | Container security context                                                                           | `{}`            |