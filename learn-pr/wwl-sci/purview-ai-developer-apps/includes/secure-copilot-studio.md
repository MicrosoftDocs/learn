Copilot Studio allows users to build custom AI agents that can answer questions, summarize documents, or automate business processes. These agents often connect to internal data sources and return generated responses to users. This flexibility introduces the risk of exposing sensitive information if agents aren't configured and governed appropriately.

Microsoft Copilot Studio is one of several platforms where developers can build custom AI agents. Like Azure AI services and Entra-registered apps, these agents can interact with sensitive data and must be secured using Microsoft Purview tools.

Microsoft Purview provides several ways to manage these risks. Sensitivity labels can limit which content agents are allowed to access. Data loss prevention (DLP) policies can block or restrict agent responses that include sensitive data. Retention, audit, and eDiscovery features can preserve, review, and investigate agent interactions to meet compliance requirements. Classification signals from AI prompts and responses can also appear in Microsoft Purview dashboards and reports when supported.

## Understand what needs to be protected

Agents built in Copilot Studio are often shared broadly within Teams or published externally. They might rely on SharePoint, Dataverse, or other Microsoft 365 sources to generate responses. These agents are designed to respond automatically to prompts, which makes it important to understand what information they're accessing and how it's being returned.

Several risks are introduced when agents work with sensitive data:

- Agents might return sensitive information if they have access to unrestricted or mislabeled content.
- Prompts and responses might contain business data that isn't automatically protected.
- Agent activity might not be recorded or retained unless logging is explicitly enabled.

Understanding these risks is the first step in applying the right protections.

## Use sensitivity labels to scope data access

Sensitivity labels determine how information is classified and protected across Microsoft 365. In Copilot Studio, [labels can influence whether agents are allowed to summarize or return certain types of content](https://learn.microsoft.com/en-us/microsoft-copilot-studio/sensitivity-label-copilot-studio#microsoft-purview-strengthens-information-protection-for-copilot-studio).

:::image type="content" source="../media/copilot-studio-sensitivity-label.png" alt-text="Screenshot showing Copilot Studio response referencing labeled files and displaying a Confidential label with protection set to Any User." lightbox="../media/copilot-studio-sensitivity-label.png":::

When a Copilot Studio agent uses SharePoint as a data source, the labels applied to documents in SharePoint can affect the agent's ability to access or summarize those files. For example, you can configure label policies to:

- Prevent agents from summarizing files with high-sensitivity labels
- Allow only certain labeled documents to be used by agents
- Automatically apply additional protections to agent-accessed content

Label-based access control helps ensure that agents operate within defined boundaries based on your organization's data classification strategy.

## Apply DLP policies to control agent responses

Microsoft Purview DLP policies can restrict AI agent behavior when those agents are configured to use SharePoint as a knowledge source.

A DLP policy scoped to the **Microsoft 365 Copilot** location can prevent agents, including agents built in Copilot Studio, from processing files labeled with specific sensitivity labels. For example, a policy can block summarization of files labeled **Highly Confidential**, allowing only file references to be returned instead of content.

:::image type="content" source="../media/data-loss-prevention-copilot.png" alt-text="Screenshot showing a DLP rule that blocks Copilot from processing content labeled Highly Confidential using a Copilot-specific action." lightbox="../media/data-loss-prevention-copilot.png":::

This policy enforcement applies to:

- Agents built in Copilot Studio for Microsoft Teams or SharePoint
- Microsoft 365 Copilot
- Other Copilot integrations that rely on SharePoint data

This functionality allows you to limit AI-generated responses based on the classification of the content being accessed. It helps reduce the risk of unintentional data disclosure through summarization.

## Retain agent interactions for compliance

When logging is enabled, Copilot Studio agent conversations can be stored in Exchange Online mailboxes. This allows organizations to retain the content of prompts and responses and apply Microsoft Purview retention policies.

:::image type="content" source="../media/retention-copilot-location.png" alt-text="Screenshot showing Microsoft Copilot experiences selected as a location in the retention policy setup." lightbox="../media/retention-copilot-location.png":::

To retain agent conversations, create a retention policy scoped to the **Microsoft Copilot Experiences** location.

Retention policies can:

- Preserve agent conversations for a specified duration
- Keep interaction records available even if the agent is modified or deleted
- Ensure content remains available for search, audit, or investigation

These policies support regulatory and internal recordkeeping needs by preserving and making agent activity accessible.

## Use audit to review agent usage

When logging is enabled, Copilot Studio interactions can generate audit events that are searchable in Microsoft Purview Audit. These events record agent activity metadata, such as which user triggered an agent, when it occurred, and which agent was involved.

Audit logs help you:

- Track how agents are being used across your environment
- Identify users interacting with specific agents
- Investigate activity timelines during security or compliance reviews

Audit logs don't contain prompt or response content. For deeper investigation, use eDiscovery to search stored conversations.

## Use eDiscovery to investigate agent-generated content

Agent conversations stored in Exchange Online can also be made available to Microsoft Purview eDiscovery tools. This allows legal, compliance, or security teams to search and review content when needed.

To search for Copilot Studio content specifically, use the `IPM.SkypeTeams.Message.Copilot.Studio.*` value in the **ItemClass** field of the search query.

With eDiscovery, teams can:

- Search for specific terms or patterns within agent prompts and responses
- Filter results based on participant, timeframe, or sensitivity
- Export content for use in legal review, incident response, or investigations

Making agent interactions discoverable helps ensure that AI usage can be reviewed with the same rigor as other forms of communication and collaboration.

Agent activity from Copilot Studio is also surfaced in **Data Security Posture Management (DSPM) for AI**, where you can view usage details in reports and the activity explorer. These tools give you visibility into AI interactions across your organization and help detect patterns of risk or policy violations.
