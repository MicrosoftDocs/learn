Retention labels let you manage how long content is kept and what happens when that time ends. They're useful when different types of content need different retention settings. You can publish labels for users to apply manually or configure them to apply automatically based on content.

In this exercise, you'll create a retention label for customer contracts and configure it to auto-apply when tax ID numbers are detected. A trainable classifier identifies relevant content, and the label retains it for seven years before deleting it.

**Estimated time to complete**: 15-20 minutes

> [!IMPORTANT]
> To complete this exercise, you need access to Microsoft Purview features through one of these Microsoft 365 licenses:
>
> - A Microsoft 365 E3 license is required to create and publish retention labels.
> - A Microsoft 365 E5 license, or the E5 Information Protection and Governance add-on, is required for auto-apply capabilities.
>
> If your tenant doesn't include these features, some tasks in the exercise might not be available. You can still follow the steps to understand how the configuration works or skip any unsupported tasks.
>
> If you don't have access to these features, you can join the **[Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program)**. This program provides a free Microsoft 365 E5 developer subscription with access to many Purview capabilities.

## Create and auto-apply a retention label for contract content

Use this task to configure a retention label that helps manage financial content containing tax IDs. The label keeps content for seven years, then deletes it. After creating the label, you'll set up a policy to automatically apply it to content that matches a predefined classifier.

1. Navigate to [Microsoft Purview](https://purview.microsoft.com) and sign in.
1. Go to **Solutions** > **Data Lifecycle Management**.
1. Select **Retention labels**.
1. Select **+ Create a label**.
1. On the **Name your retention label** page, enter:

   - **Name**: `Customer contracts - 7 years`
   - **Description for admins**: `Auto-applies to contract content with tax IDs. Retains for 7 years, then deletes.`
   - **Description for users**: `Use for customer contracts. This label is applied automatically.`

1. Select **Next**.
1. On the **Define label settings** page, select **Retain items forever or for a specific period**, then select **Next**.
1. On the **Define the retention period** page:

   - Set the retention period to **7 years**.
   - Start retention based on **when items were created**.

1. Select **Next**.
1. On the **Choose what happens after the retention period** page, select **Delete items automatically**, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Create label**.
1. On the **Your retention label is created** page, select **Auto-apply this label to a specific type of content**, then select **Done**.
1. On the **Let's get started** page, enter:

   - **Name**: `Auto-apply contracts - Tax ID`
   - **Description for admins**: `Automatically applies the Customer contracts label to content containing tax ID numbers.`

1. Select **Next**.
1. On the **Choose the type of content you want to apply this label to** page, select **Apply label to content that matches a trainable classifier**, then select **Next**.
1. On the **Choose a trainable classifier** page, select the checkbox for **Tax**, then select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​**, select **Static**.
1. On the **Choose where to automatically apply the label** page, enable locations:

   - Exchange mailboxes
   - SharePoint classic and communication sites
   - OneDrive accounts
   - Microsoft 365 Group mailboxes & sites

1. Select **Next**.
1. On the **Choose a label to auto-apply** page, make sure the **Customer contracts - 7 years** label is selected, then select **Next**.
1. On the **Decide whether to test or run your policy** page, leave the default of **Turn on policy** selected, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This setup helps ensure that customer contracts containing tax ID numbers are retained consistently without relying on manual labeling. By using a predefined trainable classifier, you can automatically apply the label based on content context, reducing the chance of oversight and supporting your organization's retention requirements.

## Check your work

Review the label and auto-apply policy you created to make sure they're configured as expected.

1. Go to **Data Lifecycle Management** > **Retention labels**.
1. Confirm that `Customer contracts - 7 years` is listed.
1. Open the label and check that:

   - The retention duration is set to 7 years
   - Retention starts when items are created
   - The action after the period is **Delete items automatically**

1. Go to **Retention policies** and confirm that `Auto-apply contracts - Tax ID` is listed.
1. Open the policy and check that:

   - The correct label is selected
   - The **Tax** classifier is enabled
   - All intended Microsoft 365 content locations are selected
   - The policy is turned on (not in simulation mode)

These checks help ensure your label is configured correctly and will apply automatically based on content type. Confirming policy settings now can help avoid unexpected gaps in retention coverage.
