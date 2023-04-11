
When migrating a user to new device or performing an in-place migration, consideration should be given for what user and app settings should be retained and what method should be used to ensure this information is retained.

### Synchronize the user state

Starting with Windows 10, Azure Active Directory (Azure AD) users gain the ability to securely synchronize their user settings and application settings data to the cloud. Enterprise State Roaming (ESR) provides users with a unified experience across their Windows devices and reduces the time needed for configuring a new device. Enterprise State Roaming operates similar to the standard consumer settings sync that was first introduced in Windows 8.

Enterprise State Roaming also offers:

 -  **Separation of corporate and consumer data**. Organizations are in control of their data, and there's no mixing of corporate data in a consumer cloud account or consumer data in an enterprise cloud account.
 -  **Enhanced security**. Data is automatically encrypted before leaving the user’s Windows device by using Azure Rights Management (Azure RMS), and data stays encrypted at rest in the cloud. All content stays encrypted at rest in the cloud, except for the namespaces, like settings names and Windows app names.
 -  **Better management and monitoring**. Provides control and visibility over who syncs settings in your organization and on which devices through the Azure AD portal integration.

ESR syncs settings across Azure AD joined devices. When the organization has ESR enabled, the user only needs to sign in to the new device, and the device will retain all the settings that ESR supports, such as Microsoft Edge browser settings, personalized settings, pass- words, language preferences, mouse settings, UWP Apps (if developer supported), etc.

As a rule of thumb, you should migrate all settings and data that users need. You shouldn't migrate unneeded and obsolete data that only occupies space. Consideration should also be given for the effort needed to migrate certain data versus the time saved. ESR doesn't synchronize desktop applications settings. Whether this has an impact depends on several factors. While many applications store data int the AppData folder, many times this data is written by the app as part of its routine functions, and not necessarily unique data the user would consider lost if it weren't migrated.

Sometimes the user data is simply easier to create. For example, perhaps the user that launches a fresh installed app might have to set up something simple such as their name in the app.

Alternatively, simple configurations that have significant impact shouldn't be ignored. If an application requires a critical setting, such as a folder location to be configured within the app, while the step itself might be simple, it may not wise to assume the user will correctly configure it. Expecting users to make several post-migration configurations, even simple ones, can lead to problems as well.

### Migrate the user state

When synchronization solutions aren't enough and there's a need to migrate files or settings from one device to another in Windows environments, the User State Migration Tool (USMT) is typically used. USMT isn't so much a user state synchronization tool as a means to migrate the user state during upgrades and migrations. User state migration has two phases:

1.  **Capture settings**. You begin by capturing settings and data from the source computer. You store these settings in a migration store, which is often on a shared network folder, although it could also be on local storage.
2.  **Restore captured settings**. After capturing the settings and data from the source computer, you must restore them on the destination computer. You can perform the second phase only after you install an operating system on the destination computer, and it can occur separately or during the operating-system installation.

Usually, all the settings and data that were captured on the source computer are later restored, but this isn't necessarily the case. You could capture some settings or data and decide later not to restore them. However, you should be aware that you can’t restore data that you didn't first capture, because it doesn't exist in the migration store.

### User state migration in the replace and refresh computer scenario

User state migration can occur in different deployment stages, depending on whether you use a wipe-and-load (refresh) or side-by-side (replace) deployment scenario.

 -  **In the replace scenario, the source and destination computers are different**. When deploying Windows on new computers, you can capture the user state from source computers before or after you deploy Windows on destination computers. After Windows deploys on destination computers, you can restore the user states on these computers.
 -  **In the refresh scenario, the source and destination computers are the same**. When upgrading to the Windows 10 or Windows 11 operating system on computers that have existing operating systems, you can capture the user state, store it in temporary storage, perform a clean Windows installation, and then restore the user state on the upgraded computers.

When you deploy Windows on a computer that has an existing, supported Windows operating system, Windows creates a Windows.old folder. You can migrate user settings from that folder. Windows enables nondestructive deployment because a Windows installation doesn't wipe out the target partition. The previous Windows installation folder, the Program Files folder, and the Users folder are moved to the Windows.old folder, whereas user data in the root folder remains unchanged. You can capture user state either online, while an older version of Windows is running, or offline, from the Windows.old folder.

