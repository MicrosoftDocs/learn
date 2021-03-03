In this section, you will learn about how, you can allow other users to use the Azure Synapse Apache Spark to Synapse SQL connector in you Synapse workspace. 
So how can you make sure others can use the connector in your workspace too?

First of all, it is necessary to be a Storage Blob Data Owner in relation to the ADLS Gen 2 storage account that is connected to your workspace. 
The reason why they have to have that role, is such that you can alter missing permissions for others. 
In addition to the above, the user needs to have access to the Synapse workspace, so make sure the user permissions or set. 
Also, in order to allow other users to use the connector, it's imperative that this user has permissions to run the notebooks. 

There are two ways to make sure you can other users use the Azure Synapse Apache Spark to Synapse SQL connector. 
Below you'll find the options for you to setting the permissions right. 

The first option is to make the user a storage Blob Data Contributor/Owner. 

The second option is to specify some Access Control Lists (ACLs) on the folder structure. 
In the below table, you'll see what that would look like. 

| Folder | / | synapse | workspaces  | \<workspacename> | sparkpools | \<sparkpoolname>  | sparkpoolinstances  |
|--|--|--|--|--|--|--|--|
| Access Permissions | --X | --X | --X | --X | --X | --X | -WX |
| Default Permissions | ---| ---| ---| ---| ---| ---| ---|

It should be possible to ACL all folders from "synapse" and downward from Azure portal. 
In case you want to ACL the root  "/" folder, there are some additional instructions to keep in mind.

First, you need to connect to the storage account that is connected to the Synapse workspace, which you can use the Storage Explorer for when using Azure Active Directory. 
Second, you need to select your Account and give the ADLS Gen 2 URL, as well as, the default file system for the Synapse workspace. 
Third, if you see the storage account listed, right-click on the listing workspace and make sure you select "Manage Access".
Lastly, you add the User to the / folder with "Execute" Access Permission and select "Ok".

It is imperative that you don't select "Default" when you don't intend to do so. 

