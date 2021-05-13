

After the team has deployed Windows Server computers throughout Contoso, they want to be able to easily maintain them. Part of this maintenance includes the management of server features. A possible solution is features on demand.

## What is features on demand?

In the past, if you tried to install an application that had dependencies on certain binaries and packages from the Desktop Experience that were not present in Server Core, the install would fail. Microsoft is improving the Server Core experience by releasing the Server Core App Compatibility feature-on-demand (FOD), making it possible to install these applications.

> [!NOTE]
> The FOD does not come pre-installed. You must download and install it.

You can obtain FOD through Windows Update if your server connects directly to the internet or you can download the ISO image file from the Microsoft Volume License Service Center.

Some operating system components that become available locally on Server Core after installing the FOD include:

- Event Viewer
- Performance Monitor
- Resource Monitor
- Device Manager
- Microsoft Management Console
- File Explorer
- Windows PowerShell ISE
- Failover Cluster Manager
- Hyper-V Manager
- Task Scheduler

## Installing features on demand

There are two ways to install the FOD. The simplest way to install the FOD is through Windows Update by using PowerShell. Launch an elevated PowerShell session and run the following command:

```powershell
Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0
```

Then restart the server. If connecting to Windows Update is not an option, then use the following method:

1. Download the FOD ISO image file from the Microsoft Volume License Service Center.
1. Save the ISO that you downloaded to a network share.
1. Connect the Server Core to the network location and copy the ISO to a local folder.
1. Mount the ISO from an elevated PowerShell session by using the following command:

    ```powershell
    Mount-DiskImage -ImagePath drive_letter:\folder_where_ISO_is_saved\ISO_filename.iso
    ```

5. Run the following command:

    ```powershell
    Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Source <Mounted_Server_FOD_Drive> -LimitAccess
    ```

6. Restart the server
