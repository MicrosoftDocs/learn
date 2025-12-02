| Quarter | Baseline update (requires restart) | Hotpatch update (no restart required) |
|---------|------------------------------------|---------------------------------------|
| 1       | January                            | February & March                      |
| 2       | April                              | May & June                            |
| 3       | July                               | August & September                    |
| 4       | October                            | November & December                   |

Hotpatch updates follow a quarterly cycle, reducing the number of required restarts from 12 to four annually, with eight hotpatch updates planned each year.

### Cumulative baseline month

In January, April, July, and October, devices install the monthly fixed security update and restart. This update includes the latest security fixes, new features, and enhancements since the last cumulative baseline.

### Subsequent two months

Devices receive hotpatch updates containing only security fixes, without requiring a restart. Feature and enhancement updates are deferred to the next cumulative baseline month (quarterly).

![Photograph of two people talking in an office setting, with one person seated at a desk using a laptop.](../media/talk.png)

## Prerequisites

To benefit from hotpatch updates, Windows client devices must meet the following requirements:

- **Eligible license**: Windows 11 Enterprise E3 or E5, Microsoft 365 F3, Windows 11 Education A3 or A5, Microsoft 365 Business Premium, or Windows 365 Enterprise. Hotpatching is also supported in Azure Virtual Desktop environments when using these licensed editions.
- **Operating system**: Windows 11 Enterprise (24H2 or later), Windows Server 2022 Azure Edition, Windows Server 2025 Azure Edition/on-prem via Azure Arc. Devices must also be on the latest baseline release version to qualify for hotpatch updates. Microsoft releases baseline updates quarterly as standard cumulative updates. For details, check [Release notes for Hotpatch](/windows/deployment/windows-autopatch/manage/windows-autopatch-hotpatch-updates).  
- **CPU**: x64 processors (AMD64 or Intel). Hotpatching is also supported on 64-bit ARM devices, with Compiled Hybrid Portable Executable (CHPE) disabled. [Learn more.](https://techcommunity.microsoft.com/blog/windows-itpro-blog/hotpatching-now-available-for-64-bit-arm-architecture/4430949)
- **Management**: Microsoft Intune to deploy hotpatch updates using a Windows quality update policy with hotpatch enabled.  
- **Security**: Virtualization-based Security (VBS) must be enabled on the device.  Learn how to enable VBS at scale on the [Windows IT Pro Blog](https://techcommunity.microsoft.com/blog/windows-itpro-blog/hotpatch-readiness-enable-vbs-at-scale/4441652).

> [!NOTE]
> A Windows client device refers to any computer or device that runs a version of the Windows operating system designed for end-users such as Windows 11.
>
> These devices are typically used for personal or business purposes and include desktops, laptops, tablets, and even some mobile devices.
>
> They're distinct from Windows server devices, which are designed to manage network resources and provide services to other computers on a network.

### ARM64 devices

For ARM64 devices, hotpatch updates might not work if Compiled Hybrid Portable Executable (CHPE) support is enabled. To make these devices eligible for hotpatch updates, you must disable CHPE by setting the following registry key:

**Path:** HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management

**DWORD key value:** HotPatchRestrictions=1

CHPE improves app performance on ARM64 devices by compiling parts of the code, but it conflicts with hotpatching because hotpatch updates modify in-memory code for running processes. The CHPE binaries stored in `%SystemRoot%\SyChpe32` aren’t compatible with this process, so disabling CHPE ensures hotpatch updates apply properly without requiring a system restart.

> [!NOTE]
> An ARM64 device uses a 64-bit processor based on the ARM architecture, which is designed for high efficiency and low power consumption. These processors are commonly used in mobile devices, tablets, and lightweight laptops due to their strong performance and battery life.
>
> ARM stands for Advanced RISC Machines—a family of processors built on Reduced Instruction Set Computing (RISC). RISC uses a simplified set of instructions that can be executed quickly, making ARM processors especially well-suited for portable and embedded systems.
