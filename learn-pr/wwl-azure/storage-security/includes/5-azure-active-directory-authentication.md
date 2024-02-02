
In addition to Shared Key and Shared Access Signatures, Azure Storage supports using Microsoft Entra ID to authorize requests to blob data. With Microsoft Entra ID, you can use Azure role-based access control (Azure RBAC) to grant permissions to a security principal, which may be a user, group, or application service principal. The security principal is authenticated by Microsoft Entra ID to return an OAuth 2.0 token. The token can then be used to authorize a request against the Blob service.

 -  To authorize requests against Azure Storage with Microsoft Entra ID provides superior security and ease of use over Shared Key authorization. Microsoft recommends using Microsoft Entra authorization with your blob applications when possible to assure access with minimum required privileges.
 -  Authorization with Microsoft Entra ID is available for all general-purpose and Blob storage accounts in all public regions and national clouds. Only storage accounts created with the Azure Resource Manager deployment model support Microsoft Entra authorization.
 -  Blob storage additionally supports creating shared access signatures (SAS) that is signed with Microsoft Entra credentials.

:::image type="content" source="../media/az500-active-directory-blobs-d42b627c.png" alt-text="A Storage Blob Data Contributor and Reader are accessing storage.":::


**A few more details**

When a security principal (a user, group, or application) attempts to access a queue resource, the request must be authorized. With Microsoft Entra ID, access to a resource is a two-step process. First, the security principal's identity is authenticated, and an OAuth 2.0 token is returned. Next, the token is passed as part of a request to the Queue service and used by the service to authorize access to the specified resource.

The authentication step requires that an application request an OAuth 2.0 access token at runtime. If an application is running from within an Azure entity, such as an Azure VM, a Virtual Machine Scale Set, or an Azure Functions app, it can use a managed identity to access queues.

The authorization step requires one or more Azure roles to be assigned to the security principal. Azure Storage provides Azure roles that encompass common sets of permissions for queue data. The roles that are assigned to a security principal determine the permissions that that principal will have.

Native and web applications that request the Azure Queue service can also authorize access with Microsoft Entra ID.
