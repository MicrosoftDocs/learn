You can use Microsoft Intune to manage the apps that your company's workforce uses on their devices. This functionality is called mobile application management (MAM). MAM in Intune is designed to protect organization data at the application level, including custom apps and store apps. App management can be used on organization-owned devices and personal devices. When it is used with personal devices, only organization-related access and data is managed.

As we mentioned previously, Microsoft Endpoint Manager supports two MAM configurations:
- **Intune MDM + MAM**: IT administrators can only manage apps using MAM and app protection policies on devices that are enrolled with Intune mobile device management (MDM). To manage apps using MDM + MAM, customers should use the Intune console in the Microsoft Endpoint Manager admin center.
- **MAM without device enrollment**: MAM without device enrollment, or MAM-WE, allows IT administrators to manage apps using MAM and app protection policies on devices not enrolled with Intune MDM. This means apps can be managed by Intune on devices enrolled with third-party EMM providers. To manage apps using MAM-WE, customers should use the Intune console in the Microsoft Endpoint Manager admin center. Also, apps can be managed by Intune on devices enrolled with third-party enterprise mobility management (EMM) providers or not enrolled with an MDM at all.

When apps are managed in Intune, administrators can:
- **Protect company data at the app level.** You can add and assign mobile apps to user groups and devices. This allows your company data to be protected at the app level. You can protect company data on both managed and unmanaged devices because mobile app management doesn't require device management. The management is centered on the user identity, which removes the requirement for device management.
- **Configure apps to start or run with specific settings enabled.** In addition, you can update existing apps already on the device.
- **Assign policies to limit access and prevent data from being used outside your organization.** You choose the setting for these policies based on your organization's requirements. For example, you can:
  - Require a PIN to open an app in a work context.
  - Control the sharing of data between apps.
  - Prevent the saving of company app data to a personal storage location.
- **Support apps on a variety of platforms and operating systems.** Each platform is different. Intune and Configuration Manager provides available settings specifically for each supported platform.
- **See reports about which apps are used, and track their usage.** In addition, Intune and Configuration Manager provides endpoint analytics to help you assess and resolve problems.
- **Do a selective wipe by removing only organization data from apps.**
- **Ensure personal data is kept separate from managed data.** End-user productivity isn't affected and policies don't apply when using the app in a personal context. The policies are applied only in a work context, which gives you the ability to protect company data without touching personal data.

## App lifecycle
The Microsoft app lifecycle for Intune and Configuration Manager apps begins when an app is added and progresses through additional phases until you remove the app. By understanding these phases, you'll have the details you need to get started with app management in Intune.

### Add
The first step when providing apps to your organization is to add the apps to Intune or create the app in Configuration Manager. While you can work with many different app types, the basic procedures are the same. With Intune, you can add different app types, including apps written in-house (line-of-business), apps from the store, apps that are built in, and apps on the web. With Configuration Manager, you can create the app and add requirements that must be met before the app is installed. 

### Deploy
After you've added the app to either Intune or Configuration Manager, you can deploy the app. In Intune you assign the app to users and devices that you manage. Intune makes this process easy, and after the app is deployed, you can monitor the success of the deployment from the Intune within the Azure portal. Additionally, in some app stores, you can purchase app licenses in bulk for your company. Intune can synchronize data with these stores so that you can deploy and track license usage for these types of apps right from the Intune administration console. In Configuration Manager you deploy the app to a device collection based on the Windows OS requirements that you select.

### Configure
Intune and Configuration Manager both provide methods to configure app installation and updates. You can configure extra functionality for some apps, for example:
- iOS/iPadOS app configuration policies supply settings for compatible iOS/iPadOS apps that are used when the app is run. For example, an app might require specific branding settings or the name of a server to which it must connect.
- Managed browser policies help you to configure settings for the  Microsoft Edge, which replaces the default device browser and lets you restrict the websites that your users can visit.
- You can set specific setting for Microsoft Outlook when you install it.
- Whether certain apps should be installed in User or System context.
- Rules to detect if the app is already installed, needs to be udpated, or has specific insallation depenencies.

### Protect
Intune gives you many ways to help protect the data in your apps. The main methods are:
- Conditional Access, which controls access to email and other services based on conditions that you specify. Conditions include device types or compliance with a device compliance policy that you deployed.
- App protection policies work with individual apps to help protect the company data that they use. For example, you can restrict copying data between unmanaged apps and apps that you manage, or you can prevent apps from running on devices that have been jailbroken or rooted.

### Retire
Eventually, it's likely that apps that you deployed become outdated and need to be removed. In Intune, you can uninstall apps by assigning an uninstall intent to a group of users or devices. In Configuration Manager, you can delete an app by first retiring the app, deleting all deployments, remove references to the application by other deployments, and then deleting all of the app's revisions.

