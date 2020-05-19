Microsoft Endpoint Manager allows you to manage and secure your organization's cloud and on-premises devices, apps, and data. Additionally, you can use Endpoint Manager to protect data, manage assignments, ensure proper access, implement security rules, and resolve compliance issues. Let's explore each of these concepts.

## Manage and secure devices

Before you can safeguard the devices that access your organization's resources, you must enroll them. Enrolling means that the device is connected and recognized by Intune or Configuration Manager baseed on a Mobile Device Management (MDM) certificate. There are several methods to enroll your workforce's devices. Each method depends on **device ownership** (personal or corporate), **device type** (iOS/iPadOS, Windows, Android, macOS), and **device management requirements** (resets, affinity, locking). These methods are explained below.

> [!NOTE]
> Before a device is enrolled with Intune or Configuration Manager, you may need to provision the device. Provisioning is a process when your organization issues new or repurposed devices to individuals in your organization. As part of the process, the indivdual user signs in to the device and steps through the process of connecting to your organization. You can either enroll the devices with Intune or Configuration Manager during the provisioning process or after depending on your needs.

### Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs owned by the organization and distributed to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). iOS/iPadOS devices can be enrolled directly through Apple's Automated Device Enrollment (ADE) tools. Devices with an international mobile equipment identifier (IMEI) number can also be identified and tagged as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. The Company Portal is where users can do common tasks. Common task may include enrolling devices, installing apps, and locating your organization's information, such assistance details from your IT department. 

### Device type

The available device types that can be managed by Endpoint Manager include iOS/iPadOS, Windows, Android, and macOS. These device types are also know as platforms. Because each device type is different, each offers sightly different enrollment methods, devices settings, protection policy settings, configuration policy settings, custom policy settings, and remote actions.

### Device management requirements

As part of the enrollment process, your organization may require specific initial actions before a devices can connect to your organization. You can choose reset required, user affinity, and locked. **Reset required** will wipe the devices during enrollment. **User affinity** will associate each device with a user. **Locked** will provent users from unenrolling their device. Based on these requirements and the device type, you can choose which enrollment methods are best for your organization. 

### Enrollment options

Each device type (iOS/iPadOS, Windows, Android, macOS) provides a different set of enrollment methods. These methods range from users adding their own device to Intune or Configuration Manager, which is called bring your own device (BYOD), to using the Device enrollment manager (DEM), a special user account that's used to enroll and manage multiple corporate-owned devices. 


The following links provide specific enrollment details about each device type and method:
- [iOS/iPadOS enrollment methods](https://docs.microsoft.com/mem/intune/enrollment/device-enrollment#iosipados-enrollment-methods)
- [macOS enrollment methods](https://docs.microsoft.com/mem/intune/enrollment/device-enrollment#macos-enrollment-methods)
- [Windows enrollment methods](https://docs.microsoft.com/mem/intune/enrollment/device-enrollment#windows-enrollment-methods)
- [Android enrollment methods](https://docs.microsoft.com/mem/intune/enrollment/device-enrollment#android-enrollment-methods)


Microsoft Intune lets you manage a range of devices by enrolling them into the service. You can enroll some device types yourself, or users can enroll using the company portal app. Enrolling lets them browse and install apps, make sure that their devices are compliant with company policies, and contact their IT support.

This article gives a full list of the capabilities that you get after devices are enrolled.

Management, inventory, app deployment, provisioning, and retirement are all handled through Intune in the Azure portal.

Users gain access to the company portal, which enables them to install apps, enroll and remove devices, and contact their IT department or helpdesk.


Intune admins can configure device enrollment to help users and enable Intune capabilities. Intune includes the following enrollment options:
- Terms and conditions - Optionally require that users accept your company's terms and conditions before they can enroll their devices and access resources like company apps and email. 
- Enrollment restrictions - Restrict device enrollment by device platform, number of devices per user, or block personal devices.
- Enable Apple device enrollment - An MDM push certificate is required for iOS/iPadOS and macOS device enrollment.
- Corporate identifiers - List international mobile equipment identifier (IMEI) numbers and serial numbers to identify corporate-owned devices.
- Multi-factor authentication - Require users to use an additional verification method, such as a phone, PIN, or biometric data, when they enroll a device. 
- Device enrollment manager - Make users device enrollment managers (DEM). DEM users can enroll large numbers of mobile devices with a single user account. 
- Device categories - Use device categories to automatically add devices to groups based on categories that you define. Organizing devices into groups makes it easier for you to manage those devices. 

## Manage and secure apps and email

Safeguard the devices and apps that access your organization resources.

## Ensure proper access
Ensure your organization is using proper credentials to access and share company data.

## Protect your organization’s data

Protect the data that the people at your organization are accessing.


## Manage assignments based on groups

Manage assignments of devices, apps, and policies.

## Implement security rules

Confirm security rules are in place based on your organizations requirements.

## Analyze and resolve compliance issues


 
