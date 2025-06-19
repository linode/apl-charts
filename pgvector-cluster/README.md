# pgvector-cluster

App Platform quick start Helm chart for creating a PostgreSQL Cluster with pgvector extension support.

This chart creates a production-ready PostgreSQL cluster using CloudNativePG with the pgvector extension for AI/ML vector workloads.

## Prerequisites

- Kubernetes 1.21+
- CloudNativePG operator installed
- Helm 3.2.0+

## Installing the Chart

```bash
helm install my-pgvector-cluster apl-charts/pgvector-cluster
```

## Uninstalling the Chart

```bash
helm uninstall my-pgvector-cluster
```

## Configuration

The following table lists the configurable parameters of the pgvector-cluster chart and their default values.

| Parameter                        | Description | Default         |
|----------------------------------|-------------|-----------------|
| `fullnameOverride`               | Override the full name of the cluster | `""`            |
| `instances`                      | Number of PostgreSQL instances in the cluster | `2`             |
| `imageName`                      | Fully qualified image name for PostgreSQL container | `null`          |
| `imageCatalogRef`                | Reference to ClusterImageCatalog resource | See values.yaml |
| `primaryUpdateStrategy`          | Rolling update strategy (unsupervised/supervised) | `unsupervised`  |
| `storage.storageClass`           | StorageClass for database data | `""`            |
| `storage.size`                   | Size of database storage | `1Gi`           |
| `walStorage.storageClass`        | StorageClass for WAL storage | `""`            |
| `walStorage.size`                | Size of WAL storage | `1Gi`           |
| `postgresql.parameters`          | PostgreSQL configuration parameters | See values.yaml |
| `monitoring`                     | Enable Prometheus monitoring | `false`         |
| `dashboard`                      | Enable Grafana dashboard | `false`         |
| `databases`                      | List of databases with extensions to create | See values.yaml |
| `byoSuperUserSecret.enabled`     | Use custom superuser secret | `false`         |
| `byoSuperUserSecret.name`        | Name of superuser secret | `""`            |
| `bootstrap.initdb.dataChecksums` | Enable data checksums | `false`         |
| `resources`                      | Container resource requests and limits | See values.yaml |
| `apl.networkpolicies.create`     | Create network policies | `true`          |

## Key Features

- **pgvector Extension**: Pre-configured with pgvector extension for AI/ML vector workloads
- **Production-Ready**: 3-instance cluster with optimized PostgreSQL parameters for vector operations
- **Declarative Database Management**: Uses CloudNativePG Database CRD for extension lifecycle management
- **Vector-Optimized Configuration**: Tuned memory and parallel worker settings for vector operations
- **Monitoring Ready**: Optional Prometheus monitoring and Grafana dashboards
- **High Availability**: Multi-instance setup with automatic failover
- **Backup Support**: Ready for barman backup configuration

## Vector Database Configuration

The chart creates databases with pgvector extensions using **Database CRDs** with proper timing handling.

**How it works:**
1. **Cluster Creation**: PostgreSQL cluster is created with default `app` database and `app` user
2. **Database CRD**: Manages the default `app` database and installs extensions  
3. **Full Kubernetes-Native**: All databases are managed via Database CRDs

**Extensions installed by default:**
- **vector**: pgvector extension for similarity search and embeddings  
- **pg_stat_statements**: Query performance monitoring

### Default Database Approach

The default database (`app`) is managed via Database CRD:

```yaml
databases:
  - name: app  # This manages the default 'app' database
    owner: app
    extensions:
      - vector
      - pg_stat_statements
```

CloudNativePG creates the default database named `app` and the Database CRD adds extensions to it.

This approach gives you:
- ✅ **Full `kubectl get database` visibility**
- ✅ **Declarative lifecycle management** for all databases
- ✅ **Consistent approach** using Database CRDs
- ✅ **Proper timing** by using CloudNativePG's default database

### Adding Additional Databases

All databases are managed consistently via Database CRD:

```yaml
databases:
  - name: app  # Default database (Database CRD)
    owner: app
    extensions:
      - vector
      - pg_stat_statements
  
  - name: analytics  # Additional database (Database CRD)
    owner: app
    extensions:
      - vector
      - pg_stat_statements
      - hstore
      - btree_gin
```

## PostgreSQL Tuning for Vector Workloads

The chart includes optimized PostgreSQL parameters for vector operations:

```yaml
postgresql:
  parameters:
    # Increased memory for vector index building
    maintenance_work_mem: "256MB"
    work_mem: "64MB"
    
    # Enhanced parallelism for vector operations
    max_parallel_workers_per_gather: "4"
    max_parallel_workers: "8"
    
    # Optimized cache and buffer settings
    shared_buffers: "256MB"
    effective_cache_size: "1GB"
```

## Storage Considerations

Vector workloads typically require more storage due to:
- Vector indexes (HNSW, IVFFlat)
- Embedding storage
- Index maintenance overhead

Default storage sizes are increased:
- **Database storage**: 10Gi (vs 1Gi in standard postgresql-cluster)
- **WAL storage**: 2Gi (vs 1Gi in standard postgresql-cluster)

