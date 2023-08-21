

After you've added an app to Microsoft Intune, you can assign the app to users and devices. It's important to note that you can deploy an app to a device whether or not the device is managed by Intune.

> [!IMPORTANT]
> The **Available for enrolled devices** deployment intent is supported for **user groups** and **device groups** when targeting Android Enterprise fully managed devices (COBO) and Android Enterprise corporate-owned personally-enabled (COPE) devices.

The following table lists the various options for assigning apps to users and devices:

| Option                                                       | Devices enrolled with Intune | Devices not enrolled with Intune |
|--------------------------------------------------------------|------------------------------|----------------------------------|
| Assign to users                                              | Yes                          | Yes                              |
| Assign to devices                                            | Yes                          | No                               |
| Assign wrapped apps or apps that incorporate the Intune SDK  | Yes                          | Yes                              |
| Assign apps as Available                                     | Yes                          | Yes                              |
| Assign apps as Required                                      | Yes                          | No                               |
| Uninstall apps                                               | Yes                          | No                               |
| Receive app updates from Intune                              | Yes                          | No                               |
| End users install available apps from the Company Portal app | Yes                          | No                               |
| End users install available apps from the web-based Company Portal | Yes                      | Yes                              |

> [!NOTE]
> Currently, you can assign iOS/iPadOS and Android apps (line-of-business and store-purchased apps) to devices that aren't enrolled with Intune.
> To receive app updates on devices that aren't enrolled with Intune, device users must go to their organization's Company Portal and manually install app updates.
> For almost all app types and platforms, Available assignments are only valid when assigning to user groups, not device groups. Win32 apps can be assigned to either user or device groups.
> If managed Google Play pre-production track apps are assigned as required on Android Enterprise personally-owned work profile devices, they will not install on the device. To work around this, create two identical user groups and assign the pre-production track as "available" to one and "required" to the other. The result will be that the pre-production track successfully deploys to the device.

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/).
1. Select **Apps** > **All apps**.
1. In the **Apps** pane, select the app you want to assign
1. In the **Manage** section of the menu, select **Properties**.
1. Scroll down to **Properties** and select **Assignments**.
1. Select **Add Group** to open the **Add group** pane that is related to the app.
1. Select Add Group to open the Add group pane that is related to the app.
    - Available for enrolled devices: Assign the app to groups of users who can install the app from the Company Portal app or website.
    - Available with or without enrollment: Assign this app to groups of users whose devices aren't enrolled with Intune. Users must be assigned an Intune license, see [Intune Licenses](/mem/intune/fundamentals/licenses).
    - Required: The app is installed on devices in the selected groups. Some platforms may have other prompts for the end user to acknowledge before app installation begins.
    - Uninstall: The app is uninstalled from devices in the selected groups if Intune has previously installed the application onto the device via an "Available for enrolled devices" or "Required" assignment using the same deployment.
        > [!NOTE]
        > For iOS/iPadOS apps only:
        >  - To configure what happens to managed apps when devices are no longer managed, you can select the intended setting under Uninstall on device removal. For more information, see [App uninstall setting for iOS/iPadOS managed apps](/mem/intune/apps/apps-deploy#app-uninstall-setting-for-ios-managed-apps).
        >  - If you have created an iOS/iPadOS VPN profile that contains per-app VPN settings, you can select the VPN profile under VPN. When the app is run, the VPN connection is opened. For more information, see [VPN settings for iOS/iPadOS devices](/mem/intune/configuration/vpn-settings-ios).
        >  - To configure whether a required iOS/iPadOS app is installed as a removable app by end users, you can select the setting under Install as removable.
        >  ### For Android apps only: 
        >  - If you deploy an Android app as Available with or without enrollment, reporting status will only be available on enrolled devices.
        >  ### For Available for enrolled devices:
        >  - The app is only displayed as available if the user logged into the Company Portal is the primary user who enrolled the device and the app is applicable to the device.
1. To select the groups of users that are affected by this app assignment, select **Included Groups**.
1. After you've selected one or more groups to include, select **Select**.
1. In the **Assign** pane, select **OK** to complete the included groups selection.
1. If you want to exclude any groups of users from being affected by this app assignment, select **Exclude Groups**.
1. If you have chosen to exclude any groups, in Select **groups**, select **Select**.
1. In the **Add group pane**, select **OK**.
1. In the app **Assignments** pane, select **Save**.

The app is now assigned to the groups that you selected.

> [!TIP]
>Intune supports assigning apps to nested groups too. For example, if you assigned an app to the "Engineering Global" group and have "Engineering APAC", "Engineering EMEA" and "Engineering US" nested as child groups, the members of those child groups will also be targeted with the assignment.