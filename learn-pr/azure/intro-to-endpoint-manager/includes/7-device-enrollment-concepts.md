Microsoft Endpoint Manager allows you to manage and secure your organization's cloud and on-premises devices, apps, and data. As part of this management, you can use Endpoint Manager to protect data, manage assignments, ensure proper access, implement security rules, and resolve compliance issues. Let's explore each of these concepts.

Before you can safeguard the devices that access your organization's resources, you must enroll them. Enrolling means that the device is connected and recognized by Intune or Configuration Manager based on a mobile device management (MDM) certificate. There are several methods to enroll your workforce's devices. Each method depends on **device ownership** (personal or corporate), **device type** (iOS/iPadOS, Windows, Android, macOS), and **device management requirements** (resets, affinity, locking). These methods are explained below.

## Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs owned by the organization and distributed to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). iOS/iPadOS devices can be enrolled directly through Apple's Automated Device Enrollment (ADE) tools. Devices with an international mobile equipment identifier (IMEI) number can also be identified and tagged as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. The Company Portal is where users can do common tasks. Common task may include enrolling devices, installing apps, and locating your organization's information, such assistance details from your IT department. 

## Device type

The available device types that can be managed by Endpoint Manager include iOS/iPadOS, Windows, Android, and macOS. These device types are also known as platforms. Because each device type is different, each offers sightly different enrollment methods, devices settings, protection policy settings, configuration policy settings, custom policy settings, and remote actions.

## Device management requirements

As part of the enrollment process, your organization may require specific initial actions before a device can connect to your organization to ensure protection and safe access. You can choose reset required, user affinity, and locked. **Reset required** will wipe the devices during enrollment. **User affinity** will associate each device with a user. **Locked** will prevent users from unenrolling their device. Based on these requirements and the device type, you can choose which enrollment methods are best for your organization.