When responding to legal, regulatory, or internal investigations, it's important to define where to search across Microsoft 365. In Microsoft Purview eDiscovery, these search locations are called **data sources**. A data source is any Microsoft 365 location that stores content, such as a mailbox, OneDrive site, or SharePoint site. Selecting the right data sources defines the scope of your search and ensures that nothing critical is left out.

## Types of data sources

Microsoft 365 stores user and group data across several services. When you add a user or group to a case, eDiscovery automatically identifies and includes related locations.

**Data sources can include:**

- **User mailboxes** (email and calendar items)
- **OneDrive sites** (files owned by the user)
- **SharePoint sites** (including Teams channel files)
- **Teams messages** (captured in Exchange mailboxes)
- **Yammer messages** (if Yammer is enabled)
- **Public folders**

Unified groups can include several containers depending on how they're used. A Microsoft Team, for example, might include a group mailbox and multiple SharePoint sites for standard and private channels.

In addition to defining where to search, data sources also determine which content can be preserved. When you place content on hold, the policy applies only to the selected sources. Choosing the right ones ensures that relevant data is available for both search and preservation.

## How sources are added and scoped

You can scope data sources in two ways:

- **Specific sources** let you select individual users, groups, or sites
- **Tenant-wide sources** include options like **All people and groups** or **All public folders**

When a user is added as a source, their mailbox and OneDrive site are included automatically. Adding a group includes its mailbox and related SharePoint or Teams content. These selections can be adjusted to include or exclude specific locations.

You can also add distribution lists to a case. eDiscovery automatically resolves them to the individual user mailboxes.

While the term **custodian** is still relevant in legal and compliance contexts, the interface in the new eDiscovery experience uses the term **source** instead. This shift reflects the focus on content locations rather than individual responsibility.

## How eDiscovery keeps sources current

eDiscovery uses **real-time sync** to track changes in associated content. If a user's data locations change, such as when a new Teams private channel is created, you'll see an alert in the data source panel so you can include the new location.

Sync also captures when content is removed or reassigned, such as:

- OneDrive sites that are deleted or replaced
- SharePoint sites that are moved or renamed
- Mailboxes that are deactivated or reassigned

This helps ensure your search and hold selections stay accurate as the Microsoft 365 environment evolves.

To help expand the investigation scope, eDiscovery can also identify **frequent collaborators**. When you add a user as a data source, the system highlights up to ten users who most often collaborate with them. You can choose to include their mailboxes and OneDrive sites to capture related communications and shared content.
