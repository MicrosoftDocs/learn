Before you create your container registry, you need a *resource group* to deploy it to. A resource group is a logical collection into which all Azure resources are deployed and managed.

Create a resource group with the `az group create` command. In the following example, a resource group named *myResourceGroup* is created in the *eastus* region:

```azurecli
az group create --name myResourceGroup --location eastus
```

Once you've created the resource group, create an Azure container registry with the `az acr create` command. The container registry name must be unique within Azure, and contain 5-50 alphanumeric characters. Replace `<acrName>` with a unique name for your registry:

```azurecli
az acr create --resource-group myResourceGroup --name <acrName> --sku Premium
```

Here's example output for a new Azure container registry.

```console
{
  "adminUserEnabled": false,
  "creationDate": "2018-08-15T19:19:07.042178+00:00",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.ContainerRegistry/registries/myACR0007",
  "location": "eastus",
  "loginServer": "myacr.azurecr.io",
  "name": "myACR",
  "provisioningState": "Succeeded",
  "resourceGroup": "myResourceGroup",
  "sku": {
    "name": "Premium",
    "tier": "Premium"
  },
  "status": null,
  "storageAccount": null,
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}
```

The rest of this module refers to `<acrName>` as a placeholder for the container registry name that you chose in this step.

## Sign in to container registry

You must sign in to your Azure Container Registry instance before pushing images to it. Use the `az acr login` command to complete the operation. Provide the unique name you chose for the container registry when you created it.

```azurecli
az acr login --name <acrName>
```

The command returns `Login Succeeded` once completed.