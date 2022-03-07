We have looked at Azure Data Share from the perspective of a data provider, as if you were sharing a dataset with someone else. Now we’re looking into it from the other side, as the data consumer. 

Let’s imagine there’s an analytics organization called Contoso Analytics. Contoso Analytics needs to receive data from Adatum Corporation, who have outsourced to Contoso Analytics because of their analytics capabilities. Contoso Analytics wants the dataset or access to the data of Adatum Corporation in order to proceed with the analytics project. How would you normally get access?

With Azure Data Share the company that has outsourced to you can create a data share with you. 

First, Adatum Corporation needs to invite Contoso Analytics. There are two ways to open the invitation:

*	**Open invitation from email:** To open the invitation from email, you need to check your email inbox for an invitation from your data provider (that is, the company that is sending you the data share) which you can find by searching for "Azure Data share invitation from: *yourdataprovider@domain.com*". 

*	**Open invitation from the Azure portal**: To open the invitation from the Azure portal, search in the Azure portal for data share invitations to access a list of data share invitations that you can accept or reject. 

Now you are ready to receive the data to analyze. Your data share resource’s managed identity needs to get access to the target Azure data store (such as Azure Data Lake Storage Gen2, Azure SQL Database, etc.). 

If you receive the data in a storage account, the data share's resource-managed identity needs to be granted the Storage Blob Data Contributor role. There is no need to set up manually, because if you specify a target data store through the Azure portal and you have proper permissions, the data share service provides it automatically.
 
In other words, if you as a user are an owner or a member of a customer role in which you have Microsoft Authorization/role assignments/write permission to the datastore where the received data needs to land, it is done automatically. 

If this is not the case, you as a user can own the Azure Data store and add the data share resource’s managed identity to the Azure Data store manually, which only needs to be performed once per data share resource. 

Now that you understand how to receive data using Azure Data Share, in the next unit let’s start receiving data with Azure Data Share.