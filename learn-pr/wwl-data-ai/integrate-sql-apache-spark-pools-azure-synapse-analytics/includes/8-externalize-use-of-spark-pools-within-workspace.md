You can allow other users to use the Azure Synapse Apache Spark to Synapse SQL connector in your Azure Synapse workspace. 

First of all, it is necessary to be a Storage Blob Data Owner in relation to the Azure Data Lake Gen 2 storage account that is connected to your workspace. The reason why the user account has to be a member of that role is so that you can alter missing permissions for others. 
In addition to the above, the user needs to have access to the Azure Synapse workspace. Finally, in order to allow other users to use the connector, it's imperative that the user has permissions to run the notebooks. 

Below you'll find the options for you to set the right permissions by configuring Access Control Lists (ACLs) on the folder structure as follows. 

| Folder | / | synapse | workspaces  | \<workspacename> | sparkpools | \<sparkpoolname>  | sparkpoolinstances  |
|--|--|--|--|--|--|--|--|
| Access Permissions | --X | --X | --X | --X | --X | --X | -WX |
| Default Permissions | ---| ---| ---| ---| ---| ---| ---|

You can configure the ACLs for all folders from "synapse" and downward from Azure portal. 
If you want to configure the ACLs from the root "/" folder, there are some extra instructions you should follow:

1. Connect to the storage account that is connected to the Azure Synapse workspace. You can use Azure Storage Explorer to do so. 
2. Select your Account and give the Azure Data Lake Storage Gen 2 URL, and the default file system for the Azure Synapse workspace. 
3. If you see the storage account listed, right-click on the listing workspace and make sure you select "Manage Access".
4. Add the user to the root "/" folder with "Execute" access permission and select "Ok".

