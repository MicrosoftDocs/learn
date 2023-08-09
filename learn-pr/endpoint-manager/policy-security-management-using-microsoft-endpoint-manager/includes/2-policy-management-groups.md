You can manage assignments of devices, apps, and policies based on groups of users or devices.

You can add the following types of groups:

- **Assigned groups**: Manually add users or devices into a static group.
- **Dynamic groups** (Requires Azure AD Premium): Automatically add users or devices to user groups or device groups based on an expression you create.

## Devices

To make managing devices easier, you can use Microsoft Intune device categories to automatically add devices to groups based on categories that you define.

Device categories use the following workflow:

1. Create categories from which users can choose when they enroll their device.
2. When users of iOS/iPadOS and Android devices enroll a device, they must choose a category from the list of categories you configured. To assign a category to a Windows device, users must use the Company Portal website.
3. You can then deploy policies and apps to these groups.

You can create any device categories you want. For example:

- Point-of-sale device
- Demonstration device
- Sales
- Accounting
- Manager

After your device is enrolled, it becomes *managed*. Your organization can assign policies and apps to the device through a mobile device management (MDM) provider, such as Intune.  

## Apps

After you've added an app to Microsoft Intune, you can assign the app to users and devices. It's important to note that you can assign an app to a device whether or not the device is managed by Intune.

In Intune, you can determine who has access to an app by assigning groups of users to include and exclude. Before you assign groups to the app, you must set the assignment type for an app. The assignment type makes the app available, required, or uninstalls the app.

To set the availability of an app, you include and exclude app assignments to a group of users or devices by using a combination of include and exclude group assignments. This capability can be useful when you make the app available by including a large group, then narrow the selected users by also excluding a smaller group. The smaller group might be a test group or an executive group.

As a best practice, create and assign apps specifically for your user groups and separately for your device groups.

For example, when you add a user with the Manager title, the user is automatically added to an **All managers** user group. When a device has the iOS/iPadOS device OS type, the device is automatically added to an **All iOS/iPadOS devices** group.

After you assign an app to a group in Intune, you can assign policies for the app to users or devices.

## Policies

You can assign policies to groups using Intune. When you assign policies, you can choose who will be included and who will be excluded.

## User groups vs. device groups

Many users ask when to use user groups and when to use device groups. The answer depends on your goal. Here's some guidance to get you started:

### Device groups

If you want to apply settings on a device regardless of who's signed in, assign your profiles to a device group. Settings applied to device groups always go with the device, not the user. Device groups are commonly used for shared and specialized devices.

For example:

- Device groups are useful for managing devices that don't have a dedicated user. For example, you have devices that print tickets, scan inventory, are shared by shift workers, are assigned to a specific warehouse, and so on. Put these devices in a device group and assign your profiles to this device group.
- You create a Device Firmware Configuration Interface (DFCI) Intune profile that updates settings in the BIOS. For example, you configure this profile to disable the device camera or lock down the boot options to prevent users from booting up another OS. This profile is a good scenario to assign to a device group.
- On some specific Windows devices, you always want to control some Microsoft Edge settings, regardless of who's using the device. For example, you want to block all downloads, limit all cookies to the current browsing session, and delete the browsing history. For this scenario, put these specific Windows devices in a device group, then create an Administrative Template in Intune, add these device settings, and assign this profile to the device group.

To summarize, use device groups when you don't care who's signed in on the device, or if anyone is signed in. You want your settings to always be on the device.

### User groups

Profile settings applied to user groups always go with the user, and go with the user when signed in to their many devices. It's normal for users to have many devices, such as a Surface Pro for work and a personal iOS/iPadOS device. It's also normal for a person to access email and other organization resources from these devices. User groups are typically used for information works and knowledge workers.

For example:

- You want to put a Help Desk icon for all users on all their devices. In this scenario, put these users in a user group and assign your Help Desk icon profile to this user group.
- A user receives a new organization-owned device. The user signs in to the device with their domain account. The device is automatically registered in Azure AD, and automatically managed by Intune. This profile is a good scenario to assign to a user group.
- Whenever a user signs in to a device, you want to control features in apps, such as OneDrive or Office. In this scenario, assign your OneDrive or Office profile settings to a user group.

  For example, you want to block untrusted ActiveX controls in your Office apps. You can create an Administrative Template in Intune, configure this setting, and assign this profile to a user group.

To summarize, use user groups when you want your settings and rules to always go with the user, whatever device they use.
