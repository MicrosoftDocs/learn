Automatically apply retention labels in Microsoft Purview
Automatically applying retention labels helps ensure that important content is retained or deleted according to organizational policies, without relying on users to classify items manually. You can configure policies that detect specific types of content and apply labels based on the conditions you define.

This approach supports consistency, reduces the risk of human error, and simplifies the user experience by applying compliance requirements in the background.

## How automatic labeling works

Auto-apply retention label policies use service-side conditions to label content. You choose a retention label and configure conditions that determine when and where it's applied. Once applied, the label governs how long the content is kept and what happens afterward.

These policies are especially useful when content matches patterns that are hard for users to identify on their own, such as financial data or sensitive keywords.

A retention label can only be applied automatically if:

- The item doesn't already have a retention label.
- The item matches one or more of the configured conditions.

Once applied, an auto-label can't be replaced or removed by another auto-apply policy, even if the content changes or a new policy is created.

## Conditions you can use

Auto-apply retention labels work by identifying specific types of content based on defined conditions. You can use one or more of the these conditions in your policy:

- **Sensitive information types**: Detect patterns like credit card numbers, Social Security numbers, or health-related data. You can customize the detection by adjusting the required confidence level and number of instances.

- **Keywords or searchable properties**: Use Keyword Query Language (KQL) to match specific terms, phrases, or document metadata. You can refine the query with logical operators like AND, OR, and NOT for more targeted results.

- **Trainable classifiers**: Identify content based on patterns learned from example documents. You can use pre-trained classifiers or custom ones built from your organization’s own content to automatically label items that don’t follow predictable formats.
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
- Adaptive scopes are supported, but may take a few days to fully populate. It’s a good idea to verify scope membership before running the simulation.

When a simulation is running or complete, its status appears as **In simulation** in the Label policies list. Select the policy and choose V**iew simulation** to inspect sample items and review match counts.






## Understand simulation mode

Simulation mode offers an environment to test and refine retention policies using conditions similar to the WhatIf parameter in PowerShell. This feature allows administrators to:

- **Preview policies before implementation**: Simulate the effects of a policy on your content before full deployment.
- **Refine and adjust**: Modify the policy based on simulation outcomes to better meet organizational needs.
- **Scale cautiously**: Gradually expand the scope of the policy, making adjustments based on iterative simulations.

## Before you begin

Before implementing auto-apply retention label policies, ensure:

- **Permissions**: Ensure you have the necessary permissions within the **Compliance Administrator** role group to create and manage retention labels. Alternative roles include **Retention Management** for active management and **View-Only Retention Management** for read-only access.
- **Enable Auditing**: Auditing must be active to use simulation mode effectively.
- **Retention labels**: Confirm that necessary retention labels are created and available for use.

## Implement automatic retention labels

To apply automatic retention labels:

1. Navigate to **Auto-apply a label** in either the Microsoft Purview portal or Microsoft Purview compliance portal.

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true)

      - If you're using records management: **Records management** > **Label policies** > **Auto-apply a label**.
      - If you're using data lifecycle management: **Data Lifecycle Management** > **Policies** > **Label policies** > **Auto-apply a label**.

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/?azure-portal=true)

      - If you're using records management: **Solutions** > **Label policies** > **Auto-apply a label**.
      - If you're using data lifecycle management: **Solutions** > **Data lifecycle management** > **Policies** > **Retention labels** > **Auto-apply a label**.

1. Enter a name and description for your new auto-labeling policy.
1. **Choose the type of content to apply the label to** by selecting one of the available conditions that describe your content.
1. If your organization uses administrative units and you want to restrict the policy to specific users, select the appropriate units. If not, select **Full directory** to include all locations.
1. On the **Choose the type of retention policy to create** page, select either **Adaptive** or **Static**. If you want to use adaptive scopes, you need to have one created before selecting this option.
1. Depending on if you selected adaptive or static scope:
   - **For adaptive**: On the **Choose adaptive policy scopes and locations page**, add scopes, and select locations. If you don't have any adaptive scopes created, no options appear on this page.
   - **For static**: On the **Choose locations page**, adjust location settings as needed.
1. Confirm the retention label to apply, decide if you want to run the policy in simulation mode or turn it on immediately. Review your settings before submitting.

After content is labeled using an auto-apply label policy, the applied label can't be automatically removed or changed. This restriction applies whether altering the content or the policy, or implementing a new auto-apply label policy.

## Configure conditions for auto-apply retention labels

Tailor your retention strategies by setting conditions based on:

### Sensitive information types

Enable retention labels to automatically apply when content meets predefined sensitive information types like financial data or personal identifiers. You can customize these settings by adjusting confidence levels and instance counts, which helps balance the precision of detections and minimize false positives effectively.

### Keywords or searchable properties

Use Keyword Query Language (KQL) to identify content that includes specific words, phrases, or metadata properties. For instance, create policies to automatically label documents containing terms like `"contract agreement"` or `"confidential"`. Enhance the specificity of these searches by using logical operators like AND, OR, and NOT, allowing for more accurate categorization of content.

### Trainable classifiers

For more dynamic and adaptable content management, you can use trainable classifiers to enhance your auto-apply retention label configurations. These classifiers learn to recognize different types of documents, from business communications to legal agreements, by analyzing examples. Once trained, they can automatically label new, similar content, facilitating consistent and automated compliance management.

These conditions can be combined to develop a comprehensive and layered retention policy, ensuring thorough coverage across various data types and content categories. For example, a policy might use both sensitive information types for detecting any financial data and trainable classifiers to catch complex patterns like specific forms or reports not covered by simpler keyword or metadata matches.
