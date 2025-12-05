Retention labels give you more control over how long individual items are kept. They're useful when content needs to be managed differently based on type, department, or business need. You can publish labels so users can apply them manually or configure them to apply automatically based on conditions.

In this exercise, you create two retention labels: one for financial content and one for HR content. You publish the financial label to make it available in email and SharePoint. Then you configure the HR label to auto-apply when sensitive content is detected. Last, you configure event-based retention so that retention starts based on specific events, like an employee leaving the organization.

**Estimated time to complete**: 45–60 minutes

> [!IMPORTANT]
> To complete this exercise, you need access to Microsoft Purview features through one of these Microsoft 365 licenses:
>
> - A Microsoft 365 E3 license is required to create and publish retention labels.
> - A Microsoft 365 E5 license, or the E5 Information Protection and Governance add-on, is required for event-based retention and auto-apply capabilities.
>
> If your tenant doesn't include these features, some tasks in the exercise might not be available. You can still follow the steps to understand how the configuration works or skip any unsupported tasks.
>
> If you don't have access to these features, you can join the [Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program). This program provides a free Microsoft 365 E5 developer subscription with access to many Purview capabilities.

## Create and publish a retention label for financial content

Start by creating a retention label that keeps financial content for seven years, then deletes it. After creating the label, publish it to make it available to users in Exchange and SharePoint.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Lifecycle Management**.
1. Select **Retention labels**.
1. Select **+ Create a label**.
1. On the **Name your retention label** page, enter:

   - **Name**: `Financial - 7 years`
   - **Description for admins**: `Retains financial content for 7 years, then deletes.`
   - **Description for users**: `Use for financial records that must be kept for 7 years.`

1. Select **Next**.
1. On the **Define label settings** page, select **Retain items forever or for a specific period**, then select **Next**.
1. On the **Define the retention period** page:

   - Set the retention period to **7 years**.
   - Start retention based on **when items were created**.

1. Select **Next**.
1. On the **Choose what happens after the retention period** page, select **Delete items automatically**, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Create label**.
1. On the **Your retention label is created** page, select **Publish this label to Microsoft 365 locations**, then select **Done**.
1. On the **Choose retention labels to publish** page, make sure the `Financial - 7 years` label is selected, then select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​**, select **Static**.
1. On the **Choose where to publish labels** page, select **All locations. Includes content in Exchange email, Office 365 groups, OneDrive and SharePoint documents.**
1. Select **Next**.
1. On the **Name your policy** page, enter:

   - **Name**: `Financial label policy`
   - **Description**: `Applies to all locations: Exchange, Microsoft 365 Groups, OneDrive, and SharePoint.`

1. Select **Next**.

1. On the **Finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This label and policy now apply a seven-year retention period to financial content across email and SharePoint. Users can apply the label manually to ensure content is retained and deleted according to your organization’s policies.

## Create an auto-apply retention label for HR content

Now create a retention label for HR content that applies automatically when specific types of information are detected. This label will apply to content that contains U.S. Social Security Numbers (SSNs), helping ensure sensitive HR records are retained even if users don’t manually apply a label.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Lifecycle Management**.
1. Select **Retention labels**, then select **+ Create a label**.
1. On the **Name your retention label** page, enter:

   - **Name**: `HR - 10 years`
   - **Description for admins**: `Applies to HR content. Retains for 10 years, then deletes.`
   - **Description for users**: `Use for HR records that need to be kept for 10 years.`

1. Select **Next**.
1. On the **Define label settings** page, select **Retain items forever or for a specific period**, then select **Next**.
1. On the **Define the retention period** page:

   - Set the retention period to **10 years**.
   - Start retention based on **when items were created**.

1. Select **Next**.
1. On the **Choose what happens after the retention period** page, select **Delete items automatically**, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Create label**.
1. After the label is created, select **Auto-apply this label to content**, then select **Done**.
1. On the **Let's get started** page, enter:

   - **Name**: `Auto-apply HR - SSN`
   - **Description**: `Automatically applies the HR label to content containing SSNs.`

