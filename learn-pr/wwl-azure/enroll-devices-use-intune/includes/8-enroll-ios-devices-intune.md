
You can let users enroll their personal devices for Intune management (BYOD). Once you've completed the prerequisites and assigned users licenses, they can download the Intune Company Portal app from the App Store, and follow enrollment instructions in the app.

Enroll your iOS device using Company Portal

1.  Download and install the Intune Company Portal from Apple app store.
2.  Open the Company Portal app.
3.  On the Company Portal Welcome screen, tap **Sign in**, and then sign in with your work or school account.
4.  Follow the instructions given in the Company Portal. The end-user experience can vary based on the policies assigned to the user and/or device.

#### Company-owned iOS devices

For organizations that buy devices for their users, Intune supports the following iOS company-owned device enrollment methods:

 -  Apple's Device Enrollment Program (DEP)
 -  Apple School Manager
 -  Apple Configurator Setup Assistant enrollment
 -  Apple Configurator direct enrollment
 -  You can also enroll company-owned iOS devices with a device enrollment manager account.
 -  **Device Enrollment Program**. Organizations can purchase iOS devices through Apple's Device Enrollment Program (DEP). DEP lets you deploy an enrollment profile “over the air” to bring devices into management.

The Apple Device Enrollment Program (DEP) is an online service that automates the enrollment and configuration of Apple iOS devices to MDM. Apple DEP is only available for devices that an organization purchases through either Apple or authorized resellers to provide to employees.

To enable DEP enrollment, you use both the Intune and Apple DEP portals. A list of serial numbers or a purchase order number is required so you can assign devices to Intune for management. On the Apple DEP website, an administrator can preconfigure device settings, including what applications and company services each device can access, and set devices to automatically enroll to MDM. iOS devices enrolled in DEP don't require manual configuration, and users never have to select on MDM links or install the Company Portal app to enroll the device.

If an organization allows its users to bring their own devices, the users should perform the regular iOS enrollment. But if the company provides employees with iOS devices that are part of the Device Enrollment Program, users can enroll those devices to MDM by performing following steps:

1.  Turn on your iOS device.
2.  After you select your **Language**, connect your device to Wi-Fi.
3.  On the **Set up iOS device** screen, choose whether you want to:
    
     -  Set up as new device
     -  Restore from iCloud backup
     -  Restore from iTunes backup
4.  Once you’ve connected to Wi-Fi, the **Configuration** screen will appear. This will say:
    
     -  \[Your Company\] will automatically configure your device.
     -  Configuration allows \[Your Company\] to manage this device over the air. An administrator can help you set up email and network accounts, install and configure apps, and manage settings remotely. An administrator may disable features, install and remove apps, monitor and restrict your Internet traffic and remotely erase this device.
     -  Configuration is provided by: \[Your Company's\] iOS Team \[Address\]
5.  **Log in with your Apple ID**. Logging in lets you install the Company Portal app and install the management profile that will let your company give you access to its resources, such as email and apps.
6.  Agree to the **Terms and Conditions** and decide whether you want to send diagnostic information to Apple.
7.  Once you complete your enrollment, your device may prompt you to take more actions. Some of these steps might be entering your password for email access or setting up a passcode.

You can enable DEP enrollment for large numbers of devices without ever touching them. You can ship devices like iPhones and iPads directly to users. When the user turns on the device, Setup Assistant runs with preconfigured settings and the device enrolls into management.

For more information, refer to [Automatically enroll iOS devices with Apple's Device Enrollment Program](https://aka.ms/AA6c2mq).

#### Supervised mode

An iOS device in supervised mode can be managed with more controls. As such, it’s especially useful for corporate-owned devices. Intune supports configuring devices for supervised mode as part the DEP. We recommend that you use supervised mode even though it requires more configuration compared to other iOS enrollment methods. It gives you access to many policy settings in Intune that are otherwise unavailable.

Note that with iOS11 and later, supervised mode should always be enabled, as support for unsupervised mode in IOS11 was deprecated.
