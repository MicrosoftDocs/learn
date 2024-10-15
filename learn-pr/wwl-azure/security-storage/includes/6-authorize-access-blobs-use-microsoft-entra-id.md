Azure Storage supports using Microsoft Entra ID to authorize requests to blob data. With Microsoft Entra ID, you can use Azure role-based access control (Azure RBAC) to grant permissions to a security principal, which may be a user, group, or application service principal. The security principal is authenticated by Microsoft Entra ID to return an OAuth 2.0 token. The token can then be used to authorize a request against the Blob service.

Authorization with Microsoft Entra ID is available for all general-purpose and Blob storage accounts in all public regions and national clouds. Only storage accounts created with the Azure Resource Manager deployment model support Microsoft Entra authorization.

For optimal security, Microsoft recommends using Microsoft Entra ID with managed identities to authorize requests against blob, queue, and table data, whenever possible. Authorization with Microsoft Entra ID and managed identities provides superior security and ease of use over Shared Key authorization. To learn more about managed identities, see [What are managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview). For an example of how to enable and use a managed identity for a .NET application, see [Authenticating Azure-hosted apps to Azure resources with .NET](/dotnet/azure/sdk/authentication/azure-hosted-apps).

For resources hosted outside of Azure, such as on-premises applications, you can use managed identities through Azure Arc. For example, apps running on Azure Arc-enabled servers can use managed identities to connect to Azure services. To learn more, see [Authenticate against Azure resources with Azure Arc-enabled servers](/azure/azure-arc/servers/managed-identity-authentication).

For scenarios where shared access signatures (SAS) are used, Microsoft recommends using a user delegation SAS. A user delegation SAS is secured with Microsoft Entra credentials instead of the account key. To learn about shared access signatures, see [Grant limited access to data with shared access signatures](/azure/storage/common/storage-sas-overview). For an example of how to create and use a user delegation SAS with .NET, see [Create a user delegation SAS for a blob with .NET](/azure/storage/blobs/storage-blob-user-delegation-sas-create-dotnet).

## Overview of Microsoft Entra ID for blobs<br>

When a security principal (a user, group, or application) attempts to access a blob resource, the request must be authorized, unless it's a blob available for anonymous access. With Microsoft Entra ID, access to a resource is a two-step process:

1.  First, the security principal's identity is authenticated and an OAuth 2.0 token is returned.

 -  The authentication step requires that an application request an OAuth 2.0 access token at runtime. If an application is running from within an Azure entity such as an Azure VM, a virtual machine scale set, or an Azure Functions app, it can use a [managed identity](/azure/active-directory/managed-identities-azure-resources/overview) to access blob data.

2.  Next, the token is passed as part of a request to the Blob service and used by the service to authorize access to the specified resource.

 -  Next, the token is passed as part of a request to the Blob service and used by the service to authorize access to the specified resource.

### Use a Microsoft Entra account with portal, PowerShell, or Azure CLI

