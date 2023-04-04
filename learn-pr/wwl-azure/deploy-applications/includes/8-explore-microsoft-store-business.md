
The Microsoft Store for Business platform enables you to procure apps for your organization, either individually or in bulk. You can manage apps procured in volume from the portal by linking the store to Microsoft Intune. This includes the ability to:
- Synchronize the list of purchased (or free) apps from the store with Intune.
- View the synchronized apps in the Microsoft Intune admin center and assign them like any other app.
- Synchronize both Online and Offline licensed versions of apps to Intune, with the app names being appended with "Online" or "Offline" in the portal.
- Monitor the number of licenses available and being used in the admin center.
- Prevent the assignment and installation of apps if there are insufficient licenses available.
- Revoke app licenses for apps managed by Microsoft Store for Business if the user is deleted from Azure AD.

>[!IMPORTANT]
>Microsoft Store for Business and Microsoft Store for Education will be retired in the first quarter of 2023. However, admins can still leverage the connection to Store for Business and Education from their UEM solution to deploy apps to managed Windows 11 devices until they are retired in 2023.

Starting March 31, 2023, Intune enables administrators to browse, deploy, and monitor Microsoft Store applications. Once deployed, the apps are automatically updated to the latest version by Intune. The Microsoft Store now supports various types of apps, including UWP apps, desktop apps packaged in `.msix`, and Win32 apps packaged in `.exe` or `.msi` installers.

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