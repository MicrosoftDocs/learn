Log in to Azure portal and create an Azure Storage Account called `uploadimagesample` (feel free to use any other name you prefer). You can do that by clicking the big plus button that says "Create a new resource", and then type "Storage Account" in the "Search the Marketplace" bar.

:::image type="content" source="../media/new_storage_account.png" alt-text="Create a new Storage account":::

Then navigate to your new storage account, select Containers, and create a new container called `images`.

:::image type="content" source="../media/new_container.png" alt-text="Create a new Container":::

Finally you are going to setup CORS for your storage account. Select CORS in the menu on the left. You need to set a `*` for Allowed origins, Allowed headers, and Exposed headers. Also select the HTTP verbs that you want to allow. In this case PUT and POST. Leave the Max age value as is. These values should be customized to fit the needs of your application.

:::image type="content" source="../media/cors_setup.png" alt-text="Setup CORS":::

Next you are going to see how the serverless backend works.

LINKS:

Please refer to [Cross-Origin Resource Sharing (CORS) support for Azure Storage](https://docs.microsoft.com/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services) for a full guide on how to fine tune CORS for your storage access needs.
