When admins want to configure and manage security tasks for at-risk devices, they can go to the Endpoint security node in Intune.

## Manage devices

The Endpoint security node includes the *All devices* view, where you'll see a list of all devices from your Azure AD that are available in Microsoft Endpoint Manager.

From this view, you can select devices to drill in for more information, such as which policies a device isn't compliant with. You can also use access from this view to remediate issues for a device, including restarting, start a scan for malware, or rotate BitLocker keys on a Windows 10 device.

For more information, go to: [Manage devices with endpoint security in Microsoft Intune](https://docs.microsoft.com/mem/intune/protect/endpoint-security-manage-devices).

## Manage security baselines

Intune includes [security baselines](https://docs.microsoft.com/mem/intune/protect/endpoint-security#manage-security-baselines) for Windows devices and a growing list of applications, including Microsoft Edge, Microsoft Defender for Endpoint (previously Microsoft Defender Advanced Threat Protection), and more. Security baselines are preconfigured groups of Windows settings that help admins apply recommended security. 

As an example, the MDM Security Baseline automatically enables BitLocker for removable drives, automatically requires a password to unlock a device, and automatically disables basic authentication. Admins can also customize the baselines to enforce only those settings and values that are required.

## Use policies to manage device security

Each [Endpoint security policy](https://docs.microsoft.com/mem/intune/protect/endpoint-security#use-policies-to-manage-device-security) focuses on aspects of device security like antivirus, disk encryption, firewalls, and areas such as endpoint detection and response and attack surface reduction, made available through integration with Microsoft Defender for Endpoint.

Endpoint security policies are one of several methods in Intune to configure settings on devices. When managing settings, it's important to understand what other methods being used in your environment can configure your devices, to [avoid policy conflicts](https://docs.microsoft.com/mem/intune/protect/endpoint-security#avoid-policy-conflicts).

## Use device compliance policy

Use device compliance policy to establish the conditions by which devices and users are allowed to access the corporate network and company resources. With compliance policies, admins can set the rules that devices and users must meet to be considered compliant. Rules can include OS versions, password requirements, device threat levels, and more. To learn more, go to: [Use compliance policies to set rules for devices you manage with Intune](https://docs.microsoft.com/mem/intune/protect/device-compliance-get-started).

Device compliance policies are one of several methods in Intune to configure settings on devices. When managing settings, it's important to understand what other methods being used in your environment can configure your devices to [avoid policy conflicts](https://docs.microsoft.com/mem/intune/protect/endpoint-security#avoid-policy-conflicts).

## Configure conditional access

Intune can be integrated with Azure AD conditional access policies to enforce compliance policies. Intune passes the results of your device compliance policies to Azure AD, which then uses conditional access policies to enforce which devices and apps can access your corporate resources.

The following are two common methods of using conditional access with Intune:

- Device-based conditional access, to ensure only managed and compliant devices can access network resources.
- App-based conditional access, which uses app protection policies to manage access to network resources by users on devices that aren't managed with Intune.

To learn more about using conditional access with Intune, go to: [Learn about Conditional Access and Intune.](https://docs.microsoft.com/mem/intune/protect/conditional-access)

## Integration with Microsoft Defender for Endpoint

Intune can integrate with Microsoft Defender for Endpoint (formerly Microsoft Defender ATP) for a Mobile Threat Defense solution. Integration can help prevent security breaches and limit the impact of breaches within an organization.

Microsoft Defender for Endpoint works with devices that run:

- Android
- iOS/iPadOS
- Windows 10 or later

By integrating Intune with Microsoft Defender for Endpoint, organizations can take advantage of Microsoft Defender for Endpoint’s Threat and Vulnerability Management (TVM), using Intune to remediate endpoint weakness identified by TVM.

To learn more, go to: [Enforce compliance for Microsoft Defender for Endpoint with Conditional Access in Intune](https://docs.microsoft.com/mem/intune/protect/advanced-threat-protection).

## Role-based access control with Microsoft Intune

Role-based access control (RBAC) helps manage who has access to the organization's resources and what they do with them. By assigning roles to Intune users, admins limit what they'll see and change. Each role has a set of permissions that determine what users with that role can access and change within your organization.

To manage tasks in the Endpoint security node of the Microsoft Endpoint Manager admin center, an account must have RBAC permissions equal to the permissions provided by the built-in Intune role of **Endpoint Security Manager**. The Endpoint Security Manager role grants access to the Microsoft Endpoint Manager admin center. This role can be used by individuals who manage security and compliance features, including security baselines, device compliance, conditional access, and Microsoft Defender for Endpoint.

To learn more, go to: [Role-based access control (RBAC) with Microsoft Intune](https://docs.microsoft.com/mem/intune/fundamentals/role-based-access-control).

## Video demonstration of Microsoft Endpoint Manager capabilities

In this eight-minute video, you’ll explore Endpoint Manager, and some of its capabilities.

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4LTIu]
