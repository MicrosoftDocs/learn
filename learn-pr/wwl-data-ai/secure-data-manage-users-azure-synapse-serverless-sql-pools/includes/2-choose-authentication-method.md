Serverless SQL pool authentication refers to how users prove their identity when connecting to the endpoint. Two types of authentication are supported:
-	**SQL Authentication** 

    This authentication method uses a username and password.

-	**Azure Active Directory Authentication** 

    This authentication method uses identities managed by Azure Active Directory. For Azure AD users, multi-factor authentication can be enabled. Use Active Directory authentication (integrated security) whenever possible.

## Authorization

Authorization refers to what a user can do within a serverless SQL pool database and is controlled by your user account's database role memberships and object-level permissions.

If SQL Authentication is used, the SQL user exists only in serverless SQL pool and permissions are scoped to the objects in serverless SQL pool. Access to securable objects in other services (such as Azure Storage) can't be granted to SQL user directly since it only exists in scope of serverless SQL pool. The SQL user needs to use one of the supported authorization types to access the files.

If Azure AD authentication is used, a user can sign in to serverless SQL pool and other services, like Azure Storage, and can grant permissions to the Azure AD user.

## Access to storage accounts

A user that is logged into the serverless SQL pool service must be authorized to access and query the files in Azure Storage. serverless SQL pool supports the following authorization types:

-	Anonymous access 

    To access publicly available files placed on Azure storage accounts that allow anonymous access.

-	Shared access signature (SAS) 

    Provides delegated access to resources in storage account. With a SAS, you can grant clients access to resources in storage account, without sharing account keys. A SAS gives you granular control over the type of access you grant to clients who have the SAS: validity interval, granted permissions, acceptable IP address range, acceptable protocol (https/http).

-	Managed Identity. 

    Is a feature of Azure Active Directory (Azure AD) that provides Azure services for serverless SQL pool. Also, it deploys an automatically managed identity in Azure AD. This identity can be used to authorize the request for data access in Azure Storage. Before accessing the data, the Azure Storage administrator must grant permissions to Managed Identity for accessing the data. Granting permissions to Managed Identity is done the same way as granting permission to any other Azure AD user.

-	User Identity 

    Also known as "pass-through", is an authorization type where the identity of the Azure AD user that logged into serverless SQL pool is used to authorize access to the data. Before accessing the data, Azure Storage administrator must grant permissions to Azure AD user for accessing the data. This authorization type uses the Azure AD user that logged into serverless SQL pool, therefore it's not supported for SQL user types.


Supported authorization types for databases users can be found in the table below:

|Authorization type|SQL user|Azure AD user|
|---|---|---|
|User Identity|Not supported|Supported|
|SAS|Supported|Supported|
|Managed Identity|Not supported|Supported|

Supported storages and authorization types can be found in the table below:

|Authorization type|Blob Storage|ADLS Gen1|ADLS Gen2|
|---|---|---|---|
|User Identity|Supported - SAS token can be used to access storage that is not protected with firewall |Not supported|Supported - SAS token can be used to access storage that is not protected with firewall|
|SAS|Supported|Supported|Supported|
|Managed Identity|Supported|Supported|Supported|
