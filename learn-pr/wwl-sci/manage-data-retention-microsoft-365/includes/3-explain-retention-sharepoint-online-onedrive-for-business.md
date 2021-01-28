To apply retention in SharePoint Online and OneDrive for Business, dedicated libraries for items and versions to hold called Preservation Hold libraries are used. Since OneDrive for Business is implemented with personal site collections in SharePoint Online, it works the same for both services. Files in SharePoint Online are all stored in document libraries and if any action is performed that requires a retention copy of a certain file, it is moved to the site-specific preservation hold library. Preservation Hold libraries are stored on the top level of sites and visible only to site collection administrators.

If someone attempts to change or delete a document that is subject to retention settings, a validation is made whether the content has been changed since the retention settings were applied. If this is the first change since the retention settings were applied, the content is copied to the Preservation Hold library, which allows the person to change or delete the original content stored in the original document library. Any content in a site collection can generally be copied to the Preservation Hold library, independently from retention settings.

A timer job periodically cleans up the Preservation Hold library. This job compares all content in the Preservation Hold library to all queries used by the retention settings for that content. Content that is older than their configured retention period is deleted from the Preservation Hold library, and the original location if it is still there. This timer job runs every seven days, which means that it can take up to seven days for content to be deleted.

This behavior applies to content that exists when the retention settings were applied. In addition, for retention policies, any new content that is created or added to the site collection after it was included in the policy will be retained after deletion. However, new content is not copied to the Preservation Hold library the first time it is edited, only when it is deleted. To retain all versions of a file independently from individual retention settings, the [versioning](https://docs.microsoft.com/microsoft-365/compliance/retention-policies-sharepoint?azure-portal=true) feature can be used to protect some versions of all files.

Users receive an error if they try to delete a library, list, folder, or site that is subject to a retention policy. Users can delete a folder if they first move or delete any files in the folder that are subject to the policy. The Preservation Hold library is created at this stage, but not when a retention policy is created, or a retention label is applied. Therefore, to test retention, first all documents must be edited or deleted of a site that is subject to a retention policy or that has a retention label applied, and then the Preservation Hold library can be investigated to view the retained copies.

After retention settings are assigned to content in a OneDrive account or SharePoint site, the paths the content takes depends on whether the retention settings are to retain and delete, to retain only, or delete only.

> [!NOTE]
> To help prevent inadvertent data loss, no content is permanently deleted from the Preservation Hold library but instead the content is only moved to the Recycle Bin. So, when content is deleted from the Preservation Hold library, it goes through the second-stage Recycle Bin before being deleted permanently.

## Preservation hold library functionality

The following image shows the way files are handled in SharePoint Online document libraries when preservation hold libraries are used with default service settings.

![processing of retention periods for preservation and deletion.](../media/preservation-hold-libraries.png)

1. How the content from the document library is handled, varies between the different retention settings. The following table shows the differences between the retention settings **retain and delete**, **retain-only** and **or delete-only**:

| **Step**| (1) **If the content is modified or deleted** during the retention period…| (2) **If the content is not modified or deleted** during the retention period…|
| :--- | :--- | :--- |
| **retain and delete**| A copy of the original content as it existed when the retention policy was assigned is created in the Preservation Hold library. There, the timer job identifies items whose retention period has expired. Those items are moved to the second stage Recycle Bin, where they're permanently deleted at the end of 93 days. The second stage Recycle Bin is not visible to end users (only the first stage Recycle Bin is), but site collection admins can view and restore content from there.| The timer job moves this content to the first stage Recycle Bin at the end of the retention period. If a user deletes the content from there or empties this Recycle Bin (also known as purging), the document is moved to the second stage Recycle Bin. A 93-day retention period spans both the first- and second stage recycle bins. At the end of 93 days, the document is permanently deleted from wherever it resides, in either the first-stage or second stage Recycle Bin. The Recycle Bin is not indexed and therefore unavailable for searching. As a result, an eDiscovery search can't find any Recycle Bin content on which to place a hold.|
| **retain-only**| A copy of the original document is created in the Preservation Hold library and retained until the end of the retention period, when the copy in the Preservation Hold library is moved to the second stage Recycle Bin and is permanently deleted after 93 days.| Nothing happens before and after the retention period; the document remains in its original location.|
| **delete-only**| The document is moved to first stage Recycle Bin. If a user deletes the document from there or empties this Recycle Bin, the document is moved to the second stage Recycle Bin. A 93-day retention period spans both the first stage and second stage recycle bins. At the end of 93 days, the document is permanently deleted from wherever it resides, in either the first-stage or second stage Recycle Bin. If the content is modified during the configured period, it follows the same deletion path after the configured period.| At the end of the configured period in the retention policy, the document is moved to the first stage Recycle Bin. If a user deletes the document from there or empties this Recycle Bin (also known as purging), the document is moved to the second stage Recycle Bin. A 93-day retention period spans both the first stage and second stage recycle bins. At the end of 93 days, the document is permanently deleted from wherever it resides, in either the first-stage or second stage Recycle Bin. The Recycle Bin is not indexed and therefore unavailable for searching. As a result, an eDiscovery search can't find any Recycle Bin content on which to place a hold.|

## How retention works with document versions

Versioning is a feature of all document lists and libraries in SharePoint and OneDrive. By default, versioning retains a minimum of 500 major versions, although you can increase this limit. When a document with versions is subject to retention settings to retain that content, versions that get copied to the Preservation Hold library exist as a separate item. If the retention settings are configured to delete at the end of the retention period:

- **If the retention period is based on when the content was created**, each version has the same expiration date as the original document. The original document and its versions all expire at the same time.

- **If the retention period is based on when the content was last modified**, each version has its own expiration date based on when the original document was modified to create that version. The original document and its versions expire independently of each other.

When the retention action is to delete the document, all versions not in the Preservation Hold library are deleted at the same time according to the current version.

For items that are subject to a retention policy (or an eDiscovery hold), the versioning limits for the document library are ignored until the retention period of the document is reached (or the eDiscovery hold is released). In this scenario, old versions are not automatically purged, and users are prevented from deleting versions. That is not the case for retention labels when the content isn't subject to a retention policy (or an eDiscovery hold). Instead, the versioning limits are honored so that older versions are automatically deleted to accommodate new versions, but users are still prevented from deleting versions.

> [!IMPORTANT]
> Important: The retained versions of these SharePoint and OneDrive documents are not searchable by eDiscovery tools. That is very important to know for compliance reasons.

## Important considerations

It is clear how retention in SharePoint Online and OneDrive for Business works for items stored in document libraries. Because any Microsoft 365 Group and any OneDrive for Business personal site is equipped with a OneNote notebook by default, the configured retention settings on a site level also apply to the notebook. However, behind the scenes, the different OneNote sections are individual files, each section will be individually retained and deleted.

It is also important to know what happens to the files of users, when they leave the organization:

| **SharePoint Online**| **OneDrive for Business**|
| :--- | :--- |
| When a user leaves the organization, any content created by that user is not affected because SharePoint is a shared workspace and single files are not affected. That differs from a user's mailbox or OneDrive account.| If a user leaves the organization, any files that are subject to a retention policy or has a retention label will remain during the policy or label. During that time period, all sharing access continues to work. When the retention period expires, content moves into the Site Collection Recycle Bin and is not accessible to anyone except the admin. If a document is marked by a retention label as a record, the document will not be deleted until the retention period is over, after which time the content is permanently deleted.|

