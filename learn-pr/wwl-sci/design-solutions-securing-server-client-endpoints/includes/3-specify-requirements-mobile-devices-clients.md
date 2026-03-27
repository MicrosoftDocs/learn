When designing security for an organization's endpoint environment, security architects must address the unique challenges that mobile devices and client workstations present. These devices operate in diverse environments, connect to multiple networks, and access corporate data both inside and outside organizational boundaries.

## Establish a requirements framework

Security requirements for mobile devices and clients should address three fundamental areas:

- **Endpoint protection**: Detection and response capabilities for threats targeting the device
- **Hardening**: Configuration settings that reduce the attack surface
- **Data protection**: Controls that prevent unauthorized access to and leakage of corporate data

Your requirements should align with the Microsoft Cloud Security Benchmark Endpoint Security (ES) domain, which applies equally to mobile endpoints and client workstations. The same core controls—ES-1 (endpoint detection and response), ES-2 (modern anti-malware), and ES-3 (software updates)—form the foundation for mobile and client security.

## Differentiate ownership models

Device ownership significantly affects security architecture decisions. Corporate-owned devices allow full management control, while bring-your-own-device (BYOD) scenarios require balancing security with user privacy.

**Corporate-owned devices** support:

- Full device enrollment with complete configuration management
- Hardware restrictions and encryption enforcement
- Mandatory security baseline deployment
- Remote wipe of entire device contents

**Personal devices (BYOD)** require a different approach:

- App-level protection without device enrollment (MAM-only)
- Containerization of corporate data within managed apps
- Selective wipe that removes only corporate data
- Privacy boundaries that prevent access to personal content

For corporate devices, use mobile device management (MDM) enrollment to enforce security policies at the device level. For BYOD scenarios, mobile application management (MAM) policies protect corporate data without requiring device enrollment.

## Define mobile threat protection requirements

Mobile devices face threats including malicious apps, network attacks, and OS vulnerabilities. Microsoft Defender for Endpoint provides mobile threat defense (MTD) capabilities that integrate with compliance evaluation.

Key protection capabilities to require:

| Capability | iOS | Android | Purpose |
| --- | --- | --- | --- |
| Web protection | ✓ | ✓ | Block access to malicious websites and phishing attempts |
| Network protection | ✓ | ✓ | Detect rogue networks and certificate-based attacks |
| Jailbreak detection | ✓ | — | Identify devices with bypassed security controls |
| Root detection | — | ✓ | Identify devices with elevated privileges |
| Malware scanning | — | ✓ | Detect malicious applications at install time |
| Vulnerability assessment | ✓ | ✓ | Identify operating system and app vulnerabilities |

Integrate MTD signals with conditional access policies to block compromised devices from accessing corporate resources. Set a maximum threat level threshold—when a device exceeds this level, access is automatically blocked until the threat is resolved.

## Specify app protection requirements

App protection policies create a security boundary around corporate data within applications. These policies apply regardless of enrollment status, making them essential for BYOD scenarios.

Configure data protection requirements:

- **Block copy-paste** between managed and unmanaged apps
- **Require encryption** for data stored by managed apps
- **Block screen capture** to prevent data leakage
- **Require PIN or biometric** authentication to access managed apps
- **Block backup** of managed app data to unmanaged cloud services

For enhanced security, implement a tiered app protection framework:

- **Level 1 (Basic)**: PIN access, data encryption, selective wipe
- **Level 2 (Enhanced)**: Block copy-paste, require minimum OS version, block jailbroken/rooted devices
- **Level 3 (High)**: Block screen capture, require MTD integration, block unmanaged keyboards

## Specify Windows client security baselines

Windows client workstations require comprehensive hardening beyond endpoint protection. Security baselines provide standardized configurations aligned with Microsoft security recommendations.

Specify these baseline categories in your requirements:

**Authentication and access control**

- Require Windows Hello for Business or hardware security keys
- Configure 14-character minimum password length with account lockout
- Enable Credential Guard with UEFI lock
- Require BitLocker device encryption with TPM protection
- Remove local administrator rights for standard users

**Attack surface reduction**

- Block executable content from email and webmail clients
- Block untrusted and unsigned processes running from USB
- Enable Virtualization Based Security with Secure Boot
- Configure Windows Defender Application Control policies

**Network protection**

- Block SMB v1
- Require SMB signing for all communications
- Disable multicast name resolution (LLMNR)
- Block connection to nondomain networks when domain-connected

**Endpoint protection**

- Enable Microsoft Defender Antivirus real-time protection
- Configure cloud-delivered protection with high blocking level
- Enable tamper protection to prevent security setting changes
- Deploy Microsoft Defender for Endpoint for EDR capabilities
- Enforce automated OS and application patching with defined compliance deadlines

## Define conditional access integration

Conditional access policies enforce device compliance requirements by evaluating device health before granting access to corporate resources.

Key integration points:

- **Compliance state**: Block access from devices that fail compliance policy evaluation
- **Risk level**: Block or require additional authentication for devices with elevated risk signals
- **App protection**: Require approved client apps with protection policies applied
- **Device filters**: Apply different policies based on device platform, ownership, or enrollment status

