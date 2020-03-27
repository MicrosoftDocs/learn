You now have a better understanding of device identity and Conditional Access. You want to investigate Azure AD join and how it might be used to improve device management for both Azure and your on-premises active directories.

Azure AD join manages the process of adding new devices to your Azure Active Directory (Azure AD) through the mobile device management platform.

In this unit, you'll learn about Azure AD join, and how to use it for infrastructure and device management. You'll look at the different applications for Azure AD join, including cloud-based, on-premises, and other devices. Then you'll see how to configure your devices to restrict or limit access. Finally, you'll see how to join a Windows 10 device using Azure AD join.

## What is Azure AD join?

Azure AD join allows you to join devices to your Azure Active Directory (AD) organization, without needing to sync with an on-premises Active Directory. Azure AD join is best suited to organizations that are principally cloud-based, although it can operate in a hybrid cloud and on-premises environment.

## Identity infrastructure

When considering an Azure AD join implementation, you decide what identity infrastructure model best supports your organizational needs.

- **Managed environment**: Uses Pass-through Authentication or password hash sync to provide seamless single sign-on (SSO) to your devices.
- **Federated environments**: Require the use of an identity provider. That provider must support the WS-Trust and WS-Fed protocols for Azure AD join to work natively with Windows devices. WS-Fed is required to join a device to your Azure AD. WS-Trust is needed to sign in to an Azure AD joined device.
- **Smartcards and certificate-based authentication**: These aren't valid methods to join devices to Azure AD. But, if you have Active Directory Federation Services (AD FS) configured, you can use smartcards to sign in to Azure AD joined devices. It's recommended you use a service like Windows Hello for Business, which supports password-less authentication to Windows 10 devices.
- **Manual user configuration**: Best used in a hybrid environment where there's an on-premises AD and an Azure AD. You need to synchronize the accounts to your Azure AD by using Azure AD Connect. Ideally, you should look to migrate all managed identity accounts to use your Azure AD.

### Supported devices

Azure AD join works with Windows 10 devices. If you're using an earlier Windows operating system like Windows 7 or 8.1, you'll need to upgrade to Windows 10.

Even when using Windows 10, it must be kept up to date with the latest service packs and upgrades.

### Managing devices

Azure AD join uses the mobile device management (MDM) platform to manage devices attached to your Azure AD. The latest versions of Windows 10 now have a built-in MDM client that works with all compatible MDM systems. When looking to manage your Azure AD joined devices, there are two approaches:

- MDM-only: All joined devices are managed exclusively through an MDM provider, like Intune. If your organization uses group policies, you'll need to review your MDM policy for support.

- Co-management: All joined devices use a combination of a locally installed System Center Configuration Manager (SCCM) agent and your MDM provider. Microsoft Intune provides co-management capabilities using SCCM. You use SCCM to manage the device while MDM delivers user management policies.

Of the two approaches, the recommendation is to use MDM-only for managing all Azure AD joined devices.

## Considerations for resources and application access

For the best user experience and to improve access to your application, you should consider moving all applications and resources to the Azure cloud. While that may be possible in some cases, it isn't always practical. In this section, we'll explore different access options for your applications and resources.

- **Cloud-based applications**: Any migrated apps and all new applications will be added to the Azure AD app gallery. Azure AD join users can use SSO to seamlessly access those applications. SSO is supported by the majority of browsers. Azure AD join provides SSO support for device access to applications still using Win32.

- **On-premises web applications**: Any bespoke or custom-made software that's hosted on-premises can still be accessed using Azure AD join. Access to those applications will need each user to add the app to their trusted sites. This action allows the application to use Windows-integrated authentication without prompting the user to authenticate.

- **Other devices**: Includes existing applications using legacy protocols, and on-premises network shares. Both are available to Azure AD joined devices using SSO, providing the device is connected to your domain controller.

- **Printer resources**: These resources won't automatically be available through Azure AD join, although users can still connect to a printer directly, using its UNC path.

## Provisioning options

When deploying Azure AD join, you have several choices for how devices are provisioned and joined to your active directory. There are three approaches available:

- **Self-service**: Requires users to manually configure the device during the Windows out-of-box experience (OOBE) for new devices, or by using the Windows settings for older devices. Self-service is better suited to users who have a strong technical background.

- **Windows Autopilot**: Allows you to preconfigure Windows devices, including automatically joining the device to your AD organization, automatic MDM enrollment, and creating customer OOBE content. This approach simplifies the management and deployment of devices across your organization. The Windows device can be provisioned and deployed. The user completes the OOBE as if they're a new user.

- **Bulk enrollment**: Lets you set up a provisioning package that applies to a large number of new Windows devices at the same time.

The table below shows the key features of each approach.

| Feature | Self-service | Windows Autopilot | Bulk enrollment |
| ---- | ---- | ---- | ---- |
| User interaction during setup | Yes | Yes | No |
| IT involvement | No | Yes | Yes |
| Applicable flows | OOBE and settings | OOBE only | OOBE only |
| Local admin rights to primary user | Yes | Configurable | No |
| Requires OEM support | No | Yes | No |

## Configuring device settings

From the Azure portal, you control how new devices are joined to your organization. You'll find the settings in your **Azure Active Directory page**. Select Devices and then Device Settings. From there, you can configure related features.

- **Users may join devices to Azure AD**: You have three options: all, selected, and none. 'All' allows for any device to be joined. 'Selected' gives fine-grained control over the type of devices you can add. 'None' prevents new devices from joining your Azure AD.

- **Additional local administrators on Azure AD joined devices**: This option lets you specify other users to be included as local administrators on all joined devices.

- **Require Multi-Factor Authentication to join devices**: This option lets you enforce Multi-Factor Authentication (MFA) when the device joins your Azure AD. 

## Join a Windows 10 device through Azure AD join

Your organization wants to provide a second layer of security when a new device is added to your domain. You've provided a new device to a tech-savvy employee. They will use the self-service approach to join the device to your AD organization, which is using MFA. The following steps show you what that workflow looks like.

1. After powering up the device, follow the prompts to set it up, including customizing your region and selecting a language.

    ![Screenshot of the region customization for Windows 10.](../media/3-walk-setup-pc.png)

1. Accept the Microsoft Software Licensing Terms.
1. Select the network connection to use to connect to the cloud.
1. When asked, **who owns this PC?**, select **This device belongs to my organization**.

    ![Screenshot that shows the who owns this pc prompt.](../media/3-walk-who-owns.png)
1. Sign in with the credentials supplied by your organization.
1. The employee will be prompted with a Multi-Factor Authentication challenge.
1. Azure AD checks the configuration settings to see if the device should be enrolled in MDM.
1. When successful, the device is registered with the organization's Azure AD. If MDM is being used, that will also be fulfilled.
