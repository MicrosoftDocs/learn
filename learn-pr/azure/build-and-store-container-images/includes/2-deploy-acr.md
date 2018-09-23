In this unit, you will create an Azure container registry using the Azure CLI.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]
 
## Create an Azure container registry

We'll be working in a free Sandbox, so there's no need to create your own Resource Group. Create an Azure container registry with the `az acr create` command. The container registry name must be unique within Azure and contain between 5 and 50 alphanumeric characters. Replace `<acrName>` with a unique name for your registry.

In this example, a premium registry SKU is deployed. The premium SKU is required for geo-replication. Enter the following command into the cloud shell editor.

```azurecli
az acr create --resource-group <rgn>[Sandbox resource group name]</rgn> --name <acrName> --sku Premium
```

Here's an example output for a new Azure container registry:

```output
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

In this unit, you created an Azure container registry using the Azure CLI.