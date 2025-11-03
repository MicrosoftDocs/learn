When Windows 10 reached end of support on October 14, 2025 it no longer receives security updates, bug fixes, or technical assistance from Microsoft.  
For IT professionals, this marks a critical point in lifecycle management: unsupported devices become increasingly vulnerable and more difficult to manage securely.

Let's explore what Windows 10 end of support means for your organization and why a structured upgrade assessment is essential to maintain compliance and protect business operations.

## What Windows 10 end of support means

End of support doesn't mean Windows 10 will stop working—but it does mean that:
- **No new updates or patches** are released to protect against emerging threats.  
- **No official support** is available from Microsoft for troubleshooting or compatibility issues.  
- **Compliance and audit risks** increase as unsupported systems may no longer meet security baselines or certification requirements.  

These changes place responsibility on IT teams to ensure every device remains secure and supported.

## Why upgrading now matters

Continuing to run Windows 10 introduces growing risk across three key areas:

| Area | Impact |
|------|--------|
| **Security** | Unsupported systems are more exposed to vulnerabilities and malware. |
| **Productivity** | Legacy hardware may struggle to run modern apps and workloads efficiently. |
| **Compliance** | Failing to maintain supported software may violate organizational or regulatory standards. |

Upgrading to Windows 11 provides continued access to updates, modern security features, and compatibility with the latest productivity tools.

## The upgrade planning process

Transitioning from Windows 10 to Windows 11 typically involves three major steps:

- **Assess device readiness**  
   Use tools such as **PC Health Check** and **Endpoint Analytics** to determine which devices can run Windows 11.  
- **Plan and execute upgrades**  
   Create a phased rollout strategy for capable devices, and plan replacements for unsupported systems.  
- **Validate application compatibility**  
   Confirm that business-critical applications function properly before and after the upgrade.

This structured process helps ensure security, reduce downtime, and provide a consistent experience for users. Before planning upgrades, it’s important to confirm which existing devices are eligible for Windows 11. For devices that aren’t managed through an endpoint management solution such as Microsoft Intune, Microsoft provides a built-in tool called **PC Health Check**.

This lightweight application quickly evaluates hardware readiness and explains whether a device can run Windows 11. You use it to determine which noncentrally managed systems meet the minimum requirements and which need additional configuration or replacement.

## Why use PC Health Check?

Noncentrally managed devices—such as standalone PCs or systems outside your organization’s management tools—still need to be evaluated for Windows 11 compatibility. Running PC Health Check ensures that each device is secure, compliant, and ready for continued updates after Windows 10 end of support.

## Minimum system requirements

Before running the assessment, review the minimum Windows 11 hardware requirements.  
Devices that don’t meet these specifications need hardware upgrades or replacement.

| Component | Requirement |
|------------|-------------|
| **Processor** | 1 GHz or faster with 2 or more cores on a compatible 64-bit processor or SoC |
| **RAM** | 4 GB or more |
| **Storage** | 64 GB or larger |
| **Firmware** | UEFI, Secure Boot capable |
| **TPM** | Version 2.0 |
| **Graphics** | DirectX 12+ compatible with WDDM 2.0 driver |
| **Display** | 720p or higher, 9” or greater |

## Get started with PC Health Check

Now that support has ended for Windows 10, IT professionals need a simple way to determine which devices in their organization are ready for Windows 11. The [PC Health Check](https://support.microsoft.com/windows/how-to-use-the-pc-health-check-app-9c8abd9b-03ba-4e67-81ef-36f37caa7844) app provides a quick, comprehensive eligibility assessment to confirm whether a device meets the Windows 11 minimum system requirements.

When you run the app, it evaluates key hardware components—such as the processor, memory, storage capacity, and Trusted Platform Module (TPM) version—and compares them to Windows 11’s baseline requirements. After scanning, the app displays a clear readiness result along with details on any gaps that prevent an upgrade.

PC Health Check doesn’t just provide a “yes” or “no” answer. It explains **why** a device is or isn’t eligible and, when possible, recommends steps you can take to meet requirements. This makes it a valuable tool for IT administrators assessing individual or small sets of unmanaged devices.

## Interpreting eligibility results

Depending on the outcome of the check, devices display one of three possible statuses:

- ✅ **Green checkmark** – The device meets all Windows 11 requirements and is ready for the upgrade.  
  If it’s currently running **Windows 10, version 2004 or later**, it can be upgraded for free through **Settings > Update and Security > Windows Update**.

- ⚠️ **Yellow exclamation point** – The device may require one or more adjustments before it qualifies for Windows 11.  
  Next steps depend on the specific gaps identified (for example, enabling Secure Boot or updating firmware).

- ❌ **Red X** – The device doesn’t meet the minimum requirements and can’t be upgraded.  
  In this case, plan a hardware refresh with Windows 11-ready devices to maintain compliance and security.

## The role of PC Health Check in your upgrade plan

Using PC Health Check gives IT professionals a fast, standardized way to evaluate readiness for unmanaged endpoints. Instead of relying on manual audits or assumptions, teams can gather accurate data and make informed decisions about which systems to upgrade, which to adjust, and which to replace—all critical steps for maintaining a secure and productive environment post-Windows 10.

> [!IMPORTANT]
> This tool is designed for **unmanaged or standalone** devices that aren’t connected to Microsoft Intune or other centralized management systems.

## Reflect

Consider the following:

- How many devices in your environment might not meet the minimum requirements?  
- Which unmet requirements—such as TPM 2.0 or Secure Boot—could be resolved through configuration versus hardware replacement?  
- How could you document these results to inform procurement or upgrade planning?

By running PC Health Check, you can accurately identify which unmanaged devices are ready for Windows 11 and which require next steps to maintain security and compliance.

Next, you apply what you’ve learned in a hands-on exercise using PC Health Check to evaluate device readiness.