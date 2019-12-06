Your organization is keen to improve the security of its devices. So far, you've seen how security is enhanced by using device identity and Azure AD join. But you need to maintain the security seamlessly when a user switches between devices. You want to see the options Azure offers to allow users to transition their accounts between devices. Users need to maintain data and settings without increasing technical overhead or maintenance.

Azure offers enterprise state roaming, a premium service that can be enabled for individuals or groups. Enterprise state roaming automatically synchronizes user data and application data to the cloud, applying them to a new device when the user joins it to your organization's Azure AD.

In this unit, you'll learn about enterprise state roaming, how to enable it, where the user's application and settings data is stored, and how long the data is kept for.

## What is enterprise state roaming?

Enterprise state roaming offers Windows 10 device users the capability to sync settings and application data with their organization's cloud service. When it's enabled, synchronization takes place automatically. You can enable all applicable device users, or select specific users or groups based on your organization's needs. Enterprise state roaming allows users to switch devices, and for their settings and application data to follow them seamlessly.

Some of the key benefits of using enterprise state roaming are:

- Separation of corporate and consumer data
- Enhanced security as all applicable device data is encrypted using Azure Rights Management before synchronizing with the cloud. All stored data remains encrypted
- Better management and monitoring so you decide who can sync their data and from which devices

Enterprise state roaming requires a Premium Azure Active Directory subscription.

## Enabling enterprise state roaming

To enable enterprise state roaming, you'll need to access the **Azure AD admin center**. This area isn't accessible from your standard Azure portal.

Enterprise state roaming requires the device to authenticate with a known Azure AD identity. For Azure AD joined devices, this identity will be the account the user first signed in with.

Follow these steps to enable enterprise state roaming:

1. Sign in to the [**Azure AD admin center**.](https://aad.portal.azure.com/)
1. Select **Azure Active Directory** > **Devices** > **Enterprise State Roaming**.
1. Select **Users may sync settings and app data across devices**. You can select 'All', 'Selected', or 'None'. 'Selected' asks you to nominate the users or groups who will use enterprise state roaming.

## Data storage

Enterprise state roaming stores the user data in a geographical region that's nearest to your Azure AD instance. There are three geographic regions: North America (USA), Europe, the Middle East, and Africa (EMEA), and Asia-Pacific (APAC). While tenant data will be hosted within the nearest region, user data can be hosted on one or more of these regions. The country or region for your tenant is defined when the Azure AD is set up and can't be changed.

## Data retention

All enterprise state roaming data persists in the cloud until it's explicitly deleted, or becomes stale. Any deleted data is automatically kept for a minimum of 90 days, after which it can't be restored.

### Explicit data deletion

Explicit data deletion occurs when an Azure Admin acts on a user, a directory within the Azure AD, or needs to request that specific roaming data is removed for a user.

**User deletion from the AD**. When the administrator removes a user from the Azure Active Directory, any associated enterprise roaming data is automatically deleted.

**AD directory deletion**. When the administrator removes a directory, all user settings or data stored in that directory are automatically discarded.

**On Request deletion**. Use this option to remove a specific user's roaming data. The administrator needs to raise an Azure support ticket for this option.

### Stale data deletion

Any enterprise state roaming data that hasn't been accessed during the past year is automatically treated as stale data. Stale data is deleted from host cloud storage. The retention period of deleted data will be no less than 90 days.

### Deleted data recovery

The data retention periods can't be changed. When the allotted retention period has elapsed, data is permanently deleted and can't be recovered. This situation only applies to the settings held in the cloud, not on the device. So if a device user whose settings were previously removed from the cloud were to sign in again, the settings would be synced back to the cloud.
