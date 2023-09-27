

Microsoft Intune includes settings and features that you can enable or disable on different devices within your organization. These settings and features are managed using profiles. Some profile examples include:

 -  A Wi-Fi profile that gives different devices access to your corporate Wi-Fi.
 -  A VPN profile that gives different devices access to your VPN server within your corporate network.

#### Types of device profiles

The following are examples of some of the profiles available in Intune. The types of profiles available depend on which platform you're creating the configuration profile under:

 -  **Administrative Templates:** The administrative templates include hundreds of settings that control features in Microsoft Edge version 77 and later, Internet Explorer, Microsoft Office programs, remote desktop, OneDrive, passwords and PINs, and more. These settings allow group administrators to manage ADMX-backed group policies using the cloud.
 -  **Certificates:** Certificates configure trusted, Simple Certificate Enrollment Protocol (SCEP), and Public Key Cryptography Standards (PKCS) certificates that can be assigned to devices, and used to authenticate Wi-Fi, VPN, and email profiles.
 -  **Device features - iOS and macOS:** Device features control features on iOS and macOS devices, such as AirPrint, notifications, and shared device configurations.
 -  **Device restrictions:** Device restrictions control security, hardware, data sharing, and more settings on the devices. For example, create a device restriction profile that prevents iOS device users from using the device camera.
 -  **Edition upgrade and mode switch:** Windows edition upgrades automatically upgrade devices that run some versions of Windows to a newer edition.
 -  **Email**. The email settings profile creates, assigns, and monitors Exchange ActiveSync email settings on the devices. Email profiles help ensure consistency, reduce support calls, and let end-users access company email on their personal devices, without any required setup on their part.
 -  **Endpoint protection:** Endpoint protection settings for Windows configure BitLocker and Microsoft Defender settings for Windows devices.
 -  **Identity protection:** Identity protection controls the Windows Hello for Business experience on Windows 10 and Windows 10 Mobile devices. Configure these settings to make Windows Hello for Business available to users and devices, and to specify requirements for device PINs and gestures.
 -  **Kiosk:** The kiosk settings profile configures a device to run one app or run multiple apps. You can also customize other features on your kiosk, including a start menu and a web browser.
 -  **VPN:** VPN settings assign VPN profiles to users and devices in your organization, so they can easily and securely connect to the network. Virtual private networks (VPNs) give users secure remote access to your company network. Devices use a VPN connection profile to start a connection with your VPN server.
 -  **Wi-Fi:** Wi-Fi settings assign wireless network settings to users and devices. When you assign a Wi-Fi profile, users get access to your corporate Wi-Fi without having to configure it themselves.
 -  **Custom profile:** Custom settings include the ability to assign device settings that aren't built-into Intune. Custom profiles will be explained in detail in a later unit.