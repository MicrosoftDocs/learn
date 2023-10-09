

App protection policies can be applied to apps running on devices that may or may not be managed by Intune. In many organizations, it’s common to allow end users to use both Intune MDM managed devices, such as corporate owned devices, and un-managed devices protected with only Intune app protection policies, such as bring your own devices (BYOD).

Because Intune app protection policies are targeted to a user’s identity, the protection settings for a user typically apply to both enrolled (MDM managed) and non-enrolled devices (no MDM). Therefore, you can target an Intune app protection policy to either Intune enrolled or un-enrolled iOS and Android devices. You can create one protection policy for un-managed devices in which strict data loss prevention (DLP) controls are in place, and a separate protection policy for MDM managed devices, where the DLP controls may be a little more relaxed.

#### Create and assign app protection policies

Use the following steps to create an app protection policy:

1.  In the Microsoft Intune admin center, in the navigation pane, select **Apps**.
2.  In the **Policy** section, select **App protection policies**.
3.  Select **+ Create Policy** and select a platform.

Creating an app protection policy presents several tabs for configuration:

 -  **Basics**. Enter a name for the policy, add a brief description.
 -  **Apps**. Select which app types to target. With **Target to all app types** set to **Yes**, both **Apps on unmanaged devices** and **Apps on Intune managed devices** will be targeted. If you select **No** you can choose between unmanaged and Intune managed devices. The apps page also allows you to choose one or more apps from the list that you want to associate with the policy that you're creating. You must select at least one app to create a policy.
 -  **Data protection**. This tab provides settings that determine how users interact with data in the apps that this app protection policy applies. These settings define if apps can send or receive org data to and from other apps, and what type of apps (such as all apps or only policy managed apps). This page also includes several other configurations, including cloud backup restrictions, copy and paste restrictions, data encryption, and print restrictions.
 -  **Access Requirements**. Provides settings to allow you to configure the PIN and credential requirements that users must meet to access apps in a work context.
 -  **Conditional Launch**. Provides settings to set the sign-in security requirements for your app protection policy. This can include max pin attempts, grace periods or if the device is jailbroken, and what action should be taken (such as a PIN reset or blocking access) if the condition is true.
 -  **Assignments**. Assign the app protection policy to groups of users. Only users with assigned Microsoft Intune licenses are affected by the policy. Users in the selected security group that don’t have an assigned Intune license aren't affected.
 -  **Review + create**. Allows you to review the settings and create the policy.

#### Edit existing policies

You can edit an existing policy and apply it to the targeted users. However, when you change existing policies, users who are already signed in to the apps won’t see the changes for an 8-hour period. To see the effect of the changes immediately, the end user must log out of the app, and sign back in.

Even though the steps for creating an app protection policy for either Android or iOS are similar, there are changes in the various settings than can be chosen.