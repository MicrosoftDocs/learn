Requests for a secured resource in the Blob, File, Queue, or Table service must be authorized. Authorization ensures that resources in your storage account are accessible only when you want them to be, and only to those users or applications to whom you grant access. Choosing the right authorization method is a critical security decision that should align with Zero Trust principles—verify explicitly, use least privilege access, and assume breach.

The following table describes the options that Azure Storage offers for authorizing access to resources:

| **Azure artifact** | **Shared Key (storage account key)** | **Shared access signature (SAS)** | **Microsoft Entra ID**                                                     | **On-premises Active Directory Domain Services**            | **Anonymous public read access** |
| ------------------ | ------------------------------------ | --------------------------------- | -------------------------------------------------------------------------- | ----------------------------------------------------------- | -------------------------------- |
| Azure Blobs        | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Supported                        |
| Azure Files (SMB)  | Supported                            | Not supported                     | Supported with Microsoft Entra Domain Services or Microsoft Entra Kerberos | Supported, credentials must be synced to Microsoft Entra ID | Not supported                    |
| Azure Files (REST) | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |
| Azure Queues       | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |
| Azure Tables       | Supported                            | Supported                         | Supported                                                                  | Not supported                                               | Not supported                    |

Each authorization option is briefly described below:

- **Microsoft Entra ID (Recommended)**: Microsoft Entra ID is Microsoft's cloud-based identity and access management service. Microsoft Entra ID integration is available for the Blob, File, Queue, and Table services. With Microsoft Entra ID, you can assign fine-grained access to users, groups, or applications via Azure role-based access control (RBAC).  RBAC is the most secure method as it eliminates the need to store credentials in your code and supports advanced security features like conditional access, multi-factor authentication, and managed identities.
- **Microsoft Entra Domain Services authorization for Azure Files**: Azure Files supports identity-based authorization over Server Message Block (SMB) through Microsoft Entra Domain Services. You can use Azure RBAC for share-level access control and Windows ACLs for file and directory-level permissions, providing fine-grained control over a client's access to Azure Files resources.
- **Active Directory (AD) authorization for Azure Files**: Azure Files supports identity-based authorization over SMB through on-premises Active Directory Domain Services. Your AD domain service can be hosted on on-premises machines or in Azure VMs. SMB access to Files is supported using AD credentials from domain-joined machines, either on-premises or in Azure. You can use Azure RBAC for share-level access control and NTFS DACLs (Discretionary Access Control Lists) for directory and file-level permission enforcement. Credentials must be synchronized to Microsoft Entra ID.
- **Shared Key**: Shared Key authorization relies on your account access keys and other parameters to produce an encrypted signature string that is passed in the request's *Authorization* header. The downside is a Shared Key provides full access to the storage account and should be avoided when possible. Consider disabling Shared Key authorization if your scenarios support identity-based authentication.
- **Shared access signatures (SAS)**: Shared access signatures delegate access to a particular resource in your account with specified permissions and over a specified time interval. There are three types of SAS:
   - user delegation SAS (secured with Microsoft Entra credentials, recommended)
   - service SAS
   - account SAS (both secured with the storage account key)

   >[!NOTE]
   > When you must use a SAS, prefer user delegation SAS for Blob storage as it provides superior security.

- **Anonymous access to containers and blobs**: You can optionally make blob resources public at the container or blob level. A public container or blob is accessible to any user for anonymous read access. Read requests to public containers and blobs do not require authorization.
>[!NOTE]
> Anonymous public access can pose security risks. Consider disabling anonymous access at the storage account level unless specifically required, and use SAS tokens with limited scope instead.

## Security recommendations

Authenticating and authorizing access to blob, file, queue, and table data with Microsoft Entra ID provides superior security and ease of use over other authorization options. For example, by using Microsoft Entra ID, you avoid having to store your account access key with your code, as you do with Shared Key authorization. While you can continue to use Shared Key authorization with your blob and queue applications, Microsoft strongly recommends moving to Microsoft Entra ID wherever possible.

Similarly, you can continue to use shared access signatures (SAS) to grant fine-grained access to resources in your storage account, but Microsoft Entra ID offers similar capabilities without the need to manage SAS tokens or worry about revoking a compromised SAS. When SAS is required, always prefer user delegation SAS over account or service SAS.

**Best practices for authorization method selection:**

- **First choice**: Use Microsoft Entra ID with managed identities for Azure resources when your application runs in Azure.
- **Second choice**: Use Microsoft Entra ID with service principals for applications that require programmatic access.
- **Third choice**: If SAS is required for delegating access, use user delegation SAS for Blob storage.
- **Last resort**: Only use Shared Key when no other option is available, and consider disabling it at the storage account level to prevent inadvertent use.
- **Anonymous access**: Disable by default unless you have a specific requirement for public blob access, in which case carefully scope the access to specific containers.
