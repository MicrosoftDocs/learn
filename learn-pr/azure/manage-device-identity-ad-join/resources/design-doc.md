# Module design

## Title

Manage device identity with Azure AD join and enterprise state roaming

## Role(s)

- Administrator
- Solution architect

## Level

- Intermediate

## Product(s)

- Azure AD Join
- Azure Active Directory

## Prerequisites

- Basic knowledge of Azure Active Directory features such as Azure AD Connect, Azure Active Directory Seamless Single Sign-On, and Multi-Factor Authentication
- Basic understanding of mobile device management software like Microsoft Intune  

## Summary

Evaluate options to manage device identities in Azure AD. Allow users to join devices in Azure AD. Require devices to be marked as compliant. Enable enterprise state roaming.

## Learning objectives

- Describe options to manage device identities in Azure AD
- Configure Azure AD Join to manage device identities
- Configure enterprise state roaming to reduce the time users need to configure a new device

## Chunk your content into subtasks

Identify the subtasks of *Manage device identity using AD join*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand device identity | Manage user identity | Knowledge Check | 1 | Yes |
| What is Azure AD Join | Restrict access to organizational resources | Knowledge Check | 2 | Yes |
| Using Enterprise State Roaming | Restrict Access to your organizations resources | Knowledge Check | 3 | Yes |

## Outline the units

1. **Introduction**

   You work for a large book publisher that's deploying Windows 10 to employees' laptops. Your organization uses Azure Active Directory with Azure AD Multi-Factor Authentication enabled. You use these services to manage user identities and help protect the organization's resources. You want to add another layer of security for devices. Specifically, you want to restrict access to the organization's resources to only devices that are managed by your organization and are deemed compliant by your mobile device management (MDM) system. You also want to improve your organization's experience when switching between devices.

1. **What is device identity in Azure**

    List the content that will enable the learner to *understand device identities*:

    - What is a device identity
        - Overview of device identities
    - Device registration options
        - Azure AD joined devices
          - Cloud only, windows 10 devices
    - Azure AD registered devices
        - Mobile devices, personal MS account, Windows 10, iOS, Android, and MacOS
    - Hybrid Azure AD joined devices
        - Exist on both on-premises and cloud, supports older versions of Windows and Windows server.  
    - Managing device/user access using conditional access
        - Conditional access policies
        - Benefits of using conditional access
        - Licensing Requirements
    - Benefits of device identity management
        - Improved device security
        - Better and simpler provision
    - Considerations of using device identity
        - Licensing requirements for device access.
        - Windows 10 limitations when joining the Azure AD through AD Join.

    What types of questions will test *understanding device identities*?

    - What operating systems are supported by Azure AD registered devices?
        - Windows 10, iOS, Android, and MacOS
    - What security measures are supported by Azure AD Join?
        - An organizational account with password, Windows Hello, and MFA.

1. **What is Azure AD Join**

    List the content that will enable the learner to *understand what Azure AD Join offers*:

    - What is Azure AD Join
        - Cloud first, mobile first with Windows
        - Cloud management solution
    - Infrastructure and Device Management
    - Considerations for resources and applications
        - Cloud-based
        - On-premises
        - Other Devices
    - Provisioning options
        - Self-service, Windows Autopilot, or bulk enrollment.
    - Configuring device settings
        - Device Settings in Azure to restrict access to azure resources.
        - Mobile Settings in Azure to limit resource access.
        - Microsoft Intune for the management of devices connected to your domain.
          - What devices are supported: PC running Windows 10, Android 4.0 or later, Apple iOS 9.0 or better.
	- Walkthrough joining a Windows 10 device through Azure AD Join.
		- Configure device settings in Azure AD
		- Configure an MDM provider
		- Configure enterprise state roaming
		- Configure Conditional Access
		- Joining a new Windows 10 device during initial setup of device.
		- Using the Azure AD, find the Windows 10 device you logged in with in the previous step.  
		- Through the Azure portal you will be able to control if their data can sync between devices, and in line with the scenario, use RBAC to control which data and resources the device is able to see.
		- You can also revoke a windows device, preventing it from gaining access.  This is different from revoking a user account.

    What types of questions will test your *understanding Azure AD join*?

    - What provisioning options are available through Azure AD join?
        - Self-service in OOBE, Windows Autopilot, or bulk enrollment.
    - What happens when a user is not in the MDM scope?
        - The Azure AD Join completes without the MDM enrollment, however this will result in an unmanaged device.

