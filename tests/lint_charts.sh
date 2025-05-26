for chart in k8s-*; do helm lint $chart $chart --values=tests/test-values.yaml; done;
helm lint knative-service --values=tests/test-values.yaml
helm lint postgres-cluster --values=tests/test-values.yaml
helm lint redis-cluster --values=tests/test-values.yaml
helm lint rabbitmq-cluster --values=tests/test-values.yaml
helm lint kfp-cluster-resources --values=tests/test-values.yaml
helm lint kubeflow-pipelines --values=tests/test-values.yaml