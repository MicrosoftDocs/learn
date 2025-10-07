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

![Two people talking in an office setting, with one person seated at a desk using a laptop.](../media/talk.png)

## Prerequisites

To benefit from Hotpatch updates, Windows client devices must meet the following requirements:

- **Eligible license**: Windows 11 Enterprise E3 or E5, Microsoft 365 F3, Windows 11 Education A3 or A5, Microsoft 365 Business Premium, or Windows 365 Enterprise.  
- **Operating system**: Windows 11 version 24H2 or later. Devices must also be on the latest baseline release version to qualify for Hotpatch updates. Microsoft releases baseline updates quarterly as standard cumulative updates. For details, see [Release notes for Hotpatch](/windows/deployment/windows-autopatch/manage/windows-autopatch-hotpatch-updates).  
- **CPU**: x64 processors (AMD64 or Intel). Hotpatching is also available for 64-bit ARM devices. [Learn more.](https://techcommunity.microsoft.com/blog/windows-itpro-blog/hotpatching-now-available-for-64-bit-arm-architecture/4430949) for details.  
- **Management**: Microsoft Intune to deploy hotpatch updates using a Windows quality update policy with hotpatch enabled.  
- **Security**: Virtualization-based Security (VBS) must be enabled on the device.

> [!NOTE]
> A Windows client device refers to any computer or device that runs a version of the Windows operating system designed for end-users such as Windows 10 or Windows 11.
>
> These devices are typically used for personal or business purposes and include desktops, laptops, tablets, and even some mobile devices.
>
> They're distinct from Windows server devices, which are designed to manage network resources and provide services to other computers on a network.