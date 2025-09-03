Next, we’ll go over steps to set up Intune as your mobile device management (MDM) solution. Keep in mind that while some steps are essential, others may be optional based on your specific needs.

Check out the [supported configurations](/mem/intune/fundamentals/supported-devices-browsers) and networking requirements for Intune before beginning the setup process.

![A photograph of a woman working on a laptop at a desk.](../media/cloud-solutions.png)

## 1. Sign in to the Intune admin center

Sign in to the Intune admin center to sign up for Intune. If you already have a subscription, use your existing credentials to sign-in.

For more details, check out [Sign up or sign in to Intune](https://docs.microsoft.com/mem/intune/fundamentals/account-sign-up)

## 2. Connect the company domain name

Set DNS registration to connect your company's domain name with Intune. This gives users a familiar domain when connecting to Intune and using resources.

For more information, visit [configure a custom domain name](https://docs.microsoft.com/mem/intune/fundamentals/custom-domain-name-configure)

## 3. Add users and device-based groups

Add [users](https://docs.microsoft.com/mem/intune/fundamentals/users-add) and [device-based groups](https://docs.microsoft.com/mem/intune/fundamentals/groups-add) or connect your existing Active Directory to sync with Microsoft Entra ID. Adding users is required unless the devices are ”user-less,” like shared or kiosk devices. In that case, device-based groups are used to assign apps, settings, and other resources because group tasks are run based on device identity, not user identity.

## 4. Grant permission to use Intune

Grant admins permission to access Intune. While you don’t need an Intune license to perform tasks in the Intune admin console, you still require the appropriate permissions. Once permissions are set, devices can be enrolled in Intune.

For more information, check out [assign licenses](/mem/intune/fundamentals/licenses-assign)

## 5. Add apps to Intune

Before you can configure, assign, protect, or monitor apps, you must [add them to Intune](/mem/intune/apps/apps-add). Apps can be assigned to groups and installed automatically or optionally. Your end users might have several app requirements—[assess and understand these requirements](/mem/intune/apps/apps-add#assess-app-requirements) before adding apps to Intune.

## 6. Set up profiles to manage settings

[Create configuration profiles to manage device settings](/mem/intune/configuration/device-profiles). These profiles allow you to preconfigure settings for email, VPN, Wi-Fi, and device features. Additionally, they can impose restrictions to enhance security for devices and the data they access. For example, you can manage device behavior by blocking features like Bluetooth® or controlling where data is stored on the device.

## 7. Customizing the user experience

[Customize the Intune Company Portal](/mem/intune/apps/company-portal-app) that allows users to securely access Intune resources and services, including optional apps available for installation and device compliance information. By tailoring the end-user experience, you can provide a familiar and intuitive interface for your users.

These settings appear in both:

- The Company Portal app

- The Intune Company Portal website

## How to enroll devices

Enrollment sets up and secures devices so they align with organizational policies. Companies must enroll devices in Intune using a supported enrollment method, which varies by OS. When selecting a method, choose one that works with the devices and features you want to support. You can [compare enrollment methods](/mem/intune/fundamentals/deployment-guide-enrollment#compare-enrollment-options) for each OS using the data tables in Microsoft Docs.

### Supported operating systems

Intune supports these device operating systems:

- [Android™](/mem/intune/fundamentals/deployment-guide-enrollment-android)

- [macOS®](/mem/intune/enrollment/macos-enroll)

- [iOS®](/mem/intune/fundamentals/deployment-guide-enrollment-ios-ipados)

- [Windows](/mem/intune/fundamentals/deployment-guide-enroll?tabs=work-profile%2Ccorporate-owned-apple%2Cautomatic-enrollment)

Some enrollment methods require an IT administrator to initiate enrollment while other methods require employees to initiate it.

You can adjust the settings in Intune to restrict specific platforms from enrolling. For more information, visit [Create a device platform restriction](/mem/intune/enrollment/enrollment-restrictions-set#create-a-device-platform-restriction)