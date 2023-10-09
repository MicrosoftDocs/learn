To get started, you'll need to set up your Blob Storage account so that you can create the container to which your user's images will be uploaded. Also, you'll enable CORS so users can upload images directly from their browsers. The following steps will walk you through the process of setting up your Blob Storage account.

> [!NOTE]
> You need access to an Azure subscription where you can create resources for this module. When you've finished the module, be sure to delete any resources you created to avoid charges to your subscription.

## Create your Azure Storage account

1. Log in to [the Azure portal](https://portal.azure.com).

1. Select **Create a resource**.

1. Select **Storage** in the Categories menu on the left side of the screen, then select **Storage Account**.

1. Select your **Subscription** and the **Resource group** where you'd like to create the storage account (you can also choose to **Create a new** resource group).

1. Enter a **Storage account name**. You can use `uploadimagesampleXXXX` (with the X characters replaced with random characters of your choosing) or any name you like, but be sure to note the name for future reference.

1. Select a **Region** close to you in which to create the storage account.

1. Leave all other options as their defaults. Select **Review**, then select **Create** when validation completes.

1. When your storage account is ready, select **Go to resource**.

:::image type="content" source="../media/new-storage-account.png" alt-text="Screenshot of the Create a new Storage account page in the Azure portal.":::

## Create a new storage container

1. In your storage account, select **Containers** under **Data storage** in the left-hand menu.

1. Select **+ Container**.

1. Enter **images** for the container **Name**, select **Private** for the **Public access level**, then select **Create.**

:::image type="content" source="../media/new-container.png" alt-text="Screenshot of the Create a new Container page in the Azure portal.":::

## Set up CORS

Finally, you'll set up CORS for your storage account.

1. Select **Resource sharing (CORS)** under **Settings** in the left-hand menu.

1. Enter an asterisk (`*`) for **Allowed origins**, **Allowed headers**, and **Exposed headers**.

1. Select the HTTP verbs you want to allow in the **Allowed methods** dropdown. In this case, select **PUT** and **POST**.

1. Leave the **Max age value** as **0**.

1. Select **Save**.

These values should be customized to fit the needs of your application.

:::image type="content" source="../media/cors-set-up.png" alt-text="Set up CORS":::

You've now successfully set up your storage backend. Next, you'll learn how the serverless backend works.
