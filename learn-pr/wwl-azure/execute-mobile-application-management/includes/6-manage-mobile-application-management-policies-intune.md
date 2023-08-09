

You can monitor the compliance status of the MAM policies that you've applied to users at the Intune app protection pane in the Azure portal. You can find information about the users affected by the MAM policies, its compliance status, and any issues that your users might be experiencing.

There are three different places to monitor the compliance status:

 -  Summary view
 -  Detailed view
 -  Reporting view

#### Summary view

1.  Sign in to the **Microsoft Intune admin center**.
2.  Select **Apps** > **Monitor** > **App protection status**.
    
    :::image type="content" source="../media/intune-mobile-application-management-summary-3d01f139.png" alt-text="Screenshot of the Intune app protection pane, Summary view screen.":::
    

 -  **Assigned Users**: The total number of users in your company who are using an app that is associated with a policy in a work context.
 -  **Flagged users**: The number of users who are experiencing issues with their devices.
 -  **User status for iOS** and **User status for Android**: The number of users, by platform, who have used an app who has a policy assigned to them in a work context. The **No Policy** count represents the number of users who are using an app that isn't targeted by any policy in a work context. You might consider adding these users to the policy.
 -  **Top Protected iOS/iPadOS Apps** and **Top Protected Android Apps**: Based on the most used, this information shows the number of protected and unprotected apps by platform.
 -  **Top Configured iOS/iPadOS Apps Without Enrollment** and **Top Configured Android Apps Without Enrollment**: Based on the most used apps for unenrolled devices, this information shows the number of configured apps by platform (as in, using an app configuration policy).

#### Detailed view

You can get to the detailed view from the summary view by choosing the User status tile (based on device OS platform), and the **Flagged users** tile.

#### User status

You can search for a single user and check the compliance status for that user. The App reporting pane shows the following information for a selected user:

 -  Devices that are associated with the user account
 -  Apps with a MAM policy on the device
 -  Status:
    
     -  **Checked in**: The policy was deployed to the user, and the app was used in the work context at least once.
     -  **Not checked in**: The policy was deployed to the user, but the app hasn't been used in the work context since then.

To see a detailed report for a user, follow these steps:

1.  Sign into **Microsoft Intune admin center**.
2.  Select **Apps** > **Monitor** > **App protection status**.
3.  Select either the **User status for iOS** tile or the **User status for Android** tile.
4.  On the **App reporting** page, select **Select user** to search for an Azure AD user.
5.  Select a user from the list i.e **Debra Berger** and then select **Select**. You can see the user name, if the user has a license for Intune and details of the compliance status for that user:

:::image type="content" source="../media/intune-user-app-license-7b7d1c74.png" alt-text="Screenshot of the app reporting screen in the Intune app protection pane.":::


#### Reporting view

To view these reports, select **Apps** > **App protection status** > **Reports**. The Reports pane provides several reports based on user and app.

 -  **User report**. You can search for a single user and check the compliance status for that user. This report includes information such as the App name and status (whether it's up to date), devices associated with the account, platform and OS, associated app policies, and when the app was last synced with Intune.
 -  **App report** You can search by platform and app, and then this report will provide two different app protection statuses that you can select before generating the report. The statuses can be **Protected** or **Unprotected**.
    
     -  User status for managed MAM activity (Protected): This report outlines the activity of each managed MAM app, on a per-user basis. It shows all apps targeted by MAM policies for each user, and the status of each app as checked in with MAM policies. The report also includes the status of each app that was targeted with a MAM policy, but was never checked in.
     -  User status for unmanaged MAM activity (Unprotected): This report outlines the activity of MAM-enabled apps that are currently unmanaged, on a per-user basis. This might happen because:
        
         -  These apps are either being used by a user or an app that isn't currently targeted by a MAM policy.
         -  All apps are checked in, but aren't getting any MAM policies.
 -  **User configuration report** Based on a selected user, this report provides details about any app configurations the user has received.
 -  **App configuration report** Based on the selected platform and app, this report provides details about which users have received configurations for the selected app.