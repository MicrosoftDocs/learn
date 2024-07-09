In this unit, you'll push a container image to Azure Container Registry.

Azure Container Registry allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. Use Azure container registries with your existing container development and deployment pipelines.

> [!NOTE]
> If your session has idled out or you're doing this step at another point in time and/or from another CLI, you might have to reinitialize your environment variables and reauthenticate with the following CLI commands.
>
>AZ_RESOURCE_GROUP=javacontainerizationdemorg
>
>AZ_CONTAINER_REGISTRY=<YOUR_CONTAINER_REGISTRY>
>
>AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
>
>AZ_LOCATION=<YOUR_AZURE_REGION>
>
>AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>
>
>az login
>
>az acr login -n $AZ_CONTAINER_REGISTRY

## Push a container image

You can push your newly built container image to the Azure Container Registry. By doing so, your container image will be network close to all of your Azure resources, such as your Azure Kubernetes Cluster. You’ll ultimately configure AKS to pull the `flightbookingsystemsample` image from Azure Container Registry.

To push the container image to Azure Container Registry, run the following three commands in your CLI:

Sign in to the Azure Container Registry (if you haven't already):

```bash
az acr login
```

First, tag the previously built container image with your Azure Container Registry:

```bash
docker tag flightbookingsystemsample $AZ_CONTAINER_REGISTRY.azurecr.io/flightbookingsystemsample
```

Second, push the container image to Azure Container Registry:

```bash
docker push $AZ_CONTAINER_REGISTRY.azurecr.io/flightbookingsystemsample
```

Once the push completes, you can view the Azure Container Registry image metadata of the newly pushed image. Run the following command in your CLI:

```bash
az acr repository show -n $AZ_CONTAINER_REGISTRY --image flightbookingsystemsample:latest
```

You’ll get output similar to the following:

```json
{
  "changeableAttributes": {
    "deleteEnabled": true,
    "listEnabled": true,
    "readEnabled": true,
    "writeEnabled": true
  },
  "createdTime": "2021-10-08T00:51:43.5522013Z",
  "digest": "sha256:bc7613a5612c914d7a6bfc0f130d1f632a5bda362aa62bb3ac12304dc4ce94c1",
  "lastUpdateTime": "2021-10-08T00:58:57.623821Z",
  "name": "latest",
  "signed": false
}
```

Your container image now resides within the Azure Container Registry, and is ready for deployments by Azure Services such as Azure Kubernetes Service.
