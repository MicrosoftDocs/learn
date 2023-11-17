This unit covers how to prepare and modify basic configuration options for apps and your image's registry.

### Disable Automatic Updates

To disable Automatic Updates via local Group Policy:

1.  Open **Local Group Policy Editor\\Administrative Templates\\Windows Components\\Windows Update**.
2.  Right-click **Configure Automatic Update** and set it to **Disabled**.

You can also run the following command on a command prompt to disable Automatic Updates.

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

```

### Specify Start layout for Windows 10 computers

Run this command to specify a Start layout for Windows 10 computers.

```
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SpecialRoamingOverrideAllowed /t REG_DWORD /d 1 /f

```

### Set up time zone redirection

Time zone redirection can be enforced on Group Policy level since all VMs in a host pool are part of the same security group.

To redirect time zones:

1.  On the Active Directory server, open the **Group Policy Management Console**.
2.  Expand your domain and Group Policy Objects.
3.  Right-click the **Group Policy Object** that you created for the group policy settings and select **Edit**.
4.  In the **Group Policy Management Editor**, navigate to **Computer Configuration &gt; Policies &gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Session Host &gt; Device and Resource Redirection**.
5.  Enable the **Allow time zone redirection** setting.

You can also run this command on the master image to redirect time zones:

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableTimeZoneRedirection /t REG_DWORD /d 1 /f

```

### Disable Storage Sense

For Azure Virtual Desktop session host that use Windows 10 Enterprise or Windows 10 Enterprise multi-session, we recommend disabling Storage Sense. You can disable Storage Sense in the Settings menu under **Storage** as displayed below.

:::image type="content" source="../media/modify-session-storage-sense-d9bc9cc8.png" alt-text="A screenshot of the Storage menu under Settings. The Storage sense option is turned off.":::


You can also change the setting with the registry by running the following command:

```
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f

```
