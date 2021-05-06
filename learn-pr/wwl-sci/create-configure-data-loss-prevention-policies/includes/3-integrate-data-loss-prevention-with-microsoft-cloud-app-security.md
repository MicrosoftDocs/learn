Data loss prevention (DLP) policies can be used for non-Microsoft cloud apps as part of the Microsoft 365 DLP suite of features.

You can use DLP policies for non-Microsoft cloud apps to monitor and detect when sensitive data is used and shared via non-Microsoft cloud apps. Using these policies provides visibility and control that helps prevent risky behavior.

You can create DLP policies for non-Microsoft cloud apps in two ways:

- Create file policies in the cloud app security portal

- Create DLP policies in the Compliance center and specify Microsoft cloud app security as the location

File policies allow control of the actions you can execute in MCAS when a policy match is found. Whereas DLP policies allow you more control over non-Microsoft cloud apps. If you want more control over the SharePoint Online and OneDrive for Business cloud apps you should use the SharePoint Online or OneDrive for Business portals.

You may need to activate the file monitoring in MCAS before creating file policies. Perform the following steps to enable MCAS to see files in the SaaS apps:

1. Navigate to the **Cloud App Security** portal at [https://portal.cloudappsecurity.com](https://portal.cloudappsecurity.com/?azure-portal=true).

1. Select the cogwheel in the upper right and select **Settings**.

1. Select **Files** from the **Information Protection** section.

1. Check **Enable file monitoring** if not checked already and select **Save**.

After selecting this setting, you can create file policies in MCAS.

To use the capabilities of the Compliance center to monitor non-Microsoft cloud apps you need to connect these apps to Microsoft Cloud App Security. Afterwards they will be available as instances in the Microsoft Cloud app security location of your DLP policies. This is required to complete integration of MCAS into DLP.

If you do not select a specific instance the policy will apply to all connected apps.

When you create a rule in the DLP policy, you can select an action for non-Microsoft cloud apps. To restrict these apps, select **Restrict Third Party Apps**. You can choose various actions for every supported non-Microsoft cloud app. For every app, there are different possible actions depending on the cloud app API.

