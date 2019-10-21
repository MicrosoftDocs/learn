You now have a better awareness of device identity and Conditional Access. You want to investigate Azure AD join and how it might be used to improve device management for both Azure and your on-premises Active Directories.

Azure AD join manages the process of adding new devices to your Azure AD through the mobile device management (MDM) platform.

In this until, you'll learn what Azure AD join is, and how you can use it to cover infrastructure and device management. You'll look at the different applications for Azure AD join, including cloud-based, on-premises, and other devices. Then you'll look at how to configure your devices to restrict or limit access. Finally, you'll walk through joining a Windows 10 device using Azure AD join.

## What is Azure AD join

Azure AD join enables the joining of devices to your Azure Active Directory without the need to sync with an on-premises AD, while maintaining security and user productivity. Azure AD join is better suited to organizations that are principle cloud-based, although it can operate in a hybrid cloud/on-premises environment.

## Choosing your Azure AD join infrastructure

When considering your Azure AD join implementation, you'll need to decide what infrastructure model best supports your organizational needs. There are four flavors you can choose from.

- Manual user configuration is best used in a hybrid environment where you use both an on-premises AD and an Azure AD. When using the on-premises AD, you'll need to synchronize the accounts with your Azure AD using Azure AD Connect. Ideally, you should look to migrate all managed identity accounts to use your Azure AD.
- Smartcards and certificate-based authentication aren't valid methods for joining devices to your Azure AD. Instead, it's recommended that you use a service like Windows Hello for Business, which supports password-less authentication.
- Federated environments require the use of an identity provider. That provider must support the WS-Trust and WS-Fed protocols for Azure AD join to work natively with Windows devices. The former is needed to log in to an Azure AD joined device, the latter to link a device to your Azure AD.
- A managed environment uses Pass-Through Authentication or Password Hash Sync to provide Seamless Single Sign-on to your devices.

### Supported devices

Azure AD join will only work with Windows 10 devices. If you're using an earlier Windows operating system like Windows 7 or 8.1, you'll need to upgrade them to Windows 10 beforehand.

Even when using Windows 10, you must ensure that it is kept up-to-date with the latest service packs and upgrades.

### Managing devices

Azure AD join uses the Mobile Device Management (MDM) platform to manage devices attached to your Azure AD. The latest versions of Windows 10 now have a built-in MDM client that will work with all compatible MDM systems. When looking to manage your Azure AD joined devices, there are two approaches.

- MDM-only - All joined devices are managed exclusively through an MDM provider, like Intune. If your organization is using group policies, you'll need to review your MDM's policy for support.

- Co-management - All joined devices use a combination of a locally installed System Center Configuration Manager (SCCM) agent and your MDM provider. Microsoft Intune provides co-management capabilities using SCCM. SCCM will let you manage the device while MDM delivers user management policies.

Of the two approaches, the recommendation is to use MDM-only for managing all your Azure AD joined devices.

## Considerations for resources and application access

For the best user experience and improving access to your application, you should consider moving all your applications and resources to the Azure cloud. While that may be possible in some cases, it isn't always practical. In this section, we'll explore different access options for your applications and resources.

- Cloud-based applications - Any migrated apps and all new applications will be added to the Azure AD app gallery. Azure AD join users can leverage SSO to seamlessly access those applications. SSO is supported by the majority of browsers. Azure AD join provides SSO support for device access to applications still using Win32.
- On-premises web applications - Any bespoke or custom made software that's hosted on-premises can still be accessed user Azure AD join. Access to those applications will need each user to add the app to their trusted sites. This is required to allow the application to use Windows-integrated authentication without prompting the user to authenticate.
- Other Devices - This includes existing applications using legacy protocols, and on-premises network shares. Both are available to Azure AD joined devices using SSO, as long as the device is connected to either your domain controller.
- Printer resources - won't automatically be available through Azure AD join, although users can still connect to a printer directly using its UNC path.

## Provisioning options

When deploying Azure AD join, you have several choices when it comes to how devices are provisioned and joined to your active directory. There are three approaches available.

- Self-service - The self-service approach requires users to manually configure the device during the Windows Out of Box Experience (OOBE) for new devices, or using the Windows settings for older devices. Self-service is better suited to users who have a strong technical background.
- Windows Autopilot - This approach allows pre-configuration of Windows devices, including automatically joining the device to your Active Directory, automatic MDM enrollment, and creating customer OOBE content. This approach simplifies the management and deployment of devices across your organization. The Windows device can be provisioned and deployed, and the user can complete the OOBE as if it's a new user.
- Bulk enrollment- Lets you set up a provisioning package that can be applied to a large quantity of new Windows devices at the same time.

The table below shows the key features of each approach.

| Feature | Self-service | Windows Autopilot | Bulk enrollment |
| ---- | ---- | ---- | ---- |
| User interaction during setup | Yes | Yes | No |
| IT involvement | No | Yes | Yes |
| Applicable flows | OOBE & Settings | OOBE only | OOBE only |
| Local admin rights to primary user | Yes | Configurable | No |
| Requires OEM support | No | Yes | No |

## Configuring device settings

From the Azure portal, it's possible to control how new devices are joined to your organization. The settings can be found in your **Azure Active Directory page**. Select Devices and then Device Settings. From there, you can configure related features.

- Users may join devices to Azure AD - You have three options: all, selected, and none. 'All' allows for any device to be joined, 'selected' allows you fine-grained control over the type of devices that can be added. 'None' prevents new devices from joining your Azure AD.
- Additional local administrators on Azure AD joined devices - this option lets you specify other users to be included as local administrators on all joined devices.
- Require multi-factor authentication to join devices - This option lets you enforce multi-factor authentication (MFA) when the device joins your Azure AD. 

## Walkthrough - Joining a Windows 10 device through Azure AD Join

Your organization wants to provide a second layer of security when a new device is added to your domain. This walkthrough will give an indication of how that might be achieved. You've provided a new device to a tech-savvy employee, who will use the self-service approach to joining a device to your AD, which is using MFA.

1. After powering up the device, you'll follow the prompts to set up your device, including customizing your region and selecting a language

    ![Screenshot showing the region customization for Windows 10](../media/3-walk-setup-pc.png)

1. Accept the Microsoft Software Licensing Terms
1. Select the network connection you'll be using to connect to the cloud.
1. When asked, "who owns this PC?" you'll select the "This device belongs to my organization".

    ![Screenshot showing the who owns this pc prompt](../media/3-walk-who-owns.png)
1. Sign in with the credentials supplied by your organization.
1. You'll be prompted with a multi-factor authentication challenge.
1. The Azure AD will check the configuration settings to see if the device should be enrolled in MDM.
1. When successful, the device is registered with the organization's Azure AD. If MDM is being used, that will be fulfilled as well.
