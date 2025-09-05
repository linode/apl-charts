for chart in k8s-*; do helm template $chart $chart --values=tests/test-values.yaml --output-dir  tests/output/$chart; done
helm template knative-service --values=tests/test-values.yaml --output-dir  tests/output/knative-service
helm template postgres-cluster --values=tests/test-values.yaml --output-dir  tests/output/postgres-cluster
helm template pgvector-cluster --values=tests/test-values.yaml --output-dir  tests/output/pgvector-cluster
helm template redis-cluster --values=tests/test-values.yaml --output-dir  tests/output/redis-cluster
helm template rabbitmq-cluster --values=tests/test-values.yaml --output-dir  tests/output/rabbitmq-cluster