Media optimization for Microsoft Teams is only available for the Windows Desktop client on Windows 10 machines.

Microsoft Teams on Azure Virtual Desktop supports chat and collaboration. With media optimizations, it also supports calling and meeting functionality.

With media optimization for Microsoft Teams, the Windows Desktop client handles audio and video locally for Teams calls and meetings. You can still use Microsoft Teams on Azure Virtual Desktop with other clients without optimized calling and meetings.

Teams chat and collaboration features are supported on all platforms. To redirect local devices in your remote session, check out [Customize Remote Desktop Protocol properties for a host pool](/azure/virtual-desktop/teams-on-wvd).

**Before you can use Microsoft Teams on Azure Virtual Desktop:**

 -  Install the Windows Desktop client on a Windows 10 or Windows 10 IoT Enterprise.
 -  Connect to a Windows 10 Multi-session or Windows 10 Enterprise virtual machine (VM).

## Install the Teams desktop app

This section will show you how to install the Teams desktop app on your Windows 10 Multi-session or Windows 10 Enterprise VM image.

### Prepare your image for Teams.

To enable media optimization for Teams, set the following registry key on the host:

1.  From the start menu, run **RegEdit** as an administrator. Navigate to **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Teams**. Create the Teams key if it doesn't already exist.
2.  Create the following value for the Teams key:

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Data/Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IsAVDEnvironment
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::


## Install the Teams WebSocket Service

Install the latest [Remote Desktop WebRTC Redirector Service](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4AQBt) on your VM image.

## Install Microsoft Teams

You can deploy the Teams desktop app using a per-machine or per-user installation. To install Microsoft Teams in your Azure Virtual Desktop environment:

1.  Download the [Teams MSI package](/microsoftteams/teams-for-vdi) that matches your environment. We recommend using the 64-bit installer on a 64-bit operating system.
2.  Run one of the following commands to install the MSI to the host VM:

**Per-user installation**

```
msiexec /i <path_to_msi> /l*v <install_logfile_name>

```

This process is the default installation, which installs Teams to the **%AppData%** user folder. Teams won't work properly with per-user installation on a non-persistent setup.

**Per-machine installation**

```
msiexec /i <path_to_msi> /l*v <install_logfile_name> ALLUSER=1

```

This installs Teams to the Program Files (x86) folder on a 32-bit operating system and to the Program Files folder on a 64-bit operating system. At this point, the golden image setup is complete. Installing Teams per-machines is required for non-persistent setups.

**To uninstall the MSI from the host VM, run this command:**

```
msiexec /passive /x <msi_name> /l*v <uninstall_logfile_name>

```

3.  This uninstalls Teams from the Program Files (x86) folder or Program Files folder, depending on the operating system environment.

### Verify media optimizations loaded.

After installing the WebSocket Service and the Teams desktop app, follow these steps to verify that Teams media optimizations loaded:

1.  Quit and restart the Teams application.
2.  Select your user profile image, then select **About**.
3.  Select **Version**.

If media optimizations loaded, the banner will show you **Azure Virtual Desktop Media optimized**.

4.  Select your user profile image, then select **Settings**.
