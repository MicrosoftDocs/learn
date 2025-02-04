The **Review data** stage is a key part of subject rights requests. This step involves evaluating content items collected during the data retrieval process. Collaborators refine the dataset to ensure only relevant and accurate information is included in the final report. A dedicated Microsoft Teams channel is created automatically to facilitate collaboration during this stage.

## Key tasks in the review process

During this stage, you perform these tasks:

- Import other files
- Start with priority items
- Filter the item list
- Mark items as Include or Exclude
- Identify duplicates
- Download files
- Apply data review tags
- Redact content
- Enter notes about a file

## Import files

If relevant content resides outside Microsoft 365 or was missed during the automated search, you can manually import files into the **Data collected** tab. Imported files are added to the same Azure Blob Storage container as other collected items.

1. In the **Data collected** tab, select **List actions** (paper and pencil icon) from the command bar.
1. Under **Import files**, select **Choose files** and upload the desired items.
1. Confirm the files in the **Import files** box, then select **Import**.

**Details**:

- Maximum file size is 500 MB.
- Imported files might take up to 20 minutes to process.
- Multiple users can upload files simultaneously, but this might affect upload times.

## Start with priority items

The **Priority items to review** tile on the request's overview page highlights flagged content items, such as those with conflicts. Start your review here to address critical issues early, like items marked for deletion but blocked by retention labels. Selecting these items provides more context and guidance for resolving conflicts.

## Filter the item list

Filters help manage large datasets by narrowing results. Microsoft Priva offers:

- **Basic filters**: Quickly sort items by properties like content type, location, and date.
- **Advanced filters (preview)**: Build complex queries using metadata, sensitive info types, and classification labels.

**Steps for basic filters**:

1. In the **Data collected** tab, select **Filter**.
1. Choose from available options, such as **Content Type** or **Date Range**.
1. Apply filters and review the results.

**Steps for advanced filters**:

1. Toggle to **Advanced filter**.
1. Build queries using operators and parameters.
1. Save queries for reuse.

## Mark items as Include or Exclude

Review items on the **Data collected** tab to determine relevance. For each item:

- Select **Include** to add it to the final report.
- Select **Exclude** if it's irrelevant; you must provide a note justifying the exclusion.
- Select **Not a match** for false positives, then confirm in the flyout pane.

By default, only included items are part of the final reports.

## Identify duplicates

Streamline the review process by identifying duplicate items. Priva allows you to:

- **Detect duplicates**: Use the **List actions** command to start the identification process. This can take several minutes to complete.
- **View duplicates**: Items marked as duplicates are flagged in a new **Duplicates** column.
- **Hide duplicates**: Filter the item list to focus on unique content.
- **Apply actions in bulk**: Mark all duplicates of a representative item with the same status (for example, Include or Exclude).

Applying actions in bulk ensures efficiency by reducing repetitive reviews for identical content.

### Important considerations for hidden duplicates

When duplicates are hidden, any actions you take, such as **Include**, **Exclude**, or redaction on a representative item might not reflect the corresponding duplicates in the hidden view. This could lead to inconsistent decisions or incomplete processing of items.

To avoid this issue:

- Identify and review duplicates before taking any actions on the representative items. This ensures all duplicates are visible and can be reviewed consistently.
- If duplicates are already hidden, review the representative item carefully. Use the **Duplicates** column to view and apply actions to all associated duplicates in bulk.

By planning your review process around duplicates, you can maintain accuracy and streamline decision-making for the entire dataset.

## Download files

For items that can't be reviewed within the content area, you can download them for offline examination or redaction:

1. Select the item from the list.
1. Choose **Download** from the command bar.
1. Make necessary changes locally, then reimport the file if needed.

> [!NOTE]
> Changes made locally don't automatically sync with the request. Files must be reimported to reflect updates.

## Apply data review tags

Tags help organize items and communicate with collaborators. Priva provides:

- **Default tags**: Two preconfigured tags (Follow-up and Update).
- **Custom tags**: Up to 21 extra tags you can define.

To apply tags:

1. Select an item or multiple items.
1. Choose **Apply tags** from the command bar.
1. Select or create tags in the flyout pane, then save your changes.

Tags don't initiate actions but serve as markers to flag items for further attention or categorization.

## Redact content

Redactions ensure sensitive or irrelevant information is removed before providing data to the subject. Use the **Redact** tab for:

- **Assisted redaction (preview)**: Highlights recommended redactions based on personal data types unrelated to the subject.
- **Search and redact (preview)**: Find specific terms or values to redact across the content.
- **Manual redaction**: Use annotation tools to block content directly.

Redactions create a PDF version of the item, preserving the original file. Annotate redacted areas with custom text if needed.

## Enter notes about a file

Add contextual notes for items or the overall request:

- **File notes**: Add comments specific to an item.
- **Case notes**: Provide general notes about the request.

Notes are visible to collaborators but not included in the final report.

## Collaboration for data review

When a request is created, a Teams channel is automatically set up for collaboration. Administrators can:

- Add collaborators: Assign users to the request via the **Collaborators** tab. Share the request link with them directly.
- Communicate in Teams: Use the **Chat with collaborators** feature to discuss the request.
- Manage roles: Collaborators are assigned the **Privacy Management Contributors** role, allowing them to assist with the request.
- Remove collaborators: Remove users via the **Collaborators** tab, except for the request creator.

The Teams integration enables seamless communication and task delegation among stakeholders.

## Complete the review

Once all items are reviewed and marked, complete the process:

1. Select **Complete review** in the upper-right corner.
1. Add internal notes as needed.
1. Confirm the completion to prepare the request for final reporting.

By following these steps, you can ensure a thorough and compliant review process for subject rights requests.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
