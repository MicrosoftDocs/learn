AI prompts and responses often contain sensitive or regulated information. Organizations need ways to retain, search, and preserve this data for compliance and legal investigations. Microsoft Purview supports these requirements across Copilot and other AI applications that integrate with Microsoft 365.

## Understand where AI interaction data is stored

When users interact with Microsoft 365 Copilot, their prompts and responses are saved in **Exchange Online mailboxes**. The data is stored in a hidden folder within the mailbox and treated like other communications data for compliance.

Because the data is stored in mailboxes, it follows the same compliance model as email and Teams chats. That consistency makes it easier for security and compliance teams to apply familiar processes to AI interactions.

This design means AI interactions can be:

- Searched with **content search** or **eDiscovery**
- Managed with **retention policies** through Data Lifecycle Management
- Audited alongside other mailbox activity with **Microsoft Purview Audit**

## Apply retention policies to AI interaction data

Retention policies help determine how long prompts and responses remain accessible. Consider a scenario where your legal team needs access to Copilot interactions from six months ago. Without retention policies, that data could be gone.

With Microsoft Purview retention policies, you can:

- Automatically apply policies to AI interactions in supported Copilot and enterprise app locations
- Use adaptive or static scopes to target specific users or groups
- Ensure content is retained for legal or compliance needs, even if a user deletes it from their mailbox view

Because retention policies for AI interactions rely on Exchange Online, their behavior is consistent with other mailbox-based items.

## Preserve and export AI data with eDiscovery

Investigations often require searching across large volumes of data. **Microsoft Purview eDiscovery** lets you find, preserve, and export AI interactions for deeper analysis.

For example, investigators can:

- Search user mailboxes to locate specific Copilot prompts or responses
- Place items on hold to prevent deletion during an active case
- Export results for legal review or external processing

In advanced scenarios, eDiscovery also supports review sets, tagging, filters, and analytics to identify patterns in AI interactions.

> [!NOTE]
> eDiscovery features available depend on your organization's Microsoft 365 license. For example, advanced capabilities like review sets, analytics, and adaptive holds are only included with Microsoft 365 E5.

These tools allow security, legal, and compliance teams to treat AI interaction data with the same rigor as other business-critical content.
