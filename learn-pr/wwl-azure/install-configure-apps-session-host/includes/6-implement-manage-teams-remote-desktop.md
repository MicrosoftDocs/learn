Microsoft Teams on Azure Virtual Desktop supports chat and collaboration. With media optimizations, it also supports calling and meeting functionality by redirecting it to the local device when using Windows App or the Remote Desktop client on a supported platform. You can still use Microsoft Teams on Azure Virtual Desktop on other platforms without optimized calling and meetings. Teams chat and collaboration features are supported on all platforms.

There are two versions of Teams, *Classic Teams* and *[New Teams](/microsoftteams/new-teams-desktop-admin)*, and you can use either with Azure Virtual Desktop. New Teams has with feature parity with Classic Teams, but improves performance, reliability, and security.

To redirect calling and meeting functionality to the local device, Azure Virtual Desktop uses an extra component. This component is either *SlimCore* or the *WebRTC Redirector Service*. The option you use depends on the following:

 -  New Teams can use either SlimCore or the WebRTC Redirector Service. SlimCore is available in preview and you need [to opt in to the preview](/microsoftteams/public-preview-doc-updates?tabs=new-teams-client) to use it. If you use SlimCore, you should also install the WebRTC Redirector Service. This allows a user to fall back to WebRTC, such as if they roam between different devices that don't support the new optimization architecture.
 -  Classic Teams uses the WebRTC Redirector Service.

If you're using the [classic Teams app with Virtual Desktop Infrastructure (VDI) environments](/microsoftteams/teams-for-vdi), such as as Azure Virtual Desktop, end of support is **October 1, 2024** and end of availability is **July 1, 2025**, after which you'll need to use the new Microsoft Teams app.

