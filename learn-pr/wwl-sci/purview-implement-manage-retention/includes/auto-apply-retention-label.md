Properly managing the lifecycle of your organization's content is essential for meeting legal and regulatory requirements and minimizing risks. Automating the application of retention labels streamlines this process. It systematically organizes how content is retained or deleted according to specific rules. This process ensures crucial information is protected until it's no longer needed.

## Understand automatic retention

Automatic retention applies predefined labels to content without manual intervention. This system identifies and labels content based on defined criteria such as sensitivity, keywords, or data type, enabling:

- **Simplified user experience**: Reduces the need for extensive training as the system handles content classification.
- **Enhanced consistency**: Ensures content is uniformly managed according to defined policies.
- **Increased productivity**: Allows users to focus on their primary responsibilities without compliance distractions.

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
