Azure Storage Explorer isn't just about storage accounts. You can also use it to investigate and download data from Azure Data Lake Storage.

You've seen how simple it is to create and manage blob and queue resources in your Azure storage account. Now you want to push your understanding further and see how the storage account connects to your developers' data lake, which they use to store infrastructure data for the CRM system.

Azure Data Lake Storage Gen2 is not a dedicated service or account type. It is a set of capabilities that you unlock by enabling the hierarchical namespace feature of an Azure Storage account.
Here, you'll learn how to use Storage Explorer to connect to Azure Data Lake Storage Gen2, create a container, and upload data into it.

## Create a storage account with Azure Data Lake Storage Gen2 capabilities

Let's now look at connecting to a Data Lake Storage Gen2 enabled account. Before you can use Storage Explorer to manage your Data Lake Storage Gen2 enabled account, you need to create the storage account in Azure.

1. To create the Gen2 storage account, use the **az storage account create** command:

   ```azurecli
   az storage account create \
       --name dlstoragetest$RANDOM \
       --resource-group <rgn>[Sandbox resource group]</rgn> \
       --location westus2 \
       --sku Standard_LRS \
       --kind StorageV2 \
       --hns
   ```
> [!NOTE] 
  >  Please give the Storage Account several minutes to complete.

## Connect to your Data Lake Gen2 enabled storage account

Now that you've created a Gen2 enabled storage account, you can connect to it in Storage Explorer.

1. In Storage Explorer, in the **EXPLORER** pane, locate **Concierge Subscription** and expand it to show all the storage accounts.

1. Right-click **Storage Accounts** and select **Connect to Azure storage**.

   ![Screenshot that shows the Connect to Azure storage option.](../media/5-connect-to-azure-storage.png)

1. If you're prompted, sign in with your Azure account.

1. When the connection is successful, you'll see the **dlsstoragetest001 (ADLS Gen2)** storage account displayed under the storage accounts. Your account will have a different number suffix.

   ![Screenshot that shows the Azure Data Lake Storage Gen2 account.](../media/5-azure-data-lake-gen2-storage-account.png)

### Create a container

All containers in a Data Lake Gen2 enabled storage account are blobs. To create a new container:

1. Right-click the **dlsstoragetest001** storage account, and select **Create Blob Container** from the shortcut menu.

    ![Screenshot that shows the shortcut menu for adding a container.](../media/5-data-lake-create-blob-container.png)

1. Name the new container **myfilesystem**.

1. When the container is created, the pane for the container appears. There, you can manage the container contents.

    ![Screenshot that shows the myfilesystem control ribbon and view.](../media/5-data-lake-create-blob-container-view.png )

### Upload and view blob data

With the new **myfilesystem** container created, you can now upload files or folders to it.

1. To upload a file, select the **Upload** option, and select **Upload Files**.

    ![Screenshot that shows the upload options.](../media/5-data-lake-container-upload-options.png)

1. In the dialog box, use the ellipsis (**...**) to select the file that you want to upload.

1. Select the **Upload** button.

1. The file is available to the **myfilesystem** container.

    ![Screenshot that shows the uploaded file.](../media/5-data-lake-file-uploaded.png)

You can upload as many files as you want to this folder. Also, you can create an unlimited number of folders. You can then organize and manage the content in your folders, as you do with your file system.
