It's easy to navigate the contents of an Azure Storage account by using Azure Storage Explorer.

Now that you have a better understanding of the features and capabilities of Azure Storage Explorer, you want to try it for yourself. You want to use it to explore some of the files that your Customer Relationship Management (CRM) system places in Azure Storage. 
 
Here, you'll get to try Azure Storage Explorer for yourself by downloading, installing, and connecting to an Azure Storage account.  You'll create both a blob and a queue in your Azure Storage account.

## Download and Install Azure Storage Explorer

To get started with Azure Storage Explorer, you'll need to download and install it.  

You can download it from the [Microsoft Azure Storage Explorer website](https://azure.microsoft.com/en-us/features/storage-explorer/).

![Screenshot from the Microsoft Azure Storage Explorer website showing how to download the app](../media/3-download-storage-explorer.png)

1. Select your preferred **Operating system**.  We'll use the Windows version of the application for the rest of this exercise.  
1. When you've selected your operating system, select the **Download now** button to download the Storage Explorer installer application to your local computer.
1. Locate the downloaded file and run it. For the Windows version, use the **StorageExplorer.exe** file.
1. Accept the licensing agreement, and select **Install**.

    ![Screenshot showing the installation licensing agreement](../media/3-install-storage-explorer-1.png)

1. You can either browse to the location where you want to install Storage Explorer or accept the default location.  Once you've selected the installation destination, select **Next**.

    ![Screenshot showing the installation licensing agreement](../media/3-install-storage-explorer-2.png)

1. For Windows installations, select the start menu folder. Accept the default and select **Next**.
1. When the installation is complete, select **Finish**.

    ![Screenshot showing the installation licensing agreement](../media/3-install-storage-explorer-3.png)

Azure Storage Explorer automatically launches after installation.

## Connect to an Azure Account

When you first launch Azure Storage Explorer, it displays the Connect to Azure Storage Wizard.

![Screenshot showing the Connect to Azure Storage wizard. ](../media/3-storage-explorer-connect.png)

1. The first thing you need to do is connect to Azure. There are several **Azure environment** options to select from:

   - Azure
   - Azure China
   - Azure Germany
   - Azure US Government
   - Add new environment

   Choose **Azure** and select **Next**.

1. An Azure sign-in page is displayed. Use your Azure credentials to sign in.

    ![Screenshot showing the Azure Sign-in page](../media/3-storage-explorer-azure-sign-in.png)

1. Once you've signed in to your Azure instance, the associated Azure account and Azure subscription are displayed in the Account Management section.

    ![Screenshot showing the account management panel after signing into an Azure account](../media/3-account-panel-subscriptions-apply.png)

   Confirm that the subscription and account details are correct, and select the **Apply** option.

You have now connected Storage Explorer to your Azure Subscription. Don't close the Storage Explorer application.

## Storage account virtual folders

Every Storage account you create is given four virtual folders. These folders don't exist until you assign data to them, but can be used to create data. The four virtual folders are containers, file shares, tables, and queues. When creating a blob in your storage account, add it to the virtual folder **containers**.  Your Storage account lets you have as many containers as you want, and each container can have as many blobs as needed.

## Create a blob in your Azure Storage Account

To create a blob in your container:

1. Using your Storage Explorer application, toggle the **Explorer** view.

    ![Screenshot showing the toggle explorer option](../media/3-storage-explorer-create-blob-1.png)

1. In the resource tree, find the **Concierge Subscription**, and expand the options.
1. Select the **cloudshell** Storage account. The cloudshell Storage account created in your sandbox may end with a different set of numbers. You'll see that it has four virtual folders: Blob Containers, File Shares, Queues, and Tables.
1. Right-click on the **Blob Containers** virtual folder to access the context menu, and select **Create Blob Container**.

    ![Screenshot showing the context menu options for Blob Containers](../media/3-storage-explorer-create-blob-context-menu.png)

1. An empty and unnamed blob container is now created inside the Blob Containers folder. To create the blob storage container, give it a name.  

   > NOTE:
   > Container names have specific rules governing how they can be named: They must begin and end in either a letter or number, must be all lowercase, and can have numbers and hyphens. Names cannot contain a double hyphen.

   ![Screenshot showing an empty blob entity waiting to be named](../media/3-storage-explorer-create-blob-name.png)

   Give this new blob the name **myblob** and press **Enter** when done. Each created container appears in a tab to the right of the resource tree.

   ![Screenshot showing the content and details of the new myblob blob container](../media/3-storage-explorer-create-blob-view.png)

1. From this view, you can manage the content of the blob container.

## Create a queue in your Azure Storage Account

To create a queue in your Storage account:

1. In the resource tree, find the **Concierge Subscription**, and expand the options.
1. Select the **cloudshell** storage account.
1. Right-click on the **Queues** virtual folder to access the context menu, and select **Create Queue**.

    ![Screenshot showing the context menu options for Queues](../media/3-storage-explorer-create-queue-1.png)

1. An empty and unnamed queue is created inside the Queues folder. The queue won't be created until you give it a name.

    > NOTE:
    > Container names have specific rules governing how they can be named: The must begin and end in either a letter or number, must by all lowercase, can have numbers and hyphens. It cannot contain a double hyphen.

   ![Screenshot showing an empty blob entity waiting to be named](../media/3-storage-explorer-create-queue-name.png)

   Give this new queue the name **myqueue** and press **Enter** when done, which creates the queue. Each created queue appears in a tab to the right of the resource tree.

   ![Screenshot showing the content and details of the new myblob blob container](../media/3-storage-explorer-create-queue-view.png)

1. From this view, you can manage the content of the queue.