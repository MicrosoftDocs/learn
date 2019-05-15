Azure CLI provides a set of command-line tools for configuring and managing Azure Storage tiers.

Using the manufacturing company example, you are now going to start to implement your company's storage tier strategy. You'll use Azure CLI commands to retrieve and modify tier levels for Azure Storage blobs.

In this exercise, you'll use Azure CLI commands to retrieve and modify storage tier assignments.

### Prepare storage account and blob

In this step, you'll create a new storage account and container, and then upload a file to the container.

1. Run the following command in the Cloud Shell to create a sample file that you will use in later examples.

   ```bash
   touch dummy.png
   ```

1. Run the following commands in the Cloud Shell to populate environment variables with unique names that you will use to create a new storage account and a container within your storage account.

   ```bash
   export STORAGE_ACCT=<your storage account name>
   export CONTAINER_NAME=userguides
   ```

1. Run the following command in the Cloud Shell to create a new storage account, selecting your nearest Azure region, and using the environment variable you populated for the storage account name.

   ```azurecli
   az storage account create --location <your region> --name $STORAGE_ACCT --resource-group <rgn>[sandbox resource group name]</rgn> --kind StorageV2 --sku Standard_LRS
   ```

1. Run the following command in the Cloud Shell to create a new container in your storage account:

   ```azurecli
   az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCT
   ```

1. Run the following command in the Cloud Shell to upload the sample file as a blob to your new container. The file will be called **guitar-model8.png** when it has been uploaded.

   ```azurecli
   az storage blob upload --file dummy.png --name guitar-model8.png --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT
   ```

1. Run the following command in the Cloud Shell to list the blobs in your container and check that your file has uploaded:

   ```azurecli
   az storage blob list --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --output table
   ```

1. Note the Blob tier is set to **Hot**.

### Change blob Access tier from Hot to Cool 

In this step, you'll first change Access tier for your blob from Hot to Cool. You'll then upload second blob and change Access tier from Hot to Archive.

1. Run the following command in the Cloud Shell to change the access tier of the blob from Hot to Cool:

   ```azurecli
   az storage blob set-tier --name guitar-model8.png --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --tier Cool
   ```

1. Run the following command in the Cloud Shell to upload a new file to your container:

   ```azurecli
   az storage blob upload --file dummy.png --name bass-model3.png --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT
   ```

1. Run the following command in the Cloud Shell to change the access tier of the blob from Cool to Archive:

   ```azurecli
   az storage blob set-tier --name bass-model3.png --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --tier Archive
   ```

1. Run the following command in the Cloud Shell to view the blobs in your container.

   ```azurecli
   az storage blob list --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --output table
   ```

1. Your two Blobs are in different tiers, with bass-model3.png now offline.

1. Run the following command in the Cloud Shell to change the access tier of the blob from Archive to Hot:

   ```azurecli
   az storage blob set-tier --name bass-model3.png --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --tier Hot
   ```

1. Run the following command in the Cloud Shell to view the blobs in your container:

   ```azurecli
   az storage blob list --container-name $CONTAINER_NAME --account-name $STORAGE_ACCT --output table
   ```

1. You'll notice that the blob **bass-model3.png** is still set to Archive. This is due to rehydration that may take several hours.
