

Intune may not have all the built-in settings you need or want. In other situations, you may want to use a setting available in other device profiles. To add these settings, create a device profile, and configure the profile with custom device settings. If you're looking for a specific Windows setting, remember that the Windows device restriction profile contains many settings that are built into Intune, and don't require custom values. Furthermore, new functionality is added to Intune frequently so you should always check to see if the setting you need is available as a native Intune setting.

#### Create a custom profile for Windows 10 and later devices

Use the Microsoft Intune custom profile for Windows 10 and later to deploy Open Mobile Alliance Uniform Resource Identifier (OMA-URI) values. These settings are used to control features on devices. Windows makes many Configuration Service Provider (CSP) settings available, such as Policy CSP.

1.  In the Microsoft Intune admin center, create a device profile for Windows 10 and later as described in the previous unit, selecting **Custom** as the profile type.
2.  On the Configuration tab, in Custom OMA-URI Settings, select **Add** to create a new setting. You can also select **Export** to create a list of all the values you configured in a comma-separated values (.csv) file.
3.  For each OMA-URI setting you want to add, enter the following information:
    
     -  **Name**: Enter a unique name for the OMA-URI setting to help you identify it in the list of settings.
     -  **Description**: Optionally, enter a description for the setting.
     -  **OMA-URI** (case sensitive): Enter the OMA-URI for which you want to supply a setting.
     -  **Data type**: Choose from:
        
         -  String
         -  String (XML)
         -  Date and time
         -  Integer
         -  Floating point
         -  Boolean
         -  Base64
     -  **Value**: Enter the value or file to associate with the OMA-URI you entered.
4.  When you're done, select **OK**. In Create profile, select **Create**. The profile is created, and is shown in the profiles list.

#### Example

In the following example for Windows, the **Connectivity/AllowVPNOverCellular** setting is enabled. This setting allows a Windows device to open a VPN connection when on a cellular network.

:::image type="content" source="../media/custom-profile-1c31fa8a.png" alt-text="Screenshot of the create profile screen, with Settings tab selected and Custom OMA-URI Settings window shown.":::


Not all settings are compatible with all Windows versions. The configuration service provider reference tells you which versions are supported for each CSP. Additionally, Intune doesn't support all the settings listed. To find out if Intune supports the setting you want, open the article for that setting. Each setting page shows its supported operation. To work with Intune, the setting must support the Add or Replace operations.

#### Create a custom profile for Android devices

Like Windows, Android Enterprise custom profiles use OMA-URI settings to control features on Android Enterprise devices. The steps for creating a custom Android profile are identical to creating a Windows custom profile, instead creating the profile under the Android platform.

Intune supports the following limited number of Android Enterprise custom profiles:

 -  Create a Wi-Fi profile with a pre-shared key: `./Vendor/MSFT/WiFi/Profile/SSID/Settings`
 -  Create a per-app VPN profile: `./Vendor/MSFT/VPN/Profile/Name/PackageList`
 -  Restrict copy and paste actions between work and personal apps on Android Enterprise devices: `./Vendor/MSFT/WorkProfile/DisallowCrossProfileCopyPaste`

Only the settings listed can be configured by this profile type. Android devices don't expose a complete list of OMA-URI settings you can configure.

In addition to custom settings, you can use OEMConfig to add, create, and customize OEM-specific settings for Android Enterprise devices. OEMConfig is typically used to configure settings that aren't built in to Intune. Different original equipment manufacturers (OEM) include different settings. The available settings depend on what the OEM includes in their OEMConfig app.

#### Create a custom profile for Apple devices

Use the Microsoft Intune iOS/iPadOS or macOS custom profile to assign settings that you created by using the Apple Configurator tool to Apple devices. This tool lets you create many settings that control the operation of these devices and export them to a configuration profile. You can then import this configuration profile into an Intune iOS/iPadOS/macOS custom profile and assign the settings to users and devices in your organization.

This capability allows you to assign settings that aren't configurable with other Apple device profile types in Intune.

1.  In the Microsoft Intune admin center, create a device profile for iOS/iPadOS or macOS as described in the previous unit, selecting **Custom** as the profile type.
2.  On the Custom Configuration Profile pane, configure each of the following settings:
    
     -  **Custom configuration profile name**: Provide a name for the policy as displayed on the device, and in Intune status.
     -  **Configuration profile file**: Browse to the configuration profile that you created by using the Apple Configurator. Ensure that the settings you export from the Apple Configurator tool are compatible with the version of the OS on the devices to which you assign the custom policy. For information about how incompatible settings are resolved, search for Configuration Profile Reference and Mobile Device Management Protocol Reference on the Apple Developer website.