For mobile devices, require both device compliance (if enrolled) and app protection policies. This dual-layer approach protects data even if device management is bypassed.

## Design considerations for architects

When specifying mobile and client security requirements, consider:

**Enrollment strategy**

Determine which scenarios require full device enrollment versus app-only protection. Corporate devices typically need MDM for comprehensive control, while BYOD may only need MAM.

**Platform coverage**

Ensure requirements address iOS, Android, Windows, and macOS clients. Each platform has different security capabilities and management tools.

**User experience**

Balance security requirements with productivity impact. Overly restrictive policies drive users toward shadow IT alternatives.

**Compliance dependencies**

Some industries require specific data protection controls. Validate that your requirements meet regulatory obligations for data handling on mobile devices.

## Design a secure solution for mobile devices and clients with Microsoft Intune

Microsoft Intune serves as the policy engine, deployment mechanism, and compliance evaluation platform for implementing the requirements defined in the preceding sections. Use Intune as the unified management plane that enforces endpoint protection, hardening, and configuration across mobile devices and client workstations.

### Design enrollment and ownership strategies

Map your ownership model requirements to Intune enrollment methods. For corporate-owned devices, design enrollment flows using automated device enrollment (Apple Business Manager, Android Enterprise, Windows Autopilot) that apply configuration profiles and compliance policies during setup—ensuring devices meet requirements before users access corporate data.

For BYOD scenarios, design around MAM without enrollment. Users access corporate data through managed apps like Outlook, Teams, and Microsoft Edge without enrolling their device. Architect app protection policies that create a secure container for corporate data while respecting user privacy.

### Architect endpoint protection with Defender integration

Design your threat protection solution around the native integration between Intune and Microsoft Defender for Endpoint. Enable the Defender for Endpoint connector and build your protection architecture on these capabilities:

- **Risk-based compliance**: Define compliance rules that mark devices as noncompliant when Defender reports a threat level above your configured threshold.
- **Automated access control**: Architect conditional access policies that automatically block noncompliant devices from Microsoft Entra ID–protected resources until remediation occurs.
- **Vulnerability-driven remediation**: Use Defender for Endpoint vulnerability findings that surface as security tasks in Intune to drive update deployments and configuration changes.

For Windows clients, design endpoint security policies in Intune to manage Defender Antivirus settings, attack surface reduction rules, and endpoint detection and response configuration. These policies provide a focused interface for deploying the protection controls specified in your baseline requirements.

### Design hardening with security baselines and configuration profiles

Use Intune security baselines as the foundation for your hardening strategy. Select and customize baselines that align with your requirements:

- **Microsoft Defender for Endpoint baseline**: Configures attack surface reduction rules, real-time protection, cloud-delivered protection level, and tamper protection settings.
- **Windows security baseline**: Deploys authentication controls (password policies, account lockout), network protections (SMB configuration, LLMNR), and system hardening (Credential Guard, Virtualization Based Security, BitLocker).
- **Microsoft Edge baseline**: Hardens browser settings to prevent phishing, block malicious downloads, and enforce site isolation.

Layer configuration profiles on top of baselines for platform-specific hardening. Use device restrictions profiles to block USB storage, require encryption, disable screen capture, and enforce specific Wi-Fi and VPN configurations.

For Windows clients, include Windows Defender Application Control (WDAC) policies and Windows Firewall rules in your design through the Intune endpoint security node to address attack surface reduction requirements.

### Design app protection for managed and unmanaged devices

Architect your app protection strategy using Intune app protection policies that implement the tiered data protection framework. These policies enforce:

- **Data transfer restrictions**: Block cut, copy, and paste between managed corporate apps and unmanaged personal apps. Block saving corporate data to personal cloud storage.
- **Access requirements**: Require a PIN, biometric authentication, or both before opening managed apps. Set minimum OS version requirements to block access from outdated devices.
- **Conditional launch**: Block access on jailbroken or rooted devices, require a minimum app version, and integrate with Defender for Endpoint risk signals to block compromised devices.

Assign these policies to user groups without device enrollment, making them your primary protection layer for BYOD scenarios. For enrolled devices, layer app protection policies on top of device-level compliance for defense in depth.

### Architect compliance evaluation with conditional access

Design your compliance evaluation strategy to connect Intune compliance policies with Microsoft Entra Conditional Access. Define compliance rules that evaluate encryption status, OS version, threat level, and password configuration, then architect the enforcement flow:

1. A user attempts to access a protected resource (Exchange Online, SharePoint, a line-of-business app).
1. Conditional access evaluates grant conditions—device compliance state, app protection policy status, user risk, sign-in risk.
1. If the device is noncompliant or lacks an app protection policy, access is blocked or the user is directed to remediate.

This design closes the loop between requirements and enforcement. Intune evaluates whether the device meets your security requirements, and conditional access enforces the access decision.

### Plan for cross-platform consistency

Design your solution to use Intune as a single management plane across all required platforms. iOS, Android, Windows, macOS, and Linux devices are managed through the same admin center with platform-specific policies. This ensures consistent security posture across the device fleet and simplifies compliance reporting.
