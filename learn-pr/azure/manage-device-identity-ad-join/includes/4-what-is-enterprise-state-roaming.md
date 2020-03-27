Your organization wants to improve the security of its devices. So far, you've seen how security is enhanced by using device identity and Azure AD join. But you need to maintain the security seamlessly when a user switches between devices. You want to see the options Azure offers to allow users to transition their accounts between devices. Users need to maintain data and settings without increasing technical overhead or maintenance.

Enterprise state roaming in Azure automatically synchronizes user and application data to the cloud. When a user joins a new device to your Azure Active Directory (Azure AD) organization, their data synchronizes from the cloud to their device. You can enable enterprise state roaming for individuals or groups.

In this unit, you'll learn about enterprise state roaming, how to enable it, where the user's application and settings data is stored, and how long the data is kept for.

## What is enterprise state roaming?

Enterprise state roaming offers Windows 10 device users the capability to sync settings and application data with their organization's cloud service. When it's enabled, synchronization takes place automatically. You can enable all applicable device users, or select specific users or groups based on your organization's needs. Enterprise state roaming allows users to switch devices, and for their settings and application data to follow them seamlessly.

Some of the key benefits of using enterprise state roaming are:

- Separation of corporate and consumer data.
- Enhanced security as all applicable device data is encrypted using Azure Rights Management before synchronizing with the cloud. All stored data remains encrypted.
- Better management and monitoring so you decide who can sync their data and from which devices.

Enterprise state roaming requires a Premium Azure Active Directory subscription.

## Enabling enterprise state roaming

Enterprise state roaming requires a device to authenticate with a known Azure AD identity. For Azure AD joined devices, this identity is the account the user first signed in with.

There are just a few steps to enable enterprise state roaming:

1. Sign in to the [Azure portal.](https://portal.azure.com/)
1. Select **Azure Active Directory** > **Devices** > **Enterprise State Roaming**.
1. For **Users may sync settings and app data across devices**, select **All** or **Selected**.

   ![Screenshot of enterprise state roaming options in the Azure portal.](../media/4-enable-enterprise-state-roaming.png)

   With **Selected**. you add the users or groups that will have enterprise state roaming available.

   ![Screenshot of enterprise state roaming options in the Azure portal.](../media/4-enterprise-state-roaming-selected.png)

## Data storage

Enterprise state roaming stores the user data in a geographical region that's nearest to your Azure AD instance. There are three geographic regions: North America (USA), Europe, the Middle East, and Africa (EMEA), and Asia-Pacific (APAC). While tenant data will be hosted within the nearest region, user data can be hosted on one or more of these regions. The country or region for your tenant is defined when the Azure AD is set up and can't be changed.

## Data retention

All enterprise state roaming data persists in the cloud until it's explicitly deleted, or becomes stale. Any deleted data is automatically kept for a minimum of 90 days. After 90 days, you can't restore the deleted data from the cloud.

### Explicit data deletion

Explicit data deletion occurs when an Azure Administrator acts on a user, an organization within Azure AD, or needs to request that specific roaming data is removed for a user.

- **User deletion**: When the administrator removes a user from Azure AD, any associated enterprise roaming data is automatically deleted.

- **Azure AD organization deletion**: When the administrator removes a directory, all user settings or data stored in that directory are automatically discarded.

- **On Request deletion**: Use this option to remove a specific user's roaming data. The administrator needs to raise an Azure support ticket for this option.

### Stale data deletion

Any enterprise state roaming data that hasn't been accessed during the past year is automatically treated as stale data. Stale data is deleted from the host cloud storage. The retention period of deleted data is 90 days.

### Deleted data recovery

After the retention period elapses, data is permanently deleted from the cloud and can't be recovered. But you can restore the data from the device when it next connects to the cloud.

The data retention periods can't be changed.
