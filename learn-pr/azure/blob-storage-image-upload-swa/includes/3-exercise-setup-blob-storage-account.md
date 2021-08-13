To get started, you'll need to setup your Blob Storage account so that you can create the container where your user's images will be uploaded to. Also you will enable CORS so users can upload images directly from their browsers. The following steps will walk you through the process of setting up your Blob Storage Account.

Log in to Azure portal and create an Azure Storage Account called `uploadimagesample` (feel free to use any other name you prefer). You can do that by clicking the big plus button that says "Create a new resource", and then type "Storage Account" in the "Search the Marketplace" bar.

:::image type="content" source="../media/new_storage_account.png" alt-text="Create a new Storage account":::

Then navigate to your new storage account, select Containers, and create a new container called `images`.

:::image type="content" source="../media/new_container.png" alt-text="Create a new Container":::

Finally you are going to setup CORS for your storage account. Select CORS in the menu on the left. You need to set a `*` for Allowed origins, Allowed headers, and Exposed headers. Also select the HTTP verbs that you want to allow. In this case PUT and POST. Leave the Max age value as is. These values should be customized to fit the needs of your application.

:::image type="content" source="../media/cors_setup.png" alt-text="Setup CORS":::

Next you are going to see how the serverless backend works.