### Known Folder Move to facilitate a modern file management solution

OneDrive allows users to seamlessly store and synchronize data between the cloud and the devices they use. Users can create, open, and edit files without impacting their existing workflows while OneDrive synchronizes those changes in the background. Users can access their files from any device using their Microsoft account.

Historically, it's the user's responsibly to set this up. Known Folder Move enables IT to facilitate OneDrive to begin protecting the commonly used Desktop, Pictures, and Documents folders.

Enabling Known Folder Move is done through Group Policy. You'll need to install the Group Policy templates, which are located at **%localappdata%\\Microsoft\\OneDrive\[BuildNumber\]\\adm** of a OneDrive client. You'll need to enable the **Prompt users to move Windows known folders to OneDrive** policy and configure it with your tenant ID (located in Azure AD admin center).

:::image type="content" source="../media/known-folder-move-b78855c6.jpg" alt-text="Screenshot of the user experience when Known Folder Move is implemented.":::


If a user is already using OneDrive to redirect their folders to another account (such as a personal account), they'll be prompted to direct the folders to the organizational account.

Alternatively, you can also configure this to occur without any user interaction. Enabling the **Silently move Windows known folders to OneDrive** group policy with your tenant ID if you don't wish to prompt users to migrate folders to OneDrive. You can also decide whether to show a notification when folders have been redirected.

There are some considerations to consider when choosing to use Known Folder Move:

 -  You can’t use KFM if you're using Windows Folder Redirection for Desktop, Pictures, or Documents folders.
 -  Consider configuring the sync client upload rate GPO if you have a large organization or expect KFM to result in a large amount of data being migrated. Also consider a pilot group to assess potential impact to network traffic.
 -  KFM will return errors if unsupported conditions are found. These can include unsupported file types (such as Outlook or OneNote files), exceeding maximum path length and known folders not in the default locations.

Utilizing OneDrive Known Folders compliments ESR and allows the ability to manage Win32 application settings without the need for legacy roaming profiles.

### Integrate USMT with Configuration Manager

You can use USMT on a single device to migrate settings from one device to another or retain settings on the same device during a rebuild process (this is also known as a Hardlink migration store.) There are several USMT components that you can use with Configuration Manager. This section covers some of the options that are available and shows an example of how you can use this in the field.

After setting up the Configuration Manager site, one prerequisite of the Windows ADK is the installation of the User State migration components. This enables Configuration Manager to create and integrate a USMT package. Below outlines at a high level the key components involved.

#### Create a USMT Package from Configuration Manager

After installing the prerequisites, you can either create a custom USMT package or use the default package to manage the capture and reinstatement of data. Typically, you'll copy the default package and then replicate it to include the changes related to the use scenario. You can use either package in the process.

The default package is located on the Configuration Manager site server under:

%Program files%\\Windows Kits\\10\\Assessment and Deployment Kit\\User State Migration

#### Set up a State Migration Point (Configuration Manager Site System Role)

To support multiple migrations of user data during an upgrade, you can assemble a State Migration Point (Configuration Manager Role) to act as a file share to store data. Each request stores a unique hash relating to the device that allows data to be captured (through a computer association), the device upgraded, and the relevant data reinstated afterwards. For large enterprises, it's common to have regionally located State Migration Points within the site hierarchy.

#### Task sequence

Task sequences drive the overall OS deployment, and you can include USMT as part of this process when required. This often occurs at the beginning of the process when capturing the settings and as a post-build process to reinstate the settings for a particular user depending on the options that are selected. The package created for USMT by the site setup is then referenced in these task sequence steps.

#### USMT templates used for migration

USMT templates consist of four .xml templates that control data, which is collected. These files are:

 -  MigApp.xml
 -  MigDocs.xml
 -  MigUser.xml
 -  ConfigMgr.xml

With these four files, you can customize which relevant data to collect in a user's profile. You can create custom versions of these files to collect a subset of information, while conforming to the structure of the XML template. Executed in either the Scan or Load module, these files are then referenced in the Configuration Manager task sequence step.
