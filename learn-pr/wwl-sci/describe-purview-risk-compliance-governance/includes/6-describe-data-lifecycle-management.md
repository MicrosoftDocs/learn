
Microsoft Purview Data Lifecycle Management provides you with tools and capabilities to retain the content that you need to keep, and delete the content that you don't. Retaining and deleting emails, documents, and messages are often needed for compliance and regulatory requirements. However, deleting content that no longer has business value also reduces your attack surface.

### Retention policies and retention labels

Retention policies and retention labels are important tools for data lifecycle management. They help organizations to manage and govern information by ensuring content is kept only for a required time, and then permanently deleted. Applying retention labels and assigning retention policies helps organizations:

- **Comply proactively with industry regulations and internal policies** that require content to be kept for a minimum time.
- **Reduce risk when there's litigation or a security breach** by permanently deleting old content that the organization is no longer required to keep.
- **Ensure users work only with content that's current and relevant to them**. Content that is no longer relevant should be deleted.

Managing content commonly requires two actions: retaining content and deleting content.

- Retaining content prevents permanent deletion and ensures content remains available for eDiscovery.
- Deleting content permanently deletes content from your organization.

With these two retention actions, you can configure retention settings for the following outcomes:

- Retain-only: Retain content forever or for a specified period of time.
- Delete-only: Permanently delete content after a specified period of time.
- Retain and then delete: Retain content for a specified period of time and then permanently delete it.

When content has retention settings assigned to it, that content remains in its original location. People can continue to work with their documents or mail as if nothing changed. But if they edit or delete content included in the retention policy, a copy of the content is automatically kept in a secure location. The secure locations and the content aren't visible to most people. In most cases, people don't even need to know that their content is subject to retention settings.

Retention settings work with the following different workloads:

- SharePoint
- OneDrive
- Microsoft Teams
- Viva Engage
- Exchange

To assign your retention settings to content, use retention policies and retention labels with label policies. You can use just one of these methods, or combine them.

When using retention policies and retention labels to assign retention settings to content, there are some points to understand about each. Listed below are just a few of the key points. For more information, see the article, "Learn about retention policies and retention labels" linked in the Summary and resources unit of this module.

**Retention policies**

- Retention policies are used to assign the same retention settings to content at a site level or mailbox level.
- A single policy can be applied to multiple locations, or to specific locations or users.
- Items inherit the retention settings from their container specified in the retention policy. If a policy is configured to keep content, and an item is then moved outside that container, a copy of the item is kept in the workload's secured location. However, the retention settings don't travel with the content in its new location.

**Retention labels**

- Retention labels are used to assign retention settings at an item level, such as a folder, document, or email.
- An email or document can have only a single retention label assigned to it at a time.
- Retention settings from retention labels travel with the content if it’s moved to a different location within your Microsoft 365 tenant, but don't persist if the content is moved outside of your Microsoft 365 tenant.
- Admins can enable users in the organization to apply a retention label manually.
- A retention label can be applied automatically if it matches defined conditions.
- A default label can be applied for SharePoint documents.
- Retention labels support disposition review to review the content before it's permanently deleted.

Consider the following scenarios. If all documents in a SharePoint site should be kept for five years, it's more efficient to do so with a retention policy than apply the same retention label to all documents in that site.

However, if some documents in that site should be kept for five years and others for 10 years, you'd need to apply a policy to the SharePoint site with a retention period of five years. You'd then apply a retention label to the individual items with a retention setting of 10 years.

### Retention label policies

When you publish retention labels, they're included in a retention label policy that makes them available for admins and users to apply to content. A retention label policy specifies which locations—such as Exchange mailboxes, SharePoint sites, or OneDrive accounts—and which users can use the labels. This lets organizations roll out labels in a controlled way, ensuring that the right people have access to the right labels at the right time.

By using retention label policies, compliance managers can ensure consistent application of retention settings across their organization, improving governance and reducing the need for manual tracking.

## Additional data lifecycle management capabilities

Beyond retention policies and retention labels, Microsoft Purview Data Lifecycle Management includes capabilities to help manage the full lifecycle of organizational data:

- **Mailbox archiving**: Provides users with extra mailbox storage space, with auto-expanding archiving for mailboxes that need more than the standard storage limit. This helps prevent email data loss due to storage constraints.
- **Inactive mailboxes**: Retains mailbox content after an employee leaves the organization. When a user's mailbox is placed on hold before the user's account is deleted, the mailbox becomes inactive and is retained indefinitely, supporting legal and regulatory requirements.
- **Adaptive Protection**: Data Lifecycle Management integrates with Microsoft Purview Insider Risk Management through Adaptive Protection. When this integration is enabled, retention labels are automatically applied to content based on dynamic risk signals generated by insider risk management's machine-learning models. This helps protect high-risk content from accidental or malicious deletion without requiring manual intervention by compliance administrators.
- **Retention of AI app interactions**: User prompts and responses from AI apps—including Microsoft 365 Copilot—are stored in the user's Exchange mailbox. This means you can use retention policies to automatically retain or delete AI interactions, applying the same compliance and governance controls to AI-generated content as to any other organizational data.