To learn about how to access data in the Azure portal with a Microsoft Entra account, see [Data access from the Azure portal](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-the-azure-portal). To learn how to call Azure PowerShell or Azure CLI commands with a Microsoft Entra account, see [Data access from PowerShell or Azure CLI](/azure/storage/blobs/authorize-access-azure-active-directory#data-access-from-powershell-or-azure-cli).

### Use Microsoft Entra ID to authorize access in application code<br>

To authorize access to Azure Storage with Microsoft Entra ID, you can use one of the following client libraries to acquire an OAuth 2.0 token:

 -  The Azure Identity client library is recommended for most development scenarios.
 -  The [Microsoft Authentication Library (MSAL)](/azure/active-directory/develop/msal-overview) may be suitable for certain advanced scenarios.

#### Azure Identity client library

The Azure Identity client library simplifies the process of getting an OAuth 2.0 access token for authorization with Microsoft Entra ID via the [Azure SDK](https://github.com/Azure/azure-sdk). The latest versions of the Azure Storage client libraries for .NET, Java, Python, JavaScript, and Go integrate with the Azure Identity libraries for each of those languages to provide a simple and secure means to acquire an access token for authorization of Azure Storage requests.

An advantage of the Azure Identity client library is that it enables you to use the same code to acquire the access token whether your application is running in the development environment or in Azure. The Azure Identity client library returns an access token for a security principal. When your code is running in Azure, the security principal may be a managed identity for Azure resources, a service principal, or a user or group. In the development environment, the client library provides an access token for either a user or a service principal for testing purposes.

The access token returned by the Azure Identity client library is encapsulated in a token credential. You can then use the token credential to get a service client object to use in performing authorized operations against Azure Storage. A simple way to get the access token and token credential is to use the **DefaultAzureCredential** class that is provided by the Azure Identity client library. **DefaultAzureCredential** attempts to get the token credential by sequentially trying several different credential types. **DefaultAzureCredential** works in both the development environment and in Azure.

The following table points to additional information for authorizing access to data in various scenarios:

| **Language**                             | **.NET**                                                                                                                                                                                      | **Java**                                                                                                                            | **JavaScript**                                                                                                                                                                                  | **Python**                                                                                                                                                                                                | **Go**                                                                                                                                                        |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Overview of auth with Microsoft Entra ID | [How to authenticate .NET applications with Azure services](/dotnet/azure/sdk/authentication)                                                                      | [Azure authentication with Java and Azure Identity](/azure/developer/java/sdk/identity)                  | [Authenticate JavaScript apps to Azure using the Azure SDK](/azure/developer/javascript/sdk/authentication/overview)                                                 | [Authenticate Python apps to Azure using the Azure SDK](/azure/developer/python/sdk/authentication-overview)                                                                   | N/A                                                                                                                                                           |
| Auth using developer service principals  | [Authenticate .NET apps to Azure services during local development using service principals](/dotnet/azure/sdk/authentication-local-development-service-principal) | [Azure authentication with service principal](/azure/developer/java/sdk/identity-service-principal-auth) | [Auth JS apps to Azure services with service principal](/azure/developer/javascript/sdk/authentication/local-development-environment-service-principal)              | [Authenticate Python apps to Azure services during local development using service principals](/azure/developer/python/sdk/authentication-local-development-service-principal) | [Azure SDK for Go authentication with a service principal](/azure/developer/go/azure-sdk-authentication-service-principal)         |
| Auth using developer or user accounts    | [Authenticate .NET apps to Azure services during local development using developer accounts](/dotnet/azure/sdk/authentication-local-development-dev-accounts)      | [Azure authentication with user credentials](/azure/developer/java/sdk/identity-user-auth)               | [Auth JS apps to Azure services with dev accounts](/azure/developer/javascript/sdk/authentication/local-development-environment-developer-account)                   | [Authenticate Python apps to Azure services during local development using developer accounts](/azure/developer/python/sdk/authentication-local-development-dev-accounts)      | [Azure authentication with the Azure SDK for Go](/azure/developer/go/azure-sdk-authentication)                                     |
| Auth from Azure-hosted apps              | [Authenticating Azure-hosted apps to Azure resources with the Azure SDK for .NET](/dotnet/azure/sdk/authentication-azure-hosted-apps)                              | [Authenticate Azure-hosted Java applications](/azure/developer/java/sdk/identity-azure-hosted-auth)      | [Authenticating Azure-hosted JavaScript apps to Azure resources with the Azure SDK for JavaScript](/azure/developer/javascript/sdk/authentication/azure-hosted-apps) | [Authenticating Azure-hosted apps to Azure resources with the Azure SDK for Python](/azure/developer/python/sdk/authentication-azure-hosted-apps)                              | [Authentication with the Azure SDK for Go using a managed identity](/azure/developer/go/azure-sdk-authentication-managed-identity) |
| Auth from on-premises apps               | [Authenticate to Azure resources from .NET apps hosted on-premises](/dotnet/azure/sdk/authentication-on-premises-apps)                                             | N/A                                                                                                                                 | [Authenticate on-premises JavaScript apps to Azure resources](/azure/developer/javascript/sdk/authentication/on-premises-apps)                                       | [Authenticate to Azure resources from Python apps hosted on-premises](/azure/developer/python/sdk/authentication-on-premises-apps)                                             | N/A                                                                                                                                                           |
| Identity client library overview         | [Azure Identity client library for .NET](/dotnet/api/overview/azure/identity-readme)                                                                               | [Azure Identity client library for Java](/java/api/overview/azure/identity-readme)                       | [Azure Identity client library for JavaScript](/javascript/api/overview/azure/identity-readme)                                                                       | [Azure Identity client library for Python](/python/api/overview/azure/identity-readme)                                                                                         | [Azure Identity client library for Go](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity)                                                   |

### Microsoft Authentication Library (MSAL)<br>

While Microsoft recommends using the Azure Identity client library when possible, the MSAL library may be appropriate to use in certain advanced scenarios. For more information, see [Learn about MSAL](/azure/active-directory/develop/msal-overview).

When you use MSAL to acquire an OAuth token for access to Azure Storage, you need to provide a Microsoft Entra resource ID. The Microsoft Entra resource ID indicates the audience for which a token that is issued can be used to provide access to an Azure resource. In the case of Azure Storage, the resource ID may be specific to a single storage account, or it may apply to any storage account.

When you provide a resource ID that is specific to a single storage account and service, the resource ID is used to acquire a token for authorizing requests to the specified account and service only. The following table lists examples of values to use for the resource ID, based on the cloud you're working with. Replace `<account-name>` with the name of your storage account.

| **Cloud**            | **Resource ID**                                     |
| -------------------- | --------------------------------------------------- |
| Azure Global         | `example: account-name.blob.core.windows.net`       |
| Azure Government     | `example: account-name.blob.core.usgovcloudapi.net` |
| Azure China 21Vianet | `example: account-name.blob.core.chinacloudapi.cn`  |

You can also provide a resource ID that applies to any storage account, as shown in the following table. This resource ID is the same for all public and sovereign clouds, and is used to acquire a token for authorizing requests to any storage account.

| **Cloud**                                                    | **Resource ID**              |
| ------------------------------------------------------------ | ---------------------------- |
| Azure Global<br>Azure Government<br>Azure China 21Vianet<br> | `example: storage.azure.com` |

## Assign Azure roles for access rights

Microsoft Entra authorizes access rights to secured resources through Azure RBAC. Azure Storage defines a set of built-in RBAC roles that encompass common sets of permissions used to access blob data. You can also define custom roles for access to blob data. To learn more about assigning Azure roles for blob access, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access).

A Microsoft Entra security principal may be a user, a group, an application service principal, or a [managed identity for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview). The RBAC roles that are assigned to a security principal determine the permissions that the principal has for the specified resource. To learn more about assigning Azure roles for blob access, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access)

