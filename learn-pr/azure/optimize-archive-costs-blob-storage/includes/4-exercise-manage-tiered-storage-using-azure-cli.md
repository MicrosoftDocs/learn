Azure CLI provides a set of command-line tools for configuring and managing Azure Storage tiers.

Using the manufacturing-company example, you're now going to start implementing your company's storage-tier strategy. You'll use Azure CLI commands to retrieve and modify tier levels for Azure Storage blobs.

In this exercise, you'll use Azure CLI commands to retrieve and modify storage tier assignments.

### Prepare storage account and blob

In this section, you'll create a new storage account and container, then upload a file to the container.

1. Run the following command in the Cloud Shell to create a sample file that you'll use in later examples:

   ```bash
   touch dummy.png
   ```

1. Run the following commands in the Cloud Shell to populate environment variables with unique names that you'll use to create a new storage account and a container within your storage account. Replace `<your storage account name>` with a name of your choosing for your storage account:

   ```bash
   export LOCATION=eastus2
   export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
   export STORAGE_ACCOUNT_NAME=<your storage account name>
   export CONTAINER_NAME=userguides
   ```

1. Run the following command in the Cloud Shell to create a new storage account, using the environment variable you populated for the storage account name:

   ```azurecli
   az storage account create \
       --location $LOCATION \
       --name $STORAGE_ACCOUNT_NAME \
       --resource-group $RESOURCE_GROUP \
       --kind StorageV2 \
       --sku Standard_LRS
   ```

1. To create a container, you'll need the storage account key. This command retrieves the storage account key and stores it in an environment variable:

   ```bash
   export AZURE_STORAGE_KEY="$(az storage account keys list -g $RESOURCE_GROUP -n $STORAGE_ACCOUNT_NAME --query [0].value --output tsv)"
   ```

1. Run the following command in the Cloud Shell to create a new container in your storage account:

   ```azurecli
   az storage container create \
       --name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --account-key $AZURE_STORAGE_KEY
   ```

1. Run the following command in the Cloud Shell to upload the sample file as a blob to your new container. The file will be called **guitar-model8.png** when it's been uploaded:

   ```azurecli
   az storage blob upload \
       --file dummy.png \
       --name guitar-model8.png \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME
   ```

1. Run the following command in the Cloud Shell to list the blobs in your container and check that your file has uploaded:

   ```azurecli
   az storage blob list \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --output table
   ```

1. Note the Blob tier is set to **Hot**.

### Change blob Access tier from Hot to Cool

In this step, you'll first change the access tier for your blob from Hot to Cool. You'll then upload second blob and change the access tier from Hot to Archive.

1. Run the following command in the Cloud Shell to change the blob's access tier from Hot to Cool:

   ```azurecli
   az storage blob set-tier \
       --name guitar-model8.png \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --tier Cool
   ```

1. Run the following command in the Cloud Shell to upload a new file to your container:

   ```azurecli
   az storage blob upload \
       --file dummy.png \
       --name bass-model3.png \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME
   ```

1. Run the following command in the Cloud Shell to change the blob's access tier from Cool to Archive:

   ```azurecli
   az storage blob set-tier \
       --name bass-model3.png \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --tier Archive
   ```

1. Run the following command in the Cloud Shell to view the blobs in your container:

   ```azurecli
   az storage blob list \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --output table
   ```

1. Your two blobs are in different tiers, with **bass-model3.png** now offline.

1. Run the following command in the Cloud Shell to change the blob's access tier from Archive to Hot:

   ```azurecli
   az storage blob set-tier \
       --name bass-model3.png \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --tier Hot
   ```

1. Run the following command in the Cloud Shell to view the blobs in your container:

   ```azurecli
   az storage blob list \
       --container-name $CONTAINER_NAME \
       --account-name $STORAGE_ACCOUNT_NAME \
       --output table
   ```

1. You'll notice that the blob **bass-model3.png** is still set to Archive. This is due to rehydration, which might take several hours.
