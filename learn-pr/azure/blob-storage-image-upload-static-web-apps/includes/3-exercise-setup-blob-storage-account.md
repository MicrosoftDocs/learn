To get started, you'll need to setup your Blob Storage account so that you can create the container where your user's images will be uploaded to. Also you will enable CORS so users can upload images directly from their browsers. The following steps will walk you through the process of setting up your Blob Storage Account.

## Create your Azure Storage Account

- Log in to Azure portal and create an Azure Storage Account called `uploadimagesample` (feel free to use any other name you prefer). You can do that by clicking the big plus button that says "Create a new resource", and then type "Storage Account" in the "Search the Marketplace" bar.

:::image type="content" source="../media/new-storage-account.png" alt-text="Create a new Storage account":::

## Create a new storage container

- Navigate to your new storage account, select Containers, and create a new container called `images`.

:::image type="content" source="../media/new-container.png" alt-text="Create a new Container":::

## Setup CORS

Finally you are going to setup CORS for your storage account.

1. Select CORS in the menu on the left.
2. Set a `*` for Allowed origins, Allowed headers, and Exposed headers.
3. Select the HTTP verbs that you want to allow. In this case PUT and POST.
4. Leave the Max age value as is.

These values should be customized to fit the needs of your application.

:::image type="content" source="../media/cors-setup.png" alt-text="Setup CORS":::

You've now successfully setup your storage backend. Next you are going to see how the serverless backend works.