1. **What is enterprise state roaming in Azure**

    List the content that will enable the learner to *understand enterprise state roaming*:

    - What is enterprise state roaming
        - Why use enterprise state roaming
        - Persistent cloud-based user and app data settings that follow the user as the roam between devices.
        - Improved user experience when switching devices.
    - Enabling enterprise state roaming in Azure
    	- Set up Azure AD to activate Enterprise State Roaming
    	- Allow users to sync settings and app data across devices.
    	- Windows 10 devices must use an Azure AD identity.
    - Features of enterprise state roaming
        - Data storage
          - Stored in one of three regions: North America, EMEA, and APAC.
          - Once set geographic region is selected for Enterprise State Roaming, it cannot be changed.
          - User settings and app data sync between devices, improving experience
        - Data retention
          - Retained in the cloud until manually deleted or data turns stale.
          - Explicit data deletion:
            - User deletion from the AD.  Permanently removed after 90 days.
            - AD directory deletion, removes all settings and data.  Can be restored upto 90 days after deletion, then is permanently removed. 
            - On Request deletion. Requires an Azure support ticket to allow a specific user's data to be deleted.
          - Stale data deletion
            - Data that has not been accessed within a year is considered stale.
          - Deleted data recovery
            - Not possible from the cloud.
            - Can be restored from the device when it next connects to the cloud. 

    What types of questions will test *understanding of enterprise state roaming*?

    - What is classified as stale data?
        - Any data that has not been accessed for one year or more.
    - Name one of the benefits of using enterprise state roaming
        - Separation of corporate and consumer data, enhanced security, and better management.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    In this module you have been introduced to device identities, and how they can be used to bring better access control to your organizations resources. You have explored using the cloud-first, mobile-first Azure AD option and how it can support self-service and BOYD. You have also explored how to use enterprise state roaming to allow for separation of corporate data from consumer data and how it can allow for settings to move with the user when they switch devices without having to go through a lengthy set-up process. You have seen how conditional access you can control when and how a user will access your corporate resources.

## Notes

- Module is to cover Az-103 and AZ-300 cert tasks: Configure Azure AD Join and Configure enterprise state roaming
- Customers will need to complete exercises with their own subscription or LOD. I'll need to confirm before we develop content.

Conceptual content to include:

- Identify and describe when to use options to manage device identities in Azure AD: Azure AD registered, Azure AD joined, or Hybrid Azure AD joined.
  - Supported devices
  - Non-supported environmental configurations
  - Prereqs for device identity management
- Tools & features you'd use as best practice (MDM tool that supports Azure AD integration & conditional access for devices - right now that's only Intune)
- If you're using MFA, user's don't have to do MFA when they're using an MDM compliant & AD joined device AND conditional access is marked as compliant. You have the option on the conditional access device settings to set AND/OR condition when you set the checkboxes for compliant, MFA, etc. If you needed to be super secure for something like a payroll app, maybe you'd require MFA AND compliant device. Need to be sure to discuss those options.
 - Discuss what settings there are for devices identity management and conditional access like local admin on devices etc. By default, **Additional local administrators on Azure AD joined devices** is enabled. This adds global admin and [device admin](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles#device-administrators) roles as local admin on device.
  
- For scenario, solution is to use AD joined for Windows 10 machines. They can have on-premises AD with SSO & AD Connect set up. But that doesn't require the "Hybrid Azure AD joined" setup. They can bypass that and just join to Azure AD and not on-premises AD. It's easier to do it that way. Employees could still BYOD as long as they're Windows 10 devices and they want to sign in using their organizational account (and want to enroll/join the organization).

- What is enterprise state roaming and why you'd set it up
- What's conditional access and why you'd use this? There is some coverage as it relates to users  in module: [Secure your Azure resources with conditional access](https://docs.microsoft.com/learn/modules/secure-azure-resources-with-conditional-access/)
- End-user experience to join and then to sign in.


Tasks involved: 
   - [Configure device settings in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/devices/azureadjoin-plan#configure-your-device-settings)
   - [Configure MDM provider](https://docs.microsoft.com/azure/active-directory/devices/azureadjoin-plan#configure-your-mobility-settings)
   - [Configure enterprise state roaming](https://docs.microsoft.com/azure/active-directory/devices/enterprise-state-roaming-enable)
   - [Configure Conditional Access - Require device to be marked as compliant](https://docs.microsoft.com/azure/active-directory/conditional-access/require-managed-devices#require-device-to-be-marked-as-compliant)
   - End-user task: [Join Windows 10 device during first run](https://docs.microsoft.com/azure/active-directory/devices/azuread-joined-devices-frx)
   - View list of joined devices some time later (as admin)
   - [Disable/delete](https://docs.microsoft.com/azure/active-directory/devices/manage-stale-devices)

## Resources
- [Plan your AD Join implementation - configure device settings](https://docs.microsoft.com/azure/active-directory/devices/azureadjoin-plan#configure-your-device-settings)
- [What is a device identity?](https://docs.microsoft.com/azure/active-directory/devices/overview)
- [What is enterprise state roaming?](https://docs.microsoft.com/azure/active-directory/devices/enterprise-state-roaming-overview)
- [Azure AD joined devices](https://docs.microsoft.com/azure/active-directory/devices/concept-azure-ad-join)
- [Manage device identities using the Azure portal](https://docs.microsoft.com/azure/active-directory/devices/device-management-azure-portal)
- [How SSO to on-premises resources works on Azure AD joined devices](https://docs.microsoft.com/azure/active-directory/devices/azuread-join-sso)
- [Tutorial: Join a new Windows 10 device with Azure AD during a first run](https://docs.microsoft.com/azure/active-directory/devices/azuread-joined-devices-frx)
- Related module in progress: [Enable single-sign on with Azure Active Directory Connect](https://github.com/MicrosoftDocs/learn-pr/blob/NEW-enable-sso-with-aad-connect/learn-pr/azure/enable-sso-with-aad-connect/resources/design-doc.md)
- [Manage stale devices in Azure AD](https://docs.microsoft.com/azure/active-directory/devices/manage-stale-devices)