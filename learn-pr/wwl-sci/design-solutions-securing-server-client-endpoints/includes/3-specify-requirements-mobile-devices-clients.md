Managing devices is a significant part of any endpoint management strategy and solution. Organizations have to manage laptops, tablets, mobile phones, wearables, and more. It can be a large task, especially if you're not sure where to start.

Enter Microsoft Intune. Intune is a cloud-based service that can control devices through policy, including security policies. For more information on Intune and its benefits, go to [What is Microsoft Intune?](/mem/intune/fundamentals/what-is-intune).

The goal of any organization that's managing devices is to secure devices and the data they access. This task includes organization owned devices and personally owned devices that access your organization resources.

From a service perspective, Intune uses Microsoft Entra ID for device storage and permissions. Using the [Microsoft Intune admin center](/mem/intune/fundamentals/tutorial-walkthrough-endpoint-manager), you can manage device tasks and policies in a central location designed for endpoint management.

This article discusses concepts and features you should consider when managing your devices.

## Manage organization owned and personal devices

Many organizations allow personally owned devices to access organization resources, including email, attend meetings, and so on. There are different options available and these options depend on how strict your organization is.

You can require personal devices be enrolled in your organization's device management services. On these personal devices, your admins can deploy policies, set rules, configure device features, and more. Or, you can use app protection policies that focus on protecting app data, such as Outlook, Teams, and Sharepoint. You can also use a combination of device enrollment and app protection policies.

For organization owned devices, they should be fully managed by your organization, and receive policies that enforce rules and protect data.

## Use your existing devices and use new devices

You can manage new devices and existing devices. Intune supports Android, iOS/iPadOS, Linux, macOS, and Windows devices.

There are some things you should know. For example, if existing devices are managed by another MDM provider, they may need to be factory reset. If the devices are using an older OS version, they may not be supported.

If your organization is investing in new devices, then it's recommended to start with a cloud approach using Intune.

## Check the compliance health of your devices

Device compliance is a significant part of managing devices. Your organization will want to set password/PIN rules and check for security features on these devices. You'll want to know which devices don't meet your rules. This task is where compliance comes in.

You can create compliance policies that block simple passwords, require a firewall, set the minimum OS version, and more. You can use these policies and built-in reporting to see non-compliant devices and see the non-compliant settings on these devices. This information gives you an idea of the overall health of the devices accessing your organization resources.

Conditional access is a feature of Microsoft Entra ID. With conditional access, you can enforce compliance. For example, if a device doesn't meet your compliance rules, then you can block access to organization resources, including Outlook, SharePoint, Teams, and more. Conditional access helps your organization secure your data and protect your devices.

## Control device features and assign policies to device groups

All devices have features that you can control and manage using policies. For example, you can block the built-in camera, allow Bluetooth pairing, manage the power button, and more.

For many organizations, it's common to create device groups. Device groups are Microsoft Entra groups that only include devices. They don't include user identities.

When you have device groups, you create policies that focus on the device experience or task, like running a single app or scanning bar codes. You can also create policies that include settings that you want to always be on the device, regardless of who's using the device.

You can group devices by OS platform, by function, by location, and anything else you prefer.

Device groups can also include devices that are shared with many users or aren't associated with a specific user. These dedicated or kiosk devices are typically used by front line workers and can also be managed by Intune.

When the groups are ready, you can assign your policies to these device groups.

## Secure your devices

To help secure your devices, you can install antivirus, scan & react to malicious activity, and enable security features.

In Intune, some common security tasks include:

-   **Integrate with Mobile Threat Defense** (MTD) partners to help protect organization owned devices and personally owned devices. These MTD services scan the devices and can help remediate vulnerabilities. The MTD partners support different platforms, including Android, iOS/iPadOS, macOS, and Windows.    
-   **Use Security Baselines** on your Windows devices. Security baselines are pre-configured settings that you can deploy to your devices. These baseline settings focus on security at a granular level and can also be changed to meet any organization specific requirements. If you're not sure where to start, then look at Security Baselines and the built-in guided scenarios.
-   **Manage software updates, encrypt hard disks, configure built-in firewalls**, and more using built-in policy settings. You can also use Windows Autopatch for automatic patching of Windows, including Windows quality updates and Windows feature updates.
-   **Manage devices remotely** using the Intune admin center. You can remotely lock, restart, locate a lost device, restore a device to its factory settings, and more. These tasks are helpful if a device is lost or stolen, or if you're remotely troubleshooting a device.
