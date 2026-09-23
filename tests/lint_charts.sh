set -eu

charts=()
for dir in */; do
  if [ -f "${dir}Chart.yaml" ]; then
    charts+=("${dir%/}")
  fi
done

for chart in "${charts[@]}"; do
  helm lint "$chart" --values=tests/test-values.yaml
done
