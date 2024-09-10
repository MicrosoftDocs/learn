Before we explore Content Delivery Networks, let's deploy a static website in Azure Storage to use throughout the module.

### Create a Storage Account in Azure Cloud Shell

Start by creating a new storage account to host a static site. When we're finished, you can access this site through the content delivery network.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Install the `storage-preview` extension by executing the following command in Azure Cloud Shell. This Azure CLI extension is needed to manage static websites from the CLI. Run the following command in the Cloud Shell terminal window on the right:

    ```azurecli
    az extension add --name storage-preview
    ```

1. Run these commands in the Cloud Shell to set up a few shell variables. Use these variables throughout this module to create items such as a storage account name. Replace `<location>` with one of the locations in the region list.

    ```bash
    STORAGE_ACCOUNT_NAME="cdnsitestorage$RANDOM" \
    RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn> \
    LOCATION=<location>
    ```

1. Run this command in the Cloud Shell to create the storage account.

    ```azurecli
    az storage account create \
        --name $STORAGE_ACCOUNT_NAME \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --sku Standard_LRS \
        --kind StorageV2
    ```

1. In the output, find the `"primaryEndpoints"` **web** url, copy it, and open the link in a web browser. The page that opens indicates that **The requested content doesn't exist**. Keep this tab open; we're going to deploy our static content and then refresh the page.

### Enable static website hosting on the storage account

1. In the Cloud Shell, run the following command to enable static website hosting on the storage account.

    ```azurecli
    az storage blob service-properties update \
        --account-name $STORAGE_ACCOUNT_NAME \
        --static-website \
        --404-document 404.html \
        --index-document index.html
    ```

    At the end of the output, you should see the entry:

    ```json
    "staticWebsite": {
        "enabled": true,
        "errorDocument_404Path": "404.html",
        "indexDocument": "index.html"
    }
    ```

1. Switch to the browser tab displaying the static website and refresh it. You see a message that the requested content doesn't exist.

### Upload Files to the Static Website

1. To upload the website files, execute the following commands:

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-create-cdn-static-resources-blob-storage source
    ```

1. Navigate to the `source/website-files` folder

    ```azurecli
    cd source/website-files
    ```

1. Then upload those files to the $web blob storage container.

    ```azurecli
    az storage blob upload-batch -s . -d \$web --account-name $STORAGE_ACCOUNT_NAME
    ```

### Check for Website Publication

Switch to the website you opened earlier and refresh the page (press F5). You see the landing page and an image.
