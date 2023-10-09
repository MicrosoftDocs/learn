

When you enable Enterprise State Roaming, your organization is automatically granted a free, limited-use license for Azure Rights Management protection from Azure Information Protection. This free subscription is limited to encrypting and decrypting enterprise settings and application data synced by Enterprise State Roaming. You must have a paid subscription to use the full capabilities of the Azure Rights Management service.

#### To enable Enterprise State Roaming

1.  Sign in to the Azure portal.
2.  Select **Azure Active Directory** > **Devices** > **Enterprise State Roaming**.
3.  Select either **All** or **Selected** next to **Users may sync settings and app data across devices**.:::image type="content" source="../media/azure-enterprise-state-roaming-6ca7af98.png" alt-text="Screenshot of the Devices - Enterprise State Roaming screen.":::
    

For a Windows device to use the Enterprise State Roaming service, the device must authenticate using an Azure AD identity. For devices that are joined to Azure AD, the user’s primary sign-in identity is their Azure AD identity, so no additional configuration is required. The IT admin must Configure Hybrid Azure Active Directory joined devices for devices that use on-premises Active Directory.

#### What data roams?

**Windows settings**: the PC settings that are built into the Windows operating system. Generally, these are settings that personalize your PC, and they include the following broad categories:

 -  Theme, which includes features such as desktop theme and taskbar settings.
 -  Internet Explorer settings, including recently opened tabs and favorites.
 -  Passwords, including Internet passwords, Wi-Fi profiles, and others.
 -  Language preferences, which include settings for keyboard layouts, system language, date and time, and more.
 -  Ease of access features, such as high-contrast theme, Narrator, and Magnifier.
 -  Other Windows settings, such as mouse settings.

**Application data**: Universal Windows apps can write settings data to a roaming folder, and any data written to this folder will automatically be synced. It’s up to the individual app developer to design an app to take advantage of this capability.

#### Data storage

Enterprise State Roaming data is hosted in one or more Azure regions that best align with the country/region value set in the Azure Active Directory instance. Enterprise State Roaming data is partitioned based on three major geographic regions: North America, EMEA, and APAC. Enterprise State Roaming data for the tenant is locally located with the geographical region and isn't replicated across regions.

The country/region value is set as part of the Azure AD directory creation process and can't be subsequently modified.

#### View per-user device sync status

Follow these steps to view a per-user device sync status report.

1.  Sign in to the Azure portal.
2.  Select **Azure Active Directory** > **Users** > **All users**.
3.  Select the user, and then select **Devices**.
4.  Under **Show**, select **Devices syncing settings and app data** to show sync status.
5.  If there are devices syncing for this user, you see the devices shown here.

#### Data retention

Data synced to the Microsoft cloud using Enterprise State Roaming is retained until it’s manually deleted or until the data in question is determined to be stale.

#### Explicit deletion

Explicit deletion is when an Azure admin deletes a user or a directory or otherwise requests explicitly that data is to be deleted.

 -  **User deletion**: When a user is deleted in Azure AD, the user account roaming data is deleted after 90 to 180 days.
 -  **Directory deletion**: Deleting an entire directory in Azure AD is an immediate operation. All the settings data associated with that directory is deleted after 90 to 180 days.
 -  **On request deletion**: If the Azure AD admin wants to manually delete a specific user’s data or settings data, the admin can file a ticket with Azure support.

#### Stale data deletion

Data that hasn't been accessed for one year (“the retention period”) will be treated as stale and may be deleted from the Microsoft cloud. The retention period is subject to change but won't be less than 90 days. The stale data may be a specific set of Windows/application settings or all settings for a user. For example:

 -  If no devices access a particular settings collection (for example, an application is removed from the device, or a settings group such as “Theme” is disabled for all of a user’s devices), then that collection becomes stale after the retention period and may be deleted.
 -  If a user has turned off settings sync on all his/her devices, then none of the settings data will be accessed, and all the settings data for that user will become stale and may be deleted after the retention period.
 -  If the Azure AD directory admin turns off Enterprise State Roaming for the entire directory, then all users in that directory will stop syncing settings, and all settings data for all users will become stale and may be deleted after the retention period.

#### Deleted data recovery

The data retention policy isn't configurable. Once the data is permanently deleted, it’s not recoverable. However, the settings data is deleted only from the Microsoft cloud, not from the end-user device. If any device later reconnects to the Enterprise State Roaming service, the settings are again synced and stored in the Microsoft cloud.
