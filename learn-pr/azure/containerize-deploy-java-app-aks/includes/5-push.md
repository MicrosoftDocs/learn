In this unit, you'll push a Docker image to Azure Container Registry.

Azure Container Registry allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. Use Azure container registries with your existing container development and deployment pipelines.

## Push a Docker image

You can push your newly built Docker image to the Azure Container Registry. By doing so, your Docker image will be network close to all of your Azure resources, such as your Azure Kubernetes Cluster. You will ultimately configure AKS to pull the TurkishAirlines image from Azure Container Registry.

To push the Docker image to Azure Container Registry, run the following two commands in your CLI:

First tag the previously built Docker image with your Azure Container Registry:

```bash
docker tag turkishairlines $AZ_CONTAINER_REGISTRY.azurecr.io/turkishairlines
```

Second, push the Docker image to Azure Container Registry:

```bash
docker push $AZ_CONTAINER_REGISTRY.azurecr.io/turkishairlines
```

> [!NOTE]
> If your session has idled out, your doing this step at another point in time and/or from another CLI you may have to re initialize your environment variables and re authenticate with the following CLI commands.
>AZ_RESOURCE_GROUP=javacontainerizationdemorg
>AZ_CONTAINER_REGISTRY=javacontainerizationdemoacr
>AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
>AZ_LOCATION=<YOUR_AZURE_REGION> 
>AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>```
>az login
>az acr login -n $AZ_CONTAINER_REGISTRY

You can now view the Azure Container Registry image meta-data of the newly pushed image. Run the following command in your CLI:

```bash
az acr repository show -n $AZ_CONTAINER_REGISTRY --image turkishairlines:latest
```

You will see the following meta-data as seen below:

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

Your Docker image is now resident within Azure Container Registry and ready for deployments by Azure Services such as Azure Kubernetes Service.