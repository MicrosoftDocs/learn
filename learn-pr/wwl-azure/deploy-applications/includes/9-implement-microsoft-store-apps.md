Deploying applications to devices can be challenging for administrators, especially when dealing with many devices. The process can be time-consuming, complex, and prone to errors. The challenges may include the following:
- Managing multiple versions of the same app.
- Ensuring app compatibility with different devices.
- Managing licenses for each app.

Furthermore, manually updating each device can be a tedious and time-consuming task. However, using Microsoft Store apps with Intune can simplify the process by providing a centralized platform to manage app deployment and updates. This integration enables administrators to easily browse, deploy, and manage apps for all devices enrolled in their organization. The automatic app update feature also eliminates the need for manual updates, reducing the burden on administrators. Additionally, Intune provides granular controls for managing app assignment and licensing, ensuring that only authorized users have access to specific apps. In summary, using Microsoft Store apps with Intune simplifies deploying and managing apps, reducing the workload on administrators and ensuring a streamlined and efficient app management process.

Let us examine the necessary steps for adding and deploying a Microsoft Store app.

## Step 1: Add an app from the Microsoft Store
1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select Apps > All apps > Add.
1. In **Select app** type pane, select **Microsoft Store app** (new) under the **Store app** section.
1. Choose **Select** at the bottom of the page to begin creating an app from the Microsoft Store. The app creation experience has three steps:
    - App information
    - Assignments
    - Review + create

## Step 2: Search the Microsoft Store
The Microsoft Store provides a large variety of apps designed to work on your Microsoft devices. Within Intune, you can search and add the apps you want to assign to your workforce at your organization.
1. Select **Search the Microsoft Store app** to display the search panel which features a search bar and includes the following columns:
    - **Name** – The name of the app.
    - **Publisher** – The publisher of the app.
    - **Type** – The app package type: Win32 or Universal Windows Platform (UWP).
1. In the search bar, type the name of the app that you want to find. You can also search by other app details, such as publisher, type, or store app ID. Once you search, a list of apps are displayed.
    > [!NOTE]
    >Specific Microsoft Store apps may not be displayed and available in Intune. Common reasons an app doesn't appear when searching within Intune include the following:
    > 
    > - The app is not available in your region.
    > - The app is not available if there is an age restriction.
    > - The app is a paid app, which is not supported.
    > - The app is an Android app.
    > - The app is a Microsoft Store for Business app that is not available publicly in the consumer store.
1. Choose the app that you want to deploy and click Select. The app information is presented with the selected app’s metadata. Specific fields are pre-populated.
The following table shows the fields that are supported:

    | Name of the field                                 | Description | Required                                 |
    | ------------------------------------------------- | ----------- | ---------------------------------------- |
    | Name                                              |The name of the app is pre-populated from the store’s metadata and you have the choice to edit the field. Enter the name of the app as it appears in the Company Portal. Make sure all app names that you use are unique. If the same app name exists twice, only one of the apps appears in the company portal.| Required                                 |
    | Description                                       |The description of the app is pre-populated from the store’s metadata and you have the choice to edit the field. The description appears in the Company Portal.| Required                                 |
    | Publisher                                         |The publisher of the app is pre-populated from the store’s metadata and you have the choice to edit the field.| Required                                 |
    | Installer Type                                    |The installer type of the application package is distinguished by either the UWP or Win32 installer types. For related information, see [Universal Windows Platform (UWP) apps](/windows/uwp/get-started/universal-application-platform-guide).| N/A Pre-filled                           |
    | Package Identifier                                |The app’s unique ID in the Microsoft Store. This value is read-only and is displayed before Installer Type in the UI.| N/A Pre-filled                           |
    | Install behavior                                  |The install behavior of the app. If the app to be installed has the option of either System or User install behaviors, you must ensure that the installation works on devices as expected. **NOTE:** If the option is greyed out, the specific store application only supports the selected install behavior.| Admin must select **System** or **User** |
    | Category                                          |Optionally, select one or more of the built-in app categories, or select a category that you created. Categories make it easier for users to find the app when they browse through the Company Portal.| Optional                                 |
    | Show this as a featured app in the Company Portal |Display the app prominently on the main page of the company portal when users browse for apps.| Admin must select **System** or **User** |
    | Information URL                                   |Optionally, enter the URL of a website that contains information about this app. The URL appears in the company portal.| Optional                                 |
    | Privacy URL                                       |Optionally, enter the URL of a website that contains privacy information for this app. The URL appears in the company portal.| N/A Pre-filled                           |
    | Developer                                         |Optionally, enter the name of the app developer.| Optional                                 |
    | Owner                                             |Optionally, enter a name for the owner of this app. An example is **HR department**.| Optional                                 |
    | Notes                                             |Enter any notes that you want to associate with this app.| Optional                                 |
    | Logo                                              |Upload an icon that is associated with the app. This icon is displayed with the app when users browse through the company portal.| Optional                                 |
1. Select Next after you have finished populating the fields.

## Step 3: Creating assignments
You can choose how you want to assign Microsoft Store apps to users and devices.

The following table provides assignment type details:

|Assignment type|Assignment options|Description|
|---------------|------------------|-----------|
|Required|Add group, Add all users, Add all devices|The app is installed on devices in the selected groups.|
|Available for enrolled devices|Add group, Add all users|Users install the app from the Company Portal app or the Company Portal website.|
|Uninstall|Add group, Add all users, Add all devices|The app is uninstalled from devices in the selected groups.|

1. Select **Add group** and assign the groups that will use this app.
1. On the **Select groups** pane, select groups to assign based on users or devices.
1. After you select your groups, choose whether to set **End user notifications**, **Restart grace period**, and **Installation deadline**.
1. If you don't want the app assignment to affect groups of users, select Included under the **Filter mode** column. In the **Edit assignment** pane, change the Filter mode value from **Included** to **Excluded**. Select **OK** to close the **Edit assignment** pane.
1. Select **Next** to display the **Review + create** page after you finish setting the assignments for the apps.

## Step 4: Review and create

1. Review the values and settings that you entered for the app. Verify that you configured the app information correctly.
1. Select **Create** to add the app to Intune.