# Otomi quick start for creating a Knative workload

The `otomi-quickstart-knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## About Otomi quick starts

The Developer Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Otomi to get started quickly. The Helm charts provided by Otomi can be used out-of-the-box, but can also be modified depending on your requirements or be removed from the catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the administrator of the platform.

## How to use this quick start

1. Create a Build and copy the image repository name of the build (see list of builds)
2. Go to the `values` tab en fill in a name for your workload
3. Add the image repository name of the build to the `image.repository` parameter value
4. Add the tag of the build to the `image.tag` parameter value
5. Optional: Change other parameter values as required

## Prerequisites

To use this Helm chart:

- Make sure the administrator has enabled `Knative`

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
| `livenessProbe` | Container liveness probe                                                                                        | `path=/` `port=http1` |
| `readinessProbe` | Container readiness probe                                                                                      | `{}`            |
| `containerSecurityContext` | Container security context                                                                           | `{}`            |
| `containerPorts` | Configures the container ports to listens on                                                                   | `8080`          |
| `resources.limits.cpu` | Container cpu limits                                                                                     | `300m`          |
| `resources.limits.memory` | Container memory limits                                                                               | `128Mi`         |
| `resources.requests.cpu` | Container cpu requests                                                                                 | `100m`          |
| `resources.requests.memory` | Container memory request                                                                            | `32Mi`          |
| `nodeSelector` | Node labels for pod assignment                                                                                   | `{}`            |
| `tolerations` | Tolerations for pod assignment |                                                                                  | `[]`            |
| `affinity` | Affinity for pod assignment |                                                                                        | `{}`            |
| `secrets` | Set secrets as container environment variables using a secretRef (secret reference)                                   | `[]`            |
| `command` | Override default container commands                                                                                   | `[]`            |
| `args` | Override default container arguments                                                                                     | `[]`            |
| `volumeMounts` | A list of volume mounts to be added to the container                                                             | `[]`            |
| `volumes` | A list of volumes to be added to the pod                                                                              | `[]`            |
| `replicaCount` | The number of replicas to deploy                                                                                 | `2`             |
| `autoscaling.minReplicas` | The minimal replica's (autoscaling.knative.dev/min-scale: "minReplicas")                              | `0`             |
| `autoscaling.maxReplicas` | The minimal replica's (autoscaling.knative.dev/min-scale: "maxReplicas")                              | `10`            |
| `serviceMonitor.create` | Set to true to create a ServiceMonitor for the Team Prometheus                                          | `false`         | 
| `serviceMonitor.endpoints` | Configure the endpoints for the service monitor                                                      | `[]`            |
| `ingress` | Configure service exposure                                                                                            | `public`            |
