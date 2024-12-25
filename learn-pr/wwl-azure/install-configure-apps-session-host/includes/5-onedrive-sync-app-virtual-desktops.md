By default, the OneDrive sync app installs per-user, meaning that you need to install the app for each user on a machine. With the per-machine installation option, you'll only need to install the app once on a PC. This option is especially useful for computers with multiple users and for when you don't want executable files running from a user profile.

Other than where the sync app is installed, the behavior is the same.

## Requirements

The per-machine installation's system requirements are the same as the per-user installation.

The per-machine installation option supports syncing OneDrive and SharePoint files in Microsoft 365 and in SharePoint Server 2019.

## Deployment instructions

1.  Download **OneDriveSetup.exe**.
2.  Run "OneDriveSetup.exe /allusers" from a command prompt window (this results in a User Account Control prompt) or by using Microsoft Endpoint Configuration Manager.

While the per-user option installs OneDrive for each user account on a PC under the %localappdata% folder, the per-machine option installs OneDrive under the "Program Files (x86)" or "Program Files" directory (depending on the OS architecture).

When setup completes, OneDrive starts. If accounts were added on the computer, they're migrated automatically.

## Verify per-machine installation

To verify that you have the per-machine installation, you can use the following registry detection rule in Configuration Manager:

| **Field**        | **Value**                     |
| ---------------- | ----------------------------- |
| Hive             | HKEY\_LOCAL\_MACHINE          |
| Key              | SOFTWARE\\Microsoft\\OneDrive |
| Name             | Version                       |
| 32-bit on 64-bit | TRUE                          |
| Type             | REG\_SZ                       |
| Value            | 19.043.0304.0007              |

## Revert back to the per-user sync app

We don't support automated migration from per-machine to per-user. To revert back after installing per-machine, uninstall the sync app and [install the latest released version](https://go.microsoft.com/fwlink/?linkid=844652) without the "/allusers" parameter.