In some cases you may need to enable fine-grained access to blob resources or to simplify permissions when you have a large number of role assignments for a storage resource. You can use Azure attribute-based access control (Azure ABAC) to configure conditions on role assignments. You can use conditions with a [custom role](/azure/role-based-access-control/custom-roles) or select built-in roles. For more information about configuring conditions for Azure storage resources with ABAC, see [Authorize access to blobs using Azure role assignment conditions (preview)](/azure/storage/blobs/storage-auth-abac). For details about supported conditions for blob data operations, see [Actions and attributes for Azure role assignment conditions in Azure Storage (preview)](/azure/storage/blobs/storage-auth-abac-attributes).

When you create an Azure Storage account, you are not automatically assigned permissions to access data via Microsoft Entra ID. You must explicitly assign yourself an Azure role for access to Blob Storage. You can assign it at the level of your subscription, resource group, storage account, or container.

## Resource scope

Before you assign an Azure RBAC role to a security principal, determine the scope of access that the security principal should have. Best practices dictate that it's always best to grant only the narrowest possible scope. Azure RBAC roles defined at a broader scope are inherited by the resources beneath them.

You can scope access to Azure blob resources at the following levels, beginning with the narrowest scope:

 -  An individual container. At this scope, a role assignment applies to all of the blobs in the container, and to the container properties and metadata.
 -  The storage account. At this scope, a role assignment applies to all containers and their blobs.
 -  The resource group. At this scope, a role assignment applies to all of the containers in all of the storage accounts in the resource group.
 -  The subscription. At this scope, a role assignment applies to all of the containers in all of the storage accounts in all of the resource groups in the subscription.
 -  A management group. At this scope, a role assignment applies to all of the containers in all of the storage accounts in all of the resource groups in all of the subscriptions in the management group.

## Azure built-in roles for blobs

Azure RBAC provides several built-in roles for authorizing access to blob data using Microsoft Entra ID and OAuth. Some examples of roles that provide permissions to data resources in Azure Storage include:

 -  [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner): Use to set ownership and manage POSIX access control for Azure Data Lake Storage Gen2. For more information, see [Access control in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control).
 -  [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor): Use to grant read/write/delete permissions to Blob storage resources.
 -  [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader): Use to grant read-only permissions to Blob storage resources.
 -  [Storage Blob Delegator](/azure/role-based-access-control/built-in-roles#storage-blob-delegator): Get a user delegation key to use to create a shared access signature that is signed with Microsoft Entra credentials for a container or blob.

To learn how to assign an Azure built-in role to a security principal, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access). To learn how to list Azure RBAC roles and their permissions, see [List Azure role definitions](/azure/role-based-access-control/role-definitions-list).

