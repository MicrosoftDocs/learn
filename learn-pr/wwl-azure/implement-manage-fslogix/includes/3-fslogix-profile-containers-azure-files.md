FSLogix has two (2) primary [container](/fslogix/concepts-fslogix-terminology) types, which can be implemented as part of your profile management solution.

FSLogix containers are the virtual hard disk (VHD(x)) files, which hold all of the data for the given container type.

> [!NOTE]
> Cloud Cache isn't a type of container, but it's an optional configuration for profile and ODFC container types. For more information, see [Cloud Cache overview](/fslogix/concepts-fslogix-cloud-cache).

## Profile container

A [profile](/fslogix/concepts-fslogix-terminology) container is the most common container used in an FSLogix solution. A profile container is all the data related to a user's profile, which is directly stored in the VHD(x). A Windows user profile is typically stored in C:\\Users\\%username%. Nearly all the files and folders found under this location would be included in an FSLogix profile container. Some data in a user's profile shouldn't or can't be roamed which can be found in the [exclusion](/fslogix/concepts-container-types#default-exclusions) list.

For users familiar with managing profiles, the function of the profile container may be compared to Microsoft User Profile Disk (UPD), Microsoft roaming profiles, or Citrix User Profile Management (UPM). Although the function is similar, the underlying method and technology is different, resulting in key FSLogix [capabilities](/fslogix/overview-what-is-fslogix#key-capabilities).

> [!NOTE]
> Unless otherwise configured, the profile container will hold all profile and ODFC content in the same VHD(x) file. ***This is the recommended configuration.***

### Profile excluded content

There's profile content that can't be roamed between virtual machines. To prevent issues with applications or processes that need access to this data, FSLogix creates a [redirect](/fslogix/concepts-fslogix-terminology) from the native profile path to a new folder in the C:\\Users path. This folder is prefixed with local\_ and combined with the user's SAM account name (for example, C:\\Users\\local\_%username%). During sign out, the C:\\Users\\local\_%username% folder is deleted.

#### Default exclusions

FSLogix automatically excludes the following paths:

 -  %userprofile%\\AppData\\Roaming\\Microsoft\\Protect
 -  %userprofile%\\AppData\\Roaming\\Microsoft\\Credentials
 -  %userprofile%\\AppData\\Local\\Microsoft\\Credentials
 -  %userprofile%\\AppData\\Local\\Microsoft\\Office\\16.0\\OfficeFileCache

## ODFC container

An [ODFC](/fslogix/concepts-fslogix-terminology) container is a container type, which is focused on storing profile content that is unique to Microsoft Office applications. The ODFC container is most commonly implemented in conjunction other roaming profile solutions.

> [!IMPORTANT]
> When using ODFC containers with other profile roaming solutions, be sure the other solutions are configured to [exclude the ODFC data](/fslogix/tutorial-configure-odfc-containers#exclusions-for-third-party-roaming-profiles).

A default ODFC container configuration includes the following data:

 -  Office Activation
 -  Outlook
 -  Outlook personalization
 -  SharePoint
 -  OneDrive
 -  Skype for Business (legacy support)

Most data contained in the ODFC container is sourced from other remote systems and is easily replaced should the ODFC container become corrupted or deleted. For example, Outlook data files are generated from remote e-mail servers (for example, Microsoft 365). The list of applications that can be included are found in the [ODFC reference](/fslogix/reference-configuration-settings?tabs=odfc#tabpanel_1_odfc) articion.

## When to use Profile and ODFC containers

Profile and ODFC containers should be used together when:

 -  Discretion is wanted in the storage location for Office data vs. other profile data.
 -  Provides isolation from data loss or corruption in one of the containers.
 -  Used as a mechanism to specify which Office components have their data included in the container.
 -  Allows organizations to have different container sizes to accommodate specific workloads or data synced from OneDrive.
