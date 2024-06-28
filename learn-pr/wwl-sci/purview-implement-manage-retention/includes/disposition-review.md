Disposition reviews are critical processes conducted at the end of an item's retention period. These reviews determine whether content should be permanently deleted or retained further, ensuring alignment with compliance requirements and organizational policies.

To perform a disposition review, you need to access the Disposition page within Records Management in Microsoft Purview. This feature allows for the management of disposition reviews and provides a way to view the metadata of items that have been marked as records and automatically deleted after their retention period.

## Prerequisites for managing dispositions

### Manage access for disposition reviews

Managing disposition tasks requires the **Disposition Management** role, typically included in the **Records Management** default role group. Global administrators don't receive this role by default, emphasizing the need for deliberate permission assignment.

- For organizations needing precise control over who performs disposition reviews, consider creating a specific group, like **Disposition Reviewers**. Ensure this group is assigned the **Disposition Management** role to access necessary functionalities.
- Viewing the content involved in disposition reviews might be necessary to make informed decisions. Assign the **Content Explorer Content Viewer** role to those who need to inspect the items closely. Users not assigned this role can still participate in the review process but won't have direct access to view the item's contents.
- For comprehensive management, create mail-enabled security groups. These groups allow managing permissions collectively rather than individually. Only the group members have access to the Disposition page, not the owners. You can set up new mail-enabled groups through the Microsoft 365 admin center. Once created, the groups' settings related to disposition can’t be modified directly from the Purview portals; any changes require PowerShell interventions.

### Enable auditing

Auditing should be enabled at least one day before conducting the first disposition action to ensure all activities are logged properly.

## Configure a retention label for disposition review

Disposition reviews help determine if content should be retained or deleted at the end of its retention period. This feature is available only with retention labels, not retention policies.

1. In the retention label settings, on the **Choose what happens after the retention period**, select **Start a disposition review**. This will open options for setting up the review stages.
   :::image type="content" source="../media/disposition-review-option.png" alt-text="Screenshot showing the option to Start a disposition review." lightbox="../media/disposition-review-option.png":::
1. Select **+ Create stages and assign reviewers**. Specify how many stages you need and who will review each stage. You can add up to five stages.
1. Optionally, set up automatic approvals by defining how many days, 7-365, to wait before moving the content to the next stage without manual approval. If the designated reviews don't take manual action during this time period, the item automatically passes to the next review stage. If the item is in the final review stage, the item is automatically removed permanently.
1. Under **Reviewers for this stage**, add up to 10 individuals or mail-enabled security groups per stage. Microsoft 365 groups aren't supported. Ensure all reviewers have the necessary **Disposition Management** role assigned to perform their duties.
1. During configuration for each stage, you can rename, add, or configure each stage's settings. You can't reorder or remove a stage after you've created the retention label. You'll see only the **Add a stage** and **Rename a stage options** available. You can still edit the reviewers.
