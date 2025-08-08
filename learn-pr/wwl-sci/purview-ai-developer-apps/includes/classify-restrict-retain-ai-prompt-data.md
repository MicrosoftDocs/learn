AI agents and copilots often generate, access, or return content that includes sensitive or regulated information. These interactions might involve summarizing SharePoint files, answering questions based on Power BI datasets, or responding to users directly in Microsoft Teams. In each case, the data exchanged in prompts and responses can require protection

Microsoft Purview supports classifying, restricting, and retaining AI prompt data using tools like sensitivity labels, data loss prevention (DLP), and retention policies. These capabilities help ensure AI interactions are governed consistently with your organization’s broader data protection strategy.

## Use sensitivity labels to control access and classification

Sensitivity labels apply classification and protection to files, emails, and other Microsoft 365 content. In AI scenarios, sensitivity labels can influence:

- Whether content is included in agent responses (for SharePoint and Copilot Studio scenarios)
- How content is processed by copilots in Microsoft 365
- What data is visible to copilots based on label scope and encryption settings

For example, in **Copilot Studio**, SharePoint files labeled **Highly Confidential** can be excluded from summarization based on your policy settings. In **Microsoft 365 Copilot**, DLP policies can reference sensitivity labels to block specific content from being included in responses.

## Understand label inheritance in AI interactions

When AI agents use Microsoft 365 data sources, label inheritance can affect how prompts and responses are treated. Content retrieved by copilots or agents might retain the sensitivity label of the source document, influencing both how the data is used and how it's logged or retained.

For example:

- In **Copilot in Fabric**, labels applied to Power BI datasets might influence what data Copilot can summarize.
- In **Copilot Studio**, prompts and responses might inherit classification based on accessed documents or files.

This behavior supports consistent labeling across generated or referenced content, helping enforce your classification policies even in conversational or generative use cases.

## Apply DLP policies to restrict sensitive responses

Microsoft Purview DLP policies allow you to block or restrict AI-generated responses that include sensitive content. You can scope DLP rules to the **Microsoft 365 Copilot** location and configure conditions such as:

- Block summarization of content labeled **Confidential** or higher
- Allow referencing file names only for files with sensitive info types
- Require user justification before content is returned

These DLP actions apply to copilots embedded in Microsoft 365 apps, and custom copilots built in Copilot Studio that use supported Microsoft 365 data sources.

## Retain AI interactions using retention policies and labels

Prompts and responses from copilots and AI agents can be stored in Exchange Online when logging is enabled. Once stored, retention labels and policies can be applied to manage the lifecycle of this data.

You can:

- Create retention labels specifically for AI interaction data
- Publish retention labels to locations like **Microsoft Copilot Experiences**
- Use auto-apply conditions if content is classified by sensitivity label or keyword match

Alternatively, you can configure retention policies without labels to preserve or delete all Copilot interactions for a defined period.

This approach helps support audit readiness, legal investigations, and internal governance standards by ensuring prompt data isn't lost or deleted prematurely.
