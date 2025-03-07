Creating a subject rights request is the first step in managing privacy requests effectively. This process allows organizations to locate and retrieve personal data efficiently, ensuring compliance with privacy regulations while streamlining workflows for data discovery and review.

To create a Subject Rights Request, users need to belong to the **Subject Rights Request Administrators** role group. Requests can be created in two ways:

- **Using a template**: A quick, preconfigured option with tailored default settings.
- **Custom setup**: A guided process that allows full customization of request settings.

## Types of requests

Priva Subject Rights Requests support four request types:

1. **Access**: Summarizes the data subject's personal information held by your organization in Microsoft 365.
1. **Export**: Provides a summary and an exported file of the content marked for inclusion during the review process.
1. **Tagged list for follow-up**: Generates a summary of files tagged during data review. Priva provides predefined tags, and you can create custom tags in settings.
1. **Delete**: Removes content items containing a data subject's personal information, pending approval and compliance with retention policies.

## Create a request using a template

Templates simplify the process with default settings for three request types: **Data access**, **Data export**, and **Data tagged for further action**. You can review and modify these settings during the request creation process.

### Steps to create a request

1. Sign in to the [Microsoft Priva portal (preview)](https://purview.microsoft.com/priva) and select **Subject Rights Requests**.

1. In the navigation pane under **Data within Microsoft 365**, select **Microsoft 365 requests**, then select **New request**.

1. Choose the request type such as Data access, then select **Get started** to open a flyout pane.

1. At **Relationship to organization**, select the data subject's relationship with your organization, such as **Current employee**, **Former employee**, or **Other**. This choice adjusts default search settings:
   - **Current employee**: Excludes items authored by or communicated to the employee.
   - **Former employee**: Prioritizes the employee's mailbox and authored items.
   - **Other**: Focuses on the most recent versions of SharePoint items.

1. To review or modify settings, select **View settings** and then **Edit settings** to adjust advanced options.

1. Enter the data subject's details, including required fields, like name and email address. Extra fields like region or regulation type are optional.

1. Select **Create** to finalize the request. The request appears at the top of the request list.

By default, your request is named with the data subject's name and type of request. To edit the request name, select the request from the list to open its details page and select the **Edit** command at the top of the screen. You arrive at the request creation wizard. Select **Next** until you advance to the **Request name** page, where you can edit the name and add a description.

## Create a custom request

Custom requests allow users to tailor every aspect of the request process. You start by choosing a template, and then walk through each setting to customize your policy.

1. Sign in to the Microsoft Priva portal and select **Subject Rights Requests**.

1. Under **Microsoft 365 requests**, select **New request** and choose the **Custom** option.

1. Complete the following steps in the request creation wizard:
   - **Data subject information**: Enter first and family name, email address (required), and additional identifiers if available. Specify the data subject's relationship to your organization.
   - **Locations**: Enable search locations such as Exchange (mailboxes and Teams chats) or SharePoint (including OneDrive and Teams channels).
   - **Define search settings**: Adjust default settings such as including content authored by the data subject or retrieving all versions of SharePoint items. You can also request a data estimate before retrieval begins.
   - **Request type**: Select Access, Export, or Tagged list for follow-up. Specify privacy regulations and adjust deadlines as needed.
   - **Request details**: Review and edit the request's name and description.

1. On the final page, review all entries and select **Create request**. The request is added to your Subject Rights Requests list.

## Customize search settings

You can use advanced search settings to tailor your search and refine the data retrieved for subject rights requests. These options provide flexibility to meet specific organizational needs:

- **Refine your search**: Specify extra properties to narrow the scope, such as item name, sender/recipient, or personal data types. This option improves the accuracy of results by allowing you to focus on relevant data.
- **Include content authored by the data subject**: Retrieve files, documents, or other content created by the data subject. Examples include files uploaded to SharePoint. Enabling this might increase the volume of retrieved data.
- **Include all versions of items**: Expand SharePoint search results to include all previous versions of items in addition to the most recent one. This option is useful when historical versions are required for review.
- **Get an estimate first**: Preview the expected amount of data before starting retrieval. Once the estimate appears on the request details page, you can view sample results to ensure they meet expectations. Select **Retrieve data** to proceed with full content retrieval.

## Manage delete requests

Delete requests include unique steps beyond those required for other request types. They enable the removal of personal data while maintaining compliance with retention and regulatory policies.

### Key steps for delete requests

- **Assign approvers**: When creating a delete request, assign at least one approver to review and approve items marked for deletion. Approvers can recommend changes if necessary.
- **Data review**: Collaborators tag items for deletion by marking them as **Include**. Approvers verify these items and either approve or request adjustments.
- **Delete workflow**: Approved requests trigger the **PrivaDelete** retention label, which is applied to items eligible for deletion. The deletion process evaluates:

  - Conflicts with existing retention labels.
  - Unsupported storage locations.
  - Manually moved or deleted items.

### Interaction with Microsoft Purview Data Lifecycle Management

Microsoft Purview Data Lifecycle Management's features, such as retention labels and policies, are respected during the delete workflow. Key points include:

- **Conflict resolution**: The **PrivaDelete** retention label won't override existing retention labels applied for regulatory or organizational purposes. If an item is already subject to a retention policy, the delete request won't proceed for that item.
- **Visibility into conflicts**: Items with conflicting retention labels are flagged as priority items for review. Administrators can access the Action execution log to understand why specific items couldn't be deleted.
- **Principles of retention**: The workflow adheres to Purview's retention principles, ensuring that compliance obligations aren't inadvertently compromised.

Tip: Collaborate with your organization's records management or compliance teams to resolve retention conflicts and communicate with data subjects about items that can't be deleted.

### Monitor progress and resolve conflicts

The **Action summary** card on the request details page tracks the deletion progress, including unresolved conflicts. Use the Action execution log to view detailed reports and address any flagged items.

### Timeline for deletion

Once approved, the delete workflow begins automatically. Eligible items are deleted within 30 days, but conflicts might delay specific deletions. Regularly monitor reports to ensure items are processed as expected.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
