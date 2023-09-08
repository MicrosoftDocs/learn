The Microsoft Store for Business platform enables you to procure apps for your organization, either individually or in bulk. You can manage apps procured in volume from the portal by linking the store to Microsoft Intune. This includes the ability to:
- Synchronize the list of purchased (or free) apps from the store with Intune.
- View the synchronized apps in the Microsoft Intune admin center and assign them like any other app.
- Synchronize both Online and Offline licensed versions of apps to Intune, with the app names being appended with "Online" or "Offline" in the portal.
- Monitor the number of licenses available and being used in the admin center.
- Prevent the assignment and installation of apps if there are insufficient licenses available.
- Revoke app licenses for apps managed by Microsoft Store for Business if the user is deleted from Azure AD.

>[!IMPORTANT]
>The retirement of the Microsoft Store for Business and the Microsoft Store for Education, originally scheduled for March 31, 2023, has been postponed. 
>
>In April 2023 we will begin ending support for the Microsoft Store for Business experience in Intune. This will occur in several stages:
>
>- On April 30, 2023, Intune will disconnect Microsoft Store for Business services. Microsoft Store for Business and Education apps will no longer be able to sync with Intune and the connector page will be removed from the Intune admin center.
>- On June 15, 2023, Intune will stop enforcing online and offline Microsoft Store for Business and Education apps on devices. Downloaded applications will remain on the device with limited support. Users may still be able to access the app from their device, but the app will no longer be managed. Existing synced Intune app objects will remain to allow admins to view the apps that had been synced and their assignments. Additionally, you will no longer be able to sync apps via the Microsoft Graph API syncMicrosoftStoreForBusinessApps and related API properties will display stale data.
>- On September 15, 2023, Microsoft Store for Business and Education apps will be removed from the Intune admin center. Apps on the device will remain until intentionally removed. The Microsoft Graph API microsoftStoreForBusinessApp will no longer be available about a month later.

>[!IMPORTANT]
>There are key improvements to the most recent Microsoft Store apps functionality over legacy functionality. Specifically, the following differences:
>
>- You can browse and search for store apps within Intune
>- You can monitor the installation progress and results for store apps
>- Win32 store apps are supported (in preview)
>- System context and user context are supported for UWP apps


## Prerequisites
To use Microsoft Store apps, be sure the following criteria are met:

- Client devices must support at least two core processors to successfully install and run Microsoft Store apps.
- Client device need to be able to support the [Intune Management Extension (IME)](/mem/intune/apps/intune-management-extension) to install Microsoft Store apps.
- Client device need access to the Microsoft Store and the destination content to install Microsoft Store apps.