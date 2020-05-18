Microsoft Endpoint Manager allows you to manage and secure your organization's cloud and on-premises devices, apps, and data. Additionally, you can use Endpoint Manager to protect data, manage assignments, ensure proper access, implement security rules, and resolve compliance issues.

## Manage and secure devices

Before you can safeguard the devices that access your organization resources, you must enroll them. There are several methods to enroll your workforce's devices. Each method depends on the device's ownership (personal or corporate), device type (iOS/iPadOS, Windows, Android, macOS), and management requirements (resets, affinity, locking).

### Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs owned by the organization and distributed to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). iOS/iPadOS devices can be enrolled directly through the ADE tools that are provided by Apple. Devices with an IMEI number can also be identified and tagged as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. This program lets users access company resources like email. 

### Device type

The available device types that can be managed by Endpoint Manager include iOS/iPadOS, Windows, Android, and macOS. Each device type offers different enrollment methods, devices settings, protection policies, configuration policies, custom policies, and remote actions.


### Management requirements



### Enrollment options

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



### Certificates

When a device is enrolled, it's issued an MDM certificate. This certificate is used to communicate with the Intune service.

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


 