1. Select **Next**.
1. On the **Choose how you want to apply labels to content** page, select **Apply label automatically based on sensitive info**, then select **Next**.
1. On the **Content that contains sensitive info** page, select a **custom** category and regulation, then select **Next**.
1. On the **Define content that contains sensitive info** page, in the **Content contains** section, enter `US SSN` as the group name, then select the **Add** > **Sensitive info types**.
1. In the **Sensitive info types** types flyout, search for `SSN`, then select the **U.S. Social Security Number (SSN)**.
1. Select **Add** at the bottom of the flyout, then select **Next** on the **Define content that contains sensitive info** page.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create** page, select **Static**, then select **Next**.
1. On the **Choose locations** page, select:

    - **Exchange mailboxes**
    - **SharePoint classic and communication sites**
    - **OneDrive accounts**

1. Select **Next**.
1. On the **Choose a label to auto-apply** page, make sure the **HR - 10 years** label is selected, then select **Next**.
1. On the **Decide whether to test or run your policy** page, select **Turn on policy**, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This auto-labeling policy now applies the HR retention label to content that contains Social Security numbers. By automating label application, you help ensure that sensitive information is consistently protected without relying on users to apply labels manually.

## Configure event-based retention

For some content, retention needs to start based on a specific event, such as when an employee leaves the organization or a contract is finalized. Event-based retention labels allow you to trigger the retention period only after that event occurs.

In this task, you configure an event-based retention label for employee files and create a new event type to support it. This setup ensures that retention for HR documents begins only after the employee offboarding process is complete.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Lifecycle Management**.
1. Select **Retention labels**, then select **+ Create a label**.
1. On the **Name your retention label** page, enter:

   - **Name**: `Employee files - 7 years`
   - **Description for admins**: `Starts retention when an employee leaves. Keeps content for 7 years, then deletes.`
   - **Description for users**: `Use for employee files. Retention starts after the employee leaves.`

1. Select **Next**.
1. On the **Define label settings** page, select **Retain items forever or for a specific period**, then select **Next**.
1. On the **Define the retention period** page:

   - Set the retention period to **7 years**.
   - In the **Start retention based on** section, select **+ Create new event type**.
   - In the **Create event type** flyout, enter:

      - **Name**: `Employee departure`
      - **Description**: `Used to trigger retention for employee-related documents.`
      - Select **Next**.
      - On the **Summary** page, select **Submit**, then select **Done** once your event type is created.

   - Back on the **Define the retention period** page, start the retention period based on **Employee departure**.

1. Select **Next**.
1. On the **Choose what happens after the retention period** page, select **Delete items automatically**, then select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Create label**.
1. On the **Your retention label is created** page, select **Publish this label to Microsoft 365 locations**, then select **Done**.
1. On the **Choose labels to publish** page, make sure the **Employee files - 7 years** label is selected, then select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​** page, select **Static**, then select **Next**.
1. On the **Choose where to publish labels** page, select **All locations. Includes content in Exchange email, Office 365 groups, OneDrive and SharePoint documents.**
1. Select **Next**.
1. On the **Name your policy** page, enter:

   - **Name**: `Employee files label policy`
   - **Description for admins**: `Makes the Employee files label available in Exchange, Microsoft 365 Groups, OneDrive, and SharePoint.`

1. Select **Next**.
1. On the **Finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This label is now available to users and will trigger retention only when the Employee departure event occurs. Event-based retention gives you more control over when retention starts, especially for documents tied to key lifecycle events.

## Check your work

Review the labels and policies you created to make sure they're configured as expected.

1. Go to **Data Lifecycle Management** > **Retention labels**.
1. Confirm these labels are listed:

   - `Financial - 7 years`
   - `HR - 10 years`
   - `Employee files - 7 years`

1. Open each label and check that the retention duration, trigger, and action after the retention period match what you configured.
1. Go to **Retention policies** and confirm these policies are listed:

   - `Financial label policy`
   - `Auto-apply HR - SSN`
   - `Employee files label policy`

1. Open each policy and confirm:

   - The correct label is included
   - The right Microsoft 365 locations are selected
   - The policy type (manual, auto-apply, or event-based) matches the label

1. Go to **Event types** and confirm that `Employee departure` is listed

These steps help verify that each label and policy works as intended. Confirming retention durations, triggers, and scopes now can help prevent misconfigured settings from affecting real data later.
