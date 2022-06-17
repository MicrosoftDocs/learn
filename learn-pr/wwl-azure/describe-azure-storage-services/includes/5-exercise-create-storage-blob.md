# Task 1: Create a storage account

In this task, we will create a new storage account.

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/)
2.  From the All services blade, search for and select Storage accounts, and then click + Add, + Create, + New.
3.  On the Basics tab of the Create storage account blade, fill in the following information (replace xxxx in the name of the storage account with letters and digits such that the name is globally unique). Leave the defaults for everything else.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Leave provided default
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        Create new resource group
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Storage account name
      :::column-end:::
      :::column:::
        storageaccountxxxxx
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        (US) East US
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Performance
      :::column-end:::
      :::column:::
        Standard
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Redundancy
      :::column-end:::
      :::column:::
        Locally redundant storage (LRS)
      :::column-end:::
    :::row-end:::
    
    
    Note - Remember to change the xxxxx so that it makes a unique Storage account name
4.  Click Review + Create to review your storage account settings and allow Azure to validate the configuration.
5.  Once validated, click Create. Wait for the notification that the account was successfully created.
6.  From the Home page, search for and select Storage accounts and ensure your new storage account is listed.
    
    [:::image type="content" source="https://microsoftlearning.github.io/AZ-900T0x-MicrosoftAzureFundamentals/Instructions/images/0401.png" alt-text="Screenshot of the newly created storage account in the Azure portal .":::
    ](https://microsoftlearning.github.io/AZ-900T0x-MicrosoftAzureFundamentals/Instructions/images/0401.png)

# Task 2: Work with blob storage

In this task, we will create a Blob container and upload a blob file.

1.  Click the name of the new storage account, scroll to the Data storage section in the left menu, and then click Containers.
2.  Click + Container and complete the information. Use the Information icons to learn more. When done click Create.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        container1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public access level
      :::column-end:::
      :::column:::
        Private (no anonymous access)
      :::column-end:::
    :::row-end:::
    
    
    [:::image type="content" source="https://microsoftlearning.github.io/AZ-900T0x-MicrosoftAzureFundamentals/Instructions/images/0402.png" alt-text="Screenshot of the newly created blob container in the storage account in the Azure portal.":::
    ](https://microsoftlearning.github.io/AZ-900T0x-MicrosoftAzureFundamentals/Instructions/images/0402.png)
3.  Open a new browser window and search Bing for an image of a flower. Right click on the image and save it to your VM.
4.  Back in the Portal, click on container1 , and then select Upload.
5.  Browse for the image file you just saved on your local computer. Select it and then select upload.
6.  Click the Advanced arrow, leave the default values but review the available options, and then click Upload.
    
    Note: You can upload as many blobs as you like in this way. New blobs will be listed within the container.
7.  Once the file is uploaded, right-click on the file and notice the options including View/edit, Download, Properties, and Delete.
8.  If you have time review the options for Files, Tables, and Queues.
