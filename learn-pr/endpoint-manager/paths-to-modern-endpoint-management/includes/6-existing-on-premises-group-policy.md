In the cloud, Mobile Device Management (MDM) providers, such as Microsoft Intune, manage settings and features on devices. When using Intune, group policies objects (GPOs) aren't used. Intune provides device configuration profiles, which replace GPOs.

## Device configuration profiles

Microsoft Intune includes settings and features you can enable or disable on different devices within your organization. These settings and features are added to "configuration profiles".  You can create profiles for different devices and different platforms, including iOS/iPadOS, Android device administrator, Android Enterprise, and Windows. Then, use Intune to apply or "assign" the profile to the devices.

As part of a MDM solution, you can use these configuration profiles to complete different tasks. Some profile examples include:

- On Windows 10 devices, use a profile template that blocks ActiveX controls in Internet Explorer.
- On iOS/iPadOS and macOS devices, allow users to use AirPrint printers in your organization.
- Allow or prevent access to bluetooth on the device.
- Create a WiFi or VPN profile that gives different devices access to your corporate network.
- Manage software updates, including when they're installed.
- Run an Android device as dedicated kiosk device that can run one app, or run many apps.

## Group policy objects

Group policy objects (GPOs) are primarily used on-premises to configure settings on Windows computers, but also can include remote Windows devices. In device management, GPOs help control security and features in the Windows OS, Internet Explorer, Office apps, and more. Group policy provides the capability to manage a large number of Active Directory Domain Services (AD DS) computer and user objects through a centralized, one-to-many model. Group Policy settings are contained in a group policy object and linked to one or more AD DS service containers—sites, domains, and organizational units (OUs). Note that devices do not have to be domain-joined to apply GPOs.

 Some organizations have Group Policy settings that are restrictive and could cause problems during operating system deployments. For example, the following group policy settings can interrupt an automated logon process:  
- Autologon restrictions
- Administrator account renaming
- Legal banners and captions
- Restrictive security policies

If your organization uses GPOs and you want to move some workloads to Microsoft Endpoint Manager and Intune, then **Group Policy analytics** will help.

## Group policy analytics

Many organizations are looking at cloud solutions to support the growing remote workforce. **Group Policy analytics** is a tool and feature in Microsoft Endpoint Manager that analyzes your GPOs. It helps you determine how your GPOs translate in the cloud. The output shows which settings are supported in MDM providers, including Microsoft Intune. It also shows any deprecated settings, or settings not available to MDM providers.

## Next steps

For detailed steps when you currently use on-premises Group Policy as your on-premises management solution, see the [Currently use on-premises group policy](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup?azure-portal=true#currently-use-on-premises-group-policy).
