Retention policies and labels are crucial tools in SharePoint Online and OneDrive, helping organizations manage their data in line with legal and regulatory standards. These tools ensure that necessary information is retained and obsolete data is deleted appropriately.

## Overview of retention in SharePoint and OneDrive

Effective retention settings are vital for compliance and efficient data management in SharePoint and OneDrive. These settings help organizations in meet legal obligations and manage the lifecycle of their data.

When you apply retention policies and retention labels, a Preservation Hold library is automatically created if it doesn't already exist. This hidden library stores files required for compliance and is accessible only to site collection administrators at the top level of sites. These files can't be directly modified, deleted, or moved, and are managed using compliance tools like eDiscovery.

### Dynamics of retention in SharePoint and OneDrive

- **Configuration**: Initial retention policies are applied to all existing and new content, setting the stage for comprehensive data management.
- **Modifications and deletions**: Edited or deleted documents are preserved in the Preservation Hold library to maintain compliance. Any attempt to alter or remove documents under retention are checked for unauthorized changes. Users attempting to delete protected items receive error notifications.
- **Periodic reviews**: A timer job periodically runs and compares files older than 30 days in the Preservation Hold library against retention rules. Files exceeding their retention period without a pending disposition review are marked for removal. This timer job runs every seven days, which means that together with the minimal 30 days, it can take up to 37 days for content to be deleted from the Preservation Hold library.

### Retention lifecycle in SharePoint and OneDrive

How content is handled in SharePoint and OneDrive depends on the applied retention settings: **retain and delete**, **retain-only**, and **delete-only**. Each setting affects the content's path from its creation to its potential deletion, aligning organizational data management with compliance protocols.

:::image type="content" source="../media/preservation-hold-libraries.png" alt-text="Diagram of content lifecycle in SharePoint and OneDrive." lightbox="../media/preservation-hold-libraries.png":::

| Scenario | Modified or deleted content| Unmodified content|
| :--- | :--- | :--- |
| **Retain and delete**| Content that is modified or deleted is first stored in the Preservation Hold library. After the retention period ends, it moves to the second-stage Recycle Bin, staying there for 93 days before permanent deletion.| Content that remains unchanged is moved to the first-stage Recycle Bin at the end of the retention period. If purged by the user, it moves to the second-stage Recycle Bin for permanent deletion after 93 days.|
| **Retain-only**| Modified or deleted content is kept in the Preservation Hold library until the retention period ends, then it moves to the second-stage Recycle Bin and permanently deleted after 93 days.| Stays indefinitely in its original location, unaffected by retention operations.|
| **Delete-only**|Actively deleted content directly moves to the first-stage Recycle Bin, and if not restored, proceeds to the second-stage Recycle Bin for permanent deletion after 93 days.| Is treated as deleted at the end of the retention period and follows the same deletion path, ending in permanent deletion after moving through both Recycle Bin stages.|

When users clear content from the first-stage Recycle Bin, it quickly moves to the second-stage, starting a 93-day countdown to its permanent deletion. Content in Recycle Bins isn't indexed and thus invisible to eDiscovery tools, potentially affecting compliance and legal investigations. If content falls under another retention policy, label, or legal hold that requires extended retention for compliance or investigative purposes, its permanent deletion is postponed.

## Retention with cloud attachments

Cloud attachments in Outlook, Teams, or Viva Engage are managed through retention labels. A copy of shared files is stored in the Preservation Hold library:

- **Start of retention period**: Setting the retention period to begin when the label is applied is recommended. If set to begin based on the creation or last modification date of the original file, these settings might not reflect the file's lifecycle your organization uses them.
- **Modifications**: If the original file is modified and shared again, a new copy of the file is saved as a new version in the Preservation Hold library, maintaining its compliance status.
- **Re-sharing without modification**: If the file is shared again without modifications, the labeled date in the Preservation Hold library is updated, resetting the start of the retention period.

Because the retention label isn't applied to the original file, users never modify or delete the labeled file. The labeled file stays in the Preservation Hold library until the timer job identifies that its retention period is over. If the retention settings are configured to delete items, the file is then moved to the second-stage Recycle Bin, where it undergoes permanent deletion at the end of 93 days:

:::image type="content" source="../media/retention-diagram-of-retention-flow-cloud-attachments.png" alt-text="Diagram showing how retention works for cloud attachments stored in SharePoint and OneDrive." lightbox="../media/retention-diagram-of-retention-flow-cloud-attachments.png":::

### Safeguards against deletion

To prevent premature deletion or movement of the original file, any files in auto-labeled locations are copied to the Preservation Hold library if deleted or moved, ensuring retention for at least one day.

## How retention works with OneNote content

OneNote notebooks consist of multiple sections, each treated as an individual file under retention policies. When a retention policy or label is applied to a OneNote folder, all sections within inherit these settings, affecting every page contained within those sections. This unique structure ensures that entire sections, along with their pages, are retained or deleted together, according to the specified retention settings. It's important to note that the **Modified** date seen on each notebook doesn't influence Microsoft 365's retention decisions.

:::image type="content" source="../media/onenote-backend-structure.png" alt-text="Diagram showing the OneNote folder and file structure to demonstrate how retention settings are applied to each section.":::

## How retention works with document versions

Versioning in SharePoint and OneDrive helps manage document revisions by retaining up to 500 major versions by default. This limit can be adjusted based on organizational needs. For documents subject to retention settings, versions are consolidated into a single file within the Preservation Hold Library to improve performance, a change implemented in July 2022. This consolidation applies unless the document is marked as a record, where versions continue to be stored separately to allow independent expiration.

For nonrecord documents:

- **Based on creation, labeling, or event start**: All versions expire at the same time with the original document.
- **Based on last modification**: All versions share the expiration date of the last document version, expiring together.

When a document marked for deletion under retention settings reaches its expiration, all versions not stored in the Preservation Hold Library are also deleted. Retention policies or eDiscovery holds override versioning limits, preserving all versions until the hold or policy expires. For documents with retention labels not under a specific policy or hold, standard versioning limits apply. This restriction means older versions might be purged to make room for new ones. However, users are still restricted from deleting versions manually.

## Handling employee departures

When an employee leaves the organization, the retention and management of their digital content varies between SharePoint and OneDrive based on the nature of each platform and the applied retention policies.

- **SharePoint**: In SharePoint, the platform is designed for collaborative work, so content created by a departing user remains unaffected. This feature ensures work continuity without disruption.
- **OneDrive**: Files are retained according to active retention policies or labels. They remain accessible and searchable until the retention period ends, then moved to the Site Collection Recycle Bin, aligning with compliance needs while preventing data loss too soon.
