App configuration policies can help you eliminate app setup problems by letting you select configuration settings for a policy. That policy is then assigned to end users before they run a specific app. The settings are then supplied automatically when the app is configured on the end user's device. End users don't need to take action. The configuration settings are unique for each app. 

You can create and use app configuration policies to provide configuration settings for both iOS/iPadOS or Android apps. These configuration settings allow you to customize an app by using app configuration and management. Use the configuration policy settings when the app checks for these settings, typically the first time you run the app.

An app configuration setting, for example, might require you to specify any of the following details:

- A custom port number
- Language settings
- Security settings
- Branding settings such as a company logo

If end users were to enter these settings instead, they could do it incorrectly. App configuration policies can help provide consistency across an enterprise and reduce helpdesk calls from end users trying to configure settings on their own. By using app configuration policies, the adoption of new apps can be easier and quicker.

Ultimately, the developers of the app decide the available configuration parameters. Documentation from the application vendor should be reviewed to see if an app supports configuration and what configurations are available. For some applications, Intune populates the available configuration settings.

For more information about app configuration, see [App configuration policies for Microsoft Intune](/mem/intune/apps/app-configuration-policies-overview?azure-portal=true) and [Plan for and configure application management in Configuration Manager](/mem/configmgr/apps/plan-design/plan-for-and-configure-application-management?azure-portal=true).