[APP](/mem/intune/apps/app-protection-policy) helps secure organizational data within applications by setting rules that control how and when users can access or transfer corporate data. These policies can restrict access to resources or monitor for prohibited actions within company apps—helping to keep sensitive information safe.

APP is a key component of [Mobile Application Management (MAM) in Microsoft Edge](/mem/intune/apps/protect-mam-windows) on Windows devices. It helps secure corporate data by controlling how it’s accessed and shared within applications. For example, it can restrict actions like copying, pasting, and saving corporate data to unauthorized locations.

APP works with Conditional Access policies to ensure that only healthy and compliant devices can access corporate resources. This means that before a device can access sensitive data, it must meet certain security criteria.

It also integrates with [Windows Security](https://www.microsoft.com/windows/comprehensive-security?msockid=3acc3426320e6adb17ce20ab33a66b84&r=1) to perform health checks on devices. This ensures that devices are free from threats and are in a secure state before they can access corporate information.

One of the significant advantages of APP is that it can be applied without requiring devices to be enrolled in Intune. This allows you to protect data on both managed and unmanaged (personal) devices.

You can learn more about how to create and assign app protection policies [here](/mem/intune/apps/app-protection-policies).

![A photograph of two employees collaborating together on a desktop computer in an office environment. One employee is seated at the desk while the other is standing beside them.](../media/intune-management.png)

## Wipe company app data

When a device is lost, stolen, or an employee leaves the company, you might want to ensure that company app data is removed from the device—without affecting personal data, especially on employee-owned devices.

With APP, you can selectively wipe only corporate data from managed apps. *(This feature is available only through Microsoft Edge on Windows.)*

### How to wipe corporate app data

To selectively remove company app data, create a wipe request by using the steps in [this article](/mem/intune/apps/apps-selective-wipe).

After the request is finished, the next time the app runs on the device, company data is removed from the app. In addition, you can also configure a selective wipe of company data as a new action when the conditions of APP Access settings aren't met. This helps automatically protect and remove sensitive company data from applications based on preconfigured criteria.

## Expanding with Intune Suite

Microsoft Intune Suite, on the other hand, is a more comprehensive package that includes all the capabilities of core Intune plus other advanced features, such as:

- **Remote Help:** Provides IT support to users remotely.

- **Endpoint Privilege Management:** Manages and controls user privileges on endpoints.

- **Microsoft Tunnel for MAM:** Secures access to corporate resources on mobile devices.

- **Advanced Endpoint Analytics:** Offers deeper insights and analytics for endpoint management.

- **Microsoft Cloud PKI:** Simplifies and automates the issuance, renewal, and revocation of certificates.

- **Enterprise App Management:** Easily discover, deploy, and keep apps up to date.

For more information about Intune Suite, including a full list of available add-ons and licensing options, visit [Intune add-ons](/mem/intune/fundamentals/intune-add-ons)

## When to use Intune Suite

Intune Suite’s add-ons are helpful for people whose needs go beyond basic endpoint management into more advanced security, analytics, and support capabilities. Here are some scenarios when Intune Suite is a good fit:

### Enhanced security and compliance needs

Endpoint Privilege Management in Intune Suite allows you to manage user permissions by providing granular, just-in-time elevation of privileges for specific tasks.

You can define which tasks require elevated permissions and grant users only the necessary access temporarily—reducing the need for permanent admin rights. You can also review logs of all privileged actions to ensure compliance and monitor for security risks.

### Comprehensive remote support needs

The Remote Help feature in Intune Suite allows you to securely assist users by troubleshooting and resolving issues on their devices, even when they're working remotely.

You can connect to an end user’s device from any location to diagnose and fix problems in real-time—without the need for in-person support. You can also monitor active Remote Help sessions and view details about past sessions through detailed reports and audit logs in the Intune admin center.

In the Microsoft Intune admin center, you can view reports that include details about who helped who, on what device, and for how long. You can also find details about active sessions.

You can reference audit log sessions created for Remote Help in Intune under:

*Tenant Administration > Audit Logs*

Auditing Remote Help sessions is limited for unenrolled devices.

### Want more proactive management

Advanced Endpoint Analytics offers deeper insights and reporting capabilities for device management. It delivers detailed analytics on device health, including metrics—like boot times, app performance, and hardware status so you can take preventative measures.

Diagnostic data helps identify the root causes of problems for faster troubleshooting and more effective resolutions. Additionally, by using historical data, you can predict future device issues—preventing disruptions before they affect users.

### Support for specialized environments

Intune Suite provides management capabilities for specialized devices like Alternate Reality/Virtual Reality (AR/VR) headsets and large smart-screen devices—ensuring consistent compliance and security across a broader range of devices.

This allows you to manage and secure these unique device types as effectively as traditional endpoints—supporting a diverse and evolving device ecosystem while maintaining robust security and compliance standards.