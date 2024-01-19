In the utilities-company scenario, several members of your development are familiar with using Azure CLI to manage their resources. In order to leverage their expertise, you decide to examine how to enable CORS using the Azure CLI.

In this exercise, you'll learn how to use the Azure CLI to enable CORS for Azure storage.

## Enable CORS using the Azure CLI

1. First, create a new storage account. Replace `<account-name>` with a unique name of your choosing:

    ```bash
    storage=utilitystorage$RANDOM
    az storage account create --name $storage --kind StorageV2 -g <rgn>[sandbox resource group name]</rgn>
    ```

1. Run the following command in the Cloud Shell to set environment variables that you'll use in later commands; these variables specify your Azure storage account's name and account key.

   ```bash
   export AZURE_STORAGE_ACCOUNT=$storage
   export AZURE_STORAGE_KEY=`az storage account keys list --account-name $AZURE_STORAGE_ACCOUNT --query [0].value | tr -d \"`
   ```

1. Run the following command to add a CORS rule to your blob service:

   ```azurecli
   az storage cors add \
      --methods GET PUT \
      --origins "http://www.contoso.com" \
      --services b \
      --account-name "$AZURE_STORAGE_ACCOUNT" \
      --account-key "$AZURE_STORAGE_KEY"
   ```

1. Run the following command to verify that your CORS rule has been added to your blob service:

   ```azurecli
   az storage cors list \
      --services b \
      --account-name "$AZURE_STORAGE_ACCOUNT" \
      --account-key "$AZURE_STORAGE_KEY"
   ```

   Your response should resemble the following JSON output:

   ```json
   [
      {
         "AllowedHeaders": "",
         "AllowedMethods": "GET, PUT",
         "AllowedOrigins": "http://www.contoso.com",
         "ExposedHeaders": "",
         "MaxAgeInSeconds": 0,
         "Rule": 1,
         "Service": "blob"
      }
   ]
   ```

## Clear your CORS rules using the Azure CLI

1. Run the following command to list your existing CORS rules; you should see the rule that you added in the previous section:

   ```azurecli
   az storage cors list \
      --services b \
      --account-name "$AZURE_STORAGE_ACCOUNT" \
      --account-key "$AZURE_STORAGE_KEY"
   ```

1. Run the following command to clear all of your CORS rules.

   ```azurecli
   az storage cors clear \
      --services b \
      --account-name "$AZURE_STORAGE_ACCOUNT" \
      --account-key "$AZURE_STORAGE_KEY"
   ```

1. Run the following command to verify that your CORS rules have been removed from your blob service.

   ```azurecli
   az storage cors list \
      --services b \
      --account-name "$AZURE_STORAGE_ACCOUNT" \
      --account-key "$AZURE_STORAGE_KEY"
   ```

   You should see an empty JSON response, like the following example:

   ```json
   []
   ```
