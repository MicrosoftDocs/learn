Serverless SQL pool authentication refers to how users prove their identity when connecting to the endpoint. Two types of authentication are supported:
-	**SQL Authentication** 

    This authentication method uses a username and password.

-	**Microsoft Entra authentication** 

    This authentication method uses identities managed by Microsoft Entra ID. For Microsoft Entra users, multi-factor authentication can be enabled. Use Active Directory authentication (integrated security) whenever possible.

## Authorization

Authorization refers to what a user can do within a serverless SQL pool database and is controlled by your user account's database role memberships and object-level permissions.

If SQL Authentication is used, the SQL user exists only in the serverless SQL pool and permissions are scoped to the objects in the serverless SQL pool. Access to securable objects in other services (such as Azure Storage) can't be granted to a SQL user directly since it only exists in scope of serverless SQL pool. The SQL user needs get authorization to access the files in the storage account.

If Microsoft Entra authentication is used, a user can sign in to a serverless SQL pool and other services, like Azure Storage, and can grant permissions to the Microsoft Entra user.

## Access to storage accounts

A user that is logged into the serverless SQL pool service must be authorized to access and query the files in Azure Storage. Serverless SQL pool supports the following authorization types:

-	Anonymous access 

    To access publicly available files placed on Azure storage accounts that allow anonymous access.

-	Shared access signature (SAS) 

    Provides delegated access to resources in storage account. With a SAS, you can grant clients access to resources in storage account, without sharing account keys. A SAS gives you granular control over the type of access you grant to clients who have the SAS: validity interval, granted permissions, acceptable IP address range, acceptable protocol (https/http).

-	Managed Identity. 

    Is a feature of Microsoft Entra ID that provides Azure services for serverless SQL pool. Also, it deploys an automatically managed identity in Microsoft Entra ID. This identity can be used to authorize the request for data access in Azure Storage. Before accessing the data, the Azure Storage administrator must grant permissions to Managed Identity for accessing the data. Granting permissions to Managed Identity is done the same way as granting permission to any other Microsoft Entra user.

-	User Identity 

    Also known as "pass-through", is an authorization type where the identity of the Microsoft Entra user that logged into serverless SQL pool is used to authorize access to the data. Before accessing the data, Azure Storage administrator must grant permissions to Microsoft Entra user for accessing the data. This authorization type uses the Microsoft Entra user that logged into serverless SQL pool, therefore it's not supported for SQL user types.


Supported authorization types for database users can be found in the table below:

|Authorization type|SQL user|Microsoft Entra user|
|---|---|---|
|User Identity|Not supported|Supported|
|SAS|Supported|Supported|
|Managed Identity|Not supported|Supported|

Supported storage and authorization types can be found in the table below:

|Authorization type|Blob Storage|ADLS Gen1|ADLS Gen2|
|---|---|---|---|
|User Identity|Supported - SAS token can be used to access storage that is not protected with firewall |Not supported|Supported - SAS token can be used to access storage that is not protected with firewall|
|SAS|Supported|Supported|Supported|
|Managed Identity|Supported|Supported|Supported|
