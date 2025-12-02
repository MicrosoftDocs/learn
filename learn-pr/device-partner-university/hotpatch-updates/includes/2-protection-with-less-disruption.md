Keeping Windows devices up to date is critical for security, but frequent restarts for updates can disrupt productivity. Hotpatch updates provide a solution by allowing IT administrators to apply security patches without requiring a system restart.

Hotpatch updates are security only updates (as opposed to nonsecurity or feature updates) that are available for Windows 11 Enterprise, version 24H2 or later, and 64-bit ARM architecture on devices with AMD or Intel x64 processors. They help maintain protection while minimizing operational disruption.  

Key benefits of hotpatching include:

- **Immediate protection**: Updates take effect as soon as they're installed.

- **Consistent security**: Security patches are at 100% parity with standard updates and follow the regular monthly schedule (the second Tuesday of every month).

- **Minimized disruptions**: Updates don't require a restart during the hotpatch months.

- **Smaller patch size**: Hotpatch updates are smaller than cumulative packages, so they install faster, deliver quicker security and compliance, and reduce network load.

> [!TIP]
> Operating system features, firmware, and application updates might still require a restart, but Windows features are included in baseline months and only restart once per quarter—no extra restarts are needed.

![Photograph of a person using a laptop at a wooden desk with a glass of water nearby.](../media/admin.png)

## How does hotpatching work?

Hotpatching begins with the creation of a hotpatch-enabled quality update policy in Windows Autopatch, configured through the Microsoft Intune console.

> [!NOTE]
>*Windows Autopatch* is a cloud service provided by Microsoft that automates the deployment of updates for Windows, Microsoft 365 Apps for Enterprise, Microsoft Edge, and Teams.  
>
> The goal of Windows Autopatch is to improve security and productivity for customers by keeping devices up to date with the latest features and security patches.  
>
> With Windows Autopatch, IT admins can manage feature, quality, and driver updates through the Microsoft Intune admin center. It also enables automatic deployment of hotpatch updates, helping keep devices secure faster and with fewer restarts.

Eligible Windows 11 Enterprise devices (version 24H2 and later) managed under this policy get hotpatch updates two times per quarter.

Devices that get hotpatch updates show different KB numbers and OS builds than devices that get standard cumulative updates. Hotpatch updates apply only security fixes in memory and don’t require a restart, so the system version (OS build) usually stays the same.

Standard cumulative updates include other changes beyond security fixes, so the system version number increases (the "build" is incremented). Microsoft Intune can track both types of updates using KB numbers and OS versions, ensuring all devices remain compliant with security requirements.

Devices that aren’t eligible for hotpatching receive standard monthly updates, which include security and nonsecurity fixes and require a restart.

> [!NOTE]
> A *KB number* is a Knowledge Base ID used by Microsoft to identify a specific update. The *Knowledge Base* is a collection of over 150,000 technical articles, including an update history that catalogs released updates for Windows.
>
> Each Windows update—whether it's a security patch, feature update, hotfix, or hotpatch—is associated with a KB (Knowledge Base) ID, like *KB5036980*. This number:
>
> - Helps IT admins find detailed information about what's in the update.
> - Serves as a unique identifier for tracking, auditing, and troubleshooting purposes.
>
> To find Windows updates in the Microsoft Knowledge Base, go to [support.microsoft.>com](https://support.microsoft.com) and enter the keyword `"kbwindowsupdate"` in >the search bar.
>
>For easier access, IT admins can also bookmark [Windows release health](/windows/>release-health/) on Microsoft Learn, which provides anchored links to release notes >by Windows version.
>
>Hotpatch release notes specifically are located at:
>
> - [Windows 11 Enterprise version 25H2 - Hotpatch release notes](https://support.>microsoft.com/topic/>release-notes-for-hotpatch-on-windows-11-enterprise-version-25h2-0bbaa1c7-5070-41ca->a7c9-4ead79602dbf)
> - [Windows 11 Enterprise version 24H2 - Hotpatch release notes](https://support.>microsoft.com/topic/>release-notes-for-hotpatch-on-windows-11-enterprise-version-24h2-c0906ee6-5e62-498f->bd5a-8f4966349f3c)
>
>They’re also linked from the Hotpatch calendar section of [Windows 11 release information](/windows/release-health/windows11-release-information#windows-11-hotpatch-calendar) on Microsoft Learn, which provides anchored links to release notes by Windows version.