When content reaches the end of its retention period, organizations need a process to decide what happens next. Should the item be permanently deleted, or is there a need to retain it longer for legal, regulatory, or business reasons? Disposition reviews help answer that question.

## What is a disposition review?

A disposition review provides a final checkpoint before content is deleted at the end of its retention period. This process is managed in the **Disposition** section under **Records Management** in the Microsoft Purview portal. From there, reviewers and administrators can view content ready for review and take action based on organizational policies.

Reviewers are notified by email when items are ready for review. These notifications can be customized in multiple languages to support global teams. Reviewers also receive weekly reminder emails until they complete their assigned reviews.

## Prerequisites

Before configuring or managing disposition reviews, ensure these prerequisites are met:

- **Roles and permissions**: Users managing reviews must have the **Disposition Management** role, which is part of the **Records Management** role group. Global Administrators aren't assigned this role by default.

  For easier administration, consider creating a mail-enabled security group such as **Disposition Reviewers** and assigning the role to that group.

- **Access to content**: Reviewers who need to see the contents of an item must also have the **Content Explorer Content Viewer** role. Without it, they still see the review task but aren't able to view the file.

- **Reviewer groups**: Reviewers must be added individually or through **mail-enabled security groups** created in the Microsoft 365 admin center. Microsoft 365 groups aren't supported. Changes to these groups can't be made through the Microsoft Purview portal and must be done using PowerShell.

- **Visibility for administrators**: To see all disposition items, a records management admin must be a member of the selected mail-enabled security group in the Records Management settings.

- **Auditing enabled**: Turn on audit logging at least one day before conducting disposition reviews to ensure actions are properly captured.

## Configure a retention label for disposition review

Disposition reviews are only available with retention labels—not retention policies. During label configuration:

1. Under **Choose what happens after the retention period**, select **Start a disposition review**.

   :::image type="content" source="../media/disposition-review-option.png" alt-text="Screenshot showing the option to Start a disposition review." lightbox="../media/disposition-review-option.png":::

1. Select **+ Create stages and assign reviewers**. You can add up to five review stages and define who is responsible for each stage.

1. Optionally, define an automatic approval window (7–365 days). If reviewers don't take action within this timeframe, the item automatically advances to the next stage or is deleted if it's the final stage.

1. For each stage, add up to 10 individual reviewers or mail-enabled security groups. Reviewers must have the **Disposition Management** role.

1. You can rename stages and update reviewers, but you can't reorder or remove stages after the label is created.

## Perform a disposition review

Reviewers can access the **Disposition** section directly from the Microsoft Purview portal or through the email notification link.

:::image type="content" source="../media/disposition-review-email.png" alt-text="Screenshot showing the email notification for a disposition review." lightbox="../media/disposition-review-email.png":::

- **Access and visibility**: Administrators can see all pending and completed disposition items if they have been added to the designated mail-enabled security group in the Records Management settings. Reviewers only see items assigned to them.

- **Available actions**: Reviewers can approve permanent deletion, apply a new retention label, extend retention, or assign more reviewers. Each action is auditable. The review pane includes tabs such as **Details** and **History** to help reviewers evaluate item metadata, location, and previous actions.

  :::image type="content" source="../media/retention-disposition-options.png" alt-text="Screenshot showing the options available during disposition review." lightbox="../media/retention-disposition-options.png":::

- **Mailbox size requirement**: For Exchange mailbox items to be eligible for disposition review, the mailbox must contain at least 10 MB of data.

## Export review activity

To support compliance or internal reporting, disposition review data can be exported as a .csv file. This provides a record of actions taken and decisions made during the review process.
