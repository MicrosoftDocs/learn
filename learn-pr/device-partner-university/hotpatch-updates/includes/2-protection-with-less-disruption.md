Keeping Windows devices up to date is critical for security, but frequent restarts for updates can disrupt productivity. Hotpatch updates provide a solution by allowing IT administrators to apply security patches without requiring a system restart.  

Hotpatch updates are available for Windows 11 Enterprise, version 24H2, on devices with AMD or Intel x64 processors. They help maintain protection while minimizing operational disruption.  

Key benefits of hotpatching include:

- **Immediate protection**: Updates take effect as soon as they're installed.

- **Consistent security**: Security patching aligns with the standard monthly update schedule (the second Tuesday of every month).

- **Minimized disruptions**: Updates don't require a restart for the remainder of the quarter.

> [!TIP]
> Operating system features, firmware, and/or application updates might still require a restart.

![Person using a laptop at a wooden desk with a glass of water nearby.](../media/admin.png)

## How does hotpatching work?

Hotpatching begins with the creation of a hotpatch-enabled quality update policy in Windows Autopatch, configured through the Microsoft Intune console.

> [!NOTE]
>*Windows Autopatch* is a cloud service provided by Microsoft that automates the deployment of updates for Windows, Microsoft 365 Apps for Enterprise, Microsoft Edge, and Teams.  
>
> The goal of Windows Autopatch is to improve security and productivity for your customers by keeping devices up to date with the latest features and security patches.  
>
> With Windows Autopatch, IT admins can manage feature, quality, and driver updates through the Microsoft Intune admin center. It also allows them to automatically deploy hotpatch updates to keep devices secure with fewer reboots.

Eligible Windows 11 Enterprise, version 24H2 devices managed under this policy receive hotpatch updates on a quarterly basis, aligned with the standard ring deployment schedule.

> [!NOTE]
> A *ring deployment* is a method of rolling out updates in phases, starting with a small, controlled group of devices and gradually expanding to the rest of the organization. The first group—often made up of early adopters, IT staff, or test devices—receives the update first.
>
> If no major issues are found, the update is then rolled out to increasingly larger groups (or "rings") of users. This approach minimizes risk, because any problems can be identified and resolved early, before they reach all users or critical systems.

Devices receiving hotpatch updates reflect a different KB number and OS version compared to those receiving standard updates that require a restart.

Devices not eligible for hotpatching receive the Latest Cumulative Update (LCU), which includes both security and nonsecurity fixes and requires a restart.

> [!NOTE]
> A *KB number* is a Knowledge Base ID used by Microsoft to identify a specific update. The *Knowledge Base* is a collection of over 150,000 technical articles provided by Microsoft, including an update history that catalogs released updates for Windows.
>
> Each Windows update—whether it's a security patch, feature update, hotfix, or hotpatch—is associated with a KB (Knowledge Base) ID, like *KB5036980*.
>
> This number:
>
> - Helps IT admins find detailed information about what's included in the update.
> - Serves as a unique identifier for tracking, auditing, and troubleshooting purposes.  
>
> To find Windows updates in the Microsoft Knowledge Base, go to [support.microsoft.com](https://support.microsoft.com) and enter the keyword `"kbwindowsupdate"` in the search bar.