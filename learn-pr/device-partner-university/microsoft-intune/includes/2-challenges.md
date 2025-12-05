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
- Encrypt data to prevent unauthorized access.
- Monitor the location of corporate tablets, laptops, and mobile phones.
- Maintain an up-to-date inventory of enrolled devices.
- Deploy certificates to devices for streamlined access to corporate networks via Wi-Fi or VPN.

### Mobile Application Management (MAM) capabilities

Available only with Microsoft Edge on Windows:

- Remove organizational data from devices that are lost, stolen, or decommissioned.
- Remotely wipe data and manage access to applications.

## Unpack Intune's core features

### Device management

For company-owned devices enrolled in Intune, you can fully manage and control device settings and access. The devices receive your configurations and rules through policies set in Intune.

For employees’ personal devices, app protection policies can enforce security measures such as blocking copy-paste actions from the corporate-managed Edge browser to unmanaged apps.

You can learn more about device management on [Microsoft Learn](/mem/intune/fundamentals/what-is-intune#manage-devices).

> [!NOTE]
> As of November 2024, Microsoft Edge is the only corporate-managed app available on Windows.

### App management

Intune can provide application-level data protection for both organization-owned and personal devices. On Windows, this capability is available exclusively through Microsoft Edge.

You can manage a wide range of apps, including custom and store apps. You can add and assign mobile apps to user groups and devices, configure app settings, and update existing installations. Intune also provides app usage reporting and allows for selective wiping of organizational data from apps.

Learn more about app management on [Microsoft Learn](/mem/intune/fundamentals/manage-apps).

### Compliance & Conditional Access

With Intune, you can deploy device compliance policies to check if a device meets their security and configuration requirements.

Based on whether a device is compliant or not, you can decide to allow or block access to company resources. This way, only devices that are properly managed and compliant can connect to the organization's network, email, Microsoft 365 services, and apps.

Learn more about Conditional Access on [Microsoft Learn](/mem/intune/protect/device-compliance-get-started).