Numerous deployment scenarios for Microsoft Azure AD don’t involve an on-premises AD DS environment. However, for many organizations that have some services on their networks and some services in the cloud, synchronization and integration between Azure AD and on-premises AD DS is the way to deliver the best user experience. Directory synchronization enables user, group, and contact synchronization between on-premises Active Directory and Azure AD. In its simplest form, you install a directory synchronization component on a server in your on-premises domain. All your user accounts, groups, and contacts from Active Directory then replicate to Azure AD. Those accounts can then sign in and access Azure services.

With Azure AD Free or Basic, the synchronization flow is in one direction, from local AD DS to Azure AD. However, with Azure AD Premium, you can replicate some attributes from Azure AD to AD DS. For example, you can configure Azure AD to write passwords back to an on-premises AD DS.

#### Azure AD Connect

Microsoft provides Azure AD Connect to perform directory synchronization between Azure AD and AD DS. By default, Azure AD Connect synchronizes all users and groups. If you don’t want to synchronize your entire on-premises AD DS, directory synchronization for Azure AD supports limited filtering and customization of attribute flow based on the following values:

 -  OU
 -  Domain
 -  User attributes
 -  Applications

When directory synchronization is enabled, you have the following authentication options:

 -  **Separate cloud password**. When you synchronize a user identity and not the password, the cloud-based user account will have a separate unique password. This can be confusing for users.
 -  **Synchronized password**. If you enable password synchronization, the AD DS user password syncs with the identity in Azure AD. This allows users to authenticate by using the same credentials, but it doesn’t provide seamless SSO, because users still receive prompts to authenticate cloud services.
 -  **Pass-through authentication**. When you enable pass-through authentication, Azure AD uses the cloud identity to verify that the user is valid, and then passes the authentication request to Azure AD Connect. This option provides true SSO because users don’t receive multiple prompts to authenticate cloud services.
 -  **Federated identities**. If you configure federated identities, the authentication process works similarly to pass-through authentication, but AD FS performs authentication on-premises instead of Azure AD Connect. This authentication method provides claims-based authentication that multiple cloud-based apps can use.

When you install Azure AD Connect, you need to sign in as a local Administrator of the computer on which you're performing installation. Additionally, you'll receive prompts for credentials to the local AD DS and Azure AD. The local AD DS account must be a member of the enterprise administrators group. The Azure AD account must be a global administrator. If you’re using AD FS or a separate SQL Server instance, you'll also receive prompts for credentials with management permissions for those resources.

The computer that is running Azure AD Connect needs to communicate with Azure AD. If the computer needs to use a proxy server for internet access, then more configuration is necessary. No inbound connectivity from the internet is necessary because Azure AD Connect initiates all communication.

Azure AD Connect must be on a domain member. Installing Azure AD Connect on a domain controller is supported, but this typically occurs only in smaller organizations with limited licensing.

When you install Azure AD Connect, you can use express settings or custom settings. Most organizations that synchronize a single AD DS forest with an Azure AD tenant use the express settings option. When you choose express settings, the following options are selected:

 -  SQL Server Express is installed and configured.
 -  All identities in the forest are synchronized.
 -  All attributes are synchronized.
 -  Password synchronization is enabled.
 -  An initial synchronization is performed immediately after install.
 -  Automatic upgrade is enabled.

You can enable other options during installation when you select custom settings, such as:

 -  Pass-through authentication.
 -  Federation with AD FS.
 -  Select an attribute for matching existing cloud-based users.
 -  Filtering based on OUs or attributes.
 -  Exchange hybrid.
 -  Password, group, or device writeback.
 -  After deploying Azure AD Connect, the following occurs:
    
     -  New user, group, and contact objects in on-premises Active Directory are added to Azure AD; however, no licenses for cloud services, such as Microsoft 365, are automatically assigned to these objects.
     -  Attributes of existing user, group, or contact objects that are modified in on-premises Active Directory are modified in Azure AD; however, not all on-premises Active Directory attributes synchronize with Azure AD.
     -  Existing user, group, and contact objects that are deleted from on-premises Active Directory are deleted from Azure AD.

Existing user objects that are disabled on-premises are disabled in Azure; however, licenses aren’t automatically unassigned.
