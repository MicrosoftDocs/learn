Each device type (iOS/iPadOS, Windows, Android, macOS) provides a different set of enrollment methods. These methods range from users adding their own device to using a special user account that's used to enroll and manage multiple corporate-owned devices. When a user adds their own device to Intune, it's called bring your own device (BYOD). When you use a special user account to enroll and manage multiple corporate-owned devices, you use the Device enrollment manager (DEM).

## iOS/iPadOS and macOS primary enrollment methods

The following list provides the primary enrollment methods:

- **BYOD**: *(iOS/iPadOS and macOS)* The Bring Your Own Device method allows your end users to enroll their device using Intune. An Apple MDM Push certificate is required for Intune to manage iOS/iPadOS and macOS devices.
- **DEM**: *(iOS/iPadOS and macOS)* Device enrollment manager (DEM) is a special user account that's used to enroll and manage multiple corporate-owned devices. Managers can install the Company Portal and enroll many user-less devices. These types of devices are good for point-of-sale or utility apps, for example, but not for users who need to access email or company resources.

Additionally, you can choose to use Apple Automated Device Enrollment (ADE) or use Apple Configurator through USB.

## Windows enrollment methods

The following list provides the primary enrollment methods:

- **BYOD**: The Bring Your Own Device method allows your end users to enroll their device using Intune. Bring your own devices (BYOD) include personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. This program lets users access company resources like email.
- **Autopilot**: Windows Autopilot simplifies enrolling devices in Intune. You provide the enrollment details up front before the end user receives a new computer. The Windows Autopilot process runs immediately after powering on a new computer for the first time, enabling employees to configure new devices to be business-ready with just a few clicks.
- **Bulk enroll**: To bulk enroll devices for your Azure AD tenant, you create a provisioning package with the Windows Configuration Designer (WCD) app. Applying the provisioning package to corporate-owned devices joins the devices to your Azure AD tenant and enrolls them for Intune management. Once the package is applied, it's ready for your Azure AD users to sign in.

Additionally, you can choose to use Device enrollment manager (DEM), Automatic enrollment, co-management, or Group Policy (GPO).

## Android enrollment methods

Android Enterprise enrollment includes two specific modes. The first mode is for corporate-owned devices associated with a single user. Such devices are exclusively for work and not personal use. The second mode is for a work profile where the device is personally owned, where IT wants a clear boundary between work and personal data. Policies controlled by IT make sure that work data can't be transferred into the personal profile.

The following list provides the primary **personal** enrollment methods:

- **BYOD** or **Corporate Owned**: End users enroll their personal or corporate-owned Android device by using the Company Portal app to get secure access to company email, apps, and data.
- **Android Enterprise Work Profile**: During enrollment, you set up Android Enterprise work profile management. Then, you tell your users how to enroll their devices using the Company Portal app. Android Enterprise work profile separates the personal data on an end user's device from their work files and data. Your organization manages the work profile, but cannot manage the personal data on the end user's device.

The following list provides the primary **corporate** enrollment methods:

- **DEM**: Enroll devices in Intune by using a device enrollment manager (DEM) account and the Company Portal. DEM includes an Intune permission that can be applied to an Azure AD user account and lets the user enroll up to 1,000 devices. A DEM account is useful for scenarios where devices are enrolled and prepared before handing them out to users. By design, there's a limit of 150 Device Enrollment Manager (DEM) accounts in Microsoft Intune.

Additionally, you can choose to enroll corporate owned devices in Intune based on an international mobile equipment identifier (IMEI) number or serial number (SN), as well as a number of other enrollment methods.

## Enrollment options

Intune admins can configure device enrollment to help users and enable Intune capabilities. Intune includes the following enrollment options:

- **Terms and conditions**: Optionally require that users accept your company's terms and conditions before they can enroll their devices and access resources like company apps and email.
- **Enrollment restrictions**: Restrict device enrollment by device platform or number of devices per user; you can also block personal devices.
- **Enable Apple device enrollment**: An MDM push certificate is required for iOS/iPadOS and macOS device enrollment.
- **Corporate identifiers**: List international mobile equipment identifier (IMEI) numbers and serial numbers to identify corporate-owned devices.
- **Multi-factor authentication**: Require users to use an additional verification method such as a phone, PIN, or biometric data when they enroll a device.
- **Device enrollment manager**: Make users device enrollment managers (DEM). DEM users can enroll large numbers of mobile devices with a single user account.
- **Device categories**: Use device categories to automatically add devices to groups based on categories that you define. Organizing devices into groups makes it easier for you to manage those devices.
