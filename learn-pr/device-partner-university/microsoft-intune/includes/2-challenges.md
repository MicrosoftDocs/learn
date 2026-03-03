As remote work becomes more prevalent, organizations must manage a diverse set of devices that require access to corporate resources. Employees need secure connectivity from various locations, while IT administrators are responsible for safeguarding data, managing access controls, and providing user support. A comprehensive solution is needed to maintain productivity, ensure data protection, and accommodate evolving operational requirements.

![A photograph showing an arial view of a remote worker using a laptop while seated in a building lobby.](../media/remote-worker.png)

## Secure access to resources

Microsoft Intune is a cloud-based service designed to address these needs.

It enables centralized management of access to organizational resources and streamlines application and device administration across multiple platforms, including mobile devices, desktops, and virtual endpoints. Additionally, it has compliance and reporting features that support the [Zero Trust security model](/mem/intune/fundamentals/zero-trust-with-microsoft-intune).

## What can Intune do?

### Mobile Device Management (MDM) capabilities

Available with or without Microsoft Edge on Windows:

- Configure devices to comply with organizational security and compliance policies.
- Generate reports to identify noncompliant users and devices.
- Manage Windows data encryption functionality.
- Initiate an admin-initiated device location request for devices where location services are enabled and allowed.
- Maintain an up-to-date inventory of enrolled devices.
- Deploy certificates to devices for streamlined access to corporate networks via Wi-Fi or VPN.
- Deploy applications.
- Deploy Windows updates.
- Deploy scripts to correct misconfiguration or configuration drift.

### Mobile Application Management (MAM) capabilities

Available only with and for Microsoft Edge on Windows:

- Remove organizational data from devices that are lost, stolen, or decommissioned.
- Remotely wipe organizational data and manage access to applications.

## Unpack Intune's core features

### Device management

For company-owned devices enrolled in Intune, you can fully manage and control device settings and access. The devices receive configurations and rules through policies set in Intune.

For employees’ personal devices, [app protection policies](/mem/intune/apps/app-protection-policy) can enforce security measures such as blocking copy-paste actions from the corporate-managed Microsoft Edge browser to any other application.

Learn more about [device management](/mem/intune/fundamentals/what-is-intune#manage-devices).

> [!NOTE]
> As of November 2024, Microsoft Edge is the only corporate-managed app available on Windows.

### App management on Windows (Microsoft Edge only)

On Windows, Microsoft Intune currently provides application-level data protection only through Microsoft Edge. This feature helps enable secure access to corporate resources from unmanaged or personal devices without requiring full device enrollment.

Administrators can protect corporate data accessed through the browser using app protection policies. These policies can restrict actions such as copying, pasting, printing, downloading, or saving data locally, and help ensure that organizational data remains isolated from personal data.

This capability supports secure access scenarios and doesn't provide broad application management on Windows.

Supported scenarios include:

- **Bring Your Own Device (BYOD):** Corporate data remains protected while employees can securely access organizational resources using Microsoft Edge on their personal devices.

- **Public or shared devices:** Users can securely sign in from public or shared Windows computers—such as conference kiosks or hotel business centers—without leaving corporate data behind on the device.

Learn more about [app management](/mem/intune/fundamentals/manage-apps).

### App management on iOS and Android

On iOS and Android, Intune can enforce app-level protection policies on managed and unmanaged devices across multiple apps—not just a single browser. Administrators can apply policies to Microsoft apps, supported non-Microsoft apps, and custom apps. These policies can restrict actions such as copying, pasting, printing, or saving organizational data, and support selective wiping of corporate data without affecting personal data. This ensures corporate data remains protected while employees have secure access to resources across multiple apps, not just Microsoft Edge.

### Compliance & Conditional Access

With Intune, you can deploy device compliance policies to check if a device meets their security and configuration requirements.

Based on whether a device is compliant or not, you can decide to allow or block access to company resources. This way, only devices that are properly managed and compliant can connect to the organization's network, email, Microsoft 365 services, and apps.

Learn more about Conditional Access on [Microsoft Learn](/mem/intune/protect/device-compliance-get-started).
