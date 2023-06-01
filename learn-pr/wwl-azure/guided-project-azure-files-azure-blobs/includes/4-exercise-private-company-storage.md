

The company needs storage for their offices and departments. This content is private to the company and shouldn't be shared without consent. This storage requires high availability if there's a regional outage. The company wants to use this storage to back up the public website storage. 

## Architecture diagram

| Storage Plan | Tasks|
| --- | --- |
| :::image type="content" source="../media/task-3.png" alt-text="Diagram with one storage account and two blob containers." border="true"::: | <ul><li>Create a storage account.<li>Create a storage container with restricted access.</li><li>Configure a shared access signature for partners.</li><li>Back up the public website storage.<li>Implement lifecycle management to move content to the cool tier.</li></ul>|

## Exercise instructions

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

1. Create a storage account for the internal private company documents.
    - In the portal, search for and select **Storage accounts**.  
    - Click **+ Create**. 
    - Select your guided project resource group.  
    - Set the **Storage account name** to **private**. 
    - Click **Review** and then **Create** the storage account. 
    - Wait for the storage account to deploy, and then click **Go to resource**.

1. This storage requires high availability if there's a regional outage. However, read access in a secondary region isn't required. Configure the appropriate level of **redundancy**. [Learn more about storage account redundancy](//azure/storage/common/storage-redundancy)

    - In the storage account, select the **Redundancy** blade. 
    - Ensure **Geo-redundant storage (GRS)** is selected.
    - **Save** your changes.
    - Refresh the page and review the primary and secondary zone information. 

1. Create a private storage container for the corporate data. 

    - In the storage account, select the **Containers** blade. 
    - Click **+ Container**. 
    - Ensure the **Name** of the container is **private**.
    - Ensure the **Public access level** is **Private (no anonymous access)**.
    - Take the defaults for the other values.
    - Click **Review** and then **Create**. 
    - Wait for the container to deploy then click **Go to resource**.
   
1.  Test to ensure the private container isn't publically accessible. 

    - Upload a file from your desktop to the container. The type of file doesn't matter. A small image or text file is a good choice. 
    - Locate the URL for the file.
    - Open a browser and navigate to the URL.
    - Verify the file doesn't display and isn't publically accessible. 


1. An external partner requires read and write access to the file for at least the next 24 hours. Configure and test a shared access signature (SAS). [Learn more about Shared Access Signatures](/rest/api/storageservices/delegate-access-with-shared-access-signature)

    - Select your uploaded blob file and move to the **Generate SAS** tab. 
    - Ensure the **Read** and **Write** permissions are selected. 
    - Verify the **Start and expiry date/time** is for the next 24 hours. 
    - Click **Generate SAS token and URL**. 
    - Using a browser, navigate to the **Blob SAS URL** page. 
    - Ensure that your file displays. 
    
1. To save on cost, after 30 days, move blobs from the hot tier to the cool tier. [Manage the Azure Blob storage lifecycle](/training/modules/manage-azure-blob-storage-lifecycle/)

    - In the storage account, under **Data management** select the **Lifecycle management blade**.
    - Click **Add rule**. 
    - Set the **Rule name** to **movetocool**.
    - Set the **Rule scope** to **Apply rule to all blobs in the storage account**.
    - Click **Next**.
    - Ensure **Last modified** is selected.
    - Set **More than (days ago)** to **30**.
    - In the **Then** drop-down select **Move to cool storage**. 
    - **Add** the rule.
  
1. The public website files need to be backed up to another storage account. [Learn more about object replication](/azure/storage/blobs/object-replication-overview)

    - In your storage account, create a new container called **backup**. Use the default values.
    - Navigate to your **publicwebsite** storage account. This storage account was created in the previous exercise. 
        - Select the **Object replication** blade. 
        - Click **Create replication rules** and set the **Destination storage account** to **private** storage account.
        - Set the **Source container** to **public** and the **Destination container** to **backup**.
        - **Create** the replication rule. 
        - Upload a file to the **public** container. This will be your replication test file. 
    - Return to the **private** storage account and refresh the **backup** container.
    - Ensure the newly uploaded file was copied to the **backup** container. 
    - It may take 2-3 minutes for the file to appear. 

