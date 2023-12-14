Every request made against a secured resource in the Blob, File, Queue, or Table service must be authorized. Authorization ensures that resources in your storage account are accessible only when you want them to be, and only to those users or applications to whom you grant access.

The following table describes the options that Azure Storage offers for authorizing access to resources:

:::image type="content" source="../media/azure-storage-options-023c819a.png" alt-text="Table showing options that Azure Storage offers for authorizing access to resources.":::
Each authorization option is briefly described below:

**Azure Active Directory (Azure AD):** Azure AD is Microsoft's cloud-based identity and access management service. Azure AD integration is available for the Blob, File, Queue and Table services. With Azure AD, you can assign fine-grained access to users, groups, or applications via role-based access control (RBAC).

**Azure Active Directory Domain Services (Azure AD DS) authorization** for Azure Files. Azure Files supports identity-based authorization over Server Message Block (SMB) through Azure AD DS. You can use RBAC for fine-grained control over a client's access to Azure Files resources in a storage account.<br>

**Active Directory (AD) authorization** for Azure Files. Azure Files supports identity-based authorization over SMB through AD. Your AD domain service can be hosted on on-premises machines or in Azure VMs. SMB access to Files is supported using AD credentials from domain joined machines, either on-premises or in Azure. You can use RBAC for share level access control and NTFS DACLs for directory and file level permission enforcement.<br>

**Shared Key:** Shared Key authorization relies on your account access keys and other parameters to produce an encrypted signature string that is passed on the request in the Authorization header.<br>

**Shared access signatures:** Shared access signatures (SAS) delegate access to a particular resource in your account with specified permissions and over a specified time interval.<br>

**Anonymous access to containers and blobs:** You can optionally make blob resources public at the container or blob level. A public container or blob is accessible to any user for anonymous read access. Read requests to public containers and blobs do not require authorization.

Authenticating and authorizing access to blob, file, queue and table data with Azure AD provides superior security and ease of use over other authorization options. For example, by using Azure AD, you avoid having to store your account access key with your code, as you do with Shared Key authorization. While you can continue to use Shared Key authorization with your blob and queue applications, Microsoft recommends moving to Azure AD where possible.

Similarly, you can continue to use shared access signatures (SAS) to grant fine-grained access to resources in your storage account, but Azure AD offers similar capabilities without the need to manage SAS tokens or worry about revoking a compromised SAS.
