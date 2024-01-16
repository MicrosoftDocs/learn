

As noted in the previous unit, many device profile types exist. Each platform has its own list of profile types. The process for creating device profiles is similar for all profiles.

To create a Windows device profile:

1.  In the Microsoft Intune admin center, select **Devices**, then select **Windows** platform, then select **Configuration Profiles**.
2.  Select **Create Profile**.
3.  Enter the following properties:
    
     -  **Platform**: Choose which versions of Windows to include.
     -  **Profile type**: Select the type you want to create.
    
:::image type="content" source="../media/intune-create-profile-ae036674.png" alt-text="This screenshot shows the Configuration profiles screen after the Create Profile button is selected. The Windows 10 and later platform has been selected, and is now prompting for a profile, with several options listed- Listed options include Administrative templates, custom, delivery optimization, device firmware configuration, Device restrictions, Domain Join, Edition Upgrade and switch, etc.":::
    

4.  Select **Create**.

Once you create the profile, you'll be prompted to configure the settings of the profile across several tabs.

 -  **Basics**. Define a name for the profile and a description
 -  **Configuration Settings**. The profile type you defined in step 3 will determine what options are here. For example, if you choose the Device Restrictions profile, you'll see several options such as which control panel options are available, Microsoft Edge configurations, or App Store restrictions. Choosing the WiFi profile will allow you to configure settings such as SSID and EAP settings.
 -  **Assignments**. The profile can be assigned to the following:
    
     -  Selected Groups
     -  All Users &amp; All Devices
     -  All Devices
     -  All Users
    
    Intune device configuration profiles let you exclude groups from policy assignment. For example, you can assign a device profile to the All sales users group, but exclude any members of the Sales Managers group. When you exclude groups from an assignment, exclude only users, or only exclude device groups (not a mixture of groups), Intune doesn't consider any user-to-device relationship. Including user groups while excluding device groups might not create the results you expect. When mixed groups are used, or if there are other conflicts, inclusion takes precedence over exclusion. For example, you want to assign a device profile to all devices in your organization, except kiosk devices. You include the All Users group, but exclude the All Devices group. In this case, all your users and their devices get the policy, even if the user’s device is part of the All Devices group. Exclusion only looks at the direct members of the groups, and doesn't include devices that are associated with a user. However, devices that don't have a user don't get the policy. This occurs because those devices have no relationship to the All Users group. If you include All Devices, and exclude All Users, then all the devices receive the policy. In this scenario, the intent is to exclude devices that have an associated user from this policy. However, it doesn't exclude the devices because the exclusion only compares direct group members.
 -  **Applicability Rules**. These rules allow further restriction of the profile assignment or exclusion specific OS versions or editions.
 -  **Review + create**. As the end of the process, a summary of the profile settings will be displayed, with the option to create the profile.
