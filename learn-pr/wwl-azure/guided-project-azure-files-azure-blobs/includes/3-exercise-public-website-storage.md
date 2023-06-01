

The company website supplies product images, videos, marketing literature, and customer success stories. Customers are located worldwide and demand is rapidly expanding. The content is mission-critical and requires low latency load times. It's important to keep track of the document versions and to quickly restore documents if they're deleted.

## Architecture diagram

| Storage Plan  | Tasks|
| --- | --- |
| :::image type="content" source="../media/task-2.png" alt-text="Diagram with one storage account and one blob container." border="true"::: | <ul><li>Create a storage account with anonymous public access. </li><li> Create a blob storage container. </li><li> Enable soft delete and versioning. </li></ul> |

## Exercise instructions

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

1. Create a storage account to support the public website.

    - In the portal, search for and select **Storage accounts**.  
    - Click **+ Create**. 
    - Select your guided project resource group.  
    - Set the **Storage account name** to **publicwebsite<xxxx>**. Make the storage account name unique by changing the **<xxxx>** identifier.  
    - Click **Review** and then **Create**.
    - Wait for the storage account to deploy, and then click **Go to resource**.
         
     
1. This storage requires high availability if there's a regional outage. To support your global customer base, there should be read access in the secondary region. [Learn more about storage account redundancy](//azure/storage/common/storage-redundancy)

    - In the storage account, select the **Redundancy** blade. 
    - Ensure **Read-access Geo-redundant storage** is selected.
    - Be sure to **Save** your changes.
    - Refresh the page to review the primary and secondary zone information. 


1. The public website has various images and documents. Create a storage container for the content. [Learn more about storage containers](/azure/storage/blobs/storage-blobs-introduction#containers)
    - In your storage account, select the **Containers** blade. 
    - Select **+ Container**. 
    - Ensure the **Name** of the container is **public**. 
    - Click **Create**. 
    

1. Customers should be able to view the images without being authenticated. Configure anonymous read access for the public container blobs.  [Learn more about configuring anonymous public access.](/azure/storage/blobs/anonymous-read-access-configure?tabs=portal)
    - Select your **public** container. 
    - On the **Overview** blade, select **Change access level**. 
    - Ensure the **Public access level** is **Blob (anonymous read access for blobs only)**.
    
1. To proceed with testing, upload a file to the **public** container. The type of file doesn't matter. A small image or text file is a good choice.  
    - Select your container.
    - Click **Upload**. 
    - Browse to a file of your choice. 
    - Click **Upload**. 

1. Determine the URL for your uploaded file. Open a browser and test the URL. 
    - Select your uploaded file.
    - On the **Overview** tab, copy the **URL**.
    - Paste the URL into a new browser tab.
    - Confirm your file displays in the browser. 

1. It's important the images can be restored if they're deleted. Configure blob soft delete for 21 days. [Learn more about soft delete for blobs](/azure/storage/blobs/soft-delete-blob-overview)
    - Go to the **Overview** blade of the storage account.
    - In the **Properties** section, **Blob service** section, ensure Blob soft delete is **Enabled (7 days)**.
    - Don't forget to **Save** your changes. 

1. If something does get deleted, you need to practice using soft delete to restore the files.
    - Click **Delete** to remove the file you uploaded.
    - Refresh the URL page and verify the file doesn't display. 
    - On the container **Overview** page, toggle the slider **Show deleted blobs**. 
    - Select your deleted file, and use the ellipses on the far right, to **Undelete** the file. 
    - Refresh the container and confirm the file has been restored.     

    
1. It's important to keep track of the different product literature versions. [Learn more about blob versioning](/azure/storage/blobs/versioning-overview)
    - Go to the **Overview** blade of the storage account.
    - In the **Properties** section, **Blob service** section, click on **Versioning**, ensure **Enable versioning for blobs** is selected.
    - Don't forget to **Save**.

    
> [!NOTE]
> For additional practice complete the [Configure Azure blob storage](/training/modules/configure-blob-storage/) module. The module has an interactive lab simulation where you can get more practice creating blob storage. 
