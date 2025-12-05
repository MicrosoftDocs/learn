Microsoft Purview Endpoint Data Loss Prevention (DLP) helps protect sensitive information when users interact with external AI tools in web browsers. It restricts actions like pasting or uploading sensitive content into sites that could retain or process that data in ways that create risk. These protections are important as generative AI becomes more commonly used in daily workflows and outside standard productivity apps.

## Prerequisites for endpoint DLP

To use these protections, make sure the devices you want to protect are onboarded to Microsoft Purview and meet the minimum requirements:

- Devices must be running supported versions of Windows 10/11 or macOS.
- For Chrome and Firefox, users must have the Microsoft Purview browser extension installed.
- Devices must be onboarded to Microsoft Purview.
- Pasting restrictions are only supported in Microsoft Edge, Google Chrome, and Mozilla Firefox.

Without these prerequisites in place, DLP policies won't apply to user activity on the device.

## Use Data Security Posture Management (DSPM) for AI to create DLP policies

In **DSPM for AI**, you can apply protections using one-click policy creation. These prebuilt policies audit or block pasting and uploading sensitive data to generative AI websites using endpoint DLP.

To get started, go to **DSPM for AI** in the Microsoft Purview portal. On the **Overview** page, select **Extend your insights for data discovery**. This creates a policy named **DSPM for AI: Detect sensitive info added to AI sites**, which audits pasting actions into generative AI sites.

   :::image type="content" source="../media/dlp-dspm-paste-ai.png" alt-text="Screenshot showing the Extend your insights one click policies flyout panel with the associated one-click policies." lightbox="../media/dlp-dspm-paste-ai.png":::

You can also create a policy by selecting **Fortify your data security** under **Recommendations**. This creates the endpoint DLP policy **DSPM for AI – Block sensitive info from AI sites**, which uses Adaptive Protection to apply a warning with override for elevated risk users who try to paste or upload sensitive information into AI assistants using Edge, Chrome, or Firefox. The policy is created in simulation mode to all users and groups in your organization.

   :::image type="content" source="../media/dlp-dspm-block-ai-sites.png" alt-text="Screenshot showing the Fortify your data security flyout panel and the one-click policy created." lightbox="../media/dlp-dspm-block-ai-sites.png":::

### Understand how the one-click policies behave

The two DSPM for AI one-click policies differ in how they're applied:

- **DSPM for AI: Detect sensitive info added to AI sites** is created as an active policy. It begins auditing pastes into generative AI websites immediately.
- **DSPM for AI – Block sensitive info from AI sites** is created in simulation mode. It uses Adaptive Protection to target elevated risk users and applies a warning with override, but doesn't enforce blocks until you move the policy out of simulation mode.

Understanding these defaults helps ensure you're reviewing and enforcing protections as intended.

## Manually configure data pasting and upload restrictions

If you need more control over scope, conditions, or actions, you can manually create an endpoint DLP policy. When defining the rule, you can:

- Enable **Paste to supported browsers** to prevent pasting sensitive content into websites
- Enable **Upload to a restricted cloud service domain** to restrict file uploads to unapproved domains

Microsoft Purview includes a built-in **Generative AI Websites** service domain group, which contains commonly used AI tools that might retain user input. You can use this group or define your own.

Use restrictions like these when you want to:

- Prevent pasting sensitive data into AI chat tools that retain or process input
- Block uploads to personal email or cloud services outside corporate policy
- Reduce exposure through social media or public platforms

### Example

You create an endpoint DLP policy to prevent pasting or uploading confidential data into unapproved AI tools. A user attempts to paste sensitive content into a generative AI site. The policy blocks the action and displays a message: _"This action is prohibited by your organization's data policy. Please contact your administrator for more information."_

### Create your DLP policy for restricting AI tools

1. Create a DLP policy scoped to **Devices**. For detailed instructions, see [Create and Deploy data loss prevention policies](/purview/dlp-create-deploy-policy?azure-portal=true#create-and-deploy-data-loss-prevention-policies).
1. On the [Define policy settings page](https://sip.compliance.microsoft.com/datalossprevention/policies?azure-portal=true) in the DLP policy creation flow, select **Create or customize advanced DLP rules** and then choose **Next**.
1. On the **Customize advanced DLP rules** page, select **Create rule**.
1. Enter a name and description for the rule.
1. Configure the appropriate **Conditions** for the rule.
1. Under Actions, select Add an action > Audit or restrict activities on devices.
1. In the **Audit or restrict activities on devices** section, configure **Service domain and browser activities**:

   1. Select one or both based on your requirements:

      - Paste to supported browsers
      - Upload to a restricted cloud service domain or access from an unallowed browser

   1. Select **+ Choose different restrictions for sensitive service domains**
   1. In the **Sensitive service domain restrictions** flyout, select **+ Add group**.
   1. On the **Choose sensitive service domain groups** page, select the checkbox for **Generative AI Websites** to apply the built-in group.

      :::image type="content" source="../media/generative-ai-websites-domain-group.png" alt-text="Screenshot showing the built-in Generative AI Websites service domain group." lightbox="../media/generative-ai-websites-domain-group.png":::

   1. Select **Add** at the bottom of the page.
   1. On the **Sensitive service domain restrictions** page, you can set a restriction like **Audit**, **Block**, **Block with override**, or **Allow** that applies to the selected service domain group within the policy. This step configures how the policy handles these service domains.
   1. Select **Save** to configure the sensitive service domain restriction.

1. On the rule configuration page, set the rule-level action to **Audit**, **Block**, or **Block with override** when the rule condition is met.
1. Select **Save** at the bottom of the rule configuration window.
1. Select **Next** on the **Customize advanced DLP rules** page.
1. Select whether you want to run your policy in simulation mode, turn it on right away, or keep it off, and then select **Next**.
1. Select **Submit** to create your endpoint DLP policy.

> [!NOTE]
> If you use [evidence collection for file activities on devices](/purview/endpoint-dlp-using#create-your-dlp-policy?azure-portal=true), make sure the Antimalware Client Version is current. Older versions might display random characters in source file names.
