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

- Familiarity with Azure Active Directory features Like Azure AD Connect, Azure Active Directory Seamless Single Sign-On, and Multi-Factor Authentication
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
| What is Azure AD Join | Restrict access to organizational resources | Exercise | 2 | Yes |
| Using Enterprise State Roaming | Restrict Access to your organizations resources | Knowledge Check | 3 | Yes |

## Outline the units

1. **Introduction**

   You work for a large book publisher that's deploying Windows 10 to employees' laptops. Your organization uses Azure Active Directory with Azure Multi-Factor Authentication enabled. You use these services to manage user identities and help protect the organization's resources. You want to add another layer of security for devices. Specifically, you want to restrict access to the organization's resources to only devices that are managed by your organization and are deemed compliant by your mobile device management (MDM) system.

1. **Understand device identity**

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
           - Licencing Requirements
    - Benefits of device identity management
           - Improved device security
           - Better and simpler provision
    - Considerations of using device identity
           - Licensing requirements
           - Windows 10 limitations

    What types of questions will test *understanding device identities*?

    - What operating systems are supported by Azure AD registered?
           - Windows 10, iOS, Android, and MacOS
    - What security measures are supported by Azure AD Join?
           - An organizational account with password or Windows Hello.

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
           - Device Settings in Azure
           - Mobile Settings in Azure

1. **Exercise - Use Azure AD Join to connect a Windows 10 device to Azure AD Join**

    List the steps, which apply the learning content from previous unit:

    We'll start by add a windows device to your Azure AD

    1. Start with a new Windows 10 device that is ready to start the set-up process. Follow the set-up wizard until the asked who owns the PC.
    1. Select this device belongs to my organization and select Next.
    1. Enter your organizations log in credentials and sign in.
    1. Follow any MFA that is required.

    Next we'll log into Azure AD and find the device:

    1. Sign into the Azure portal you used ot register the Windows 10 device.
    1. Select Azure Active Directory from the nav bar.
    1. Select Device settings from the manage section.
    1. Select All Devices
    1. If the new Windows 10 device is not present search for it.

    Now you can see all the devices that have been registered.

    1. Find the registered device, click on the ellipses.
    1. Select Disable.
    1. Return to your Windows device.  If you are logged in, log out now.
    1. Try to connect the device to your Azure AD.  You will see that it is no longer allowed. 
    1. Return to the Azure Portal.
    1. Navigate to the Device and enable it again.
    1. Return to your device and log in again.

1. **What is enterprise state roaming in Azure**

    List the content that will enable the learner to *understand enterprise state roaming*:

    - What is enterprise state roaming
           - Why use enterprise state roaming
    - Enabling enterprise state roaming in Azure
    - Features of enterprise state roaming
           - Data storage
           - Data retention

    What types of questions will test *learning objective*?

    - What is classified as stale data?
           - Any data that has not been accessed for one year or more.
    - Name one of the benefits of using enterprise state roaming
           - Separation of corporate and consumer data, enhanced security, and better management.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    In this module you have been introduced to device identities, and how they can be used to bring better access control to your organizations resources. You have explored using the cloud-first, mobile-first Azure AD option and how it can support self-service and BOYD. You have also explored how to use enterprise state roaming to allow for separation of corporate date from consumer data and how it can allow for settings to move with the user when they switch devices without having to go through a lengthy set-up process. You have seen how conditional access you can control when and how a user will access your corporate resources. 

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

**Question**

- I have assumed that it is possible to set up a VM and treat this as a new device, to simulate a windows 10 device.  Is this the right approach or should this all be based on knowledge checks?
