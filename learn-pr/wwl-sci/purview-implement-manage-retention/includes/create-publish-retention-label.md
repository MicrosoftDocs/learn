Retention labels in Microsoft Purview help you control how long to keep files and when to delete them. You can use them to meet regulatory requirements, manage risk, and improve how your organization handles information. Labels can be applied manually or automatically, and they're a key part of your data lifecycle strategy.

## Create a retention label

You can create a retention label either from the **Data Lifecycle Management** section or by using the **File plan** in **Records Management**. The main difference is that the file plan includes extra classification features like bulk actions, detailed overviews, and metadata tags (called descriptors). If you're managing just a few labels or don't need structured classification, you can create them directly in Data Lifecycle Management instead.

### What is a file plan?

A file plan is a structured way to manage retention labels across your organization. It gives you a centralized view of all your labels and lets you organize them by categories like department, function, or regulatory authority. File plans are especially helpful when you need to manage many labels or align your data governance practices with formal records management standards.

## Steps to create a retention label using file plan

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) and select **Solutions** > **Records management** > **File plan**.

1. Select **Create a label** and give it a name.

1. On the **Define file plan descriptors** page, you can tag the label with optional metadata like:

   - **Business function or department**
   - **Category**
   - **Authority type**
   - **Provision or citation**

   :::image type="content" source="../media/file-plan-descriptors.png" alt-text="Screenshot showing the Define file plan descriptors for this label page."::: with optional metadata like:

1. Choose what happens to content with this label:

   - Retain forever or for a specific time
   - Retain then delete
   - Just label for classification without retention or deletion

1. If you selected retention, choose the length of time and what happens when that time ends.

1. Review and finish your configuration.

## Publish a retention label

To make your label available to users or apply it across your Microsoft 365 services, you need to publish it through a retention label policy.

1. In the file plan, find your label and select the **Publish labels** icon (:::image type="icon" source="../media/publish-retention-label-icon.png":::).

1. Choose whether the policy uses an adaptive or static scope.

   - **Adaptive scope**: Uses dynamic membership based on user or site attributes. Make sure the scope already exists.
   - **Static scope**: Lets you manually choose locations like Exchange mailboxes or SharePoint sites.

1. Select the specific services or locations where the label should be available.

1. Name your policy and finish setup.

> [!NOTE]
> Retention label policies can't be scoped using administrative units. If you need to scope retention settings by administrative unit, consider using a retention policy instead.

## When the label becomes available

Retention labels don't appear immediately and might take up to seven days to propagate across services:

:::image type="content" source="../media/retention-labels-published-timings.png" alt-text="Diagram illustrating when retention label policies are available to apply.":::

- **SharePoint and OneDrive**: Usually visible within 24 hours but can take up to 7 days

- **Exchange**: Can take up to 7 days; the mailbox must have at least 10 MB of data

If your labels don't appear, double-check that the policy is active. You can also use PowerShell to verify status or force distribution.

Retention labels help ensure your organization's data is kept as long as needed and removes it when it's no longer needed. Whether you're managing content manually or automating retention across services, labels give you the control and visibility to manage data confidently.
