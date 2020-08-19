Microsoft Endpoint Manager allows you to manage and secure your organization's cloud and on-premises devices, apps, and data. As part of this management, you can use Endpoint Manager to protect device data, manage assignments, ensure proper device access, implement device security rules, and resolve device compliance issues. All devices that you manage have a lifecycle. Intune can help you manage this lifecycle: from enrollment, through configuration and protection, to retiring the device when it's no longer required. The following sections describe common stages of the device lifecycle.

## Enroll

After a device have been provisioned and before you can safeguard the devices that access your organization's resources, you must enroll them. In Intune, enrolling means that the device is connected and recognized by Intune based on a mobile device management (MDM) certificate. There are several methods to enroll your workforce's devices. Each method depends on **device ownership** (personal or corporate), **device type** or platform (iOS/iPadOS, Windows, Android, macOS), and **device management requirements** (resets, affinity, locking). These methods are explained below.

> [!NOTE]
> For Configuration Manager, you install the Configuration Manager client on a device, and then it registers with the site.

### Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs owned by the organization and distributed to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). iOS/iPadOS devices can be enrolled directly through Apple's Automated Device Enrollment (ADE) tools. Devices with an international mobile equipment identifier (IMEI) number can also be identified and tagged as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. The Company Portal is where users can do common tasks. Common task may include enrolling devices, installing apps, and locating your organization's information, such assistance details from your IT department. 

### Device type

The available device types that can be managed by Endpoint Manager include iOS/iPadOS, Windows, Android, and macOS. These device types are also known as platforms. Because each device type is different, each offers sightly different enrollment methods, devices settings, protection policy settings, configuration policy settings, custom policy settings, and remote actions.

### Device management requirements

As part of the enrollment process, your organization may require specific initial actions before a device can connect to your organization to ensure protection and safe access. You can choose reset required, user affinity, and locked. **Reset required** will wipe the devices during enrollment. **User affinity** will associate each device with a user. **Locked** will prevent users from unenrolling their device. Based on these requirements and the device type, you can choose which enrollment methods are best for your organization.

## Configure

Enrolling your devices is just the first step. When you configure devices in your organization, you can apply settings and features to be enabled or disabled. These settings and features are added to "configuration profiles". You can create profiles for different devices and different platforms, including iOS/iPadOS, Android device administrator, Android Enterprise, and Windows. Then, use Intune to apply or "assign" the profile to the devices.

As part of your mobile device management (MDM) solution, use these configuration profiles to complete different tasks. Some profile examples include:

- On Windows 10 devices, use a profile template that blocks ActiveX controls in Internet Explorer.
- On iOS/iPadOS and macOS devices, allow users to use AirPrint printers in your organization.
- Allow or prevent access to bluetooth on the device.
- Create a WiFi or VPN profile that gives different devices access to your corporate network.
- Manage software updates, including when they're installed.
- Run an Android device as dedicated kiosk device that can run one app, or run many apps.

## Protect

In the modern IT world, protecting devices from unauthorized access is one of the most important tasks that you perform. In addition to the items in the **Configure** step of the device lifecycle, Intune provides these capabilities that help protect devices you manage from unauthorized access or malicious attacks. For example, you can restrict use of hardware features on the device such as the camera, or Bluetooth.

You can require devices to be compliant. Intune features device compliance policies that let you evaluate (and in some cases remediate) devices that aren't compliant with rules that you specify. For example, you can get reports on the following device characteristics before taking action:
- jailbroken iOS/iPadOS devices
- encrypted or not encrypted devices
- the health of Windows 10 devices (as determined by the Health Attestation Service).

You can protect apps and the data they use. Intune gives you a range of features to help you protect apps and their data. For example, mobile application management (MAM) policies can:
- prevent data from being backed up from a protected app
- restrict copy and paste to other apps
- require a PIN to access an app

You can also add an additional layer of protection to devices, such as:
- **Multi-factor authentication** - Adding an extra layer of authentication to user sign-ins can help make devices even more secure. Many devices support multi-factor authentication that requires a second level of authentication, such as a phone call or text message, before users can gain access.
- **Windows Hello for Business settings** - Windows Hello for Business is an alternative sign-in method that lets users use a *gesture*—such as a fingerprint or Windows Hello—to sign in without needing a password.

### Software updates

Intune can help you to secure your managed computers in a number of ways, including the management of software updates that keep your computers up-to-date by ensuring the latest patches and software updates are quickly installed. Software updates in Configuration Manager provides a set of tools and resources that can help manage the complex task of tracking and applying software updates to client computers in the enterprise. An effective software update management process is necessary to maintain operational efficiency, overcome security issues, and maintain the stability of the network infrastructure. However, because of the changing nature of technology and the continual appearance of new security threats, effective software update management requires consistent and continual attention. Both Intune and Configuration Manager can help you effectively update your organization's devices.

## Retire

When a device gets lost or stolen, when it needs to be replaced, or when users move to another position, it's usually time to retire or wipe the device. There are a number of ways you can do this, including resetting the device, removing it from management, and wiping the corporate data on it.