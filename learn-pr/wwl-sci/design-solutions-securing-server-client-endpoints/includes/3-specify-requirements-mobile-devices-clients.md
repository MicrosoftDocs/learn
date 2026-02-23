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
- Hardware-level restrictions and encryption enforcement
- Mandatory security baseline deployment
- Remote wipe of entire device contents

**Personal devices (BYOD)** require a different approach:

- App-level protection without device enrollment (MAM-only)
- Containerization of corporate data within managed apps
- Selective wipe that removes only corporate data
- Privacy boundaries that prevent access to personal content

For corporate devices, use mobile device management (MDM) enrollment to enforce security policies at the device level. For BYOD scenarios, mobile application management (MAM) policies protect corporate data without requiring device enrollment.

## Define mobile threat protection requirements

Mobile devices face threats including malicious apps, network attacks, and operating system vulnerabilities. Microsoft Defender for Endpoint provides mobile threat defense (MTD) capabilities that integrate with device compliance evaluation.

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

App protection policies create a security boundary around corporate data within applications. These policies apply regardless of device enrollment status, making them essential for BYOD scenarios.

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

## Configure Windows client security baselines

Windows client workstations require comprehensive hardening beyond endpoint protection. Security baselines provide a standardized set of configurations aligned with Microsoft security recommendations.

Specify these baseline categories in your requirements:

**Authentication and access control**

- Require Windows Hello for Business or hardware security keys
- Configure 14-character minimum password length
- Set account lockout after failed attempts
- Enable Credential Guard with UEFI lock

**Attack surface reduction**

- Block executable content from email and webmail clients
- Block untrusted and unsigned processes running from USB
- Enable Virtualization Based Security with Secure Boot
- Configure Windows Defender Application Control policies

**Network protection**

- Block SMB v1
- Require SMB signing for all communications
- Disable multicast name resolution (LLMNR)
- Block connection to non-domain networks when domain-connected

**Endpoint protection**

- Enable Microsoft Defender Antivirus real-time protection
- Configure cloud-delivered protection with high blocking level
- Enable tamper protection to prevent security setting changes
- Deploy Microsoft Defender for Endpoint for EDR capabilities

## Integrate with conditional access

Conditional access policies provide the enforcement mechanism for device compliance requirements. Configure policies that evaluate device health before granting access to corporate resources.

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
