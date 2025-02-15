# Quick start for creating a Knative service

The `knative-service` Helm chart can be used to create a Knative `Service` (to deploy a single image), a `Service` and a  `ServiceAccount`. Optionally a Prometheus `ServiceMonitor` can be created.

## About the quick starts

The Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Application Platform for LKE to get started quickly, but they can also be modified depending on your requirements or be removed from the Catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the platform administrator.

## Using public vs. private registries

To enable Knative to pull images from public repositories, the `harbor-pullsecret` is not added to the `serviceAccount`. Add the `harbor-pullsecret` to pull images from the Team's private image repository.

## How to use this quick start

1. Create a Build and copy the image repository name of the build (see list of builds)
2. Go to the `values` tab and fill in a name for your Workload
3. Add the image repository name of the Build to the `image.repository` parameter value
4. Add the tag of the Build to the `image.tag` parameter value
5. Add the `harbor-pullsecret` pull secret to the service account
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

### Application Platform for LKE (APL) controlled parameters

| Name               | Description                                                                                                    | Value           |
|--------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `fullnameOverride` | Used by Application Platform for LKE to set the name of all resources using the workload name                  | `""`            |

### Optional parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `pullPolicy` | Image pull policy. Choose between `always`, `never` or (default) `IfNotPresent`                                    | `IfNotPresent`  |
| `env` | Environment variables for containers                                                                                      | `[]`            |
| `annotations` | Additional Annotations. See https://knative.dev/docs/serving/autoscaling/ for all auto scaling annotations        | `{}`            |
| `podLabels` | Additional labels for pods                                                                                          | `{}`            |
| `commonLabels` | Additional labels for all resources                                                                              | `{}`            |
| `serviceAccount.annotations` | Annotations for the service account                                                                | `{}`            |
| `serviceAccount.imagePullSecrets` | Image pull secrets. Configure when using the Team local Harbor repository                     | `[]`            |
| `livenessProbe` | Container liveness probe                                                                                        | `path=/` `port=http1` |
| `readinessProbe` | Container readiness probe                                                                                      | `{}`            |
| `containerSecurityContext` | Container security context                                                                           | `{}`            |
| `containerPorts` | Configures the container ports to listens on                                                                   | `8080`          |
| `resources` | Container resource requests and limits                                                                              | `{}`            |
| `nodeSelector` | Node labels for pod assignment                                                                                   | `{}`            |
| `tolerations` | Tolerations for pod assignment                                                                                    | `[]`            |
| `affinity` | Affinity for pod assignment                                                                                          | `{}`            |
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
| `ingress` | Configure service exposure                                                                                            | `public`        |
