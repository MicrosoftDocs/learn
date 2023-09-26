

The preferred method for managing your Windows device, which has built-in mobile device management features in the operating system, is to enroll it as a mobile device with Intune.

You must use device enrollment for devices running any operating system other than Windows, such as those on phones or Macs.

There are several different ways to enroll Windows devices to MDM, based on device type and its current state, including:

 -  If a device is already joined to your on-premises AD DS, you can use Group Policy to automatically enroll it to MDM.
 -  You can configure integration between Azure AD and MDM so that when you join a Windows device to Azure AD, it’s automatically enrolled to MDM.
 -  You can enroll Windows devices to MDM manually, by using a Settings app, provisioning packages, or the Company Portal app.

Automatic enrollment to MDM works for Windows devices, because only Windows devices can be joined to an on-premises AD DS and Azure AD. Other devices, such as Android and iOS devices, can only be enrolled manually to MDM by using the Company Portal app. The Company Portal app isn't included on Android and iOS devices by default; it's available as a free app in Google Play store and the Apple app store. If you want to enroll iOS devices, you must ensure that MDM is configured with a valid Apple Push Notification (APN) certificate. iPhones, iPad, and macOS devices require an APN certificate for secure communication with MDM, regardless if MDM is Intune, MDM for Microsoft 365, or a third-party MDM product.

For more details, refer to [Enable Windows device automatic enrollment](https://aka.ms/Ff5rl5).

#### Supported Devices

Intune supports various mobile devices and computers. Users can install the Company Portal app to help them enroll and remove devices, install published apps, and help them contact their IT support.

Intune supports devices running the following operating systems through device enrollment, which was discussed in the previous unit:

 -  Windows 10/11 (Home, Pro, Education, S mode, and Enterprise versions)
 -  Windows 10/11 Cloud PCs on Windows 365
 -  Windows 10 IoT and Windows 10 Holographic
 -  Windows 10 2019 LTSC
 -  Surface Hub
 -  Windows 10 Teams (Surface Hub)
 -  Apple iOS/iPadOS 14.0 and later
 -  macOS 11.0 and later
 -  Android 8.0 and later, including Samsung KNOX Standard 3.0 and higher
 -  Linux Ubuntu Desktop (20.04 or 22.04 LTS on x86/64)
 -  Chrome OS

> [!NOTE]
> Intune offered a software client for legacy operating systems. This is not needed on current supported operating systems.

#### Define Allowed Devices

By default, all users who are assigned an Intune license are allowed to enroll their supported device types to Intune. However, you can configure enrollment restrictions that users must meet before they can enroll a device. Enrollment restrictions can include the following criteria:

 -  Maximum number of devices that a user can enroll. By default, this is set to five devices per user.
 -  Device platforms that can be enrolled:
 -  Required operating system version for iOS, Android, Android work profile, and Windows devices
    
     -  Minimum version
     -  Maximum version
 -  Restrict enrollment of personally owned devices. You can configure this restriction for iOS, Android, Android work profile, macOS, and personally owned devices for Windows 10/11.

:::image type="content" source="../media/configure-platform-326ebf7a.png" alt-text="Screenshot of the Configure platforms screen.":::


You can manage device enrollment by configuring the following enrollment options:

 -  **Terms and conditions**. You can require that users accept the company's terms and conditions before they can use the Company Portal to enroll their devices and access resources such as company apps and email.
 -  **Enrollment restrictions**. You can configure device types that can be enrolled, block enrollment of personal devices, and restrict the number of devices that each user can enroll.
 -  **Enable Apple device enrollment**. You can control whether Apple devices can be enrolled; they can be enrolled only if you added an APN certificate to MDM.
 -  **Corporate identifiers**. You can list international mobile equipment identifier (IMEI) numbers and serial numbers to identify company-owned devices. Intune can perform additional management tasks and collect additional information such as the full phone number and an inventory of apps from company-owned devices. You can also prevent enrollment of devices that aren't company-owned.
 -  **Multifactor authentication**. When users enroll a device, you can require an additional verification method, such as a phone, PIN, or biometric data.
 -  **Device enrollment manager**. Device enrollment manager (DEM) can enroll large numbers of devices. A restriction on the number of devices that a user can enroll doesn't apply to DEM; DEM can enroll up to 1,000 devices.

#### Ensure Users Enroll Their Devices

To ensure that users enroll their devices, you can configure a Security policy in Microsoft 365 or a Conditional access policy in Intune to allow access to company resources only from enrolled devices. If such policy is in place and a user tries to access company resources, such as his or her Exchange Online mailbox, the user will be denied access and redirected to enroll his or her device first. After the user enrolls the device, he or she'll be able to access the mailbox.

Users can use their devices for personal work and leisure as soon as they obtain the device. But organizations don’t have control over such devices, and they can't manage them until the devices are enrolled to an MDM solution, such as Intune or MDM for Microsoft 365. However, because device enrollment is usually a manual process and users often forget to perform it, most organizations have resorted to making enrollment mandatory.

They only allow users to access company resources from enrolled devices that comply with organizational policy. They use compliance policies to define how devices should be configured and conditional access policies for controlling access to organizational resources. If a user tries to access resources from a non-enrolled device, he or she's denied access and asked to enroll the device first.

You can configure automatic enrollment to MDM for Windows devices only. If a Windows device is already joined to on-premises AD DS which is synced to Azure AD, you can configure the **Enable automatic MDM enrollment using default Azure AD credentials** Group Policy setting to enroll devices to MDM.