## Examples

### Basic Vector Database

```yaml
# values.yaml
fullnameOverride: "my-vector-db"
instances: 1  # For development

databases:
  - name: app  # Uses cluster name as database name
    owner: app
    extensions:
      - vector
```

### Production Vector Database with Monitoring

```yaml
# values.yaml
fullnameOverride: "prod-vector-db"
instances: 3
monitoring: true
dashboard: true

storage:
  size: 50Gi
  storageClass: "fast-ssd"

walStorage:
  size: 10Gi
  storageClass: "fast-ssd"

postgresql:
  parameters:
    max_connections: "500"
    shared_buffers: "1GB"
    effective_cache_size: "4GB"
    maintenance_work_mem: "512MB"
    work_mem: "128MB"

databases:
  - name: app  # Default database
    owner: app
    extensions:
      - vector
      - pg_stat_statements
  
  - name: analytics
    owner: app
    extensions:
      - vector
      - pg_stat_statements
      - hstore
      - btree_gin
```

### High-Performance Vector Database

```yaml
# values.yaml
fullnameOverride: "high-perf-vector-db"
instances: 5

resources:
  limits:
    cpu: "4"
    memory: 8Gi
  requests:
    cpu: "2"
    memory: 4Gi

storage:
  size: 100Gi
  storageClass: "nvme-ssd"

postgresql:
  parameters:
    max_connections: "1000"
    shared_buffers: "2GB"
    effective_cache_size: "6GB"
    maintenance_work_mem: "1GB"
    work_mem: "256MB"
    max_parallel_workers_per_gather: "8"
    max_parallel_workers: "16"
```

## Connecting to the Database

After installation, connect to your vector database:

```bash
# Get connection details
kubectl get secret <cluster-name>-app -o yaml

# Connect via psql
kubectl cnpg psql <cluster-name> -- <database-name>

# Verify pgvector is installed
\dx
```

## Using pgvector

Once connected, you can start using vector operations:

```sql
-- Create a table with vector column
CREATE TABLE items (
    id bigserial PRIMARY KEY,
    name text,
    embedding vector(1536)  -- OpenAI embedding dimension
);

-- Create vector index for fast similarity search
CREATE INDEX ON items USING hnsw (embedding vector_cosine_ops);

-- Insert vectors
INSERT INTO items (name, embedding) VALUES 
    ('item1', '[1,2,3,...]'),
    ('item2', '[4,5,6,...]');

-- Similarity search
SELECT name, embedding <=> '[1,2,3,...]' AS distance
FROM items
ORDER BY embedding <=> '[1,2,3,...]'
LIMIT 5;
```

## Monitoring

When monitoring is enabled, the chart provides:

- **PodMonitor**: Prometheus scraping configuration
- **Grafana Dashboard**: pgvector-specific monitoring dashboard
- **Vector-specific Metrics**: Query performance, index usage, connection patterns

Access the dashboard via your Grafana instance under the "pgvector" folder.

## Backup Configuration

To enable backups, configure the `backup` section:

```yaml
backup:
  enabled: true
  retentionPolicy: "30d"
  barmanObjectStore:
    destinationPath: "s3://your-backup-bucket/pgvector-cluster"
    s3Credentials:
      accessKeyId:
        name: backup-credentials
        key: ACCESS_KEY_ID
      secretAccessKey:
        name: backup-credentials
        key: SECRET_ACCESS_KEY
```

## Troubleshooting

### Extension Not Available

If pgvector is not available:

```bash
# Check if extension is in the image
kubectl cnpg psql <cluster-name> -- postgres -c "SELECT * FROM pg_available_extensions WHERE name = 'vector';"

# Check CloudNativePG operator logs
kubectl logs -n cnpg-system deployment/cnpg-controller-manager
```

### Performance Issues

For vector workload performance:

1. **Increase memory settings**: `shared_buffers`, `work_mem`, `maintenance_work_mem`
2. **Tune parallel workers**: `max_parallel_workers_per_gather`
3. **Use appropriate indexes**: HNSW for approximate search, IVFFlat for exact search
4. **Monitor query performance**: Enable `pg_stat_statements`

### Storage Issues

Vector workloads can grow quickly:

1. **Monitor storage usage**: Check Grafana dashboard
2. **Increase storage size**: Update `storage.size` in values
3. **Consider storage class**: Use fast SSDs for better performance

## Migration from postgresql-cluster

To migrate from the standard `postgresql-cluster` to `pgvector-cluster`:

1. **Backup your data**: Use CloudNativePG backup features
2. **Update values**: Migrate configuration to pgvector-specific format
3. **Install pgvector chart**: Deploy new cluster
4. **Restore data**: Import data and create vector extensions
5. **Update applications**: Point to new cluster endpoints

## Related Charts

- `postgresql-cluster`: Standard PostgreSQL cluster without vector extensions
- `redis-cluster`: For caching vector search results
- `rabbitmq-cluster`: For vector processing job queues
