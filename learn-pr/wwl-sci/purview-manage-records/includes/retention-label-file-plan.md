
Managing records at scale requires more than just creating retention labels. You also need a way to structure, categorize, and review those labels consistently across your organization. Using the file plan in Records Management, you can organize retention labels, assign classification metadata, and meet governance needs like declaring records or conducting disposition reviews.

## Why use the file plan?

Retention labels can be created from either **Data lifecycle management** or **Records management** in the Microsoft Purview portal. The file plan is available through Records management and provides extra functionality that supports formal records management processes.

The file plan lets you:

- View all retention labels in a centralized, filterable list.
- Export existing labels to a .csv file for offline analysis or periodic reviews.
- Bulk-import labels using a standardized .csv template.
- Add optional **file plan descriptors** to help classify and organize labels by business function, regulatory authority, or legal requirement.

You can use the file plan for any retention label, whether or not the label marks content as a record.

## Access the file plan

To open the file plan in the Microsoft Purview portal, you must have one of the following roles:

- **Retention Manager**
- **View-only Retention Manager**

Then, go to **Solutions** > **Records management** > **File plan**.

Any retention labels previously created in Data lifecycle management also appears here automatically. Likewise, labels created through the file plan can be managed from either area—unless they're configured to declare content as a record, which limits some settings to Records management only.

## View and manage label properties

From the **File plan** page, you can view all your retention labels along with key properties that support record governance. You can customize the columns that are shown, but the default view includes important fields like:

- **Status**: Whether the label is active in a label policy or auto-apply policy.
- **Based on**: The event or condition that starts the retention period.
- **Is record**: Whether the label marks content as a record or regulatory record.
- **Disposition type**: Whether content is deleted, reviewed, or retained at the end of the retention period.
- **Relabel to**: If a different label should be applied after the retention period ends.

These details help you identify which labels are used for recordkeeping, how long content is retained, and what happens to it afterward.

## Use file plan descriptors for structured classification

File plan descriptors let you add optional metadata to each label to support classification, reporting, and internal governance standards. These descriptors include:

- **Business function or department**
- **Category**
- **Authority type**
- **Provision or citation**
- **Reference ID**

You can assign predefined values or create your own values for each descriptor when creating or editing a retention label. For example, you might use the **Authority type** descriptor to link a label to a specific regulatory agency, or use **Provision/citation** to reference the relevant law or policy.

This structured metadata supports internal audits, classification schemes, and file plan consistency.

## Export or import retention labels

The file plan includes options to manage labels in bulk:

- **Export**: Download all retention labels and their properties into a .csv file for review and collaboration.
- **Import**: Create new retention labels in bulk by uploading a completed .csv template.

When importing labels, you can define all label settings—including file plan descriptors—and validate the file before the labels are added. This is especially useful when onboarding large classification schemes or reorganizing existing labels.

## Edit or delete labels from the file plan

You can edit an existing label directly from the file plan unless the label has settings that are locked after creation (such as the name or record declaration setting).

You can also delete labels that:

- Aren't part of a published or auto-apply policy.
- Don't declare items as regulatory records.
- Haven't already been applied to content.
- Isn't configured for event-based retention

If a label can't be deleted because it has been applied, you see a link to **Content explorer** to identify where it's in use.
