Numerous deployment scenarios for Microsoft Entra don’t involve an on-premises AD DS environment. However, for many organizations that have some services on their networks and some services in the cloud, synchronization and integration between Microsoft Entra ID and on-premises AD DS is the way to deliver the best user experience. Directory synchronization enables user, group, and contact synchronization between on-premises Active Directory and Microsoft Entra ID. In its simplest form, you install a directory synchronization component on a server in your on-premises domain. All your user accounts, groups, and contacts from Active Directory then replicate to Microsoft Entra ID. Those accounts can then sign in and access Azure services.

With Microsoft Entra ID Free or Basic, the synchronization flow is in one direction, from local AD DS to Microsoft Entra ID. However, with Microsoft Entra ID P1 or P2, you can replicate some attributes from Microsoft Entra ID to Active Directory DS. For example, you can configure Microsoft Entra ID to write passwords back to an on-premises AD DS.

<a name='azure-ad-connect'></a>

#### Microsoft Entra Connect

Microsoft provides Microsoft Entra Connect to perform directory synchronization between Microsoft Entra ID and AD DS. By default, Microsoft Entra Connect synchronizes all users and groups. If you don’t want to synchronize your entire on-premises AD DS, directory synchronization for Microsoft Entra ID supports limited filtering and customization of attribute flow based on the following values:

 -  OU
 -  Domain
 -  User attributes
 -  Applications

When directory synchronization is enabled, you have the following authentication options:

 -  **Separate cloud password**. When you synchronize a user identity and not the password, the cloud-based user account will have a separate unique password. This can be confusing for users.
 -  **Synchronized password**. If you enable password synchronization, the AD DS user password syncs with the identity in Microsoft Entra ID. This allows users to authenticate by using the same credentials, but it doesn’t provide seamless SSO, because users still receive prompts to authenticate cloud services.
 -  **Pass-through authentication**. When you enable pass-through authentication, Microsoft Entra ID uses the cloud identity to verify that the user is valid, and then passes the authentication request to Microsoft Entra Connect. This option provides true SSO because users don’t receive multiple prompts to authenticate cloud services.
 -  **Federated identities**. If you configure federated identities, the authentication process works similarly to pass-through authentication, but AD FS performs authentication on-premises instead of Microsoft Entra Connect. This authentication method provides claims-based authentication that multiple cloud-based apps can use.

When you install Microsoft Entra Connect, you need to sign in as a local Administrator of the computer on which you're performing installation. Additionally, you'll receive prompts for credentials to the local AD DS and Microsoft Entra ID. The local AD DS account must be a member of the enterprise administrators group. The Microsoft Entra account must be a global administrator. If you’re using AD FS or a separate SQL Server instance, you'll also receive prompts for credentials with management permissions for those resources.

The computer that is running Microsoft Entra Connect needs to communicate with Microsoft Entra ID. If the computer needs to use a proxy server for internet access, then more configuration is necessary. No inbound connectivity from the internet is necessary because Microsoft Entra Connect initiates all communication.

Microsoft Entra Connect must be on a domain member. Installing Microsoft Entra Connect on a domain controller is supported, but this typically occurs only in smaller organizations with limited licensing.

When you install Microsoft Entra Connect, you can use express settings or custom settings. Most organizations that synchronize a single AD DS forest with a Microsoft Entra tenant use the express settings option. When you choose express settings, the following options are selected:

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
 -  After deploying Microsoft Entra Connect, the following occurs:
    
     -  New user, group, and contact objects in on-premises Active Directory are added to Microsoft Entra ID; however, no licenses for cloud services, such as Microsoft 365, are automatically assigned to these objects.
     -  Attributes of existing user, group, or contact objects that are modified in on-premises Active Directory are modified in Microsoft Entra ID; however, not all on-premises Active Directory attributes synchronize with Microsoft Entra ID.
     -  Existing user, group, and contact objects that are deleted from on-premises Active Directory are deleted from Microsoft Entra ID.

Existing user objects that are disabled on-premises are disabled in Azure; however, licenses aren’t automatically unassigned.

