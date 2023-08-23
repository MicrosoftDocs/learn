

To enable co-management for your on-premises Active Directory devices, you must configure your devices as hybrid Azure AD joined devices.

Before you start enabling hybrid Azure AD joined devices in your organization, you need to make sure that:

 -  You're running an up-to-date version of Azure AD connect. Azure AD Connect provides you with a wizard to configure hybrid Azure AD join. Azure AD Connect has synchronized the computer objects of the devices you want to be hybrid Azure AD joined to Azure AD. If the computer objects belong to specific organizational units (OUs), then these OUs need to be configured for synchronization in Azure AD Connect as well.
 -  Intune MDM must be set up and configured for automatic enrollment.
 -  Microsoft Endpoint Manager is installed.
 -  Active Directory joined devices are using Windows 10 version 1709 or later. We recommended that you always use the latest version of Windows so that you get the newest advances in terms of security, Azure AD, and Intune features.
 -  Azure AD automatic enrollment is enabled.

Hybrid Azure AD join is designed to facilitate the automatic registration of your on-premises domain-joined devices with Azure AD. However, there may be instances where you prefer not to have all devices register automatically. This process is relevant during the initial pilot phase when it's necessary to verify that everything functions as anticipated.

All Windows current devices automatically register with Azure AD at device start or user sign-in. You can control this behavior either with a Group Policy Object (GPO) or Configuration Manager.

To control Windows current devices:

 -  For all devices: Disable automatic device registration.
 -  For selected devices: Enable automatic device registration.

You can control the device registration behavior of your devices by deploying the following GPO: **Register domain-joined computers as devices**.

1.  In the Group Policy Management Console, create two new GPOs and then go to **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Device Registration**.
2.  In the first GPO, apply the **Disabled** setting to prevent automatic device registration. In the second GPO, apply the **Enabled** setting to enable automatic device registration
3.  Link the first GPO to all devices in your environment and then link the second GPO only to the OU containing your pilot devices. Alternatively, you can use Group Policy security filtering and a security group to control which devices can automatically register with Azure AD.

After you've joined your on-premises Active Directory devices to Azure AD, you can immediately use the following Intune remote actions:

 -  Factory reset
 -  Selective wipe
 -  Delete devices
 -  Restart device
 -  Fresh start

### Transition workloads to Intune

Once you have completed the necessary preparations in Intune and configured your Windows devices for co-management, the next step is to determine the specific workloads that you want to transition to Intune. However, before making any switches, it's crucial to ensure that the corresponding workload has been appropriately configured and deployed within Intune. By following these steps, you can ensure that one of the designated management tools consistently manages all workloads on your devices.

The following list features some of the workloads that you can transition to Intune:

 -  Resource access policies
    
     -  Email profile
     -  Wi-Fi profile
     -  VPN profile
     -  Certificate profile
 -  Windows Update policies
 -  Endpoint Protection
     -  Microsoft Defender Antivirus
     -  Microsoft Defender Application Guard
     -  Microsoft Defender Firewall
     -  Microsoft Defender SmartScreen
     -  Windows Encryption
     -  Microsoft Defender Exploit Guard
     -  Windows Defender Application Control
     -  Microsoft Defender for Endpoint
     -  Windows Information Protection
 -  Device Configuration
     -  Device Configuration is essentially the settings you configure using Group Policy.
 -  Microsoft 365 Select-to-Run apps
     -  Once the workload has been moved, the app will appear in the Company Portal on the device.

The recommended approach is to prioritize devices with simple configuration settings and migrate those workloads to Intune first. This process may include tasks such as configuring Endpoint Protection, Windows Update policies, software deployment, and device configuration policies that align with existing Group Policy settings.