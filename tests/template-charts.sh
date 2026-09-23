set -eu

charts=()
for dir in */; do
  if [ -f "${dir}Chart.yaml" ]; then
    charts+=("${dir%/}")
  fi
done

for chart in "${charts[@]}"; do
  helm template $chart --values=tests/test-values.yaml --output-dir  tests/output/$chart
done
