# Otomi quick start for creating a PostgreSQL cluster

The `otomi-quickstart-postgresql` Helm chart can be used to create a cloudnativepg Postgressql `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## About Otomi quick starts

The Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Otomi to get started quickly, but they can also be modified depending on your requirements or be removed from the Catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the platform administrator.

## How to use this quick start

1. Go to the `values` tab and fill in a name for your PostgreSQL Cluster
2. Optional: Change other parameter values as required
3. Use a `secretKeyRef` to configure the environment variables for the container:

```yaml
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: clustername-superuser
      key: password
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: clustername-superuser
      key: username
```
4. Add more environment variables to connect to the database. All the database settings can be found in the `<clustername>-superuser` secret. Open a Shell and run `k9s`. Then see your secrets `:secrets`, select the `<clustername>-superuser` secret and type `x`


## Parameters

### Otomi controlled parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `fullnameOverride` | Used by Otomi to set the name of all resources including the name name of the database                                   | `""`            |

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
| `autoscaling.minReplicas` | The minimal replica's (autoscaling.knative.dev/min-scale: "minReplicas")                              | `0`             |
| `autoscaling.maxReplicas` | The minimal replica's (autoscaling.knative.dev/min-scale: "maxReplicas")                              | `10`            |
| `serviceMonitor.create` | Set to true to create a ServiceMonitor for the Team Prometheus                                          | `false`         | 
| `serviceMonitor.endpoints` | Configure the endpoints for the service monitor                                                      | `[]`            |
| `ingress` | Configure service exposure                                                                                            | `public`        |
