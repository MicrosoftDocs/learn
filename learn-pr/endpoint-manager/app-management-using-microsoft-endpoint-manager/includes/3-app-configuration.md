App configuration policies can help you eliminate app setup up problems by letting you select configuration settings for a policy. That policy is then assigned to end users before they run a specific app. The settings are then supplied automatically when the app is configured on the end user's device. End users don't need to take action. The configuration settings are unique for each app. 

You can create and use app configuration policies to provide configuration settings for both iOS/iPadOS or Android apps. These configuration settings allow an app to be customized by using app configuration and management. The configuration policy settings are used when the app checks for these settings, typically the first time the app is run. 

An app configuration setting, for example, might require you to specify any of the following details:
- A custom port number
- Language settings
- Security settings
- Branding settings such as a company logo

If end users were to enter these settings instead, they could do this incorrectly. App configuration policies can help provide consistency across an enterprise and reduce helpdesk calls from end users trying to configure settings on their own. By using app configuration policies, the adoption of new apps can be easier and quicker.

The available configuration parameters are ultimately decided by the developers of the app. Documentation from the application vendor should be reviewed to see if an app supports configuration and what configurations are available. For some applications, Intune will populate the available configuration settings.

For more information about app configuration, see [App configuration policies for Microsoft Intune](https://docs.microsoft.com/mem/intune/apps/app-configuration-policies-overview?azure-portal=true) and [Plan for and configure application management in Configuration Manager](https://docs.microsoft.com/mem/configmgr/apps/plan-design/plan-for-and-configure-application-management?azure-portal=true).