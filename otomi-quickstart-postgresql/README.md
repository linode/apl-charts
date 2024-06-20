# Otomi quick start for creating a PostgreSQL cluster

The `otomi-quickstart-postgresql` Helm chart can be used to create a cloudnativepg PostgreSQL `Cluster`. Optionally a Prometheus `PodMonitor` and a `Configmap` (for adding a postgresql dashboard to Grafana) can be created.

## About Otomi quick starts

The Catalog is a library of curated Helm charts to create Kubernetes resources. By default the Catalog contains a set of Helm charts provided by Otomi to get started quickly, but they can also be modified depending on your requirements or be removed from the Catalog. The contents of the Catalog and the RBAC configuration (which Team can use which Helm chart) are managed by the platform administrator.

## How to use this quick start

1. Go to the `values` tab and fill in a name for your PostgreSQL Cluster
2. Optional: Change other parameter values as required
3. Use a `secretKeyRef` to configure the environment variables for the container:

```yaml
- name: DB_NAME
  name: <clustername>
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: <clustername>-app
      key: password
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: <clustername>-app
      key: username
```

Note that there is also a superuser secret `<clustername>-superuser` with the same keys, containing the superuser credentials. However, this is only needed for advanced functionality such as creating and removing additional databases. The `-app` credentials provide full access to the default database with the same name as the cluster, including DDL and grant operations.

## Parameters

### Otomi controlled parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `fullnameOverride` | Used by Otomi to set the name of all resources including the name name of the database                       | `""`            |

### Optional parameters

| Name             | Description                                                                                                    | Value           |
|------------------|----------------------------------------------------------------------------------------------------------------|-----------------|
| `instances` | Number of instances required in the cluster                                                                         | `2`             |
| `primaryUpdateStrategy` | Rolling update strategy. Select between unsupervised or supervised                                      | `unsupervised`  |
| `storage.storageClass` | StorageClass to use for database data                                                                    | `""`            |
| `storage.size` | Size of the storage. Required if not already specified in the PVC template                                       | `1Gi`           |
| `walStorage.storageClass` | Configuration of the storage for PostgreSQL WAL (Write-Ahead Log)                                     | `""`            |
| `walStorage.size` | Size of the WAL storage. Required if not already specified in the PVC template                                | `1Gi`           |
| `monitoring` | Create a PodMonitor and metrics will be scraped by the team Prometheus                                             | `false`         |
| `dashboard` | Create a ConfigMap with a Grafana dashboard for CloudNativePG                                                       | `false`         |
| `byoSuperUserSecret.enabled` | Bring your own secret for super admin credentials                                                  | `false`         |
| `byoSuperUserSecret.name` | Name of the secret containing the super admin credentials                                             | `""`            |
| `bootstrap.initdb.dataChecksums` | Whether the -k option should be passed to initdb enabling checksums on data pages              | `false`         |
| `resources` | Container resource requests and limits                                                                              | `{}`            |

