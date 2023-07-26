After devices have been provisioned and before you can safeguard the devices that access your organization's resources, you must enroll them. In Intune, enrolling means that the device is connected and recognized by Intune based on a mobile device management (MDM) certificate. There are several methods to enroll your workforce's devices. Each method depends on **device ownership** (personal or corporate), **device type** or platform (iOS/iPadOS, Windows, Android, macOS), and **device management requirements** (resets, affinity, locking). Let's take a look at these methods.

[ ![Screenshot of enrolling devices using Microsoft Intune.](../media/intro-to-endpoint-manager-15.png) ](../media/intro-to-endpoint-manager-15.png#lightbox)

> [!NOTE]
> For Configuration Manager, you install the Configuration Manager client on a device, then it registers with the site.

## Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs the organization owns and distributes to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). You can enroll iOS/iPadOS devices directly through Apple's Automated Device Enrollment (ADE) tools. You can also identify and tag devices with an international mobile equipment identifier (IMEI) number as corporate-owned.

Personally owned devices are often called *bring your own devices* (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. Users can do common tasks in the Company Portal. Common task might include enrolling devices, installing apps, and locating your organization's information, such assistance details from your IT department.

## Device type

The available device types that Intune can manage include iOS/iPadOS, Windows, Android, and macOS. These device types are also known as *platforms*. Because each device type is different, each offers slightly different enrollment methods, device settings, protection-policy settings, configuration-policy settings, custom policy settings, and remote actions.

## Device management requirements

As part of the enrollment process, your organization might require specific initial actions before a device can connect to your organization to ensure protection and safe access. You can choose reset required, user affinity, and locked. **Reset required** will wipe the devices during enrollment. **User affinity** will associate each device with a user. **Locked** will prevent users from unenrolling their device. Based on these requirements and the device type, you can choose which enrollment methods are best for your organization.
