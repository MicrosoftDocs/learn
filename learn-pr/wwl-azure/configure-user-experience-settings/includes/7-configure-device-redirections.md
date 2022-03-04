Configuring device redirections for your Azure Virtual Desktop environment allows you to use printers, USB devices, microphones, and other peripheral devices in a remote session.

Some device redirections require changes to both Remote Desktop Protocol (RDP) properties and Group Policy settings.

Each client supports different device redirections.

## Setup device redirections

You can use the following RDP properties and Group Policy settings to configure device redirections.

### Audio input (microphone) redirection

Set the following RDP property to configure audio input redirection:

 -  `audiocapturemode:i:1` enables audio input redirection.
 -  `audiocapturemode:i:0`disables audio input redirection.

### Audio output (speaker) redirection

Set the following RDP property to configure audio output redirection:

 -  `audiomode:i:0`enables audio output redirection.
 -  `audiomode:i:1` or `audiomode:i:2` disable audio output redirection.

### Camera redirection

Set the following RDP property to configure camera redirection:

 -  `camerastoredirect:s:*` redirects all cameras.
 -  `camerastoredirect:s:` disables camera redirection.

> [!NOTE]
> Even if the `camerastoredirect:s:` property is disabled, local cameras may be redirected through the `devicestoredirect:s:` property. To fully disable camera redirection set `camerastoredirect:s:` and either set `devicestoredirect:s:` or define some subset of plug and play devices that does not include a camera.

You can also redirect specific cameras using a semicolon-delimited list of KSCATEGORY\_VIDEO\_CAMERA interfaces, such as `camerastoredirect:s:\?\usb#vid_0bda&pid_58b0&mi`.

### Clipboard redirection

Set the following RDP property to configure clipboard redirection:

 -  `redirectclipboard:i:1` enables clipboard redirection.
 -  `redirectclipboard:i:0` disables clipboard redirection.

### COM port redirections

Set the following RDP property to configure COM port redirection:

 -  `redirectcomports:i:1` enables COM port redirection.
 -  `redirectcomports:i:0` disables COM port redirection.

### USB redirection

First, set the following RDP property to enable USB device redirection:

 -  `usbdevicestoredirect:s:*` enables USB device redirection.
 -  `usbdevicestoredirect:s:` disables USB device redirection.

Second, set the following Group Policy on the user's local device:

 -  Navigate to **Computer Configuration &gt; Policies&gt; Administrative Templates &gt; Windows Components &gt; Remote Desktop Services &gt; Remote Desktop Connection Client &gt; RemoteFX USB Device Redirection**.
 -  Select **Allows RDP redirection of other supported RemoteFX USB devices from this computer**.
 -  Select the **Enabled** option, and then select the **Administrators and Users in RemoteFX USB Redirection Access Rights** box.
 -  Select **OK**.

### Plug and play device redirection

Set the following RDP property to configure plug and play device redirection:

 -  `devicestoredirect:s:*` enables redirection of all plug and play devices.
 -  `devicestoredirect:s:` disables redirection of plug and play devices.

You can also select specific plug and play devices using a semicolon-delimited list, such as `devicestoredirect:s:root\*PNP0F08`.

### Local drive redirection

Set the following RDP property to configure local drive redirection:

 -  `drivestoredirect:s:*` enables redirection of all disk drives.
 -  `Drivestoredirect:s:` disables local drive redirection.

You can also select specific drives using a semicolon-delimited list, such as `drivestoredirect:s:C:;E:;`.

### Printer redirection

Set the following RDP property to configure printer redirection:

 -  `redirectprinters:i:1` enables printer redirection.
 -  `redirectprinters:i:0` disables printer redirection.
