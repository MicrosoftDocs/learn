

Windows offers advanced techniques for managing user profiles and data. By using cloud-based services such as Enterprise State Roaming and Microsoft OneDrive, companies can seamlessly empower their users to transition between various device platforms. With these services, employees can effortlessly access their data from any device and transfer their settings from one Windows device to another.

### Enterprise State Roaming

Windows 8 introduced the Sync your settings feature, which uses Microsoft accounts to sync settings with Microsoft OneDrive. Enterprise State Roaming offers similar functionality, but it's targeted to enterprises, because it requires Azure AD Premium and it syncs Windows settings with Azure. Enterprise State Roaming can sync only settings and not data. However, you should note that Enterprise State Roaming can only sync the settings of the Universal Windows Platform (UWP) apps and Windows settings, and that it can't sync desktop-application settings. You can use the Settings app, Group Policy or mobile device management (MDM) to control which settings will be synced.

:::image type="content" source="../media/enterprise-sync-settings-c2bf2ecc.png" alt-text="Screenshot of two Windows 10 computers that are connected to Azure AD Premium illustrating that Enterprise State Roaming can sync Windows 10.":::


Enterprise State Roaming syncs settings across Azure AD joined devices and provides users with the same experience across their devices. Enterprise State Roaming provides the following benefits:

 -  Separation of business and private data. Business data and private data are stored separately. If a user installs an app by using an Azure AD identity, the assumption is that the app is for business use. If an app was installed by using a Microsoft account, it's considered a personal app. Enterprise State Roaming syncs only state of the business UWP apps.
 -  Enhanced security. Synced data is automatically encrypted by using Azure Rights Management (Azure RMS) when it moves from a Windows device to the cloud and back. All data that is stored in the cloud is encrypted. When you enable Enterprise State Roaming, your company is automatically issued a free, limited-use license for Azure RMS. This free subscription is limited to encrypting and decrypting enterprise settings and application data synced by Enterprise State Roaming.
 -  Better management and monitoring. You can enable and configure Enterprise State Roaming in the Azure portal or by using Windows PowerShell. In the portal, you can view information such as which devices are synced by Enterprise State Roaming, who syncs data in your company, and when devices were last synced.
 -  Synced data is kept in the same region. Enterprise State Roaming data is hosted in the Azure region that best aligns with the Azure AD tenant’s country/region, and data resides locally in the geographical region and doesn't replicate across regions.
 -  Data retention. Enterprise State Roaming data that was synced to Azure is kept at least 90 days after it was last accessed or until you delete it manually.

#### Sync user data

Enterprise State Roaming (ESR) doesn't provide a mechanism for synchronizing user files, such as documents and pictures. For this, OneDrive is a service that enables the ability to store and access files from all your devices, by storing data in the cloud. Together, OneDrive and ESR provide a modern method for providing users a seamless experience when using different devices. The modern method is fairly straight-forward. User data and settings are seamlessly synchronized between the client device and the cloud. When a user logs in to any other (approved) device, the user’s data and settings follow.

The primary advantage of using the modern method is that it's relatively easy to set up and doesn't require any customer infrastructure other than internet access. This greatly reduces the risks inherent with migrations and simplifies the migration process, since potentially no effort need be made to back up or transfer user data.

The disadvantage of this is that ESR and OneDrive don't provide a solution for synchronizing all the data in a user profile, most notably, application data associated with desktop apps. Depending on the applications the organization uses and how critical the app data is, will determine whether a modern or traditional method is needed. However, as client desktops are a single point of failure, organizations should strive to find solutions for moving critical data off of client devices.

#### ESR and Microsoft Edge (Chromium based)

ESR is a tool used to sync settings across the Windows ecosystem. With Microsoft Edge, the sync solution isn’t tied to Windows sync ecosystem. This enables us to offer Microsoft Edge across all the platforms, such as Windows 8.1, iOS, Android and macOS.

With Microsoft Edge sync, the following data will sync between devices:

 -  Favorites
 -  Passwords
 -  Form-fill
 -  History
 -  Open tabs (sessions)
 -  Settings (preferences)
 -  Extensions

> [!NOTE]
> Microsoft Edge doesn't use Windows credential Manager for passwords and as a result, won't sync passwords with Internet Explorer or other apps that use Windows Credential manager.

### User Experience Virtualization

User Experience Virtualization (UE-V) is a Windows Enterprise edition feature that enables the synchronization of operating-system settings, desktop-application settings, Microsoft Store app settings, network printers, and user credentials between Windows Enterprise edition computers in the same AD DS domain environment.

While UE-V is still a current product, it should be noted that UE-V is currently in extended support, scheduled to reach end-of-life on April 14, 2026.
