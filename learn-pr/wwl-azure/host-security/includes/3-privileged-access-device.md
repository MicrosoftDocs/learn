
To ensure the most secure conditions for your company to you need to ensure security from the time of purchase of a new device, to its first usage, and beyond. Zero Trust, means that you don't purchase from generic retailers but only supply hardware from an authorized OEM that support Autopilot.

For this solution, root of trust will be deployed using Windows Autopilot technology with hardware that meets the modern technical requirements. To secure a workstation, Autopilot lets you leverage Microsoft OEM-optimized Windows 10 devices. These devices come in a known good state from the manufacturer. Instead of reimaging a potentially insecure device, Autopilot can transform a Windows 10 device into a “business-ready” state. It applies settings and policies, installs apps, and even changes the edition of Windows 10.

:::image type="content" source="../media/secure-workstation-deployment-flow-f33ffd59.png" alt-text="Process flow diagram that shows that hardware is most secure, when purchased from a trusted OEM that uses Autopilot to provision the device before delivery, then strong security policies are enforced throughout its usage.":::


## Hardware root-of-trust

To have a secured workstation you need to make sure the following security technologies are included on the device:

 -  Trusted Platform Module (TPM) 2.0
 -  BitLocker Drive Encryption
 -  UEFI Secure Boot
 -  Drivers and Firmware Distributed through Windows Update
 -  Virtualization and HVCI Enabled
 -  Drivers and Apps HVCI-Ready
 -  Windows Hello
 -  DMA I/O Protection
 -  System Guard
 -  Modern Standby

## Levels of device security

| **Device Type**    | **Common usage scenario**                                                    | **Permitted activities**                                                                              | **Security guidance**                                                                                         |
| ------------------ | ---------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Enterprise Device  | Home users, small business users, general purpose developers, and enterprise | Run any application, browse any website                                                               | Anti-malware and virus protection and policy based security posture for the enterprise.                       |
| Specialized Device | Specialized or secure enterprise users                                       | Run approved applications, but cannot install apps. Email and web browsing allowed. No admin controls | No self administration of device, no application installation, policy based security, and endpoint management |
| Privileged Device  | Extremely sensitive roles                                                    | IT Operations                                                                                         | No local admins, no productivity tools, locked down browsing. PAW device                                      |

This chart shows the level of device security controls based on how the device will be used.

:::image type="content" source="../media/secure-workstations-levels-73fa7cab.png" alt-text="Chart with three levels of device security across the top - Enterprise, Specialized, and Privileged.  Then content of the chart explore what security settings should be used for each.  This data is covered in the table included in the content below.":::


## Device security controls

A secure workstation requires it be part of an end-to-end approach including device security, account security, and security policies applied to the device at all times. Here are some common security measures you should consider implementing based on the users' needs. Using a device with security measures directly aligned to the security needs of it users is the more secure solution.

| **Security Control**                      | **Enterprise Device** | **Specialized Device**          | **Privileged Device** |
| ----------------------------------------- | --------------------- | ------------------------------- | --------------------- |
| Microsoft Endpoint Manager (MEM) managed  | Yes                   | Yes                             | Yes                   |
| Deny BYOD Device enrollment               | No                    | Yes                             | Yes                   |
| MEM security baseline applied             | Yes                   | Yes                             | Yes                   |
| Microsoft Defender for Endpoint           | Yes                   | Yes                             | Yes                   |
| Join personal device via Autopilot        | Yes                   | Yes                             | No                    |
| URLs restricted to approved list          | Allow Most            | Allow Most                      | Deny Default          |
| Removal of admin rights                   |                       | Yes                             | Yes                   |
| Application execution control (AppLocker) |                       | Audit -&gt; Enforced | Yes                   |
| Applications installed only by MEM        |                       | Yes                             | Yes                   |
