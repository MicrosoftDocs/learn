Azure Storage provides a comprehensive set of security capabilities that together enable developers to build secure applications.

 -  **Encryption**. All data written to Azure Storage is automatically encrypted using Storage Service Encryption (SSE).
 -  **Authentication**. Azure Active Directory (Azure AD) and Role-Based Access Control (RBAC) are supported for Azure Storage for both resource management operations and data operations, as follows:
    
     -  You can assign RBAC roles scoped to the storage account to security principals and use Azure AD to authorize resource management operations such as key management.
     -  Azure AD integration is supported for data operations on the Blob and Queue services.
 -  **Data in transit**. Data can be secured in transit between an application and Azure by using Client-Side Encryption, HTTPS, or SMB 3.0.
 -  **Disk encryption**. OS and data disks used by Azure virtual machines can be encrypted using Azure Disk Encryption.
 -  **Shared Access Signatures**. Delegated access to the data objects in Azure Storage can be granted using Shared Access Signatures.

## Authorization options

Every request made against a secured resource in the Blob, File, Queue, or Table service must be authorized. Authorization ensures that resources in your storage account are accessible only when you want them to be, and only to those users or applications to whom you grant access. Options for authorizing requests to Azure Storage include:

 -  **Azure Active Directory (Azure AD)**. Azure AD is Microsoft's cloud-based identity and access management service. With Azure AD, you can assign fine-grained access to users, groups, or applications via role-based access control (RBAC).
 -  **Shared Key**. Shared Key authorization relies on your account access keys and other parameters to produce an encrypted signature string that is passed on the request in the Authorization header.
 -  **Shared access signatures**. Shared access signatures (SAS) delegate access to a particular resource in your account with specified permissions and over a specified time interval.
 -  **Anonymous access to containers and blobs**. You can optionally make blob resources public at the container or blob level. A public container or blob is accessible to any user for anonymous read access. Read requests to public containers and blobs do not require authorization.
