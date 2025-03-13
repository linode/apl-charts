# spin-operator

spin-operator is a Kubernetes operator in charge of handling the lifecycle of Spin applications based on their SpinApp resources.

## Prerequisites

- Kubernetes v1.11.3+

## Prepare the cluster

Prior to installing the chart, you'll need to ensure the following:

- [Kwasm Operator](https://github.com/kwasm/kwasm-operator) to install WebAssembly support on Kubernetes nodes. See the [project README.md](https://github.com/KWasm/kwasm-operator/blob/main/README.md) for installation and configuration steps, including annotating nodes to run Spin/wasm workloads.


## Post-installation

spin-operator depends on the following resources. If not already present on the cluster, install them now:

- An application executor is installed. This is the executor that spin-operator uses to run Spin applications.

  ```console
  $ kubectl apply -f https://raw.githubusercontent.com/spinkube/spin-operator/main/config/samples/spin-shim-executor.yaml
  ```

- A RuntimeClass resource for the `wasmtime-spin-v2` container runtime is installed. This is the runtime that Spin applications use.

  ```console
  $ kubectl apply -f https://raw.githubusercontent.com/spinkube/spin-operator/main/config/samples/spin-runtime-class.yaml
  ```

## Upgrading the chart

Note that you may also need to upgrade the spin-operator CRDs in tandem with upgrading the Helm release:

```console
$ kubectl apply -f https://raw.githubusercontent.com/spinkube/spin-operator/main/config/crd/bases/core.spinkube.dev_spinapps.yaml
$ kubectl apply -f https://raw.githubusercontent.com/spinkube/spin-operator/main/config/crd/bases/core.spinkube.dev_spinappexecutors.yaml
```

To upgrade the `spin-operator` release, run the following:

```console
$ helm upgrade spin-operator \
  --namespace spin-operator \
  --version {{ CHART_VERSION }} \
  oci://ghcr.io/spinkube/charts/spin-operator
```
