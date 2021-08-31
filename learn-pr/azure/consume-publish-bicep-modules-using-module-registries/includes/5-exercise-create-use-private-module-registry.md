## Create a module

1. Open VS Code

1. Create a new file named *module.bicep*

1. Paste the following Bicep code

   ```bicep
   // TODO
   ```

## Create a container registry

1. Decide on a unique name for your container registry. The name can't be used by any other Azure customers. Choose a name that is between 5 and 50 characters in length and contains letters and numbers. You'll use this in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code **Terminal**. Make sure to replace the name placeholder with the name you selected in the preceding step.

   ```azurecli
   az acr create \
     --name YOUR_CONTAINER_REGISTRY_NAME \
     --sku Basic \
     --location westus
   ```

## Publish the module

1. Run this command:

   ```azurecli
   az bicep publish \
     --file module.bicep \
     --target 'oci:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/test/test:v1'
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
     --template-file main.bicep
   ```

1. Open portal, verify deployed successfully
