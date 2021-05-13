Use the Azure CLI to move blobs from one storage account to another. You can perform the move as a batch operation if you have many blobs. Additionally, you can apply the `--if-unmodified-since` parameter if you only want to copy blobs that haven't changed recently.

In the example scenario, you want to move blobs that contain the details for product specifications, and that are more than six months old, to an archive store in a separate blob storage account. You can use a *Cool* storage account for this purpose; it's more cost effective for holding rarely accessed files than keeping them in *Hot* storage.

In this exercise, you'll use the Azure CLI to migrate blobs that haven't changed in the last six months to a separate storage account.

## Create and add data to hot storage

  [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Create environment variables for your storage account name and region. Replace `<location>` with a region from the previous list.

    ```azurecli
    HOT_STORAGE_NAME=hotstorage$RANDOM
    LOCATION=<location>
    ```

1. Next, run the following command to create a storage account to hold blobs.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $HOT_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Hot
    ```

1. Obtain the keys for your storage account.

    ```azurecli
    az storage account keys list \
      --account-name $HOT_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --output table
    ```

1. Create an environment variable for your account key; use the value of the first key retrieved by the previous command.

    ```bash
    HOT_KEY="<source account key>"
    ```

1. Create a container named *specifications* in your storage account.

    ```azurecli
    az storage container create \
      --name specifications \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

1. Run the following command to download the sample files for this exercise.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-copy-move-blobs-from-containers-or-storage-accounts sample
    ```

1. Upload the files to your storage account and save each one as a blob. This command uploads a number of specification files.

    ```azurecli
    az storage blob upload-batch \
      --destination specifications \
      --pattern "*.md" \
      --source ~/sample/specifications \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

1. Verify that the blobs have been created.

    ```azurecli
    az storage blob list \
      --container-name specifications \
      --output table \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

## Create a Cool storage account

Now we'll create a second storage account and move data between accounts.

1. Create an environment variable for your cool storage account name.

    ```azurecli
    COOL_STORAGE_NAME=coolstorage$RANDOM
    ```

1. Create a storage account for holding the archived blobs. Use the **Cool** access tier. As before, specify an appropriate region, and choose a unique name for your storage account.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $COOL_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Cool
    ```

1. Obtain the keys for your storage account.

    ```azurecli
    az storage account keys list \
      --account-name $COOL_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --output table
    ```

1. Create an environment variable for the cool account key; use the value of the first key retrieved by the previous command:

    ```bash
    COOL_KEY="<source account key>"
    ```

1. Create a container named *archived-specifications* in your storage account. Provide the name of the destination storage account and key as parameters to this command; otherwise, the container will be created in the source storage account.

    ```azurecli
    az storage container create \
      --name archived-specifications \
      --account-name $COOL_STORAGE_NAME \
      --account-key $COOL_KEY
    ```

1. Verify that the destination container is empty. The following command shouldn't display any output.

    ```azurecli
    az storage blob list \
      --container-name archived-specifications \
      --account-name $COOL_STORAGE_NAME \
      --account-key $COOL_KEY \
      --output table
    ```

## Copy blobs to Cool storage

1. Batch-copy the blobs from the specifications container in the source storage account to the archived-specifications container in the destination storage account. Use the `--dryrun` flag to see which blobs will be copied, without actually copying them.

    ```azurecli
    az storage blob copy start-batch \
      --destination-container archived-specifications \
      --account-name $COOL_STORAGE_NAME \
      --account-key $COOL_KEY \
      --source-account-name "$HOT_STORAGE_NAME" \
      --source-account-key $HOT_KEY \
      --source-container specifications \
      --dryrun
    ```

1. Review the list of blobs to copy.

1. Repeat the blob copy command, this time without the `--dryrun` parameter used in the previous step. This time, the blobs will be copied.

    ```azurecli
    az storage blob copy start-batch \
      --destination-container archived-specifications \
      --account-name $COOL_STORAGE_NAME \
      --account-key $COOL_KEY \
      --source-account-name "$HOT_STORAGE_NAME" \
      --source-account-key $HOT_KEY \
      --source-container specifications
    ```

1. Run the following command and verify that the blobs have been copied to the destination container.

    ```azurecli
    az storage blob list \
      --container-name archived-specifications \
      --account-name $COOL_STORAGE_NAME \
      --account-key $COOL_KEY \
      --output table
    ```
