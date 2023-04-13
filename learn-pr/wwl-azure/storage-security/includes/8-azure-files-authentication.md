
Azure Files supports identity-based authentication over Server Message Block (SMB) through on-premises Active Directory Domain Services (AD DS) and Azure Active Directory Domain Services (Azure AD DS). This article focuses on how Azure file shares can use domain services, either on-premises or in Azure, to support identity-based access to Azure file shares over SMB. Enabling identity-based access for your Azure file shares allows you to replace existing file servers with Azure file shares without replacing your existing directory service, maintaining seamless user access to shares.

Azure Files enforces authorization on user access to both the share and the directory/file levels. Share-level permission assignment can be performed on Azure Active Directory (Azure AD) users or groups managed through the role-based access control (RBAC) model. With RBAC, the credentials you use for file access should be available or synced to Azure AD. You can assign built-in RBAC roles like Storage File Data SMB Share Reader to users or groups in Azure AD to grant read access to an Azure file share.

At the directory/file level, Azure Files supports preserving, inheriting, and enforcing Windows DACLs just like any Windows file servers. You can choose to keep Windows DACLs when copying data over SMB between your existing file share and your Azure file shares. Whether you plan to enforce authorization or not, you can use Azure file shares to back up ACLs along with your data.

## Advantages of identity-based authentication

Identity-based authentication for Azure Files offers several benefits over using Shared Key authentication:

 -  Extend the traditional identity-based file share access experience to the cloud with on-premises AD DS and Azure AD DS. If you plan to lift and shift your application to the cloud, replacing traditional file servers with Azure file shares, then you may want your application to authenticate with either on-premises AD DS or Azure AD DS credentials to access file data. Azure Files supports using both on-premises AD DS or Azure AD DS credentials to access Azure file shares over SMB from either on-premises AD DS or Azure AD DS domain-joined VMs.
 -  Enforce granular access control on Azure file shares. You can grant permissions to a specific identity at the share, directory, or file level. For example, suppose that you have several teams using a single Azure file share for project collaboration. You can grant all teams access to non-sensitive directories while limiting access to directories containing sensitive financial data to your Finance team only.
 -  Back up Windows ACLs (also known as NTFS) along with your data. You can use Azure file shares to back up your existing on-premises file shares. Azure Files preserves your ACLs along with your data when you back up a file share to Azure file shares over SMB.

## Identity-based authentication data flow

:::image type="content" source="../media/az500-azure-files-authentication-6d7a7c7d.png" alt-text="Diagram of how identity-based authentication works or Azure files.":::


### How it works

Azure file shares leverages Kerberos protocol for authenticating with either on-premises AD DS or Azure AD DS. When an identity associated with a user or application running on a client attempts to access data in Azure file shares, the request is sent to the domain service, either AD DS or Azure AD DS, to authenticate the identity. If authentication is successful, it returns a Kerberos token. The client sends a request that includes the Kerberos token and Azure file shares use that token to authorize the request. Azure file shares only receive the Kerberos token, not access credentials.

### Preserve directory and file ACLs when importing data to Azure file shares

Azure Files supports preserving directory or file level ACLs when copying data to Azure file shares. You can copy ACLs on a directory or file to Azure file shares using either Azure File Sync or common file movement toolsets. For example, you can use robocopy with the /copy:s flag to copy data as well as ACLs to an Azure file share. ACLs are preserved by default, you are not required to enable identity-based authentication on your storage account to preserve ACLs.
