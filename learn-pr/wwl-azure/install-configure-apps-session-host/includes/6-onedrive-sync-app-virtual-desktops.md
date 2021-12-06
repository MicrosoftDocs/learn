For all supported operating systems, the OneDrive sync app supports:

 -  Virtual desktops that persist between sessions.
 -  Non-persistent virtual desktops that use [Azure Virtual Desktop](https://azure.microsoft.com/services/virtual-desktop/).
 -  Non-persistent virtual desktops that have [FSLogix Apps](/fslogix/configure-profile-container-tutorial) or [FSLogix Office Container](/fslogix/configure-office-container-tutorial), and a Microsoft 365 subscription for all of the following operating systems:

 -  Windows 10, 32-bit or 64-bit (supports VHDX files)
 -  Windows 7, 32-bit or 64-bit (supports VHD files)
 -  Windows Server 2019 (supports VHDX)
 -  Windows Server 2016 (supports VHDX)
 -  Windows Server 2012 R2 (supports VHDX)
 -  Windows Server 2008 R2 (supports VHD)

:::image type="content" source="../media/client-onedrive-9d78fce1.png" alt-text="Diagram of users signed in OneDrive files avai.able.":::


OneDrive for Business is not supported in non-persistent RDSH or VDI environments without FSLogix profile containers.

## Install the OneDrive sync app per machine

By default, the OneDrive sync app installs per user, meaning OneDrive.exe needs to be installed for each user account on the PC under the `%localappdata%` folder. With the new per-machine installation option, you can install OneDrive under the **Program Files (x86)** or **Program Files** directory, meaning all profiles on the computer will use the same **OneDrive.exe** binary. Other than where the sync app is installed, the behavior is the same.

The new per-machine sync app provides:

 -  Automatic transitioning from the previous OneDrive for Business sync app (Groove.exe).
 -  Automatic conversion from per-user to per-machine.
 -  Automatic updates when a new version is available.

The per-machine sync app supports syncing OneDrive files for Microsoft 365 and SharePoint Server 2019.

## Deployment instructions

1.  Download **OneDriveSetup.exe**.
2.  Run `OneDriveSetup.exe /allusers` from a command prompt window or by using Microsoft Endpoint Configuration Manager. This will install the sync app under the `Program Files (x86)\Microsoft OneDrive` directory. When setup completes, OneDrive will start. If accounts were added on the computer, they'll be migrated automatically.
