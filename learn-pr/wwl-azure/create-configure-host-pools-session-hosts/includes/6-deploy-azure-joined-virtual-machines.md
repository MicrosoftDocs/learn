This unit provides an overview for deploying and accessing Microsoft Entra joined virtual machines in Azure Virtual Desktop. Microsoft Entra joined virtual machines remove the need to have line-of-sight from the VM to an on-premises or virtualized Active Directory Domain Controller (DC) or to deploy Microsoft Entra Domain Services. In some cases, it can remove the need for a DC entirely, simplifying the deployment and management of the environment. These virtual machines can also be automatically enrolled in Intune for ease of management.

The configurations listed below are supported with Microsoft Entra joined virtual machines:

 -  Personal desktops with local user profiles.
 -  Pooled desktops used as a jump box. In this configuration, users first access the Azure Virtual Desktop VM before connecting to a different PC on the network. Users shouldn't save data on the VM.
 -  Pooled desktops or apps where users don't need to save data on the VM. For example, for applications that save data online or connect to a remote database.

> [!NOTE]
> User accounts can be cloud-only or hybrid users from the same Microsoft Entra tenant.

Access to your on-premises or Active Directory domain-joined resources and should be considered when deciding whether Microsoft Entra joined virtual machines suits your environment. Microsoft recommends Microsoft Entra joined virtual machines for scenarios where users only need access to cloud-based resources or Microsoft Entra ID-based authentication.

 -  Azure Virtual Desktop (classic) doesn't support Microsoft Entra joined VMs.
 -  Microsoft Entra joined VMs don't currently support external identities, such as Microsoft Entra Business-to-Business (B2B) and Azure AD Business-to-Consumer (B2C).
 -  Microsoft Entra joined VMs can only access [Azure Files shares](/azure/virtual-desktop/create-profile-container-azure-ad) for hybrid users using Microsoft Entra Kerberos for FSLogix user profiles.
 -  The [Remote Desktop app for Windows](/azure/virtual-desktop/users/connect-microsoft-store) doesn't support Microsoft Entra joined VMs.

<a name='deploy-azure-ad-joined-virtual-machines'></a>

## Deploy Microsoft Entra joined virtual machines

You can deploy AD-joined virtual machines directly from the Azure portal when creating a new host pool or expanding an existing host pool. On the Virtual Machines tab, select whether to join the VM to Active Directory or Microsoft Entra ID. Selecting Microsoft Entra ID gives you the option to Enroll the VM with Intune automatically so you can manage Windows 10 Enterprise and Windows 10 Enterprise multi-session virtual machines. Keep in mind that the Microsoft Entra option will join virtual machines to the same Microsoft Entra tenant as the subscription you're in.

> [!NOTE]
> Host pools should only contain virtual machines of the same domain join type. For example, AD-joined virtual machines should only be with other AD virtual machines. The host pool virtual machines must be Windows 10 single-session or multi-session.

## Assign user access to host pools

After you've created your host pool, you must assign users access to let them access their resources. To grant access to resources, add each user to the app group. We recommend that you use user groups instead of individual users wherever possible.

For Microsoft Entra joined virtual machines, you'll need to do two things:

 -  Assign your users the Virtual Machine User Login role so they can sign in to the virtual machines.
 -  Assign administrators who need local administrative privileges the Virtual Machine Administrator Login role.

To grant users access to Microsoft Entra joined virtual machines, you must configure role assignments for the VM. You can assign the Virtual Machine User Login or Virtual Machine Administrator Login role either on the virtual machines, the resource group containing the virtual machines, or the subscription. It's recommend assigning the Virtual Machine User Login role to the same user group you used for the app group at the resource group level to make it apply to all the virtual machines in the host pool.

## Connect using the Windows Desktop client

The default configuration supports connections from Windows 10 using the Windows Desktop client. You can use your credentials, smart card, Windows Hello for Business certificate trust or Windows Hello for Business key trust with certificates to sign in to the session host. However, to access the session host, your local computer must meet one of the conditions listed below:

 -  The local PC is Microsoft Entra joined to the same Microsoft Entra tenant as the session host.
 -  The local PC is Microsoft Entra hybrid joined to the same Microsoft Entra tenant as the session host.
 -  The local PC is running Windows 10, version 2004 and later, and is Microsoft Entra registered to the same Microsoft Entra tenant as the session host.

To enable access from Windows devices not joined to Microsoft Entra ID, add **targetisaadjoined:i:1** as a custom RDP property to the host pool.

To access Microsoft Entra joined virtual machines using the web, Android, macOS and iOS clients, you must add **targetisaadjoined:i:1** as a custom RDP property to the host pool. These connections are restricted to entering user name and password credentials when signing in to the session host.

> [!NOTE]
> Azure Virtual Desktop currently only supports local profiles for Microsoft Entra joined virtual machines.

<a name='enabling-mfa-for-azure-ad-joined-virtual-machines'></a>

## Enabling MFA for Microsoft Entra joined virtual machines

You can enable multifactor authentication for Microsoft Entra joined virtual machines by setting a Conditional Access policy on the Azure Virtual Desktop app. For connections to succeed, disable the legacy per-user multifactor authentication.
