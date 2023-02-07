
Your users can install the client directly after downloading it. If you're deploying to multiple devices, you may want to also deploy the client to them through other means. Deploying using group policies or the Microsoft Endpoint Configuration Manager lets you run the installer silently using a command line. Run the following commands to deploy the client per-device or per-user.

### Per-device installation

```
msiexec.exe /I <path to the MSI> /qn ALLUSERS=1

```

### Per-user installation

```
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=2 MSIINSTALLPERUSER=1

```

## Configuration options

The section below describes the new configuration options for this client.

### Configure update notifications

The client notifies you whenever there's an update and automatically updates itself when the client is closed and has no active connections. Even with no active connections, the msrdc.exe process runs in the background to allow you to reconnect quickly when you reopen the client. You can stop **msrdc.exe** by right-clicking on the Azure Virtual Desktop icon in the system tray area and selecting **Disconnect all sessions** in the drop-down menu.

To turn off notifications, set the following registry information:

 -  **Key**: `HKLM\Software\Microsoft\MSRDC\Policies`
 -  **Type**: `REG_DWORD`
 -  **Name**: `AutomaticUpdates`
 -  **Data**: `0` = Disable notifications and turn off auto-update. `1` = Show notifications and turn off auto-update. `2` = Show notifications and auto-update on close.

### Configure user groups

You can configure the client for one of the following types of user groups, which determines when the client receives updates.

### Insider group

The Insider group is for early validation, and consists of admins and their selected users. The Insider group serves as a test run to detect any issues in the update that can impact performance before it's released to the Public group.

It’s a good idea for each organization to have some users in the Insider group to test updates and catch issues early.

In the Insider group, a new version of the client is released to the users on the second Tuesday of each month for early validation. If the update doesn't have issues, it gets released to the Public group two weeks later. Users in the Insider group will receive update notifications automatically whenever updates are ready.

To configure the client for the Insider group, set the following registry information:

 -  **Key**: `HKLM\Software\Microsoft\MSRDC\Policies`
 -  **Type**: `REG_SZ`
 -  **Name**: `ReleaseRing`
 -  **Data**: `insider`

### Public group

This group is for all users and is the most stable version. You don't need to do anything to configure this group.

The Public group receives the version of the client that was tested by the Insider group every fourth Tuesday of each month. All users in the Public group will receive an update notification if that setting is enabled.
