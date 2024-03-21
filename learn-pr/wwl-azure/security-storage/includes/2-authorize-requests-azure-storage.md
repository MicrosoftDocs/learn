Every request made against a secured resource in the Blob, File, Queue, or Table service must be authorized. Authorization ensures that resources in your storage account are accessible only when you want them to be, and only to those users or applications to whom you grant access.

The following table describes the options that Azure Storage offers for authorizing access to resources:

| **Azure artifact** | **Shared Key (storage account key)** | **Shared access signature (SAS)** | **Microsoft Entra ID**                                                     | **On-premises Active Directory Domain Services**            | **Anonymous public read access** |
| ------------------ | ------------------------------------ | --------------------------------- | -------------------------------------------------------------------------- | ----------------------------------------------------------- | -------------------------------- |
| Azure Blobs        | Supported                            | Supported                         | Supported                                                                  | Not Supported                                               | Supported                        |
| Azure Files (SMB)  | Supported                            | Not Supported                     | Supported with Microsoft Entra Domain Services or Microsoft Entra Kerberos | Supported, credentials must be synced to Microsoft Entra ID | Not supported                    |
| Azure Files (REST) | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |
| Azure Queues       | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |
| Azure Tables       | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |

Each authorization option is briefly described below:

**Microsoft Entra ID**: Microsoft Entra is Microsoft's cloud-based identity and access management service. Microsoft Entra ID integration is available for the Blob, File, Queue and Table services. With Microsoft Entra ID, you can assign fine-grained access to users, groups, or applications via role-based access control (RBAC).

**Microsoft Entra Domain Services authorization** for Azure Files: Azure Files supports identity-based authorization over Server Message Block (SMB) through Microsoft Entra Domain Services. You can use RBAC for fine-grained control over a client's access to Azure Files resources in a storage account.

**Microsoft Entra ID authorization** for Azure Files: Azure Files supports identity-based authorization over SMB through Microsoft Entra ID. Your Microsoft Entra domain service can be hosted on on-premises machines or in Azure VMs. SMB access to Files is supported using Microsoft Entra ID credentials from domain joined machines, either on-premises or in Azure. You can use RBAC for share level access control and New Technology File System (NTFS) Discretionary Access Control List (DACLs) for directory and file level permission enforcement.

**Shared Key**: Shared Key authorization relies on your account access keys and other parameters to produce an encrypted signature string that is passed on the request in the Authorization header.

**Shared access signatures**: Shared access signatures (SAS) delegate access to a particular resource in your account with specified permissions and over a specified time interval.

**Anonymous access to containers and blobs**: You can optionally make blob resources public at the container or blob level. A public container or blob is accessible to any user for anonymous read access. Read requests to public containers and blobs do not require authorization.

Authenticating and authorizing access to blob, file, queue and table data with Microsoft Entra ID provides superior security and ease of use over other authorization options. For example, by using Microsoft Entra ID, you avoid having to store your account access key with your code, as you do with Shared Key authorization. While you can continue to use Shared Key authorization with your blob and queue applications, Microsoft recommends moving to Microsoft Entra ID where possible.

Similarly, you can continue to use shared access signatures (SAS) to grant fine-grained access to resources in your storage account, but Microsoft Entra ID offers similar capabilities without the need to manage SAS tokens or worry about revoking a compromised SAS.
