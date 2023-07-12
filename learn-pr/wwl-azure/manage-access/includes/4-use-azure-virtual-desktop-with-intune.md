You can now use Microsoft Intune to manage Windows 10 or Windows 11 Enterprise multi-session remote desktops in the Microsoft Endpoint Manager admin center just as you can manage a shared Windows 10 or Windows 11 client device. When managing such virtual machines (VMs), you'll be able to use both device-based and user configuration.

Windows 10 or Windows 11 Enterprise multi-session is a Remote Desktop Session Host exclusive to Azure Virtual Desktop on Azure.

 -  Allows multiple concurrent user sessions.
 -  Gives users a familiar Windows 10 or Windows 11 experience.
 -  Supports use of existing per-user Microsoft 365 licensing.

You can manage **Windows 10** and **Windows 11 Enterprise multi-session** VMs created in Azure Government Cloud in US Government Community (GCC), GCC High, and DoD.

## Overview

Device configuration support in Microsoft Intune for Windows 10 or Windows 11 Enterprise multi-session is Generally Available (GA). This means policies defined in the OS scope and apps configured to install in the system context can be applied to Azure Virtual Desktop multi-session VMs. Additionally, multi-session configurations can be targeted to devices or device groups.

User configuration support in Microsoft Intune for Windows 11 multi-session VMs is in public preview. With this you'll be able to:

 -  Configure user scope policies using **Settings catalog** and assign to groups of users. You can use the search bar to search all configurations with scope set to "user".
 -  Configure user certificates and assign to users.
 -  Configure PowerShell scripts to install in the user context and assign to users.

This feature supports Windows 10 or Windows 11 Enterprise multi-session VMs, which are:

 -  Running Windows 10 multi-session, version 1903 or later, or running Windows 11 multi-session.
 -  Set up as remote desktops in pooled host pools that have been deployed through Azure Resource Manager.
 -  Running an Azure Virtual Desktop agent.
 -  Hybrid Azure AD-joined and enrolled in Microsoft Intune using one of the following methods:
     -  Configured with Active Directory group policy, set to use Device credentials, and set to automatically enroll devices that are Hybrid Azure AD-joined.
     -  Configuration Manager co-management.
 -  Azure AD-joined and enrolled in Microsoft Intune by enabling [Enroll the VM with Intune](https://github.com/MicrosoftDocs/memdocs/blob/main/azure/virtual-desktop/deploy-azure-ad-joined-vm#deploy-azure-ad-joined-vms) in the Azure portal.
 -  Licensing: The appropriate Microsoft Intune license is required if a user or device benefits directly or indirectly from the Microsoft Intune service, including access to the Microsoft Intune service through a Microsoft API. For more information, see Microsoft Intune licensing.

> [!NOTE]
> If you're joining session hosts to Azure Active Directory Domain Services, you can't manage them using Intune..

Windows 10 or Windows 11 Enterprise multi-session VMs are treated as a separate OS edition and some Windows 10 or Windows 11 Enterprise configurations won’t be supported for this edition. Using Microsoft Intune doesn't depend on or interfere with Azure Virtual Desktop management of the same VM.

## Create the configuration profile

To configure configuration policies for Windows 10 or Windows 11 Enterprise multi-session VMs, you'll need to use the [Settings catalog](https://github.com/MicrosoftDocs/memdocs/blob/main/memdocs/intune/configuration/settings-catalog.md) in the Microsoft Endpoint Manager admin center.

The existing device configuration profile templates aren't supported for Windows 10 or Windows 11 Enterprise multi-session VMs, except for the following templates:

 -  [Trusted certificate](https://github.com/MicrosoftDocs/memdocs/blob/main/memdocs/intune/protect/certificates-trusted-root.md#create-trusted-certificate-profiles) \- Device (machine) only
 -  [SCEP certificate](https://github.com/MicrosoftDocs/memdocs/blob/main/memdocs/intune/protect/certificates-profile-scep.md#create-a-scep-certificate-profile) \- Device (machine) only
 -  [PKCS certificate](https://github.com/MicrosoftDocs/memdocs/blob/main/memdocs/intune/protect/certificates-pfx-configure.md#create-a-pkcs-certificate-profile) \- Device (machine) only
 -  [VPN](https://github.com/MicrosoftDocs/memdocs/blob/main/memdocs/intune/configuration/vpn-settings-configure.md#create-the-profile) \- Device Tunnel only

Microsoft Intune won't deliver unsupported templates to multi-session devices, and those policies appear as *Not applicable* in reports.

To configure policies

1.  Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) and choose **Devices,** select **Windows**, select **Configuration profiles**, and select **Create Profile**.
2.  For **Platform**, select **Windows 10 and later**.
3.  For **Profile type**, select **Settings catalog**, or when deploy settings by using a Template, select **Templates** and then the name of the supported Template.
4.  Select **Create**.
5.  On the **Basics** page, provide a **Name** and (optionally) **Description** &gt; **Next**.
6.  On the **Configuration settings** page, select **Add settings**.
7.  Under **Settings picker**, select **Add filter** and select the following options:
     -  **Key**: **OS edition**
     -  **Operator**: **==**
     -  **Value**: **Enterprise multi-session**
     -  Select **Apply**. The filtered list now shows all configuration profile categories that support Windows 10 or Windows 11 Enterprise multi-session. The scope for a policy is shown in parentheses. For user scope it shows as (User) and all the rest are policies with device scope.
8.  From the filtered list, pick the categories that you want.
     -  For each category you pick, select the settings that you want to apply to your new configuration profile.
     -  For each setting, select the value that you want for this configuration profile.
9.  Select **Next** when you’re done adding settings.
10. On the **Assignments** page, choose the Azure AD groups containing the devices to which you want this profile assigned &gt; **Next**.
11. On the **Scope tags** page, optionally add the scope tags you want to apply to this profile &gt; **Next**.
12. On the **Review + create** page, choose **Create** to create the profile.

### Administrative templates

Windows 10 or Windows 11 Administrative Templates are supported for Windows 10 or Windows 11 Enterprise multi-session via the Settings catalog with some limitations:

 -  ADMX-backed policies are supported. Some policies aren't yet available in the Settings catalog.
 -  ADMX-ingested policies are supported, including Office and Microsoft Edge settings available in Office administrative template files and Microsoft Edge administrative template files.
 -  ADMX - ingested policies are not supported for user targeting at this time.
