Retention labels and policies help organizations to manage and govern information by ensuring content is retained only for the period of time that is required, and permanently deleted at the end of the retention period.  Applying retention labels and assigning retention policies helps organizations:

- **Comply proactively with industry regulations and internal policies** that require content to be retained for a minimum period of time.
- **Reduce risk in the event of litigation or a security breach** by permanently deleting old content that the organization is no longer required to keep.
- Ensure users work only with content that's current and relevant to them.
When content has retention settings assigned to it, that content remains in its original location. People can continue to work with their documents or mail as if nothing's changed. But if they edit or delete content that's included in the retention policy, a copy of the content is automatically retained in a secure location. The secure locations and the retained content are not visible to most people. In most cases, people do not even need to know that their content is subject to retention settings.

When content has retention settings assigned to it, that content remains in its original location. People can continue to work with their documents or mail as if nothing's changed. But if they edit or delete content that's included in the retention policy, a copy of the content is automatically retained in a secure location. The secure locations and the retained content are not visible to most people. In most cases, people do not even need to know that their content is subject to retention settings.

Retention settings work with the following different workloads:

- [SharePoint and OneDrive](https://docs.microsoft.com/microsoft-365/compliance/retention-policies-sharepoint?view=o365-worldwide)
- [Microsoft Teams](https://docs.microsoft.com/microsoft-365/compliance/retention-policies-teams?view=o365-worldwide)
- [Yammer](https://docs.microsoft.com/microsoft-365/compliance/retention-policies-yammer?view=o365-worldwide)
- [Exchange](https://docs.microsoft.com/microsoft-365/compliance/retention-policies-exchange?view=o365-worldwide)

When using retention policies and retention labels to assign retention settings to content, there are some points to understand about each.  Listed below are just a few of the key points. For a more complete list visit [Compare capabilities for retention policies and retention labels](https://docs.microsoft.com/microsoft-365/compliance/retention?view=o365-worldwide#compare-capabilities-for-retention-policies-and-retention-labels).

Retention policies:

- Are used to assign the same retention settings to content at a site level or mailbox level.
- A single policy can be applied to multiple locations, or to specific locations or users.
- Items inherit the retention settings from their container specified in the retention policy. If a policy is configured to retain content, and an item is then moved outside that container, a copy of that item is retained in the workload's secured location. However, the retention settings don't travel with the content in its new location.

Retention labels:

- Are used to assign retention settings at an item level, such as a folder, document, or email. 
- An email or document can have only a single retention label assigned to it at a time.
- Retention settings from retention labels travel with the content if it’s moved to a different location within your Microsoft 365 tenant.
- Admins can enable users in the organization to apply a retention label manually.
- Retention labels can be applied automatically if it matches defined conditions.
- A default label can be applied for SharePoint documents.
- Support disposition review to review the content before it is permanently deleted.

Consider the following scenarios.  If all documents in a SharePoint site should be retained for 5 years, it's more efficient to do this with a retention policy than apply the same retention label to all documents in that site.  However, if some documents in that site should be retained for 5 years and others retained for 10 years, you would need to apply a policy to the SharePoint site with a retention period of five years, and then apply a retention label to the individual item with a retention setting of ten years.
