

The Devices feature provides additional details into the devices you manage, including their hardware and the apps installed. To view all your devices, and their properties do the following:

1.  Sign in to the **Microsoft Intune admin center**.
2.  Select **Devices** and then select **All Devices**. Select an individual device to view.

The **Overview** page is displayed by default. It shows the device name, and lists some key properties of the device, including whether it's a bring-your-own-device (BYOD) device, when it checked in, and more. The actions available depend on the device platform, and the configuration of the device.

 -  You can perform the following remote actions on the device:
    
     -  **Retire**. Removes managed app data (where applicable), settings, and email profiles that were assigned by using Intune. The device is removed from Intune management
     -  **Wipe**. Restores a device to its factory default settings. The user data is kept if you choose the **Retain enrollment state and user account** checkbox. Otherwise, all data, apps, and settings will be removed.
     -  **Delete**. Remove devices from the Intune portal. The next time the device checks in, any company data on it will be removed.
     -  **Remote lock (Android, iOS, macOS)**. Locks the device. To unlock the device, the device owner enters their passcode. Devices that don't have a PIN or password can't be remotely locked.
     -  **Sync**. Forces the selected device to immediately check in with Intune and immediately receives any pending actions or policies that have been assigned to it. This feature can help you immediately validate and troubleshoot policies you've assigned, without waiting for the next scheduled check-in.
     -  **Reset passcode (iOs/Android)**. A device level reset of the passcode for the entire device.
     -  **Restart**. Causes the device you choose to be restarted (within 5 minutes). The device owner isn't automatically notified of the restart, and they might lose work. Not supported for macOS or Android work profile devices.
     -  **Fresh Start (Windows 10 and later only)**. Removes any apps that are installed on a PC. Fresh Start helps remove preinstalled (OEM) apps that are typically installed with a new PC.
     -  **AutoPilot Reset (Windows 10 and later only)**. Initiates the reset process, avoiding the need for IT staff or other administrators to visit each machine to initiate the process.
     -  **Quick scan (Windows 10 and later only)**. Performs a Microsoft Defender quick scan. Looks at common locations where there could be malware registered, such as registry keys and known Windows startup folders.
     -  **Full scan (Windows 10 and later only)**. Performs a Microsoft Defender full scan.
     -  **Update Microsoft Defender Security Intelligence**. Instructs the device to check for signature updates.
     -  **BitLocker key rotation**. Remotely rotate the BitLocker recovery key of a device that runs version 1909 or later.
     -  **Rename Device.** The Rename device action lets you rename a device that is enrolled in Intune. The device's name is changed in Intune and on the device.
     -  **New Remote Assistance Session**. Devices managed by Intune can be administered remotely using TeamViewer. TeamViewer is a third-party program that you purchase separately.
     -  **Locate device (Windows 10 and later, iOS, Android Enterprise dedicated).** Identifies the location (or last known location of Android dedicated devices) of a device or initiates a sound alert to assist in finding devices that support this feature.

:::image type="content" source="../media/endpoint-manage-admin-center-device-overview-c304c3a0.png" alt-text="Screenshot of the Devices - Azure AD devices screen.":::


On the device details page, you can also manage and monitor the following:

 -  Use **Properties** to assign a device category you create and change ownership of the device to a personal device, or a corporate device.
 -  **Hardware** includes many details about the device, including the device ID, the operating system and version, storage space, the model and manufacturer, conditional access settings, and more details.
 -  **Discovered apps** lists all the apps that Intune found installed on the device, and the app versions. You can also Export the app list into a .csv file.
 -  **Device compliance** lists all assigned compliance policies, and if the device is compliant or not compliant.
 -  **Device configuration** shows all device configuration policies assigned to the device, and if the policy succeeded or failed.

Intune collects an app list on corporate-owned devices. With personal devices, only organizational managed apps are checked. For Windows clients, modern apps are listed for corporate-owned devices. Intune collect information about Win32 apps if the Intune management extention is installed on the device. Depending on the carrier used by the devices, not all apps may be collected.
