TODO

During the process, you'll:

> [!div class="checklist"]
> * Sign in as your own user account.
> * Create a resource group for your company's website.
> * Create a role assignment to allow the service principal to deploy resources to the resource group.
> * Sign in as the service principal and deploy the Bicep file that creates your company's website resources.
> * Verify the deployment.
> * Clean up the resource group and service principal.

## Sign in as your user account

TODO

## Create a resource group

1. Run this Azure CLI command in the Visual Studio Code terminal to create a resource group:

   ```azurecli
   az group create --name ToyWebsite --location eastus
   ```

1. TODO copy out the resource group ID

## Create a role assignment

```azurecli
az role assignment create \
  --assignee TODO \
  --role Contributor \
  --scope TODO \
  --description TODO
```

## Create a Bicep file

TODO

## Deploy the Bicep file using the service principal

TODO this is simulating what the pipeline does

1. Run this Azure CLI command in the Visual Studio Code terminal to log in using the service principal's credentials. Make sure you replace the placeholders with the values you copied in the previous exercise.

   ```azurecli
   az login --service-principal \
     --username SERVICE-PRINCIPAL-NAME \
     --password SERVICE-PRINCIPAL-PASSWORD \
     --tenant YOUR-AZURE-AD-TENANT-ID
   ```

1. Deploy the Bicep template by running the following Azure CLI command:

   ```azurecli
   az deployment group create \
     --resource-group ToyWebsite \
     --template-file main.bicep
   ```

## Verify the deployment

TODO use portal to see the deployment as normal

## Clean up the resource group and service principal

TODO