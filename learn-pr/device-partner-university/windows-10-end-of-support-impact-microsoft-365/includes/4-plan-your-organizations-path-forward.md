Organizations have several options to remain supported and ensure a smooth experience with Microsoft 365 apps:

- Upgrade existing PCs
- Purchase new Windows 11 devices
- Use Windows 365 Cloud PCs

## Upgrade existing PCs

Upgrade existing devices that meet the Windows 11 hardware requirements.

Use tools such as **PC Health Check**, **Microsoft Intune**, or **Windows Autopatch** to assess and automate the process.

**Try it yourself:**

Run the following PowerShell command to confirm your current operating system version:

```powershell
Get-CimInstance Win32_OperatingSystem | Select Caption, Version, BuildNumber, OSArchitecture
```

This command displays the Windows version and hardware abstraction layer so you can verify which devices are still on Windows 10.

### Validation steps

1. Open **Settings > System > About** to verify edition and build.
1. Use **PC Health Check** to test upgrade readiness.
1. In Intune, filter by operating system version to locate devices still running Windows 10.

## Purchase new Windows 11 devices

Modern PCs are designed for Windows 11 and include hardware-level protection features such as Secure Boot and TPM 2.0.

They're also optimized for modern productivity experiences, including **Copilot in Windows**, which integrates AI assistance directly into workflows.

| **Benefit** | **Description** |
| :---: | :---: |
| **Security** | Hardware-based security is enabled by default. |
| **Performance** | Faster startup, better power management, and support for AI-accelerated workloads. |
| **Manageability** | Simplified deployment with Intune and Autopilot. |

## Use Windows 365 Cloud PCs

**Windows 365** allows users with legacy or incompatible hardware to access a secure Windows 11 Cloud PC from any device.

Each Cloud PC includes access to Microsoft 365 apps in a managed, up-to-date environment.

>[!TIP]
> Windows 365 subscriptions include **Extended Security Updates** for Windows 10 devices at no additional cost when accessing a Cloud PC.
> This enables a hybrid approach—using older hardware temporarily while maintaining full support for Microsoft 365.

## Compare your options

| **Path** | **Description** | **When to choose it** |
| :---: | :---: | :---: |
| **Upgrade in place** | Move existing supported devices to Windows 11. | Devices meet TPM 2.0 and CPU requirements. |
| **Replace devices** | Purchase new Windows 11 PCs for users. | Hardware is outdated or fails compatibility checks. |
| **Adopt Windows 365** | Run Windows 11 in the cloud. | Ideal for hybrid work or when hardware refresh cycles are delayed. |

:::image type="content" border="true" source="../media/windows-10-to-windows-11-flowchart.png" alt-text="Flowchart diagram showcasing the various options for moving from Windows 10 to Windows 11":::
