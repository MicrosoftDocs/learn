In this unit, you use the Azure Container Registry service to push a container image to your Azure container registry. Azure Container Registry allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. Use Azure container registries with your existing container development and deployment pipelines.

> [!NOTE]
> If your session has idled out or you're doing this step at another point in time or from another CLI, you might have to reinitialize your environment variables and reauthenticate by using the following commands:
>
> ```azurecli
>    AZ_RESOURCE_GROUP=javacontainerizationdemorg
>    AZ_CONTAINER_REGISTRY=<YOUR_CONTAINER_REGISTRY> 
>    AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
>    AZ_LOCATION=<YOUR_AZURE_REGION> 
>    AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER> 
>    az login
>    az acr login -n $AZ_CONTAINER_REGISTRY
>```

## Push a container image

You can push your newly built container image to your Azure container registry. By doing so, your container image is network close to all of your Azure resources, such as your Azure Kubernetes Cluster. Later, you configure Azure Kubernetes Service (AKS) to pull the `flightbookingsystemsample` image from the registry. To push the container image to your registry, use the following steps:

1. Sign in to Azure Container Registry (if you haven't already):

    ```azurecli
       az acr login
    ```

1. Tag the previously built container image with your Azure container registry:

   ```azurecli
      docker tag flightbookingsystemsample $AZ_CONTAINER_REGISTRY.azurecr.io/flightbookingsystemsample
   ```

1. Push the container image to your Azure container registry:

   ```azurecli
      docker push $AZ_CONTAINER_REGISTRY.azurecr.io/flightbookingsystemsample
   ```

1. Once the push completes, you can view the Azure container registry image metadata of the newly pushed image by using the following command:

   ```azurecli
      az acr repository show -n $AZ_CONTAINER_REGISTRY --image flightbookingsystemsample:latest
   ```

The following output is typical:

```json
   {
     "changeableAttributes": {
       "deleteEnabled": true,
       "listEnabled": true,
       "readEnabled": true,
       "writeEnabled": true
     },
     "createdTime": "2024-11-15T12:23:55.5624474Z",
     "digest": "sha256:13851640a3****************************************f7f1e482c6eaa825",
     "lastUpdateTime": "2024-11-15T12:23:55.5624474Z",
     "name": "latest",
     "signed": false
   }
```

Your container image is now located within your Azure container registry, and is ready for deployments by Azure Services such as AKS.
