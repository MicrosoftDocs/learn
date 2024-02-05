Using Office Container, both applications and users see the portions of the profile managed by Office Container as if they're located on the local drive.

All benefits of Office Container are automatic when using Profile Container. There's no need to implement Office Container if Profile Container is your primary solution for managing profiles. Office Container could optionally be used with Profile Container, to place Office Data in a location separate from the rest of the user's profile.

In this unit, learn how to:

 -  Configure Office Container Registry settings.
 -  Set up Include and Exclude User Groups.
 -  Configure third party profile exclusions.

## Configure Office Container Registry settings

The configuration of Office Container is accomplished through registry settings and user groups. Registry settings may be managed manually, with GPOs, or using alternate preferred methods. Configuration settings for Profile Container are set in **HKLM\\SOFTWARE\\Policies\\FSLogix\\ODFC**.

 -  [Full Office Container Registry Settings Reference](/fslogix/office-container-configuration-reference)
 -  [Create a Group Policy Object](/windows/security/threat-protection/windows-firewall/create-a-group-policy-object)

These settings are required to enable Office Container and to specify the location for the profile VHD to be stored. The minimum required settings to enable Office Container are:

| **Value**                       | **Type**             | **Configured Value** | **Description**                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------------------- | -------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Enabled (required setting)      | DWORD                | 1                    | 0: Profile Containers disabled. 1: Profile Containers enabled                                                                                                                                                                                                                                                                                                                                              |
| VHDLocations (required setting) | MULTI\_SZ or REG\_SZ |                      | A list of file system locations to search for the user's profile VHD(X) file. If one isn't found, one will be created in the first listed location. If the VHD path doesn't exist, it will be created before it checks if a VHD(X) exists in the path. These values can contain variables that will be resolved. When specified as a REG\_SZ value, multiple locations can be separated with a semi-colon. |

:::image type="content" source="../media/office-container-config-1-7b5ef71f.png" alt-text="Screenshot showing the Office Containers Registry Configuration.":::


## Set up Include and Exclude User Groups<br>

There are often users, such as local administrators that have profiles that should remain local. During installation, four user groups are created to manage users who's profiles are included and excluded from Profile Container and Office Container redirection.

:::image type="content" source="../media/fslogix-excludegroups-3-cec6f3f2.png" alt-text="Screenshot of the exclude lists for folder containers.":::


By default **Everyone** is added to the **FSLogix ODFC Include List** group.

:::image type="content" source="../media/office-container-include-4-3e9f0e89.png" alt-text="Screenshot of the FSLogix include list properties for Outlook data folder containers.":::


Adding a user to the **FSLogix ODFC Exclude List** group means that the FSLogix agent won't attach a FSLogix office container for the user. In the case where a user is a member of both the exclude and include groups, exclude takes priority.

:::image type="content" source="../media/office-container-exclude-5-f756ec43.png" alt-text="Screenshot of the exclude list for members in the group.":::


Office Containers is now configured and ready to be used. To verify Office Container is working, sign in as a user included in the **Include List** group. Using **File Manager**, navigate to the location specified in VHDLocations. Verify a folder, with the user name and SID has been created.

:::image type="content" source="../media/validate-container-6-3c437172.png" alt-text="Screenshot of the Office Container in the ProfileFolder .":::


## Configure third-party exclusions

When the FSLogix Office Container is used with any other profile solution, exclusions must be configured. The folders listed below must be excluded from handling by the third-party profile solution, or errors may occur. It isn't necessary to configure exclusions when Office Container with local profiles.

### OneDrive

Exclude profile solution (except FSLogix Profile Container) syncing for the directories (and subdirectories) seen below:

 -  `Users<Username><OneDrive folder name>`
     -  The folder name depends on your Office 365 subscription, so it isn't a fixed name. If you have a question what this folder name is, set `HKLM\Software\FSLogix\Logging\LoggingEnabled = 2` and sign out and back on.
     -  Look in`c:\programdata\fslogix\logs\odfc<find file with todays date>`. In the log file, search for "OneDrive folder is" and you'll see which folder needs to be excluded.
 -  `Users<Username>\AppData\Local\Microsoft\OneDrive`

These exclusions fix the following warning found in the FSLogix Profile log when users **logon: "`<name>`** isn't your original OneDrive folder"

### Outlook

Exclude the directory (and subdirectories) listed below:

 -  `\Users\<username>\AppData\Local\Microsoft\Outlook`
