Copilot Studio allows users to create custom AI agents that connect to data sources like SharePoint or Dataverse. If left unprotected, these agents might return sensitive content in responses or bypass logging requirements. Microsoft Purview gives you the ability to enforce sensitivity labels, restrict responses through data loss prevention, and retain agent interactions for audit or investigation.

## Understand what needs to be protected

Agents built in Copilot Studio are often shared broadly within Teams or published externally. They might rely on SharePoint, Dataverse, or other Microsoft 365 sources to generate responses. These agents are designed to respond automatically to prompts, which makes it important to understand what information they're accessing and how it's being returned.

Several risks are introduced when agents work with sensitive data:

- Agents might return sensitive information if they have access to unrestricted or mislabeled content.
- Prompts and responses might contain business data that isn't automatically protected.
- Agent activity might not be recorded or retained unless logging is explicitly enabled.

Understanding these risks is the first step in applying the right protections.

## Use sensitivity labels to scope data access

Copilot and agents run in the user's context and honor sensitivity labels and encryption. If a user doesn't have rights to open or extract content from a labeled file, the agent can't summarize it. To block agents from processing labeled content even when a user does have access, use a DLP policy scoped to Microsoft 365 Copilot.

:::image type="content" source="../media/copilot-studio-sensitivity-label.png" alt-text="Screenshot showing Copilot Studio response referencing labeled files and displaying a Confidential label with protection set to Any User." lightbox="../media/copilot-studio-sensitivity-label.png":::

When a Copilot Studio agent uses SharePoint as a data source, the labels applied to documents in SharePoint can affect the agent's ability to access or summarize those files. For example, you can configure label policies to:

- Prevent agents from summarizing files with high-sensitivity labels
- Allow only certain labeled documents to be used by agents
- Automatically apply extra protections to agent-accessed content

Label-based access control helps ensure that agents operate within defined boundaries based on your organization's data classification strategy.

## Apply DLP policies to control agent responses

To reduce the risk of agents disclosing sensitive information, you can use a DLP policy scoped to the **Microsoft 365 Copilot** location. This lets you block or limit agent responses when they attempt to process SharePoint files labeled as highly sensitive.

:::image type="content" source="../media/data-loss-prevention-copilot.png" alt-text="Screenshot showing a DLP rule that blocks Copilot from processing content labeled Highly Confidential using a Copilot-specific action." lightbox="../media/data-loss-prevention-copilot.png":::

A Copilot-scoped DLP policy applies when the knowledge source is SharePoint. It includes Copilot Studio agents in Teams or SharePoint, Microsoft 365 Copilot, and other Copilot integrations that rely on SharePoint data.

This functionality limits AI-generated responses based on content classification and helps reduce the risk of unintentional data disclosure.

> [!NOTE]
> Some features in Microsoft Purview, including DLP and eDiscovery, require Microsoft 365 E5 or Microsoft 365 E5 Compliance licensing. Make sure your organization meets the licensing requirements to use these capabilities.

## Retain agent interactions for compliance

Copilot Studio interactions used in Microsoft 365 are automatically captured as compliance copies in Exchange Online. You can apply a Microsoft Purview retention policy scoped to the **Microsoft Copilot Experiences location** to preserve them for compliance or recordkeeping.

:::image type="content" source="../media/retention-copilot-location.png" alt-text="Screenshot showing Microsoft Copilot experiences selected as a location in the retention policy setup." lightbox="../media/retention-copilot-location.png":::

> [!NOTE]
> Copilot Studio transcript logging in Dataverse is optional and separate from Microsoft Purview. Compliance copies in Exchange Online are automatic and don't require enabling a setting in the agent.

## Use audit to review agent usage

Microsoft Purview Audit logs provide metadata about agent activity, such as who used the agent, when it occurred, and which agent was involved. Audit logs help you:

- Track how agents are used across your environment
- Identify users interacting with specific agents
- Investigate activity timelines during security or compliance reviews

Audit logs don't contain prompt or response content. For deeper investigation, use eDiscovery to search stored conversations.

## Use eDiscovery to investigate agent-generated content

To review the content of prompts and responses in more detail, you can search Copilot Studio conversations using eDiscovery. This makes it possible to identify risky use, filter results, or export data for compliance or legal review.

To search for Copilot Studio content specifically, use the `IPM.SkypeTeams.Message.Copilot.Studio.*` value in the **ItemClass** field of the search query.

With eDiscovery, teams can:

- Search for specific terms or patterns within agent prompts and responses
- Filter results based on participant, timeframe, or sensitivity
- Export content for use in legal review, incident response, or investigations

Making agent interactions discoverable helps ensure that AI usage can be reviewed as consistently as other forms of communication and collaboration.

## View agent activity in Data Security Posture Management (DSPM) for AI

DSPM for AI reports show prompt and response activity across your environment, including sensitivity and risk indicators. You can filter by user, sensitivity, or risk signal to spot potential misuse or gaps in protection. In **Activity explorer**, you can view Copilot Studio prompts and responses with filters for user, sensitivity, and risk indicators.

Together, these safeguards let you govern Copilot Studio agents so they don't expose sensitive information or bypass compliance requirements.
