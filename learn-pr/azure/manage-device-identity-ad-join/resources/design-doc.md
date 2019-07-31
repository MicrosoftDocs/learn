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

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

   You work for a large book publisher that's deploying Windows 10 to employees' laptops. Your organization uses Azure Active Directory with Azure Multi-Factor Authentication enabled. You use these services to manage user identities and help protect the organization's resources. You want to add another layer of security for devices. Specifically, you want to restrict access to the organization's resources to only devices that are managed by your organization and are deemed compliant by your mobile device management (MDM) system.

1. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**
How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Module is to cover Az-103 and AZ-300 cert tasks: Configure Azure AD Join and Configure enterprise state roaming
- Customers will need to complete exercises with their own subscription or LOD. I'll need to confirm before we develop content.

Conceptual content to include:

- Identify and describe when to use options to manage device identities in Azure AD: Azure AD registered, Azure AD joined, or Hybrid Azure AD joined.
  - Supported devices
  - Non-supported environmental configurations 
  - Prereqs for device identity management
- Tools & features you'd use as best practice (MDM tool that supports Azure AD intergration & conditional access for devices - right now that's only Intune)
- If you're using MFA, user's don't have to do MFA when they're using an MDM compliant & AD joined device AND conditional access is marked as compliant. You have the option on the conditional access device settings to set AND/OR condition when you set the checkboxes for compliant, MFA, etc. If you needed to be super secure for something like a payroll app, maybe you'd require MFA AND compliant device. Need to be sure to discuss those options.
 - Discuss what settings there are for devices identity management and conditional access like local admin on devices etc. By default, **Additional local administrators on Azure AD joined devices** is enabled. This adds global admin and [device admin](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles#device-administrators) roles as local admin on device.
  
- For scenario, solution is to use AD joined for Windows 10 machines. They can have on-premises AD with SSO & AD Connect set up. But that doesn't require the "Hybrid Azure AD joined" setup. They can bypass that and just join to Azure AD and not on-premises AD. It's easier to do it that way. Employees could still BYOD as long as they're Windows 10 devices and they want to sign in using their organizational account (and want to enroll/join the organization).

- What is enterprise state roaming and why you'd set it up
- What's conditional access and why you'd use this? There is some coverage as it relates to users  in module: [Secure your Azure resources with conditional access](https://docs.microsoft.com/learn/modules/secure-azure-resources-with-conditional-access/)
- End user experience to join and then to sign in.


Tasks involved: 
   - [Configure device settings in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/devices/azureadjoin-plan#configure-your-device-settings)
   - [Configure MDM provider](https://docs.microsoft.com/azure/active-directory/devices/azureadjoin-plan#configure-your-mobility-settings)
   - [Configure enterprise state roaming](https://docs.microsoft.com/azure/active-directory/devices/enterprise-state-roaming-enable)
   - [Configure Conditional Access - Require device to be marked as compliant](https://docs.microsoft.com/azure/active-directory/conditional-access/require-managed-devices#require-device-to-be-marked-as-compliant)
   - End-user task: [Join Windows 10 device during first run](https://docs.microsoft.com/en-us/azure/active-directory/devices/azuread-joined-devices-frx)
    - View list of joined devices some time later (as admin)
   - [Disable/delete](https://docs.microsoft.com/azure/active-directory/devices/manage-stale-devices)

## Resources
- [Plan your AD Join implementation - configure device settings](https://docs.microsoft.com/en-us/azure/active-directory/devices/azureadjoin-plan#configure-your-device-settings)
- [What is a device identity?](https://docs.microsoft.com/azure/active-directory/devices/overview)
- [What is enterprise state roaming?](https://docs.microsoft.com/azure/active-directory/devices/enterprise-state-roaming-overview)
- [Azure AD joined devices](https://docs.microsoft.com/azure/active-directory/devices/concept-azure-ad-join)
- [Manage device identities using the Azure portal](https://docs.microsoft.com/en-us/azure/active-directory/devices/device-management-azure-portal)
- [How SSO to on-premises resources works on Azure AD joined devices](https://docs.microsoft.com/en-us/azure/active-directory/devices/azuread-join-sso)
- [Tutorial: Join a new Windows 10 device with Azure AD during a first run](https://docs.microsoft.com/en-us/azure/active-directory/devices/azuread-joined-devices-frx)
- Related module in progress: [Enable single-sign on with Azure Active Directory Connect](https://github.com/MicrosoftDocs/learn-pr/blob/NEW-enable-sso-with-aad-connect/learn-pr/azure/enable-sso-with-aad-connect/resources/design-doc.md)
- [Manage stale devices in Azure AD](https://docs.microsoft.com/azure/active-directory/devices/manage-stale-devices)
