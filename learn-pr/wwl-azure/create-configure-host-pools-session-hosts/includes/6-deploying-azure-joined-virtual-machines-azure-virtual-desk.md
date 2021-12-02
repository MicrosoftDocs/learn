This unit provides and overview for deploying and accessing Azure Active Directory joined virtual machines in Azure Virtual Desktop. Azure AD-joined VMs remove the need to have line-of-sight from the VM to an on-premises or virtualized Active Directory Domain Controller (DC) or to deploy Azure AD Domain services (Azure AD DS). In some cases, it can remove the need for a DC entirely, simplifying the deployment and management of the environment. These VMs can also be automatically enrolled in Intune for ease of management.

The configurations listed below are supported with Azure AD-joined VMs:

 -  Personal desktops with local user profiles.
 -  Pooled desktops used as a jump box. In this configuration, users first access the Azure Virtual Desktop VM before connecting to a different PC on the network. Users shouldn't save data on the VM.
 -  Pooled desktops or apps where users don't need to save data on the VM. For example, for applications that save data online or connect to a remote database.

> [!NOTE]
> User accounts can be cloud-only or hybrid users from the same Azure AD tenant.

Access to your on-premises or Active Directory domain-joined resources and should be considered when deciding whether Azure AD-joined VMs suits your environment. Microsoft recommends Azure AD-joined VMs for scenarios where users only need access to cloud-based resources or Azure AD-based authentication.

 -  Azure Virtual Desktop (classic) doesn't support Azure AD-joined VMs.
 -  Azure AD-joined VMs don't currently support external users.
 -  Azure AD-joined VMs only supports local user profiles at this time.
 -  Azure AD-joined VMs can't access Azure Files file shares for FSLogix or MSIX app attach. You'll need Kerberos authentication to access either of these features.
 -  The Windows Store client doesn't currently support Azure AD-joined VMs.
 -  Azure Virtual Desktop doesn't currently support single sign-on for Azure AD-joined VMs.

## Deploy Azure AD-joined VMs

You can deploy Azure AD-joined VMs directly from the Azure portal when creating a new host pool or expanding an existing host pool. On the Virtual Machines tab, select whether to join the VM to Active Directory or Azure Active Directory. Selecting Azure Active Directory gives you the option to Enroll the VM with Intune automatically so you can manage Windows 10 Enterprise and Windows 10 Enterprise multi-session VMs. Keep in mind that the Azure Active Directory option will join VMs to the same Azure AD tenant as the subscription you're in.

> [!NOTE]
> Host pools should only contain VMs of the same domain join type. For example, AD-joined VMs should only be with other AD VMs. The host pool VMs must be Windows 10 single-session or multi-session.

## Assign user access to host pools

After you've created your host pool, you must assign users access to let them access their resources. To grant access to resources, add each user to the app group. We recommend that you use user groups instead of individual users wherever possible.

For Azure AD-joined VMs, you'll need to do two things:

 -  Assign your users the Virtual Machine User Login role so they can sign in to the VMs.
 -  Assign administrators who need local administrative privileges the Virtual Machine Administrator Login role.

To grant users access to Azure AD-joined VMs, you must configure role assignments for the VM. You can assign the Virtual Machine User Login or Virtual Machine Administrator Login role either on the VMs, the resource group containing the VMs, or the subscription. It's recommend assigning the Virtual Machine User Login role to the same user group you used for the app group at the resource group level to make it apply to all the VMs in the host pool.

## Connect using the Windows Desktop client

The default configuration supports connections from Windows 10 using the Windows Desktop client. You can use your credentials, smart card, Windows Hello for Business certificate trust or Windows Hello for Business key trust with certificates to sign in to the session host. However, to access the session host, your local computer must meet one of the conditions listed below:

 -  The local PC is Azure AD-joined to the same Azure AD tenant as the session host.
 -  The local PC is hybrid Azure AD-joined to the same Azure AD tenant as the session host.
 -  The local PC is running Windows 10, version 2004 and later, and is Azure AD registered to the same Azure AD tenant as the session host.

To enable access from Windows devices not joined to Azure AD, add **targetisaadjoined:i:1** as a custom RDP property to the host pool.

To access Azure AD-joined VMs using the web, Android, macOS and iOS clients, you must add **targetisaadjoined:i:1** as a custom RDP property to the host pool. These connections are restricted to entering user name and password credentials when signing in to the session host.

> [!NOTE]
> Azure Virtual Desktop currently only supports local profiles for Azure AD-joined VMs.

## Enabling MFA for Azure AD joined VMs

You can enable multifactor authentication for Azure AD-joined VMs by setting a Conditional Access policy on the Azure Virtual Desktop app. For connections to succeed, disable the legacy per-user multifactor authentication.
