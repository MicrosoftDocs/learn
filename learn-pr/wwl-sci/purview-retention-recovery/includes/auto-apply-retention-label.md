Automatically applying retention labels helps retain or delete content based on organizational policies—without relying on users to classify items manually. You can configure policies that detect specific types of content and apply labels based on the conditions you define.

This approach supports consistency, reduces the risk of human error, and simplifies the user experience by applying compliance requirements in the background.

## How automatic labeling works

Auto-apply retention label policies use service-side conditions to label content. You choose a retention label and configure conditions that determine when and where it's applied. Once applied, the label governs how long the content is kept and what happens afterward.

These policies are especially useful when content matches patterns that are hard for users to identify on their own, such as financial data or sensitive keywords.

A retention label can only be applied automatically if:

- The item doesn't already have a retention label.
- The item matches one or more of the configured conditions.

Once applied, an auto-label can't be replaced or removed by another auto-apply policy, even if the content changes or a new policy is created.

## Conditions you can use

Auto-apply retention labels work by identifying specific types of content based on defined conditions. You can use one or more of these conditions in your policy:

- **Sensitive information types**: Detect patterns like credit card numbers, Social Security numbers, or health-related data. You can customize the detection by adjusting the required confidence level and number of instances.

- **Keywords or searchable properties**: Use Keyword Query Language (KQL) to match specific terms, phrases, or document metadata. You can refine the query with logical operators like AND, OR, and NOT for more targeted results.

- **Trainable classifiers**: Identify content based on patterns learned from example documents. You can use pretrained classifiers or custom ones built from your organization's own content to automatically label items that don't follow predictable formats.
- **Cloud attachments**: Apply labels to files shared through Outlook, Teams, Viva Engage, or Copilot when those files are stored in OneDrive or SharePoint. A copy of the shared file is labeled and stored in the Preservation Hold library for compliance purposes.

## Use simulation mode to test your policy

Simulation mode lets you preview which content would be labeled before turning on the policy. This helps you fine-tune your conditions and avoid unexpected results.

Simulation mode is optional, but it's useful for verifying accuracy. Here's how it works:

1. Create the auto-labeling policy with your chosen label and conditions.
1. Run the policy in simulation mode.
1. Review the results, including how many items match and where they're located.
1. Adjust the conditions if needed and rerun simulation.
1. When ready, turn on the policy to start labeling content.

### Simulation mode limitations and considerations

Here are a few things to keep in mind when testing policies with simulation mode:

- Simulations expire after 7 days.
- You can have up to 30 simulation jobs active within a 12-hour period.
- Each mailbox can return up to 100 sample items.
- Only items that exist at the time the simulation job runs are evaluated. Items that are deleted or moved beforehand won't be included.
- Adaptive scopes are supported, but might take a few days to fully populate. It's a good idea to verify scope membership before running the simulation.

When a simulation is running or complete, its status appears as **In simulation** in the Label policies list. Select the policy and choose **View simulation** to inspect sample items and review match counts.

## Create an auto-apply policy

To automatically apply a retention label:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), go to **Solutions** > **Data lifecycle management** or **Records management**.
1. Select **Policies** > **Label policies** > **Auto-apply a label**.
1. On the **Let's get started** page, enter a name and optional description.
1. On the **Choose the type of content you want to apply this label to** page, choose the condition to trigger labeling:
   - Sensitive info types
   - Keywords or searchable properties
   - Trainable classifiers
   - Cloud attachments
1. On the **Policy scope** page, keep the default of **Full directory**. Currently, admin units aren't supported for this policy.
1. Choose a **Static** or **Adaptive** policy scope:
   - Adaptive scopes require separate setup and allow targeting by user, site, or group attributes.

1. On the **Choose where to automatically apply the label** page, choose whether to include all locations or specify only certain ones.

1. On the **Choose a label to auto-apply** page, select **Add label** and select the label for your auto-apply policy.

1. On the **Decide whether to test or run your policy** page, choose to run your policy in simulation mode, or turn the policy on right away.

1. Review your settings, then submit your configuration to create the auto-apply label.

## When labels take effect

Auto-labeling policies can take up to 7 days to apply labels after activation. Timing depends on content volume and location.

:::image type="content" source="../media/auto-apply-labels-published-timings.png" alt-text="Diagram illustrating when auto-apply retention label policies are available." lightbox="../media/auto-apply-labels-published-timings.png":::

If expected labels don't appear after 7 days, check the policy's **Status** in the **Label policies** list. If necessary, use PowerShell to retry distribution:

```powershell
Set-RetentionCompliancePolicy -Identity <policy name> -RetryDistribution
```

## Location behavior and limitations

- Auto-labeling works only on content without an existing retention label.
- Some conditions apply only to new or modified content.
- Simulation runs against data at rest but is based on current content only.
- Draft SharePoint items aren't supported.
- Policies for cloud attachments label a stored copy of the shared file, not the message or original file.

Auto-apply retention labels help enforce consistent retention policies by labeling content automatically, based on content types and patterns that are easy to miss manually. Simulation mode provides a safe way to test policies before deployment, while static and adaptive scopes give you flexible targeting options.

Use auto-labeling to protect sensitive content, reduce manual effort, and support compliance across Microsoft 365.
