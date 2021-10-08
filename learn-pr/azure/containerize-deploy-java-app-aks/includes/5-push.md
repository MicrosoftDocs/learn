In this unit, you'll push a Docker image to Azure Container Registry

## Push a Docker image

You can push your Docker image to the Azure Container Registry. By doing so, your Docker image will be network close to all of your Azure resources, such as your Azure Kubernetes Cluster. You will ultimately configure AKS to pull the TurkishAirlines image from Azure Container Registry.

To build and push the Docker image to Azure Container Registry, run the following command in your CLI:

```bash
az acr build --registry $AZ_CONTAINER_REGISTRY --resource-group $AZ_RESOURCE_GROUP --image turkishairlines:latest .
```

> [!NOTE]
> If your session has idled out and/or your doing this step at another point in time, you may have to re authenticate with the following CLI commands.
> ```bash az login``` and ```bash az acr login -n $AZ_CONTAINER_REGISTRY```

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