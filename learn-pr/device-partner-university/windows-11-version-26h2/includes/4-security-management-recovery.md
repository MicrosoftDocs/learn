Contoso's endpoint and security teams have a different question:

**What does Windows 11, version 26H2 introduce or change for securing, managing, and recovering Windows devices?**

The update includes changes across each of these areas.

## Security and sign-in

Windows 11, version 26H2 includes security and sign-in changes with different configuration and hardware requirements. As Contoso evaluates these capabilities, the IT team needs to distinguish between features that are available but require configuration and features that depend on compatible hardware.

### Available but off by default

- **Administrator protection** uses just-in-time administrative privileges and profile separation to help harden Windows against elevation-of-privilege attacks. Administrator protection is off by default and can be enabled using Microsoft Intune or Group Policy.
- **System Monitor (Sysmon) is built into Windows but is off by default.** Sysmon captures system events that security tools can use for threat detection and supports configuration files for filtering the events to monitor.

### Configurable security behavior

- **Smart App Control** can now be turned on or off without requiring a clean installation of Windows. When enabled, Smart App Control helps block untrusted or potentially harmful applications.

### Requires compatible hardware

- **Windows Hello Enhanced Sign-in Security** expands to compatible peripheral fingerprint sensors, extending the capability beyond devices with built-in fingerprint sensors.

Windows 11, version 26H2 also changes how the kernel trusts third-party drivers. Default trust for cross-signed drivers is removed, while drivers from the Windows Hardware Compatibility Program and an allow list of trusted legacy drivers remain allowed. Windows audits driver compatibility before enabling enforcement.

For Contoso, these different states affect what the team needs to validate. Installing Windows 11, version 26H2 doesn't mean every security capability associated with the release is automatically active or applicable to every device. During its targeted deployment, the team can determine which capabilities require configuration, which depend on compatible hardware, and which are relevant to its security requirements.

## Device management

Windows 11, version 26H2 includes several enhancements for device management and deployment.

- **Windows Autopilot device preparation:** Device association helps organizations identify trusted devices before enrollment. It enables device-targeted policies, automatic corporate device enrollment, and additional customization during the out-of-box experience.
- **Policy-based app removal:** Organizations have additional flexibility to remove preinstalled Microsoft apps packaged as MSIX or APPX by using Group Policy.
- **RSAT on Arm64:** Support for Remote Server Administration Tools on Arm64 is included among the management and deployment enhancements associated with version 26H2.
- **App update orchestration:** App update orchestration is also included among the management and deployment enhancements associated with version 26H2.

## Backup and recovery

Windows settings backup is enabled by default for eligible commercial devices in Windows 11, version 26H2. It can preserve supported Windows settings and Microsoft Store app lists for recovery and device replacement scenarios, while existing administrator-configured policies continue to be honored.

The first sign-in restore experience supports Microsoft Entra hybrid joined devices, Cloud PCs, and multi-user environments. It can restore user settings and Microsoft Store app lists automatically at first sign-in.

Point-in-time restore for Windows provides another recovery option. It can roll back a PC, including applications, settings, and personal files, to a recent automatic restore point. This feature is automatically disabled on enterprise-managed systems and on devices with an OS volume size of less than 200 GB, but can be enabled if desired.

Quick machine recovery can perform a one-time scan for remediation when quick machine recovery and automatically checking for solutions are both enabled. On domain-joined or enterprise-managed devices, the feature remains off unless enabled.

## Return to Contoso

Contoso's team shouldn't ask only:

What security features do we get when we install 26H2?

A better set of questions is:

- Which capabilities are available?
- Which are enabled by default?
- Which require IT to enable or configure them?
- Which management or recovery capabilities are relevant to Contoso's environment?

This distinction helps the team avoid assuming that the presence of a capability and its configuration are the same thing.

## Key takeaways

Windows 11, version 26H2, includes security, management, backup, and recovery changes, but these capabilities can have different defaults and configuration requirements. Contoso should evaluate each relevant capability according to its documented behavior.
