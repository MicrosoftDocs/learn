Retention labels in Microsoft Purview allow you to specify how long items like documents or emails should be kept and when they should be deleted. This is important for meeting compliance requirements and managing organizational information efficiently.

## Understand File plan

File plan in Microsoft Purview Records Management enhances the creation and management of retention labels with advanced capabilities such as bulk actions and comprehensive overviews. It's designed for detailed management of records and non-record information across your organization.

### Key features of file plan

- **Bulk creation and management**: Import and create multiple retention labels from a spreadsheet, allowing for efficient setup.
- **Detailed overview**: View and manage detailed settings of all retention labels from a single interface.
- **Enhanced descriptors**: Use file plan descriptors for extra categorization and organization of retention labels.

### Access requirements

Ensure you have the necessary permissions within the **Compliance Administrator** role group to create and manage retention labels. Alternative roles include **Retention Management** for active management and **View-Only Retention Management** for read-only access.

## Create and publish retention labels

There are some important steps to follow when you create and publish retention labels, from setting up the label to applying it across your organization's services like SharePoint or Exchange. Here's what you need to do:

### Steps to create a retention label using file plan

Creating retention labels involves defining retention or deletion periods and specifying conditions that trigger these actions. Here's how to create a label:

1. Navigate to **File plan** in either the Microsoft Purview portal or Microsoft Purview compliance portal:

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) > **Records management** card > **File plan**.

        - If you don't see the **Records management** card, select **View all solutions** and find **Records management** under the **Risk & Compliance** section.

        :::image type="content" source="../media/purview-portal-records-management-card.png" alt-text="Screenshot showing the Records Management card in the Microsoft Purview portal.":::

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/?azure-portal=true) > **Solutions** > **Records management** > **File plan**.

1. Select **Create a label** to start the **Create retention label** configuration, and name your new retention label.

1. On the **Define file plan descriptors for this label** page:

   - Review and categorize the retention label using predefined descriptors such as **Business function/department**, **Category**, **Authority type**, and **Provision/citation**.

        :::image type="content" source="../media/file-plan-descriptors.png" alt-text="Screenshot showing the Define file plan descriptors for this label page.":::

   - Select or create descriptors:

      - Select **Choose** to select appropriate descriptors that match the content management needs.

      - If needed, select **Create new** to add a custom descriptor, provide its details, and confirm.

   - Review and ensure your descriptors accurately reflect the label’s governance role within your organization.

1. On the **Define label settings**, choose one of the configurations for managing your content over a specified period:

   - **Retain items forever or for a specific period**: Retain items indefinitely or for a set time. After this time, retention settings can be deactivated.

   - **Enforce actions over a specific period**: Retain items for a defined period. After this time, actions like automatic deletion or initiation of a disposition review are enforced.

   - **Just label items**: Labels are used only for classification without enforcing any retention or deletion actions.

1. If **Retain items forever or for a specific period** or **Enforce actions over a specific period** was selected in the previous step, **Define the retention period** and **Choose what happens after the period**.

1. Review your settings and finish the **Create retention label** configuration.

### Steps to publish the retention label

After creating the label, you need to publish them through a retention label policy, which makes them available to users in your organization to classify and manage content.

1. Return to **File plan** from either the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) or [Microsoft Purview compliance portal](https://compliance.microsoft.com/?azure-portal=true).

1. Select the retention label you'd like to publish and select the **Publish labels** icon (:::image type="icon" source="../media/publish-retention-label-icon.png":::) to start the configuration to publish your retention label.

1. On the **Assign admin units** page, if your organization uses administrative units, assign the policy to specific units to restrict its application to designated users or departments.

1. Select the scope type for your retention policy.

1. On the **Choose where to publish labels** page select either **All locations** or **Let me choose specific locations**.

1. Give your policy a unique name, and submit your changes to create your retention label policy and complete the configuration.

## When retention labels become available to apply

The visibility of retention labels can vary based on the service:

- **SharePoint and OneDrive**: Labels usually appear within one day, but it can take up to seven days.
- **Exchange**: Labels can take up to seven days to appear and require the mailbox to have at least 10 MB of data.

:::image type="content" source="../media/retention-labels-published-timings.png" alt-text="Diagram illustrating when retention label policies are available to apply.":::

If labels don't appear as expected, verify the policy status and consider using PowerShell commands to troubleshoot or force policy distribution.

Retention labels are an important feature of Microsoft Purview, ensuring data is managed according to policies and regulations. Creating and publishing these labels helps strengthen your organization's data management strategy and ensures compliance across all digital content.
