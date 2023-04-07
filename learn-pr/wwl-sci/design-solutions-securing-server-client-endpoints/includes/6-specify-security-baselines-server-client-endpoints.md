This unit will explore using security baselines to configure Windows devices in Intune.

Intune makes it easy to deploy Windows security baselines to help you secure and protect your users and devices.

Even though Windows and Windows Server are designed to be secure out-of-the-box, many organizations still want more granular control over their security configurations. To navigate the large number of controls, organizations often seek guidance on configuring various security features. Microsoft provides this guidance in the form of security baselines.

Security baselines are groups of pre-configured Windows settings that help you apply and enforce granular security settings that are recommended by the relevant security teams. You can also customize each baseline you deploy to enforce only those settings and values you require. When you create a security baseline profile in Intune, you're creating a template that consists of multiple _device configuration_ profiles.

To learn more about why and when you might want to deploy security baselines, see [Windows security baselines](https://learn.microsoft.com/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines) in the Windows security documentation.

This feature applies to:

-   Windows 10 version 1809 and later
-   Windows 11

You deploy security baselines to groups of users or devices in Intune, and the settings apply to devices that run Windows 10/11. For example, the _MDM Security Baseline_ automatically enables BitLocker for removable drives, automatically requires a password to unlock a device, automatically disables basic authentication, and more. When a default value doesn't work for your environment, customize the baseline to apply the settings you need.

Separate baseline types can include the same settings and use different default values for those settings. It's important to understand the defaults in the baselines you choose to use, and to then modify each baseline to fit your organizational needs.

In almost all scenarios, the default settings in the security baselines are the most restrictive. You should confirm that these settings don't conflict with other policy settings or features in your environment.

For example, the default settings for firewall configuration might not merge connection security rules and local policy rules with MDM rules. So, if you're using delivery optimization, then you should validate these configurations before assigning the security baseline.

Security baselines can help you to have an end-to-end secure workflow when working with Microsoft 365. Some of the benefits include:

-   A security baseline includes the best practices and recommendations on settings that impact security. Intune partners with the same Windows security team that creates group policy security baselines. These recommendations are based on guidance and extensive experience.
-   If you're new to Intune, and not sure where to start, then security baselines gives you an advantage. You can quickly create and deploy a secure profile, knowing that you're helping protect your organization's resources and data.
-   If you currently use group policy, migrating to Intune for management is much easier with these baselines. These baselines are natively built in to Intune, and include a modern management experience.
<!--
[](https://learn.microsoft.com/mem/intune/protect/security-baselines#available-security-baselines)
-->


## Available security baselines

The following security baseline instances are available for use with Intune. Use the links to view the settings for recent instances of each baseline.

-   **Security Baseline for Windows 10 and later**
    -   [November 2021](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-mdm-all?pivots=november-2021)
    -   [December 2020](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-mdm-all?pivots=december-2020)
    -   [August 2020](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-mdm-all?pivots=mdm-sept-2020)

-   **Microsoft Defender for Endpoint baseline**  
    _(To use this baseline your environment must meet the prerequisites for using [Microsoft Defender for Endpoint](https://learn.microsoft.com/mem/intune/protect/advanced-threat-protection#prerequisites))_.
    
    -   [Version 6](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-defender-atp?pivots=december-2020)
    -   [Version 5](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-defender-atp?pivots=atp-sept-2020)
    -   [Version 4](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-defender-atp?pivots=atp-april-2020)
    -   [Version 3](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-defender-atp?pivots=atp-march-2020)
       
-   **Microsoft Edge Baseline**
    
    -   [September 2020 (Edge version 85 and later)](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-edge?pivots-edge-sept-2020)
    -   [April 2020 (Edge version 80 and later)](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-edge?pivots-edge-april-2020)
    -   [Preview: October 2019 (Edge version 77 and later)](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-edge?pivots=edge-october-2019)
-   **Windows 365 Security Baseline**
    
    -   [October 2021](https://learn.microsoft.com/mem/intune/protect/security-baseline-settings-windows-365)

After a new version for a profile releases, settings in profiles based on the older versions become read-only. You can continue using those older profiles, including editing their name, description, and assignments, but you won't be able to edit settings for them or create new profiles based on the older versions.

When you're ready to use the more recent version of a baseline, you can create new profiles or update your existing profiles to the new version. See [Change the baseline version for a profile](https://learn.microsoft.com/mem/intune/protect/security-baselines-configure#change-the-baseline-version-for-a-profile) in the _Manage security baseline profiles_ article.
<!--
[](https://learn.microsoft.com/mem/intune/protect/security-baselines#about-baseline-versions-and-instances)
-->

## About baseline versions and instances

Each new version instance of a baseline can add or remove settings or introduce other changes. For example, as new Windows settings become available with new versions of Windows 10/11, the MDM Security Baseline might receive a new version instance that includes the newest settings.

In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), under **Endpoint security** > **Security baselines** you'll see a list of the available baselines. The list includes:

-   The baseline template name.
-   How many profiles you have that use that type of baseline.
-   How many separate instances (versions) of the baseline type are available.
-   A _Last Published_ date that identifies when the latest version of the baseline template became available.

To view more information about the baseline versions you use, select a baseline type, like _MDM Security Baseline_ to open its _Profiles_ pane, and then select **Versions**. Intune displays details about the versions of that baseline that are in use by your profiles. The details include the most recent and current baseline version. You can select a single version to view deeper details about the profiles that use that version.

You can choose to [change of the version](https://learn.microsoft.com/mem/intune/protect/security-baselines-configure#change-the-baseline-version-for-a-profile) of a baseline that's in use with a given profile. When you change the version, you don't have to create a new baseline profile to take advantage of updated versions. Instead you can select a baseline profile and use the built-in option to change the instance version for that profile to a new one.