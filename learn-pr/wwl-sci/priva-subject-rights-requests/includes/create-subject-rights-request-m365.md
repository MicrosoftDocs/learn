Creating a subject rights request is the first step in responding to an individual's privacy request. With Microsoft Priva, organizations can automate much of the process, reduce manual effort, and provide accurate results on time.

Organizations often need to respond when employees or customers ask to see or delete their personal data. Instead of searching manually across services, administrators can use a subject rights request to ensure the process is consistent and compliant.

## Prerequisites

To create a subject rights request, the user must have all roles in the **Subject Rights Request Administrators** role group.

## Request types

Microsoft Priva supports four request types:

- **Access**: Summarizes personal data held in Microsoft 365 for the individual.
- **Export**: Provides a summary and an exported file of content items that contain the individual's personal data.
- **Tagged list for follow-up**: Compiles files that were tagged during data review.
- **Delete**: Removes content items that contain the individual's personal data after approval and in accordance with retention policies.

> [!NOTE]
> Delete requests include extra steps beyond what is shown here. This unit covers the essentials and how to start one; see the delete section below for an overview.

## Creating requests

You can create a request in two ways:

- **Template**: A quick option with default settings for Access, Export, or Tagged list for follow-up. You can view and adjust defaults during creation.
- **Custom setup**: A guided process that lets you choose all settings, including data subject details, locations, search settings, and deadlines.

### Getting started with your first request

If this is your first time in **Subject Rights Requests**, you may see a banner with **Get started**. Selecting it opens a pane with your own name and email prepopulated so you can explore the workflow. You can replace those details with an actual data subject before creating the request. Any request you create counts toward your allotment, and standard data retention applies after closure.

## Steps to create a request from a template

1. Go to the [Microsoft Priva portal](https://purview.microsoft.com/priva) and open **Subject Rights Requests**.
1. Select **Microsoft 365 requests**, then select **New request**.
1. Choose **Data access**, **Data export**, or **Data tagged for further action**, and select **Get started**.
1. At **Relationship to organization**, choose the option that fits the individual. This choice sets default search behavior:

   - **Current employee**: Avoids email or Teams items the employee participated in, and files they authored.
   - **Former employee**: Prioritizes the former employee's mailbox and content they authored.
   - **Customer**, **Prospective employee**, or **Other**: Excludes authored content and includes only the most recent SharePoint versions by default.
1. To review or change defaults, select **View settings**, then **Edit settings** to open the guided process.
1. Enter the individual's details. First and last name and email address are typical; country of residence, regulation, and a timeframe are optional.

   - The default timeframe searches content from the last 12 months. You can change it to all time or a custom range.
1. Select **Create**. The new request is listed on the **Subject Rights Requests** page.

By default, the request name includes the data subject's name and the request type. To change it, open the request, select **Edit**, and go to **Request name** to update the name and description.

## Steps to create a custom request

Custom setup lets you configure every step.

1. Go to the [Microsoft Priva portal](https://purview.microsoft.com/priva) and open **Subject Rights Requests**.
1. Under **Data within Microsoft 365**, select **Microsoft 365 requests**, then select **New request** and choose **Custom**.
1. Complete the wizard:

   - **Data subject information**: Provide the email address and any identifiers (name, nicknames, phone, address). Choose the relationship to your organization.
   - **Locations**: Turn on one or both locations:

     - **Exchange** searches mailboxes and Teams chats. Search all accounts or choose specific accounts.
     - **SharePoint** searches SharePoint sites, OneDrive, and Teams channels. Search all sites or choose specific sites.
   - **Search settings**: Adjust defaults or choose to get a data estimate before retrieval.
   - **Select the type of request**: Choose **Access**, **Export**, or **Tagged list for follow-up**. Set the deadline and, if needed, identify the applicable regulation.
   - **Request details**: Confirm or edit the friendly name and description.
1. Review your selections and select **Create request**. You return to the main list with your request added.

## Define search settings

A default search runs based on the locations you selected. Use these options to tighten scope or stage the workflow:

- **Refine your search**: Add conditions to refine your search such as item name, sender or recipient, personal data type, or whether an item was shared externally.
- **Include content authored by the data subject**: Add files created or uploaded by the individual. This can increase the amount of data returned.
- **Include all versions of items**: When searching SharePoint, include version history rather than the most recent version only.
- **Get an estimate first**: Show an estimate and a sample of discovered items before retrieval. If the sample looks right, select **Retrieve data** to collect full content.

After creation, requests typically move from **Data estimate** to **Data retrieval** automatically. If you chose to pause at estimate or the system predicts a large volume, you can review and adjust search settings before proceeding.

## Managing delete requests

Delete requests add controls to ensure compliance:

- **Approvals**: Assign at least one approver. Items marked for deletion are reviewed and must be approved before deletion proceeds.
- **Review and tagging**: Collaborators mark items for deletion by including them. Approvers verify or send items back for changes.
- **Retention conflicts**: Deletion respects existing retention labels and policies. Items blocked by retention are excluded and flagged in reports. Use logs to see why specific items could not be deleted.
- **Monitoring progress**: The request details page shows status and any unresolved conflicts. Eligible items are deleted within 30 days.

Because retention can block deletion, coordinate with records management to resolve conflicts and communicate outcomes to the individual.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
