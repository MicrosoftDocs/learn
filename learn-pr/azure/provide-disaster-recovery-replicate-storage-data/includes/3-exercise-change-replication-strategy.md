In this unit, you'll create a storage account and configure a blob container for it. You'll create a blob file and upload it to your storage account. You can then view the replication status in the Azure portal.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a storage account

Create a storage account with geo-zone-redundant storage (GZRS).

1. Sign in to the [Azure portal](https://portal.azure.com).
1. From the menu bar in the upper right, open **Cloud Shell**.
1. Set the resource group name.
    ```bash
    export RESOURCEGROUP=learn-storage-replication-rg
    ```
1. To set the storage account name where you replace *storageaccountname* and the brackets with a unique Azure Storage account name, run this command.

    ```bash
    export AZURE_STORAGE_ACCOUNT=<storageaccountname>
     ```

1. Set the location. Replace the **westus2** value with a location near you.

    ```bash
    export LOCATION=westus2
    ```

    The following list has some location values you can use:

    - southeastasia
    - northeurope
    - westeurope
    - japaneast
    - uksouth
    - centralus
    - eastus2
    - westus2

1. To create a resource group, run this command.

    ```azurecli
    az group create --name $RESOURCEGROUP --location $LOCATION
    ```

1. To create a storage account, run this command.

    ```azurecli
    az storage account create \
    --name $AZURE_STORAGE_ACCOUNT \
    --resource-group $RESOURCEGROUP \
    --location $LOCATION \
    --sku Standard_GZRS \
    --encryption-services blob \
    --kind StorageV2
    ```

1. For the rest of the steps in this exercise, you'll need your storage credentials. To list your storage account keys, run this command.

    ```azurecli
    az storage account keys list \
    --account-name $AZURE_STORAGE_ACCOUNT \
    --resource-group $RESOURCEGROUP \
    --output table
    ```

1. Copy the keys listed.
1. To hold your storage key, set an environment variable. Replace *account-key* and the brackets with one of your key values.

    ```bash
    export AZURE_STORAGE_KEY="<account-key>"
    ```

## Create a blob container

To upload blobs to Azure Storage, you need a container. You use containers to logically group your blobs. A container helps you organize blobs, like a folder organizes files on your computer.

1. To set a container name where you replace *blob-container-name* and the brackets with another name, run this command.

    ```bash
    export BLOB_CONTAINER_NAME=<blob-container-name>
    ```

1. Run the following command to create a container for your storage account:

    ```azurecli
    az storage container create --account-key $AZURE_STORAGE_KEY --account-name $AZURE_STORAGE_ACCOUNT --name $BLOB_CONTAINER_NAME
    ```

1. When your storage account container has been created, you'll see this message returned in your terminal.

    ```output
    {
        "created": true
    }
    ```

## Create a file (blob)

Your company uploads its music files as blobs in the container. A blob can represent a file of any type. For the purposes of this exercise, you'll upload a text file as a blob.

1. To create a file you can upload to your storage account, run this command.

    ```bash
    cat > song.mp3
    ```

1. An empty file is created that you can write to. Enter **This is a song!**, select <kbd>Enter</kbd>, and then select <kbd>Ctrl+D</kbd>.

1. To see the contents of your `song.mp3` file, run this command.

    ```bash
    cat song.mp3
    ```

1. You'll see **This is a song!** returned to you in the terminal. You've created a file you can now upload to your storage account.

## Upload your file

Upload the file to your storage account via your container.

1. To upload your file, run this command.

    ```azurecli
    az storage blob upload \
        --container-name $BLOB_CONTAINER_NAME \
        --name song \
        --file song.mp3
    ```

1. When the upload is complete, to verify the file is in your storage account, run this command.

    ```azurecli
    az storage blob list \
    --container-name $BLOB_CONTAINER_NAME  \
    --output table
    ```

1. You'll see details about your file, like its name, blob type, and when it was last modified.

## View the replication status

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select or search for **Resource groups**.
1. Select **learn-storage-replication-rg**.
1. Select the storage account you created from the list of resources in your resource group.
1. Under **Settings**, select **Geo-replication**. You see the replication status of your Azure Storage account's primary and secondary regions. If the status shows as **available** for a region, it means your region is responsive.

1. To ensure you're seeing the latest status updates, select **Refresh**.

   :::image type="content" source="../media/3-view-replication-status.png" alt-text="Screenshot of the geo-replication map that shows the primary and secondary locations available.":::

It will take some time for your data to replicate from the primary to the secondary region.
