for chart in quickstart-*; do helm template --debug $chart $chart --values=tests/test-values.yaml --output-dir  tests/output/$chart; done