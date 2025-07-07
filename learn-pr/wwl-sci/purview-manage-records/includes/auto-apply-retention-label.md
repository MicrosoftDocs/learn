Automatic retention helps your organization manage content consistently and reduce risk. By applying retention labels based on specific conditions, Microsoft Purview can help protect important information until it's no longer needed, without requiring users to classify content themselves.

## What is automatic retention?

Automatic retention uses conditions like sensitive information types, keywords, or trainable classifiers to identify content and apply the appropriate retention label. This reduces the need for user training and improves the consistency of retention across Microsoft 365 services. Once a label is applied, either manually or automatically, it can't be removed or replaced by another auto-apply policy.

Benefits include:

- **Consistent labeling**: Content is classified according to organization-wide rules.
- **Improved productivity**: Users don't have to decide how to label or manage files.
- **Fewer mistakes**: Automated rules reduce the chance of mislabeling or skipping important items.

## What is simulation mode?

Simulation mode lets you test your auto-labeling policy before turning it on. It's similar to using the WhatIf parameter in PowerShell. You can see which items would have been labeled without making changes to live content.

Simulation mode helps you:

- Validate that your conditions are accurate
- Adjust your policy before it's active
- Scale the policy gradually by starting with smaller scopes

Simulation results are visible for up to seven days. It's available for policies using sensitive information types or keywords, but not for those using trainable classifiers.

## Before you begin

Before setting up automatic retention labels, make sure:

- **Permissions**: You have the right permissions, such as being in the **Compliance Administrator** role group. You can also use **Retention Management** or **View-Only Retention Management** roles.
- **Auditing is enabled**: Simulation mode requires audit logs to be turned on.
- **Labels exist**: Create the retention labels you plan to use before setting up the policy.

## How to create an auto-apply retention label policy

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).

1. Go to either **Records Management** or **Data Lifecycle Management** and select **Auto-apply a label**:

   - **Solutions** > **Records management** > **Policies** > **Label policies** > **Auto-apply a label**
   - **Solutions** > **Data Lifecycle Management** > **Policies** > **Label policies** > **Auto-apply a label**

1. Name your policy and provide a description.

1. Choose the condition type to trigger the label. You can use:

   - Sensitive information types (SITs)
   - Keywords or metadata (KQL)
   - Trainable classifiers
   - Cloud attachments and links shared in Exchange, Teams, Viva Engage, and Copilot

1. For the **Assign admin units page**, keep the default of **Full directory**. Currently, admin units aren't supported for this policy.

1. Choose the policy type:

   - **Adaptive scope**: Uses attributes like job title or department (requires preconfigured scopes)
   - **Static scope**: Manually select services or locations

1. Select the retention label to apply.

1. Choose whether to run the policy in simulation mode or turn it on immediately.

1. Review your settings and submit the policy.

## Conditions for automatic labeling

You can tailor your policy by combining different conditions:

### Sensitive information types

Use this option to apply retention labels when content includes built-in or custom sensitive information types. You can fine-tune how content is matched by adjusting:

- **Confidence levels**: Such as high, medium, or low
- **Instance counts**: How many times the data type must appear in the content

This method is useful for labeling content that contains things like financial data, government-issued IDs, or health-related information.

### Keywords and searchable properties

Use Keyword Query Language (KQL) to label content that contains specific phrases or metadata. For example:

- "Confidential project"
- Metadata tags like department: HR

You can use logical operators like AND, OR, and NOT to combine conditions.

### Trainable classifiers

Trainable classifiers recognize content based on patterns learned from sample documents. Once trained, the classifier can be added to an auto-labeling policy.

This method is useful for identifying:

- Contracts
- Business communications
- Financial statements

Simulation mode can't be used with this method.

By combining conditions, you can build detailed policies that label a broad set of items across your environment. For example, you might use sensitive information types to detect credit card data and a classifier to identify financial statements. This layered approach helps you meet your compliance requirements without relying on users to apply labels manually.
