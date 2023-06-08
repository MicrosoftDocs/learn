

Intune application deployment procedures entail several considerations and settings to ensure that a deployment is successful. No matter what type of app you're deploying with Intune, the overall process is the same.

:::image type="content" source="../media/app-deployment-c52a07de.png" alt-text="Diagram of the app deployment steps with Intune.":::


To deploy an app from Intune, perform the following steps:

1.  **Ensure that Intune supports the app:** Make sure that Intune supports the application installation type and that the application can be installed without user intervention.
2.  **Create Azure AD groups for either users or devices:** In Intune, you create user-based or device-based groups to help you target software management tasks to specific users or devices. If you have a specific group of users that requires an application, create a user or device group for the app deployment. If you’re planning to deploy available installations, you also should link managed users to their computers to ensure that external links and company portal apps are available.
3.  **Add the app to Intune:** You must upload LOB apps to Intune cloud storage, specify a URL for web apps, or link a store app to Intune. For LOB apps, you must configure installation requirements, detection rules, command-line arguments, and provide general information about the app. Adding the app makes it available for deployment from the Apps section in the Microsoft Intune admin center console. Assign the app to user or device groups. When you create an application, you can assign the app to a set of users or devices. Once assigned, the app can either be installed by the user or, if the device is managed with Intune, the app can be automatically installed.
4.  **Configure policies:** You can manage application features and protect data by deploying app configuration and app protection policies.
5.  **Monitor the results of the app deployment:** You can monitor the status of app deployments and installations from the Intune console by viewing the details for any app that appears in the list of apps in your Client Apps blade. You can view the installation status for the app either by device or by user.

#### App categories

A common setting across app types is **Category**. When you add more than just a few apps, organizing apps in the Company Portal into groups is helpful for your users. Creating categories allows you to do this in a way that makes the most sense for your organization. There are already nine categories created for you in Intune. You can assign apps to one category, multiple categories, or no categories.

To create your own app categories in Intune, perform the following steps:

1.  On the **Apps** page, select **App categories** under **Other**.
2.  Select **Add**, and enter a name for the category in the **Name** field, and then select **Create**.

#### Assign apps

You can assign the app to users and devices either when adding the app to Intune or afterwards. Assigning apps makes them available for users to install or can cause the app to be installed automatically. You assign the apps to Azure AD groups, this can be either user groups or device groups; for each group, you choose an assignment type. The assignment type will differ depending on the app type you choose to assign.

When you assign apps by using Intune, you have the following options in the **Assignments** tab:

 -  **Available**. The app is available in the Company Portal, and users can install the app.
 -  **Not Applicable**. The app doesn't install and doesn't appear in the Company Portal.
 -  **Required**. The app installs automatically on a device in the selected group.
 -  **Uninstall**. The app uninstalls automatically from a device in the selected group.
 -  **Available for enrolled devices**. The app is available to users who have devices enrolled in Intune.
 -  **Available with or without enrollment**. The app is available to users who don't have devices enrolled in Intune.

Although you assign apps to either devices or to users, the options for how you can assign them will depend on the enrollment status of the devices with Intune. The following table shows you the assignment options when a device is enrolled in Intune and when it isn't enrolled. It also shows the options users have, depending on the device enrollment.

| **Options**                                            | **Device enrolled in Intune** | **Device not enrolled in Intune** |
| ------------------------------------------------------ | ----------------------------- | --------------------------------- |
| Assign an app to a user                                | Yes                           | Yes                               |
| Assign an app to a device                              | Yes                           | No                                |
| Assign an app using the Intune SDK                     | Yes                           | Yes                               |
| Assign an app as Available                             | Yes                           | Yes                               |
| Assign an app as Required                              | Yes                           | No                                |
| Uninstall an app                                       | Yes                           | No                                |
| Receive app updates from Intune                        | Yes                           | No                                |
| User install of an app from the Company Portal app     | Yes                           | No                                |
| User install of an app from the Company Portal website | Yes                           | Yes                               |
