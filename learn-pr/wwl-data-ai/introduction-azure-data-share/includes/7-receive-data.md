We have looked at Azure Data Share from the perspective as a data provider, as if you were sharing a dataset with someone else. Now we’re looking into it from the other side, as one of the recipients as a data consumer. 

Let’s imagine there’s an Analytics Organization that needs to receive data from a company that has outsourced to you for your analytics capabilities. You would want the dataset or access to the data in order to proceed with your analytics project. How would you normally get access?

Well, Azure Data Share is there to solve this problem for you. The company that has outsourced to you can create a Data Share with you. 

First of all,    the company that wants to share data with you, needs to invite you. There are two ways to open the invitation:

*	*Open invitation from email*:

    In order to open the invitation from email, you need to check your email inbox for an invitation from your data provider (that is, the company that is sending you the data share) which you can find easily by checking the title: Azure Data share invitation from: yourdataprovider@domain.com. 

*	*Open invitation from Azure portal*:

    In order to open the invitation from the Azure portal, you can search in the Azure portal for Data Share Invitations where you will be taken into a list of data share invitations that you can accept/reject. 

The next step is to receive the data that you are able to analyze. The first step is that your data share resource’s managed identity needs to get access to the target Azure data store (such as  Data Lake, SQL DB etc.). 

If receiving the data in a storage account, the data share resource-managed identity needs to be granted the Storage Blob Data Contributor role. There is no need to set up manually, because if you specify a target data store through the Azure portal and you as a data consumer user has proper permission, the data share service provides it automatically.
 
In other words, if you as a user is an owner or a member of a customer role in which you have Microsoft Authorization/role assignments/write permission of the datastore where the received data needs to land, it is done automatically. 

However, if that is not the case, you as a user can own the Azure Data store and add the data share resource’s managed identity to the Azure Data store manually, which only needs to be performed once per data share resource. 
