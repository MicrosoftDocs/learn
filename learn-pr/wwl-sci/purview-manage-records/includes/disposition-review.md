When content reaches the end of its retention period, it doesn't always make sense to delete it automatically. Sometimes, content needs to be kept longer for legal, regulatory, or business reasons. Disposition reviews provide a way to evaluate content before it's permanently deleted.

## What is a disposition review?

A disposition review lets designated reviewers examine items before deletion and decide what to do with them. This helps ensure content isn't deleted if it's still needed or subject to additional requirements.

Reviews take place in the **Disposition** section of the **Records Management** solution in the Microsoft Purview portal. Reviewers are notified by email when items are ready for review and receive weekly reminders until the task is complete. Notifications can be customized for different languages if needed.

## What you need before getting started

Before you create or manage disposition reviews, make sure the following requirements are in place:

- **Roles and permissions**: Reviewers need the **Disposition Management** role, which is part of the **Records Management** role group. Global Admins don't get this role by default.

- **Access to content**: To view files during review, users also need the **Content Explorer Content Viewer** role.

- **Reviewers must be mail-enabled security groups**: Add reviewers individually or by assigning them to mail-enabled security groups created in the Microsoft 365 admin center. Microsoft 365 groups aren't supported, and changes must be made using PowerShell.

- **Admin visibility**: To see all reviewable items, a records admin must be part of the designated mail-enabled security group listed in Records Management settings.

- **Audit logging enabled**: Turn on audit logging at least a day before using disposition review so actions can be captured.

## Configure a label for disposition review

Disposition reviews are only supported with **retention labels**, not retention policies.

To enable disposition review:

1. When creating or editing a retention label, under **Choose what happens after the retention period**, select **Start a disposition review**.

   :::image type="content" source="../media/disposition-review-option.png" alt-text="Screenshot showing the option to Start a disposition review." lightbox="../media/disposition-review-option.png":::

1. Select **+ Create stages and assign reviewers**. You can add up to five stages, each with its own group of reviewers.

1. Optionally, set an automatic approval window between 7–365 days. If no action is taken in that time, the item moves to the next stage or is deleted.

1. Add reviewers using individual names or mail-enabled security groups. Each reviewer must have the **Disposition Management** role.

1. After label creation, you can rename stages and update reviewers—but you can't change the stage order or remove stages.

## Perform a disposition review

Reviewers can open the **Disposition** section in the Microsoft Purview portal or through email, but must be assigned the **Disposition Management** role in **Records Management** to take action on items.

:::image type="content" source="../media/disposition-review-email.png" alt-text="Screenshot showing the email notification for a disposition review." lightbox="../media/disposition-review-email.png":::

- **Review visibility**: Reviewers only see items assigned to them. Admins who need to see all items must be part of the designated review group.

- **Review actions**: Reviewers can:

  - Approve deletion
  - Extend retention
  - Apply a different retention label
  - Assign additional reviewers

  All actions are captured in the audit log. The review panel shows item details and history to help reviewers make informed decisions.

  :::image type="content" source="../media/retention-disposition-options.png" alt-text="Screenshot showing the options available during disposition review." lightbox="../media/retention-disposition-options.png":::

- **Exchange requirement**: To appear in a disposition review, an Exchange mailbox must have at least 10 MB of content.

## Export disposition review activity

You can export disposition review activity to a .csv file for compliance tracking or internal reporting. This provides a record of all actions taken during the review process.
