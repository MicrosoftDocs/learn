AI agents and copilots often work with sensitive or regulated information. They might summarize SharePoint files, analyze Power BI datasets, or respond to questions in Microsoft Teams. To keep this data safe, organizations need consistent policies that classify content, apply protections, and manage how long interactions are kept.

Microsoft Purview supports this by using sensitivity labels, data loss prevention (DLP) policies, and retention settings. These tools extend the same safeguards already applied to files, emails, and other content so that AI-generated prompts and responses are governed in a reliable way.

## Use sensitivity labels to control access and classification

Without classification, copilots might treat all content the same, increasing the risk of exposure. Sensitivity labels apply classification and protection to files, emails, and other Microsoft 365 content. In AI scenarios, sensitivity labels can influence:

- Whether content is included in agent responses (for SharePoint and Copilot Studio scenarios)
- How content is processed by copilots in Microsoft 365
- What data is visible to copilots based on label scope and encryption settings

For example, in **Copilot Studio**, SharePoint files labeled **Highly Confidential** can be excluded from summarization based on your policy settings. In **Microsoft 365 Copilot**, data loss prevention (DLP) policies can reference sensitivity labels to block specific content from being included in responses.

## Label inheritance in AI interactions

Beyond controlling access, labels also carry through to prompts and responses. This inheritance influences how they're classified, retained, and used by AI agents. Content retrieved by copilots or agents might retain the sensitivity label of the source document, influencing both how the data is used and how it's logged or retained.

For example:

- In **Copilot in Fabric**, labels applied to Power BI datasets might influence what data Copilot can summarize.
- In **Copilot Studio**, prompts and responses might inherit classification based on accessed documents or files.

This behavior supports consistent labeling across generated or referenced content, helping enforce your classification policies even in conversational or generative use cases.

## Apply DLP policies to restrict sensitive responses

Even when content is labeled, copilots can still surface it in responses unless policies restrict it. Microsoft Purview DLP policies let you block or restrict AI-generated responses that include sensitive content.

### Conditions and scope

You can scope DLP rules to the Microsoft 365 Copilot location and configure conditions such as:

- Block summarization of content labeled Confidential or higher
- Restrict referencing of file names to those with sensitive info types
- Require user justification before content is returned

DLP policies apply to copilots embedded in Microsoft 365 apps and to custom copilots built in Copilot Studio that use supported Microsoft 365 data sources.

## Retain AI interactions using retention policies and labels

Prompts and responses can be sensitive records, and without retention they might be lost before investigations or audits. When logging is enabled, copilots and AI agents store prompts and responses in Exchange Online. Once stored, retention labels and policies can help manage the lifecycle of this data.

- **Retention labels** let you classify and apply granular retention rules to content, such as specific AI interactions. Labels are published through **retention label policies**, which by default can target standard locations like Exchange mailboxes, SharePoint sites, OneDrive accounts, and Microsoft 365 Groups.
- **Retention policies** provide broader coverage, allowing you to preserve or delete all Copilot interactions in a location for a defined period. Labels provide more precise control, while policies apply broadly across interaction data.

> [!NOTE]
> To include AI-specific locations like **Microsoft Copilot Experiences**, **Enterprise AI apps**, or **Other AI apps**, your tenant must have pay-as-you-go billing enabled.

Together, labels, DLP, and retention ensure AI interactions are classified, protected, and preserved with the same consistency as other Microsoft 365 data.
