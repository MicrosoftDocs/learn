Disposition reviews are critical processes conducted at the end of an item's retention period. They determine whether content should be permanently deleted or retained further to align with compliance requirements and organizational policies. These reviews are managed through the Disposition page within Records Management in Microsoft Purview. This page also allows for the monitoring of records that are at the end of their lifecycle.

## Understand disposition reviews

Disposition reviews are initiated when content reaches its retention endpoint, which might occur for various reasons like litigation holds, policy adjustments, or archival needs. Reviewers are alerted through email notifications that detail the content due for review. These notifications can be customized in multiple languages to accommodate global teams, ensuring all reviewers understand their responsibilities and the actions they might need to take.

## Prerequisites for managing dispositions

- **Access and roles**: Managing disposition tasks requires the **Disposition Management** role, included in the **Records Management** default role group. It's important to note that global administrators don't automatically receive this role, requiring the need for intentional assignment of permissions.
  - **Create a specific group**: For tighter control, creating a group like **Disposition Reviewers** and assigning them the **Disposition Management** role can streamline the process.
  - **View content**: The **Content Explorer Content Viewer** role is necessary for users who need to closely inspect items under review. Without this role, users can participate in reviews but can't view the item's contents directly.
  - **Use of security groups**: For efficient management, setting up mail-enabled security groups through the Microsoft 365 admin center is advised. Remember, once configured, these groups can't be modified in the Purview portals without PowerShell commands.

- **Enable auditing**: Auditing should be enabled at least one day before conducting the first disposition action to ensure all activities are logged properly.

## Configure a retention label for disposition review

Disposition reviews help determine if content should be retained or deleted at the end of its retention period. This feature is available only with retention labels, not retention policies.

1. In the retention label settings, on the **Choose what happens after the retention period**, select **Start a disposition review**. This opens options for setting up the review stages.
   :::image type="content" source="../media/disposition-review-option.png" alt-text="Screenshot showing the option to Start a disposition review." lightbox="../media/disposition-review-option.png":::
1. Select **+ Create stages and assign reviewers**. Specify how many stages you need and who reviews each stage. You can add up to five stages.
1. Optionally, set up automatic approvals by defining how many days, 7-365, to wait before moving the content to the next stage without manual approval. If the designated reviews don't take manual action during this time period, the item automatically passes to the next review stage. If the item is in the final review stage, the item is automatically removed permanently.
1. Under **Reviewers for this stage**, add up to 10 individuals or mail-enabled security groups per stage. Microsoft 365 groups aren't supported. Ensure all reviewers have the necessary **Disposition Management** role assigned to perform their duties.
1. During configuration for each stage, you can rename, add, or configure each stage's settings. You can't reorder or remove a stage after you create the retention label. In the portal, you only see the **Add a stage** and **Rename a stage options** available. You can still edit the reviewers.

## Conduct a disposition review

- **Accessing the disposition page**: Reviewers can directly access the Disposition page from the links provided in their notification emails or through navigation within the Microsoft Purview portals.

   :::image type="content" source="../media/disposition-review-email.png" alt-text="Email notification for a disposition review." lightbox="../media/disposition-review-email.png":::

- **Overview and management**: Administrators have access to an overview of all pending and completed dispositions on the Disposition page. Individual reviewers only see dispositions assigned to them.

   :::image type="content" source="../media/dispositions-overview.png" alt-text="Overview of pending dispositions." lightbox="../media/dispositions-overview.png":::

- **Actions during review**: During the review, actions such as approving disposal, relabeling items, extending retention, or adding reviewers can be taken based on the organizational needs and outcomes of the review. Each action is auditable to ensure transparency. More reviewers must be granted appropriate permissions to participate. The mini-review pane provides detailed information about the item, including its history and properties, to aid in informed decision-making.

   :::image type="content" source="../media/retention-disposition-options.png" alt-text="Options available during disposition review." lightbox="../media/retention-disposition-options.png":::

### Exporting data

For further analysis or compliance documentation, disposition data can be exported as a .csv file. This process helps maintain detailed records of disposition actions and outcomes, supporting ongoing compliance and data management standards.