## Before you can use Microsoft Teams on Azure Virtual Desktop, you need:<br>

 -  [Prepare your network](/microsoftteams/prepare-network/) for Microsoft Teams.
 -  Connect to a session host running Windows 10 or 11 multi-session or Windows 10 or 11 Enterprise. Session hosts running an N or KN SKU of Windows aren't supported.
 -  For Windows, you also need to install the latest version of the [Microsoft Visual C++ Redistributable](https://support.microsoft.com/help/2977003/the-latest-supported-visual-c-downloads) on your client device and session hosts. The C++ Redistributable is required to use media optimization for Teams on Azure Virtual Desktop.
 -  Install the latest version of [Windows App](/windows-app/get-started-connect-devices-desktops-apps) or the [Remote Desktop client](/azure/virtual-desktop/users/connect-windows) on Windows or macOS that meets the [hardware requirements for Microsoft Teams](/microsoftteams/hardware-requirements-for-the-teams-app#hardware-requirements-for-teams-on-a-windows-pc/).
    
    SlimCore is available on Windows with the following apps and versions:
    
    
     -  Windows App for Windows, version 1.3.252 or later
     -  Remote Desktop client for Windows, version 1.2.5405.0 or later
 -  If you use FSLogix for profile management and want to use the new Microsoft Teams app, you need to install FSLogix 2210 hotfix 3 (2.9.8716.30241) or later.

Media optimization for Microsoft Teams is only available for the following clients:

 -  [Remote Desktop client for Windows](/azure/virtual-desktop/users/connect-windows) or the [Azure Virtual Desktop app](/azure/virtual-desktop/users/connect-windows-azure-virtual-desktop-app), version 1.2.1026.0 or later, including ARM64-based devices.
 -  [Remote Desktop client for macOS](/azure/virtual-desktop/users/connect-macos), version 10.7.7 or later.
 -  [Windows App](/windows-app/get-started-connect-devices-desktops-apps).

## Prepare to install the Teams desktop app

This section shows you how to install the Teams desktop app on your Windows 10 or 11 Enterprise multi-session or Windows 10 or 11 Enterprise VM image.

### Enable media optimization for Teams

To enable media optimization for Teams, set the following registry key on each session host:

1.  From the start menu, run **Registry Editor** as an administrator. Go to HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Teams. Create the Teams key if it doesn't already exist.
2.  Create the following value for the Teams key:

| **Name**         | **Type** | **Data/Value** |
| ---------------- | -------- | -------------- |
| IsWVDEnvironment | DWORD    | 1              |

Alternatively, you can create the registry entry by running the following commands from an elevated PowerShell session:

```powershell
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Teams" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Teams" -Name IsWVDEnvironment -PropertyType DWORD -Value 1 -Force
```

### Install the Remote Desktop WebRTC Redirector Service

You need to install the WebRTC Redirector Service on each session host. You can install the [MSI file](https://aka.ms/msrdcwebrtcsvc/msi) using a management tool such [Configuration Manager](/mem/configmgr/apps/get-started/create-and-deploy-an-application), or manually.

To install the WebRTC Redirector Service manually:

1.  Sign in to a session host as a local administrator.
2.  Download the [Remote Desktop WebRTC Redirector Service installer](https://aka.ms/msrdcwebrtcsvc/msi).
3.  Open the file that you downloaded to start the setup process.
4.  Follow the prompts. Once it's completed, select **Finish**.

You can find more information about the latest version of the WebRTC Redirector Service at [What's new in the Remote Desktop WebRTC Redirector S](/azure/virtual-desktop/whats-new-webrtc) client.

## Install Teams on session hosts

You can deploy the Teams desktop app per-machine or per-user. For session hosts in a pooled host pool, you need to install Teams per-machine. To install Teams on your session hosts follow the steps in the relevant article:

## Verify media optimizations loaded

After installing the WebRTC Redirector Service and the Teams desktop app, follow these steps to verify that Teams media optimizations loaded:

1.  Connect to a remote session.
2.  Quit and restart the Teams application.
3.  Select your user profile image, then select **About**.
4.  Select **Version**.
    
    If media optimizations loaded, the banner shows you **AVD SlimCore Media Optimized** or **AVD Media Optimized**. If the banner shows you **AVD Media not connected**, quit the Teams app and try again.
5.  Select your user profile image, then select **Settings**.
    
    If media optimizations loaded, the audio devices and cameras available locally will be enumerated in the device menu. If the menu shows **Remote audio**, quit the Teams app and try again. If the devices still don't appear in the menu, check the Privacy settings on your local PC. Ensure the under **Settings** &gt; **Privacy** &gt; **App permissions - Microphone** the setting **"Allow apps to access your microphone"** is toggled **On**. Disconnect from the remote session, then reconnect and check the audio and video devices again. To join calls and meetings with video, you must also grant permission for apps to access your camera.
    
    If media optimizations don't load, uninstall then reinstall Teams and check again.

## Enable registry keys for optional features

If you want to use certain optional features for Teams on Azure Virtual Desktop, you need to enable certain registry keys. The following instructions only apply to Windows client devices and session host VMs.

### Enable hardware encode for Teams on Azure Virtual Desktop

Hardware encode lets you increase video quality for the outgoing camera during Teams calls. In order to enable this feature, your client needs to be running version 1.2.3213 or later of the [Windows Desktop client](/azure/virtual-desktop/whats-new-client-windows). You need to repeat the following instructions for every client device.

To enable hardware encode:

1.  On your client device, from the start menu, run **Registry Editor** as an administrator.
2.  Go to HKCU\\SOFTWARE\\Microsoft\\Terminal Server Client\\Default\\AddIns\\WebRTC Redirector.
3.  Add the **UseHardwareEncoding** as a DWORD value.
4.  Set the value to **1** to enable the feature.
5.  Repeat these instructions for every client device.

### Enable content sharing for Teams for RemoteApp

Enabling content sharing for Teams on Azure Virtual Desktop lets you share your screen or application window. To enable this feature, your session host VM needs to be running version 1.31.2211.15001 or later of [the WebRTC Redirector Service](/azure/virtual-desktop/whats-new-webrtc) and version 1.2.3401 or later of the [Windows Desktop client](/azure/virtual-desktop/whats-new-client-windows).

To enable content sharing:

1.  On your session host VM, from the start menu, run **Registry Editor** as an administrator.
2.  Go to HKLM\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\AddIns\\WebRTC Redirector\\Policy.
3.  Add the **ShareClientDesktop** as a DWORD value.
4.  Set the value to **1** to enable the feature.

### Disable desktop screen share for Teams for RemoteApp

You can disable desktop screen sharing for Teams on Azure Virtual Desktop. To enable this feature, your session host VM needs to be running version 1.31.2211.15001 or later of [the WebRTC service](/azure/virtual-desktop/whats-new-webrtc) and version 1.2.3401 or later of the [Windows Desktop client](/azure/virtual-desktop/whats-new-client-windows).

> [!NOTE]
> You must [enable the ShareClientDesktop key](/azure/virtual-desktop/teams-on-avd#enable-content-sharing-for-teams-for-remoteapp) before you can use this key.

To disable desktop screen share:

1.  On your session host VM, from the start menu, run **Registry Editor** as an administrator.
2.  Go to HKLM\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\AddIns\\WebRTC Redirector\\Policy.
3.  Add the **DisableRAILScreensharing** as a DWORD value.
4.  Set the value to **1** to disable desktop screen share.

### Disable application window sharing for Teams for RemoteApp

You can disable application window sharing for Teams on Azure Virtual Desktop. To enable this feature, your session host VM needs to be running version 1.31.2211.15001 or later of [the WebRTC service](/azure/virtual-desktop/whats-new-webrtc) and version 1.2.3401 or later of the [Windows Desktop client](/azure/virtual-desktop/whats-new-client-windows).

> [!NOTE]
> You must [enable the ShareClientDesktop key](/azure/virtual-desktop/teams-on-avd#enable-content-sharing-for-teams-for-remoteapp) before you can use this key.

To disable application window sharing:

1.  On your session host VM, from the start menu, run **Registry Editor** as an administrator.
2.  Go to HKLM\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\AddIns\\WebRTC Redirector\\Policy.
3.  Add the **DisableRAILAppSharing** as a DWORD value.
4.  Set the value to **1** to disable application window sharing.
