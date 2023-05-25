

Intune includes some features in the Microsoft Intune admin center to help monitor and manage your device configuration profiles. For example, you can check the status of a profile, see which devices are assigned to it, and update the properties of a profile.

### View existing profiles

Complete the following steps to view existing profiles:

1.  In the Microsoft Intune admin center, select **Devices**.
2.  On the **Devices overview** page, select **Monitor** , then select **Assignment status**.

All your existing profiles are listed, which includes details such as the platform, and shows if the profile is assigned to any devices.

### View details on a profile

After you create your device profile, Intune provides graphical charts. These charts display the status of a profile, such as it being successfully assigned to devices, or if the profile shows a conflict.

1.  Select an existing profile and select the **Overview** tab. The top graphical chart shows the number of devices assigned to the specific device profile. For example, if the configuration device profile applies to Windows 10 and later devices, the chart lists the count of the Windows 10 and later devices. It also shows the number of devices for other platforms that are assigned the same device profile. In the example, it shows the count of the non-Windows 10 and later devices.
    
    :::image type="content" source="../media/intune-profile-assignment-status-2f5eb053.png" alt-text="Screenshot of two charts. Top chart titled, Profile assignment status - Windows 10 and later devices.":::
    
    
    The second graphical chart shows the number of users assigned to the specific device profile. For example, if the configuration device profile applies to Windows 10 and later users, the chart lists the count of the Windows 10 and later users.
2.  Select the circle in the top graphical chart. The **Device status** opens. The devices assigned to the profile are listed, and it shows if the profile is successfully deployed. Also note that it only lists the devices with the specific platform (for example, Windows 10 and later devices). Close the Device status details.
3.  Select the circle in the bottom graphical chart. The **User status** opens. The users assigned to the profile are listed, and it shows if the profile is successfully deployed. Also note that it only lists the users with the specific platform (for example, Windows 10 and later devices). Close the User status details.
4.  Back in the **Profiles** list, select a specific profile. You can also change existing properties:
    
     -  **Properties.** Change the name or update any existing settings.
     -  **Assignments.** Include or exclude devices that the policy should apply. Choose **Selected Groups** to choose specific groups.
     -  **Device status.** The devices assigned to the profile are listed, and it shows if the profile is successfully deployed. You can select a specific device to get even more details, including the installed apps.
     -  **User status.** Lists the user names with devices impacted by this profile, and if the profile successfully deployed. You can select a specific user to get even more details.
     -  **Per-setting status.** Filters the output by showing the individual settings within the profile and shows if the setting is successfully applied.

### View conflicts

In **Devices** >**All devices**, you can see any policy settings that are causing a conflict. When there's a conflict, you're also shown all the configuration profiles that contain this setting. Administrators can use this feature to help troubleshoot and fix any discrepancies with the profiles.

1.  In the Microsoft Intune admin center, select **Devices** >**All Devices**, and then select an existing device in the list. An end user can get the device name from their Company Portal app.
2.  Select **Device configuration**. All configuration policies that apply to the device are listed.
3.  Select the policy. It shows you all the settings in that policy that apply to the device. If a device has a Conflict state, select that row. In the new window, you see all the profiles, and the profile names that have the setting causing the conflict.

Now that you know the conflicting setting and the policies that include that setting, it should be easier to resolve the conflict.
