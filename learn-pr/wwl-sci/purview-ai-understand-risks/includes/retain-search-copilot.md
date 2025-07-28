AI prompts and responses often contain sensitive or regulated content. OOrganizations need the ability to retain, search, and preserve this information for legal or compliance investigations. Microsoft Purview provides tools to support these scenarios across supported Copilot and AI application categories.

## Understand where AI interaction data is stored

When users interact with AI tools like Microsoft 365 Copilot, their prompts and responses are stored in **Microsoft Exchange Online mailboxes**. These interactions are saved in a hidden folder within the mailbox and are treated like other forms of communications data for compliance and retention.

This mailbox-based storage model supports:

- Searching AI interaction data using **content search** or **eDiscovery**
- Applying retention policies to AI interactions using **Microsoft Purview Data Lifecycle Management**
- Auditing interactions using **Microsoft Purview Audit**

:::image type="content" source="../media/copilot-data-in-mailbox.png" alt-text="Diagram showing Copilot prompts and responses stored in a user mailbox in Exchange Online, with retention, audit, and eDiscovery access through Microsoft Purview." lightbox="../media/copilot-data-in-mailbox.png":::

AI data is only stored for supported Copilot experiences and enterprise AI apps that are integrated with Microsoft 365. Browser-based AI tools, like consumer ChatGPT, are not covered.

## Apply retention policies to AI interaction data

You can use Microsoft Purview retention policies to manage how long prompts and responses are retained. This includes:

- Creating **auto-apply retention policies** that target AI interaction data using specific Copilot or Enterprise AI app locations where supported
- Applying **adaptive or static scopes** to tailor the policy to specific users or groups
- Ensuring that content is retained for compliance, legal, or operational reasons—even if the user deletes the data from their view

Retention policies for AI interactions rely on **Exchange Online** as the underlying location. This means retention behaviors align with those used for other mailbox-based items, such as email and Teams chats.

## Preserve and export AI data with eDiscovery

When an investigation requires deeper analysis of AI interaction data, you can use **Microsoft Purview eDiscovery** to find, preserve, and export relevant content.

Key capabilities include:

- **Search**: Run targeted searches across user mailboxes to locate Copilot interactions based on keywords, labels, or metadata
- **Hold**: Place content on **litigation hold** or **eDiscovery hold** to ensure it isn’t modified or deleted during an investigation
- **Export**: Download interaction content for external review or legal processing

In **eDiscovery**, you can also add interaction data to **review sets**, apply tagging or filters, and run **analytics** to identify trends or key entities in large data volumes.

> [!NOTE]
> The capabilities available in eDiscovery depend on your Microsoft 365 license. For example, organizations with Microsoft 365 E5 can access advanced tools like review sets, analytics, and adaptive holds.

These tools allow security, legal, and compliance teams to treat AI interaction data with the same rigor as other business-critical content.
