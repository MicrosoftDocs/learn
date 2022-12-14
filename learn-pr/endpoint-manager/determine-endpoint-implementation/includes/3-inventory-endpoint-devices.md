Organizations have a range of devices, including desktop computers, laptops, tablets, and mobile phones. These devices can be owned by the organization or owned by your users. When planning your device-management solution, be sure to consider every device that will access your organization's resources, including users' personal devices.

Your organization's endpoints will likely be focused to one or more of the following categories:

- Supported platforms
- Personal devices versus organization-owned devices
- Managed desktop computers

## Supported platforms

Microsoft Endpoint Manager supports several device platforms. Endpoint Manager can manage devices on the iOS/iPadOS, Windows, Android, and macOS platforms. These platforms are often referred to as device types. Because each platform is different, each offers sightly different enrollment methods, device settings, protection-policy settings, configuration-policy settings, custom policy settings, and remote actions.

### Intune supported operating systems

You can manage devices running operating systems for iOS/iPadOS, macOS, Android, Android Enterprise, Surface Hub, as well as a variety of Windows operating systems.

For more information about Intune supported devices, platforms, and operating systems, reference [Supported operating systems and browsers in Intune](/mem/intune/fundamentals/supported-devices-browsers?azure-portal=true).

### Configuration Manager supported operating systems

The supported OS versions for clients and devices that Configuration Manager can manage include several dozen operating system. These operating systems focus on Windows computers, Windows Servers, Windows Server Core, Azure Virtual Desktop, Windows Embedded computers, Windows 10/11 IoT Mobile Enterprise, Windows 10/11 Teams for Surface Hub, and Mac computers.

For more information about Configuration Manager supported devices, servers, platforms, and operating systems, check out [Supported OS versions for clients and devices for Configuration Manager](/mem/configmgr/core/plan-design/configs/supported-operating-systems-for-clients-and-devices?azure-portal=true).

If your devices use unsupported OS versions, which are primarily older operating systems, then it's time to upgrade the OS or replace the devices. These older operating systems and devices might have limited support, and are a potential security risk.

## Personal devices vs organization-owned devices

You can allow corporate or personal device ownership. Corporate-owned devices (COD) include phones, tablets, and PCs the organization owns and distributes to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). You can enroll iOS/iPadOS devices directly through Apple's Automated Device Enrollment (ADE) tools. You can also tag and identify devices with an international mobile equipment identifier (IMEI) number as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. The Company Portal is where users can do common tasks. Common tasks may include enrolling devices, installing apps, and locating your organization's information, such as assistance details from your IT department.

On personal devices, it's normal and expected for users to check email, join Teams meetings, update SharePoint files, and more. Many organizations allow personal devices, and many organizations only allow organization-owned devices.

As an organization and as an administrator, you decide if you'll allow personal devices.

## Manage desktop computers

Intune can manage desktop computers running Windows 10 and newer. The Windows 10/11 OS includes built-in modern device management features, and removes dependencies on local Active Directory (AD) group policy. You get the benefits of the cloud when creating rules and settings in Intune and deploying these policies to all your Windows 10/11 devices, including desktop computers and PCs.

If your Windows 10/11 devices are currently managed using Configuration Manager, you can still enroll these devices in Intune. This approach is called *co-management*. Co-management offers many benefits, including running remote actions on the device (restart, remote control, factory reset), Conditional Access with device compliance, and more.

## Additional information

For more information about each of these objectives, reference [Microsoft Intune planning guide - Inventory your devices](/mem/intune/fundamentals/intune-planning-guide?azure-portal=true#task-2-inventory-your-devices).