In this module, you will deploy a simple web application that presents an HTML-based user interface. A serverless back end enables the application to upload images and automatically generate descriptive captions.

![Running web app](../media/0-app-screenshot-finished.png)

The following illustration shows the Azure services that are used by the application.

![An illustration showing how different Azure services such as, Azure Blob storage, Azure functions, Cosmos DB, Azure logic apps, and Azure active directory are used by the application. ](../media/0-architecture.jpg)

1. Azure Blob storage serves static web content (HTML, CSS, JS) and stores images.
2. Azure Functions manages image uploads, resizing, and metadata storage.
3. Azure Cosmos DB stores image metadata.
4. Azure Logic Apps retrieves image captions from the Cognitive Services Computer Vision API.
5. Azure Active Directory manages user authentication.

Azure Blob storage is a low-cost and massively scalable service that can be used to host static files. In this module, you will use Blob storage to serve static content (for example, HTML, JavaScript, or CSS) for a web app you build.

## Create an Azure Storage account

[!include[](../../../includes/azure-sandbox-activate.md)]

An Azure Storage account is an Azure resource that allows you to store tables, queues, files, blobs (objects), and virtual machine disks.

1. The static content (HTML, CSS, and JavaScript files) for this module is hosted in Blob storage. Blob storage requires a Storage account. Create a general-purpose v2 (GPv2) Storage account in the resource group. Replace `<storage account name>` with a unique name.

    ```azurecli
    az storage account create \
        -n <storage account name> \
        -g <rgn>[Sandbox resource group name]</rgn> \
        --kind StorageV2 \
        --https-only true \
        --sku Standard_LRS
    ```

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Use the Search bar at the top of the portal to find the storage account that you just created. Open the account.

1. On the left navigation, select **Static website (preview)** to configure a container for static website hosting.
    - Select **Enabled** to enable a static website.
    - Enter **index.html** as the index document name. The box already has *index.html* in a gray font, but this is only example text. You still have to enter **index.html** in the box.
    - Click **Save**.

    ![Enter static website settings](../media/1-storage-static-website.png)

1. Save the **Primary Endpoint** in a place where you can conveniently copy it from while working through the module. This endpoint is the URL of your web application.

## Upload the web application

1. The source files for the application that you build in this module are located in a [GitHub repository](https://github.com/Azure-Samples/functions-first-serverless-web-application). Go to your home directory in Cloud Shell and clone this repository.

    ```azurecli
    cd ~
    git clone https://github.com/Azure-Samples/functions-first-serverless-web-application
    ```

    The repository is cloned to `/home/<username>/functions-first-serverless-web-application`

1. The client-side web application is located in the **www** folder and is built using the Vue.js JavaScript framework. Open the **www** folder and run **npm** commands to install the application dependencies and build the application. The last of these commands might take several minutes to complete.

    ```azurecli
    cd ~/functions-first-serverless-web-application/www
    npm install
    npm run generate
    ```

    The application is generated in the **dist** folder.

1. Change the current directory to the **dist** folder and upload the application to the **$web** blob container.

    ```azurecli
    cd dist
    az storage blob upload-batch -s . -d \$web --account-name <storage account name>
    ```

1. To view the application, open the static website’s primary endpoint URL in a web browser.

    ![First serverless web app home page](../media/1-app-screenshot-new.png)


## Summary

In this unit, you created a storage account. A blob container named **$web** in the storage account stores the static content for your web application and makes the content publicly available. Next, you will learn how to use a serverless function to upload images to Blob storage from this web application.