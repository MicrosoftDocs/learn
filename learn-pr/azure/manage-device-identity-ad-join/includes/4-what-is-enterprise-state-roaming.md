Your organization is keen to improve the security of its devices. So far, you've seen how security can be improved through the use of device identity and Azure AD join. But you want to maintain the security seamlessly when a user transitions between devices. You want to see what options Azure offers to allow users to transition their accounts between devices and maintain their data and settings without increasing the technical overhead or maintenance.

Azure offers enterprise state roaming. Enterprise state roaming is a premium service that can be enabled for individuals or groups and automatically synchronizes user data and application data to the cloud and applies them to a new device when the user joins it to your organization's Azure AD.

In this unit, you'll learn about enterprise state roaming, how to enable it, where the user's application and settings data is stored, and finally, how long the data is kept for.

## What is enterprise state roaming

Enterprise state roaming offers Windows 10 device users the capability to sync their settings and application data with their organization's cloud service. Once enabled, synchronization takes place automatically. You can enable all applicable device users, or select specific users or groups based on your organization's needs. Enterprise state roaming allows your users to switch devices, and for their settings and application data to follow them seamlessly.

Some of the key benefits of using enterprise state roaming are:

- Separation of corporate and consumer data
- Enhanced security - All applicable device data is encrypted using Azure Rights Management before synchronizing with the cloud. All stored data remains encrypted.
- Better management and monitoring - you get to decide who can sync their data and from what devices.

Enterprise state roaming requires a Premium Azure Active Directory subscription.

## Enabling enterprise state roaming

To enable enterprise state roaming, you'll need to access the **Azure AD admin center**. This isn't accessible from your standard Azure portal.

Enterprise state roaming requires the device to authenticate with a known Azure AD identity. For Azure AD joined devices, this will be the account the user's first signed in with.

Follow these steps to enable enterprise state roaming.

1. Sign in to the [**Azure AD admin center**](https://aad.portal.azure.com/)
1. Select **Azure Active Directory** > **Devices** > **Enterprise State Roaming**
1. Select **Users may sync settings and app data across devices. You can select All, Selected, or None. Selected will ask you to nominate the users or groups that will use enterprise state roaming.

## Data storage

Enterprise state roaming stores the user data in a geographical region nearest to where your Azure AD instance is. There are three geographic regions: North America (USA), Europe, the Middle East, and Africa (EMEA), and Asia-Pacific (APAC). While the tenant data will be hosted within the nearest region, user data can be hosted on one or more of these regions. The country or region for your tenant is defined when the Azure AD Directory is set up and can't be changed.

## Data retention

All enterprise state roaming data persists in the cloud until either explicitly deleted, or it becomes stale. Any deleted data is automatically kept for a minimum of 90 days, after which it can't be restored.

### Explicit data deletion
  
Explicit data deletion is when an Azure Admin acts upon a user, a directory within the Azure AD, or needs to request specific roaming data is removed for a user.

- User deletion from the AD - When the administrator removes a user from the Azure Active Directory, any associated enterprise roaming data is automatically deleted.
- AD directory deletion - When the administrator removes a directory, all user settings, or data stored in that directory are automatically discarded.
- On Request deletion - Use this option when you want to remove specific users roaming data. Which requires the administrator to raise an Azure support ticket.

### Stale data deletion

  Any enterprise state roaming data that hasn't been accessed during the past year is automatically trodden as stale data. Stale data is deleted from host cloud storage. The retention period of deleted data will be no less than 90 days.

### Deleted data recovery

  The data retention periods aren't immutable. Once the allotted retention period has elapsed, the data is permanently deleted and can't be recovered. Which applies only to the settings held in the cloud and not to the device. So, if a device, whose settings were previously removed from the cloud were to sign in again, their settings would be synced to the cloud once more.
