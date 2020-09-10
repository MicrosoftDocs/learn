Microsoft Endpoint Manager helps you protect the digital resources that your organization uses. These resources include devices, apps, and data. You protect these resources based on settings related to these resources. You use the Microsoft Endpoint Manager admin center to configure the settings that are then applied based on the devices, apps, and users of your organization. Those settings are contained in policies that you create. You assign the policies to groups that you define. And, those groups are either users or devices.

## Manage and protect devices

Microsoft Intune helps you protect the devices you manage and the data stored on those devices. Protected devices are also known as managed devices. You can create and apply device policies as part of your efforts to protect endpoints. Intune includes settings and features you can enable or disable for different devices within your organization. These settings and features are added to "configuration profiles". You can create profiles for different devices and different platforms, including iOS/iPadOS, macOS, Android, Android Enterprise, and Windows. Then, use Intune to apply or "assign" the profile to the devices.

### Types of device policies
Device policies allow you to perform several different types of actions to protect devices. For instance, device policies allow you to restricts, reset, require, configure, protect, control, and retire many of the aspects of the devices at your organization.

### Examples of device configuration policies
Intune configuration policies help you protect and configure devices by allowing you to control a multitude of settings and features. For example, you can:
- Restrict use of hardware features on the device such as the camera, or Bluetooth.
- Reset passcodes when users are locked out of their devices.
- Require devices to be compliant with the protection requirements implemented by your organization, such as requiring each device to use a PIN to access the device.
- Configure compliant and noncompliant apps. You'll get an alert if a noncompliant app is installed (and some platforms can actually block the install).
- Protect apps and the data they use.
- Protect devices based on identity, by adding an additional layer of protection to devices.
- Control Windows Hello for Business settings, which is an alternative sign-in method for Windows 10 and later.
- Retire devices and remove data.

### Video - Interactive guide to managing devices (optional)
The following interactive guide steps you through the Microsoft Endpoint Manager admin center to show you how to manage and protect devices.

</p>
<div align=”center”>
<iframe allowfullscreen width="95%" height="450" src="https://mslearn.cloudguides.com/guides/Manage%20devices%20with%20Microsoft%20Endpoint%20Manager" frameborder="0" scrolling="no" loading="lazy"/></iframe>
</div>

## Manage and protect apps
Microsoft Intune gives you a range of features to help you manage and protect apps and data. Intune supports mobile application management (MAM) policies without managing the device. 

Intune MAM supports two configurations. The first involves mobile device management (MDM) along with Mobile App Management (MAM). This configuration is where IT administrators can only manage apps using MAM and app protection policies on devices that are *enrolled* with Intune mobile device management (MDM). The second configuration involves MAM without device enrollment. MAM without device enrollment, or MAM-WE, allows IT administrators to manage apps using MAM and app protection policies on devices *not enrolled* with Intune MDM. This means apps could be managed by Intune on devices enrolled with third-party enterprise mobility management (EMM) providers. Additionally, members of your organization can choose to use their own devices, known as bring-your-own-device (BYOD), and still support a Intune mobile application management scenario.

> [!IMPORTANT]
> Intune MAM capabilities are supported whether you choose to enroll the device or not. 

### Examples of app policies
App policies allow you to perform several different types of actions to configure and protect apps. By using MAM policies in Intune you can configure, secure, publish, monitor, and update apps for devices and users of your organization. For example, you can:
- Add and assign apps to devices and users.
- Assign apps to devices not enrolled with Intune.
- Use app configuration policies to control the startup behavior of apps.
- Prevent data from being backed up from a protected app.
- Restrict copy and paste actions to other apps.
- Require a PIN to access an app.

### Video - Interactive guide to managing apps (optional)
The following interactive guide steps you through the Microsoft Endpoint Manager admin center to show you how to manage devices enrolled in Intune, enforce compliance with policies, and protect your organization's data.

</p>
<div align=”center”>
<iframe allowfullscreen width="95%" height="450" src="https://mslearn.cloudguides.com/guides/Manage%20and%20protect%20mobile%20and%20desktop%20applications%20with%20Microsoft%20Endpoint%20Manager" frameborder="0" scrolling="no" loading="lazy"/></iframe>
</div>

## Manage and protect your organization’s data

Using Endpoint Manager, you can prevent data leaks and prevent unauthorized access.

### Prevent data leaks

You can control how users share and save data without risking intentional or accidental data leaks. Microsoft Intune provides app protection policies that you set to secure your company data on user-owned devices. The devices do not need to be enrolled in the Intune service.

App protection policies set up with Intune also work on devices managed with a non-Microsoft device management solution. The personal data on the devices is not touched; only company data is managed by the IT department.

You can set app protection policies for Office mobile apps on devices running Windows, iOS/iPadOS, or Android to protect company data. These policies enforce device requirements such as an app-based PIN or company data encryption, or more advanced settings to restrict how cut, copy, paste, and save-as features are used by users between managed and unmanaged apps. You can also remotely wipe company data without requiring users enroll devices.

### Prevent unauthorized access

You can classify, label, and protect Office 365 documents and emails so only authorized users have access to the data. The settings are managed automatically after IT administrators or users set the rules and conditions. Alternatively, the IT team can provide recommended settings for users to follow. Administrators and users can also revoke access to data already shared with others without assistance from another authority. The goal of this work is to control who opens or updates protected data, even when the data leaves the company's network.