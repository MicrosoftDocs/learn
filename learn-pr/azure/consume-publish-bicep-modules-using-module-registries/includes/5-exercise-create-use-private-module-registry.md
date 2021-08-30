## Create a module

1. Open VS Code

1. Create a new file named *module.bicep*

1. Paste the following Bicep code

   ```bicep
   // TODO
   ```

## Create a container registry

1. TODO Generate a name

1. Run this command:

   ```azurecli
   az acr create \
     --resource-group TODO \
     --name TODO \
     --sku Standard \
     --location westus
   ```

## Publish the module

1. Run this command:

   ```azurecli
   az bicep publish \
     --file module.bicep \
     --target 'oci:TODO.azurecr.io/test/test:v1'
   ```

1. TODO look on the portal to verify it's been created?

## Update your Bicep file to use the new module

1. Update *main.bicep* to include the following:

   ```bicep
   module todo 'oci:TODO.azurecr.io/test/test:v1' = {
     name: 'todo'
     params: {
     }
   }
   ```

1. Save the file.

## Deploy to Azure

1. Run this command:

   ```azurecli
   az deployment group create \
     --resource-group TODO \
     --template-file main.bicep
   ```

1. Open portal, verify deployed successfully
