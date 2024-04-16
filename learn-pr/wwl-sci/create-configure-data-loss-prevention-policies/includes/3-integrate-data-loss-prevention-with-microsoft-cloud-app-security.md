Data loss prevention (DLP) policies can be used for non-Microsoft cloud apps as part of the Microsoft Purview Data Loss Prevention features.

You can use DLP policies for non-Microsoft cloud apps to monitor and detect when sensitive data is used and shared via non-Microsoft cloud apps. Using these policies provides visibility and control that helps prevent risky behavior.

You can create DLP policies for non-Microsoft cloud apps in three ways:

- Create file policies in the Microsoft Defender for Cloud Apps portal
- Create file policies in the Microsoft Defender portal
- Create DLP policies in the Microsoft Purview compliance portal and specify Microsoft Defender for Cloud Apps as the location

File policies allow control of the actions you can execute in Microsoft Defender for Cloud Apps when a policy match is found. Whereas DLP policies allow you more control over non-Microsoft cloud apps. If you want more control over the SharePoint Online and OneDrive cloud apps, you should use the SharePoint Online or OneDrive portals.

You may need to activate the file monitoring in Defender for Cloud Apps before creating file policies. Perform the following steps to enable Defender for Cloud Apps to see files in the SaaS apps:

1. Navigate to the **Microsoft Defender for Cloud Apps** portal at [https://portal.cloudappsecurity.com](https://portal.cloudappsecurity.com/?azure-portal=true).

1. Select the cogwheel in the upper right and select **Settings**, the select **Settings** again.

1. Select **Files** from the **Information Protection** section.

1. Check **Enable file monitoring** if not checked already and select **Save**.

After selecting this setting, you can create file policies in Microsoft Defender for Cloud Apps.

To use the capabilities of the Microsoft Purview compliance portal to monitor non-Microsoft cloud apps, you need to connect these apps to Microsoft Defender for Cloud Apps. Afterwards they'll be available as instances in the Microsoft Defender for Cloud Apps location of your DLP policies. This is required to complete integration of Microsoft Defender for Cloud Apps into DLP.

If you don't select a specific instance the policy will apply to all connected apps.

When you create a rule in the DLP policy, you can select an action for non-Microsoft cloud apps. To restrict these apps, select **Restrict Third Party Apps**. You can choose various actions for every supported non-Microsoft cloud app. For every app, there are different possible actions depending on the cloud app API.

