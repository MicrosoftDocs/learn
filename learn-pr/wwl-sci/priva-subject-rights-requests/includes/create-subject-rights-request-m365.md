Creating a subject rights request is the first step in responding to an individual's privacy request. With Microsoft Priva, organizations can automate much of the process, reduce manual effort, and provide accurate results on time.

Organizations often need to respond when employees or customers ask to see or delete their personal data. Instead of searching manually across services, administrators can use a subject rights request to ensure the process is consistent and compliant.

## Request types

Microsoft Priva supports four request types:

- **Access**: Summarizes personal data held in Microsoft 365 for the individual.
- **Export**: Provides a summary and an exported file of content items that contain the individual's personal data.
- **Tagged list for follow-up**: Compiles files that were tagged during data review.
- **Delete**: Removes content items that contain the individual's personal data after approval and in accordance with retention policies.

Delete requests include extra steps beyond creation. Here you'll see how to start one, with details about approvals and retention later in the process.

## Create a request

Before you create a subject rights request, ensure the user has all roles in the **Subject Rights Request Administrators** role group.

You can start a request in two ways:

- **Template**: A quick option with default settings for Access, Export, or Tagged list for follow-up. You can review and adjust defaults as you go.
- **Custom setup**: A guided process that lets you configure every detail, including locations, search scope, and deadlines.

If this is your first time in **Subject Rights Requests**, you might see a banner with **Get started**. Selecting it opens a pane with your own name and email prepopulated so you can explore the workflow. You can replace those details with an actual data subject before creating the request.

### Steps to create a request

1. Go to the [Microsoft Priva portal](https://purview.microsoft.com/priva) and open **Subject Rights Requests**.
1. Under **Data within Microsoft 365**, select **Microsoft 365 requests**, then select **New request**.
1. Choose either **Template** or **Custom** setup:

   - **Template**: Pick **Access**, **Export**, or **Tagged list for follow-up**, then confirm or edit the default settings.
   - **Custom**: Complete the wizard to configure all details, including:

     - **Data subject information**: Provide email and any identifiers such as name, nicknames, or phone number.
     - **Relationship to the organization**: Choose from options such as current employee, former employee, customer, or other. This choice sets defaults for the search.
     - **Locations**: Select Exchange, SharePoint, OneDrive, or Teams. Search all accounts or limit to specific ones.
     - **Request type**: Access, Export, or Tagged list for follow-up.
     - **Deadline and regulation**: Optional, but helpful for tracking.
     - **Request details**: Confirm or edit the name and description.
1. Review your selections and select **Create request**. The request now appears in the main list. By default, its name includes the data subject's name and the request type. You can edit the name and description at any time.

## Define search settings

Search settings control how much data is returned and how precise the results are. After choosing locations, you can refine scope or stage the workflow:

- **Refine your search**: Add conditions such as item name, sender or recipient, personal data type, or whether an item was shared externally.
- **Include authored content**: Decide whether to add files created or uploaded by the individual. This often increases the amount of data collected.
- **Include version history**: For SharePoint content, choose whether to include all versions or only the most recent.
- **Get an estimate first**: Show an estimate and a sample of discovered items before full retrieval. If the sample looks correct, select **Retrieve data** to continue.

Requests usually move from **Data estimate** to **Data retrieval** automatically. If the system predicts a large volume, you'll have a chance to adjust settings before collection continues.

## Manage delete requests

Delete requests add controls to ensure compliance:

- **Approvals**: Assign at least one approver. Items marked for deletion must be reviewed and approved.
- **Retention conflicts**: Existing retention policies take precedence. Items blocked by retention are excluded and flagged in reports.
- **Review and tagging**: Collaborators mark items for deletion by including them. Approvers verify or send items back for changes.
- **Progress tracking**: The request details page shows status and conflicts. Eligible items are deleted within 30 days.

Because retention can block deletion, coordinate with records management to resolve conflicts and communicate outcomes to the individual.

## Next steps

After creating a request, proceed to the review stage. You'll decide what to include, exclude, or redact, and prepare the package for reporting.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