## App configuration 
App configuration policies can help you eliminate app setup up problems by letting you assign configuration settings to a policy that is assigned to end users before they run the app. The settings are then supplied automatically when the app is configured on the end-users device, and end users don't need to take action. The configuration settings are unique for each app. 

You can create and use app configuration policies to provide configuration settings for both iOS/iPadOS or Android apps. These configuration settings allow an app to be customized by using app configuration and management. The configuration policy settings are used when the app checks for these settings, typically the first time the app is run. 

An app configuration setting, for example, might require you to specify any of the following details:
- A custom port number
- Language settings
- Security settings
- Branding settings such as a company logo

If end users were to enter these settings instead, they could do this incorrectly. App configuration policies can help provide consistency across an enterprise and reduce helpdesk calls from end users trying to configure settings on their own. By using app configuration policies, the adoption of new apps can be easier and quicker.

The available configuration parameters are ultimately decided by the developers of the app. Documentation from the application vendor should be reviewed to see if an app supports configuration and what configurations are available. For some applications, Intune will populate the available configuration settings.

## App protection 
One of the primary ways that Intune provides mobile app security is through policies. App protection policies allow you to do the following actions:
- Use Azure AD identity to isolate organization data from personal data. So personal information is isolated from organizational IT awareness. Data accessed using organization credentials are given additional security protection.
- Help secure access on personal devices by restricting actions users can take with organizational data, such as copy-and-paste, save, and view.
- Create and deploy on devices that are enrolled in Intune, enrolled in another mobile device management (MDM) service, or not enrolled in any MDM service. 

On enrolled devices, app protection policies can add an extra layer of protection. For example, a user signs in to a device with their organization credentials. Their organization identity allows access to data that's denied to their personal identity. As that organization data is used, app protection policies control how the data is saved and shared. When users sign in with their personal identity, those same protections (access and restrictions) aren't applied. In this way, IT has control of organization data, while end users maintain control and privacy over their personal data.

There are additional benefits to using MDM with app protection policies, and companies can use app protection policies with and without MDM at the same time. For example, consider an employee that uses both a phone issued by the company, and their own personal tablet. The company phone is enrolled in MDM and protected by app protection policies while the personal device is protected by App protection policies only.

## Protected apps

Intune supports a number of protected Microsoft apps and partner apps. Intune protected apps are enabled with a rich set of mobile application protection policies. These apps allow you to:

- Restrict copy-and-paste and save-as functions
- Configure web links to open inside the secure Microsoft browser
- Enable multi-identity use and app-level Conditional Access
- Apply data loss prevention policies without managing the user's device
- Enable app protection without requiring enrollment
- Enable app protection on devices managed with 3rd party EMM tools

Protected apps incorporate mobile app management using the Intune App Software Development Kit (SDK), or the App Wrapping Tool for either iOS or Android.

For instance, you can manage Outlook for iOS and Android with Intune. You can use Intune app protection and configuration policies with Outlook for iOS and Android to ensure team collaboration experiences are always accessed with safeguards in place. Organizations can use use Azure AD Conditional Access policies to ensure that users can only access work or school content using Outlook for iOS and Android. 

## Data protection framework using app protection policies 

As more organizations implement mobile device strategies for accessing work or school data, protecting against data leakage becomes paramount. Intune's mobile application management solution for protecting against data leakage is App Protection Policies (APP). APP are rules that ensure an organization's data remains safe or contained in a managed app, regardless of whether the device is enrolled. 

When configuring App Protection Policies, the number of various settings and options enable organizations to tailor the protection to their specific needs. Due to this flexibility, it may not be obvious which permutation of policy settings are required to implement a complete scenario. To help organizations prioritize client endpoint hardening endeavors, Microsoft has introduced a new taxonomy for security configurations in Windows 10. Intune is leveraging a similar taxonomy for its APP data protection framework for mobile app management. 

The Intune APP data protection framework is organized into three distinct configuration levels, with each level building off the previous level:

- **Enterprise basic data protection** (Level 1) ensures that apps are protected with a PIN and encrypted and performs selective wipe operations. For Android devices, this level validates Android device attestation. This is an entry level configuration that provides similar data protection control in Exchange Online mailbox policies and introduces IT and the user population to APP.
- **Enterprise enhanced data protection** (Level 2) introduces APP data leakage prevention mechanisms and minimum OS requirements. This is the configuration that is applicable to most mobile users accessing work or school data.
- **Enterprise high data protection** (Level 3) introduces advanced data protection mechanisms, enhanced PIN configuration, and APP Mobile Threat Defense. This configuration is desirable for users that are accessing high risk data.

Each level has specific recommendations about how and what to set to meet each level of app protection.