For more information about how built-in roles are defined for Azure Storage, see [Understand role definitions](/azure/role-based-access-control/role-definitions#control-and-data-actions). For information about creating Azure custom roles, see [Azure custom roles](/azure/role-based-access-control/custom-roles).

Only roles explicitly defined for data access permit a security principal to access blob data. Built-in roles such as **Owner**, **Contributor**, and **Storage Account Contributor** permit a security principal to manage a storage account, but don't provide access to the blob data within that account via Microsoft Entra ID. However, if a role includes **Microsoft.Storage/storageAccounts/listKeys/action**, then a user to whom that role is assigned can access data in the storage account via Shared Key authorization with the account access keys. For more information, see [Choose how to authorize access to blob data in the Azure portal](/azure/storage/blobs/authorize-data-operations-portal).

For detailed information about Azure built-in roles for Azure Storage for both the data services and the management service, see the **Storage** section in [Azure built-in roles for Azure RBAC](/azure/role-based-access-control/built-in-roles#storage). Additionally, for information about the different types of roles that provide permissions in Azure, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).

Azure role assignments may take up to 30 minutes to propagate.

### Access permissions for data operations

For details on the permissions required to call specific Blob service operations, see [Permissions for calling data operations](/rest/api/storageservices/authorize-with-azure-active-directory#permissions-for-calling-data-operations).

## Access data with a Microsoft Entra account<br>

Access to blob data via the Azure portal, PowerShell, or Azure CLI can be authorized either by using the user's Microsoft Entra account or by using the account access keys (Shared Key authoti

Authorization with Shared Key is not recommended as it may be less secure. For optimal security, disable authorization via Shared Key for your storage account, as described in [Prevent Shared Key authorization for an Azure Storage account](/azure/storage/common/shared-key-authorization-prevent).

Use of access keys and connection strings should be limited to initial proof of concept apps or development prototypes that don't access production or sensitive data. Otherwise, the token-based authentication classes available in the Azure SDK should always be preferred when authenticating to Azure resources.

Microsoft recommends that clients use either Microsoft Entra ID or a shared access signature (SAS) to authorize access to data in Azure Storage. For more information, see [Authorize operations for data access](/azure/storage/common/authorize-data-access?toc=/azure/storage/blobs/toc.json&bc=/azure/storage/blobs/breadcrumb/toc.json).

## Data access from the Azure portal

The Azure portal can use either your Microsoft Entra account or the account access keys to access blob data in an Azure storage account. Which authorization scheme the Azure portal uses depends on the Azure roles that are assigned to you.

When you attempt to access blob data, the Azure portal first checks whether you've been assigned an Azure role with **Microsoft.Storage/storageAccounts/listkeys/action**. If you've been assigned a role with this action, then the Azure portal uses the account key for accessing blob data via Shared Key authorization. If you haven't been assigned a role with this action, then the Azure portal attempts to access data using your Microsoft Entra account.

To access blob data from the Azure portal using your Microsoft Entra account, you need permissions to access blob data, and you also need permissions to navigate through the storage account resources in the Azure portal. The built-in roles provided by Azure Storage grant access to blob resources, but they don't grant permissions to storage account resources. For this reason, access to the portal also requires the assignment of an Azure Resource Manager role such as the [Reader](/azure/role-based-access-control/built-in-roles#reader) role, scoped to the level of the storage account or higher. The **Reader** role grants the most restricted permissions, but another Azure Resource Manager role that grants access to storage account management resources is also acceptable. To learn more about how to assign permissions to users for data access in the Azure portal with a Microsoft Entra account, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access).

The Azure portal indicates which authorization scheme is in use when you navigate to a container. For more information about data access in the portal, see [Choose how to authorize access to blob data in the Azure portal](/azure/storage/blobs/authorize-data-operations-portal).

## Data access from PowerShell or Azure CLI

Azure CLI and PowerShell support signing in with Microsoft Entra credentials. After you sign in, your session runs under those credentials.

## Feature support

Support for this feature might be impacted by enabling Data Lake Storage Gen2, Network File System (NFS) 3.0 protocol, or the SSH File Transfer Protocol (SFTP).
