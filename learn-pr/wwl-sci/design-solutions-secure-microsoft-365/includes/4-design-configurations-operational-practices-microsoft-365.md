As a security architect, you need to evaluate how Microsoft Intune addresses your organization's device management requirements. Intune is a cloud-based endpoint management solution that manages user access to organizational resources, simplifies app and device management across mobile devices, desktops, and virtual endpoints, and supports the Zero Trust security model through compliance and reporting features.

## Evaluate Intune device management capabilities

[Microsoft Intune](/intune/intune-service/fundamentals/what-is-intune) provides two primary management approaches that you can use independently or together, depending on your organization's requirements.

### Mobile device management (MDM)

MDM gives you full control over enrolled devices. When devices enroll in Intune, they receive policies that configure settings, enforce security requirements, and manage features. MDM is appropriate for organization-owned devices where you need to control passwords, VPN configurations, threat protection settings, and certificate deployment.

Intune MDM supports multiple platforms, including Windows, macOS, iOS/iPadOS, Android, and Linux. Each platform has specific enrollment methods and configuration capabilities. For Windows devices, [Windows Autopilot](/autopilot/overview) automates device provisioning and preconfiguration, simplifying the deployment lifecycle from initial setup through end of life.

### Mobile application management (MAM)

MAM protects organizational data at the application level without requiring full device enrollment. This approach is ideal for bring-your-own-device (BYOD) scenarios where users access corporate resources from personal devices. [App protection policies](/intune/intune-service/apps/app-protection-policy) enforce rules that control how data is accessed and shared within managed apps. For example, you can prevent users from copying corporate data into personal apps, require a PIN to open work applications, or block saving corporate files to personal storage.

MAM works independently of any MDM solution. You can apply app protection policies to devices enrolled in Intune, enrolled in a non-Microsoft MDM, or not enrolled in any management solution. For enrolled devices, combining MDM with MAM provides both device-level and app-level protection.

### App protection policy framework

Intune organizes app protection policies into three levels that align to increasing security requirements:

- **Level 1 (Enterprise basic)**: Minimum data protection recommended for all enterprise devices.
- **Level 2 (Enterprise enhanced)**: Recommended for devices that access sensitive or confidential information. Some controls might affect user experience.
- **Level 3 (Enterprise high)**: Recommended for devices used by high-risk users or in environments with highly sensitive data, where unauthorized disclosure causes material loss.

## Evaluate endpoint security policies

Intune provides [endpoint security policies](/intune/intune-service/protect/endpoint-security-policy) that focus specifically on device security. These policies are separate from device configuration profiles and compliance policies, providing a dedicated surface for security-focused management.

The following endpoint security policy types are available:

| Policy type | Purpose |
|---|---|
| **Antivirus** | Configures and manages Microsoft Defender Antivirus settings across Windows, macOS, and Linux |
| **Disk encryption** | Manages BitLocker (Windows) and FileVault (macOS) for data-at-rest protection |
| **Firewall** | Configures built-in firewall rules and network access controls |
| **Endpoint detection and response** | Onboards devices to Microsoft Defender for Endpoint and configures advanced threat detection |
| **Attack surface reduction** | Reduces attack vectors through rules that target behaviors used by malware, device control policies, and exploit protection |
| **Account protection** | Protects user identities through Windows Hello for Business, credential guard, and Local Administrator Password Solution (LAPS) |
| **App Control for Business** | Controls which applications can run on Windows devices using Windows Defender Application Control (WDAC) |

For organizations that use Microsoft Defender for Endpoint, Intune supports [security settings management](/intune/intune-service/protect/mde-security-integration) that extends endpoint security policies to devices onboarded to Defender but not enrolled in Intune. This capability provides consistent security controls across enrolled and unenrolled devices.

## Evaluate compliance and Conditional Access integration

[Device compliance policies](/intune/intune-service/protect/device-compliance-get-started) define the rules and conditions that devices must meet to be considered compliant. Common compliance rules include minimum OS version requirements, password complexity, maximum device threat level (when integrated with a Mobile Threat Defense partner), and encryption status.

Compliance policies become most effective when integrated with [Microsoft Entra Conditional Access](/intune/intune-service/protect/conditional-access). This integration creates a Zero Trust access control mechanism:

1. Intune evaluates device compliance against your defined policies.
2. The compliance status is reported to Microsoft Entra ID.
3. Conditional Access policies use the compliance status to grant or block access to organizational resources.

You can implement device-based Conditional Access that requires devices to be marked as compliant before accessing Microsoft 365 services, SaaS applications, or on-premises resources. For apps where device enrollment isn't feasible, app-based Conditional Access works with Intune app protection policies to ensure only managed apps can access corporate data.

### Actions for noncompliance

Compliance policies support configurable [actions for noncompliance](/intune/intune-service/protect/actions-for-noncompliance) that execute in a time-ordered sequence. These actions include sending notifications to the user, remotely locking the device, marking the device as noncompliant (which triggers Conditional Access enforcement), and retiring noncompliant devices with removal of corporate data.

## Design considerations for Intune

When you evaluate Intune for your organization, consider the following:

- **Enrollment strategy**: Determine which devices require full MDM enrollment and which scenarios suit MAM-only protection. Organization-owned devices typically benefit from MDM, while BYOD scenarios often work best with MAM or MAM combined with lightweight enrollment.
- **Security baselines**: Use [Intune security baselines](/intune/intune-service/protect/security-baselines) as a starting point for device configuration. Baselines provide Microsoft-recommended security settings for Windows and other platforms, reducing the effort needed to establish a secure configuration.
- **Endpoint security layering**: Layer endpoint security policies with compliance policies and Conditional Access to create defense in depth. Each layer addresses a different aspect of device security.
- **Mobile Threat Defense integration**: Integrate a [Mobile Threat Defense partner](/intune/intune-service/protect/mobile-threat-defense) to add device threat level as a compliance signal. This extends compliance evaluation beyond configuration checks to include active threat detection.
- **Platform coverage**: Assess the platforms in your environment and verify that Intune supports the enrollment methods, configuration profiles, and security policies required for each. Not all policy types are available on all platforms.

## Align with Microsoft cloud security benchmark v2

The [Microsoft cloud security benchmark v2 (MCSBv2)](/security/benchmark/azure/overview) provides a framework of security controls that you can use to validate your Intune design against Microsoft-recommended best practices. The **Endpoint Security (ES)** domain includes three controls, all rated "Must have," that map directly to Intune capabilities:

| MCSBv2 control | Intune alignment |
|---|---|
| **ES-1: Use Endpoint Detection and Response (EDR)** | Endpoint detection and response policies onboard devices to Microsoft Defender for Endpoint and integrate with Microsoft Defender XDR for cross-signal correlation. Security settings management extends EDR policies to devices not enrolled in Intune. |
| **ES-2: Use modern anti-malware software** | Antivirus policies manage Microsoft Defender Antivirus with behavioral analytics and cloud-delivered protection. Attack surface reduction rules, exploit protection, and controlled folder access address advanced threat techniques. |
| **ES-3: Ensure anti-malware software and signatures are updated** | Defender Update controls policies automate signature and engine updates. Compliance policies and Conditional Access enforce access restrictions for devices with outdated protection. |

Beyond endpoint security, Intune also supports controls in other MCSBv2 domains. Compliance policies integrated with Conditional Access align with **Identity Management (IM)** controls for device-based access enforcement. App protection policies and disk encryption align with **Data Protection (DP)** controls for protecting data at rest and in transit. Device inventory and configuration management capabilities support **Asset Management (AM)** controls for maintaining security visibility across your endpoint estate.


