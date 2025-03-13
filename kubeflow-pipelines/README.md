# Helm chart for installing Kubeflow Pipelines

The `kubeflow-pipelines` Helm chart can be used to install Kubeflow Pipelines. The chart is configured to use Linode Object storage.

## Prerequisites

- Before the `kubeflow-pipelines` Helm chart can be installed, the `kfp-cluster-resources` Helm chart needs to be installed.

- 2 Sealed Secrets in the Team where the `kubeflow-pipelines` Helm chart is going to be installed are required:

1. Create a Sealed Secret called `mlpipeline-minio-artifact` that contains the Object Storage `accesskey` and `secretkey`.

2. Create a Sealed Secret that contains the with the following key/values:

- `password`="a random password"
- `username`=`root`