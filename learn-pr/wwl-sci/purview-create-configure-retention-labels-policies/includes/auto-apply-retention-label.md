Managing the lifecycle of your organization's content is crucial for meeting legal and regulatory requirements and for reducing risks. Automating the application of retention labels simplifies this process by organizing how content is kept or deleted based on specific rules. This automation ensures that important information is protected as long as needed and properly discarded when it's no longer necessary.

## What is automatic retention?

Automatic retention involves the application of predefined labels to content within an organization's digital environment. This method doesn't require manual intervention from end users, as the system identifies and labels content based on specified conditions such as sensitivity, keywords, or data type.

### Benefits of auto-labeling

- **Reduced need for user training**: Simplifies the process since users don't need to understand or remember how to apply labels.
- **Accuracy and consistency**: Ensures content is consistently classified according to organizational policies.
- **Focus on core responsibilities**: Allows users to concentrate on their primary tasks without sidetracking them with compliance requirements.

## What is simulation mode?

Simulation mode is a powerful feature in the setup of automatic retention policies. It allows you to test and refine your policies under controlled conditions before fully applying them across your organization. This mode operates similarly to the WhatIf parameter in PowerShell, offering a preview of how the policy would affect your content without making any permanent changes.

### Benefits of simulation mode

- **Testing before implementation**: You can see the potential effects of a retention policy without altering actual data.
- **Iterative refinement**: Based on simulation results, you can fine-tune the policy to ensure it meets your specific needs before going live.
- **Gradual expansion**: Start with a limited scope, like a single SharePoint site, and systematically broaden to more sites and data types, adjusting the policy as you scale up.

## Before you begin

Before you begin setting up auto-apply retention label policies, ensure you meet the following prerequisites to successfully create and manage these policies:

- **Permissions**: Ensure you have the necessary permissions within the **Compliance Administrator** role group to create and manage retention labels. Alternative roles include **Retention Management** for active management and **View-Only Retention Management** for read-only access.
- **Auditing**: Make sure auditing for Microsoft 365 is enabled. Auditing needs to be on to run policies in simulation mode effectively.
- **Retention labels**: Ensure that the retention labels you plan on using are already created. This step is important since the policy applies these labels to the content meeting your specified conditions.

## Steps to implement automatic retention labels

The process to set up and use automatic retention involves several steps, each designed to ensure that the labels are applied accurately and effectively.

1. Navigate to **Auto-apply a label** in either the Microsoft Purview portal or Microsoft Purview compliance portal.

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/)

      - If you're using records management: **Records management** > **Label policies** > **Auto-apply a label**.
      - If you're using data lifecycle management: **Data Lifecycle Management** > **Policies** > **Label policies** > **Auto-apply a label**.

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/)

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

Set conditions for automatic application of retention labels based on:

### Sensitive information types

Retention labels can be automatically applied when content matches specific sensitive information types defined within Microsoft Purview. This process includes various predefined categories like financial data, personal identification numbers, or health records. When setting up a policy, you can select from a list of existing templates or customize your criteria to target specific data types. You can adjust the confidence level and instance count to refine how sensitive the detection should be. This adjustment allows for a balance between accuracy and minimizing false positives.

### Keywords or searchable properties

This condition uses Keyword Query Language (KQL) to identify content that contains certain words, phrases, or property values. For instance, you might set a policy to apply a particular retention label to all documents containing the terms `"contract agreement"` or `"confidential"`. Advanced KQL can include operators like **AND**, **OR**, and **NOT** to further refine the search, providing robust control over what content is labeled based on its textual content or metadata attributes.

### Trainable classifiers

For more dynamic and adaptable content management, you can use trainable classifiers to enhance your auto-apply retention label configurations. These tools categorize content by learning from examples, distinguishing between document types such as business communications and legal agreements. Once trained, classifiers automatically apply retention labels to similar new content, ensuring consistent and automated compliance management.

These conditions can be combined to create comprehensive and layered retention policies. For example, a policy might use both sensitive information types for detecting any financial data and trainable classifiers to catch complex patterns like specific forms or reports not covered by simpler keyword or metadata matches.
