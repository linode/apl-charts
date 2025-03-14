## Installation instructions

To install Kubeflow Pipelines, first install the `kfp-cluster-resources` Helm chart. When the `kfp-cluster-resources` Helm chart is installed, then install the `kubeflow-pipelines` Helm chart in the target Team namespace.

### Install the `kfp-cluster-resources` Helm chart

1. Select the Team view and select Team `Admin`.
2. Go to `Workloads` and create a new Workload.
3. Select the `kfp-cluster-resources` Helm chart.
4. Use the name: `kfp-cluster-resources`
5. Use namespace: `team-admin`
6. Adjust the values.
7. Click `Submit`

### Install the `kubeflow-pipelines` Helm chart

Note: the `kubeflow-pipelines` Helm chart can only be installed by a user that is a Platform Admin using the `team-admin`.

1. Create a bucket.
2. Select the Team view and select the team where Kubeflow Pipelines will be installed.
3. Create a SealedSecret and add 2 key's:
- accesskey
- secretkey
4. Select the Team view and select Team `Admin`.
5. Go to `Workloads` and create a new Workload.
6. Select the `kubeflow-pipelines` Helm chart.
7. Fill in a name.
8. Fill in the namespace of the Team where the `kubeflow-pipelines` Helm chart will be installed (`team-<team-name>`).
9. Adjust the values (make sure the name of the secret is the same as the SealedSecret created in step 3).
10. When the chart is installed, create a Service to expose the `ml-pipeline-ui` service.

Kubeflow Pipelines is now installed and can be used by the members of the Team only.