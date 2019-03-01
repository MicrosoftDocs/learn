Next, let's create an Azure Storage account and Blob storage container to hold the data we want to import into our data warehouse.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating the Blob container and associated storage account.

## Create the Azure Storage account

1. Sign into the [Azure portal](https://portal.azure.com) with your Azure account.
1. Click **Create a Resource** in the left sidebar.
1. Select **Storage** > **Storage account**.

    ![Screenshot showing the Storage account option selection from the list](../media/4-exercise-create-blob-storage-account.png)

1. On the **Basics** tab, select your subscription and use the **mslearn-demodw** Resource group.
1. Name your storage account **demodwstorage**.
1. Select the same _Location_ you placed your database in.
1. Click **Review + create** to validate the account details.
1. Once validation passes, click **Create** to start the deployment process.

Wait for the deployment to complete. You should get a popup notification from the browser, or you can click the **Notification** icon in the toolbar to monitor the deployment progress.

## Create the Blob container for our import data

Next, we need to create a blob container that will hold our source data.

1. Select **Go to resource** from the deployment page, or locate your new storage account using the search bar at the top of the window.
1. Select **Blobs** in the **Services** section of the **Overview** page.

    ![Screenshot showing the creating a Blob in the storage account option](../media/4-exercise-create-blob-storage-blobs.png)

1. You need a container to store the files, click **+ Container** from the top menu.
1. Name the container **data-files**.
1. Set the _Public access_ to **Blob (anonymous read access for blobs only)**.

    ![Screenshot showing the New Blob creation screen with details filled in](../media/4-create-blob-container.png)

1. Click **OK** to create the container.

![Screenshot showing the data-files container in the Blob account](../media/4-exercise-create-blob-storage-container.png)

