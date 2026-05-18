Governance practices that serve human users also serve AI workloads. AI agents and Copilot experiences rely on the same classification, endorsement, and documentation signals you've already implemented, but they process these signals programmatically, making consistent governance even more critical.

## Understand how AI agents consume governed data

AI agents in Microsoft Fabric, including Copilot and data agents, rely on metadata, governance signals, and semantic context to determine which data to access and trust:

- **Sensitivity labels** define boundaries. An AI agent respects the same access controls that sensitivity labels enforce for human users. If a protection policy blocks access, the AI agent can't surface that data.
- **Endorsement** signals trust. When multiple data sources could answer a question, endorsement helps determine which source to prioritize. A certified semantic model is more authoritative than an unpromoted dataset.
- **Descriptions and documentation** provide context. AI agents use item descriptions and column names to understand what data represents. Well-documented semantic models produce more accurate AI responses.

## Connect governance to Fabric IQ

Fabric IQ (preview) is the intelligence layer that unifies business semantics across the Fabric platform. It provides an ontology, a knowledge graph, and agent capabilities that rely on well-governed data:

- **Ontology (preview):** Fabric IQ's ontology defines business concepts like Customer, Product, and Order, then binds them to data sources in OneLake. You choose which lakehouses, eventhouses, and semantic models to bind. Endorsement, classification, and documentation ensures the ontology connects to trustworthy, well-understood data.
- **Data agents:** Data agents answer questions by querying your semantic models, lakehouses, and warehouses. They use endorsement and sensitivity metadata to determine which sources are appropriate for a given query. A data agent configured for a sales dashboard uses certified semantic models rather than unverified personal workbooks.
- **Operations agents (preview):** Operations agents in Real-Time Intelligence monitor eventhouse data streams against defined rules and conditions. When a condition is met, the agent recommends or triggers actions through Microsoft Teams and Power Automate. Well-governed source data helps ensure that the rules and actions the agent applies are based on trustworthy, well-documented data.

Your governance practices make Fabric IQ more effective, and Fabric IQ makes your governance more visible by surfacing well-governed assets to the right users at the right time.

## Build an AI-ready governance foundation

**Endorse before you expose.** Ensure data sources are endorsed before making them available to AI agents. **Promoted** is suitable for team-level AI use. **Certified** is appropriate for organization-wide consumption. **Master data** items should be the primary targets for data agents that answer business-critical questions.

**Classify to set boundaries.** Apply sensitivity labels to all items that contain personal, financial, or otherwise restricted data. AI agents automatically respect these guardrails.

**Document for AI context.** Treat item descriptions and column-level metadata as context for AI comprehension, not just human readability. Clear, specific descriptions produce better AI outputs:

| Documentation quality | AI agent behavior |
|----------------------|-------------------|
| No description on a semantic model | Agent might reference the item by its technical name, or skip it in favor of a documented alternative. |
| Generic description: "Sales data" | Agent has limited context. Responses might be vague or incomplete. |
| Specific description: "Monthly retail sales revenue by region and product category, refreshed daily from the certified lakehouse" | Agent has full context. Responses are specific, accurate, and reference the correct scope. |

**Use the OneLake catalog as your governance dashboard.** The Govern tab tracks governance coverage across your data estate. Use the recommended actions to close gaps before they affect AI quality.

## Approve semantic models for Copilot

Endorsement and documentation provide general governance signals, but Power BI also offers an explicit **Approved for Copilot** setting on semantic models. This setting acts as a formal governance gate that controls whether Copilot treats a model as ready for AI consumption.

When you mark a semantic model as Approved for Copilot:

- The standalone Copilot experience removes friction treatment (disclaimers or warnings) from answers generated using that model.
- All reports built on that semantic model are also considered Approved for Copilot.
- Workspace administrators can configure their workspace to show only Approved for Copilot items in the standalone Copilot experience, filtering out unapproved content.

You can mark a semantic model as *Approved for Copilot* in the semantic model settings in the Fabric service.

> [!NOTE]
> Changes can take up to 24 hours to fully reflect across all reports, though most updates appear within an hour.

### Prepare data for AI before approving

Before marking a model as Approved for Copilot, use the **Prep data for AI** feature to ensure the model is ready for quality AI interactions. You can access Prep data for AI from the **Home** ribbon in Power BI Desktop or the semantic model page in the Power BI service. It provides three features:

- **AI data schema:** Define a focused subset of tables, columns, and measures that Copilot should prioritize when generating responses. This reduces ambiguity and improves accuracy. When you add the model to a data agent, select the same tables you defined in the schema to ensure consistent behavior.
- **AI instructions:** Provide natural language context about your model, such as business rules, terminology, or typical use cases, that helps Copilot generate more relevant answers.
- **Verified answers:** Associate specific visuals with trigger phrases so Copilot returns a known, validated answer for common questions.

Think of Prep data for AI as the quality preparation and Approved for Copilot as the governance gate. You prepare the model first, then approve it to signal that it's ready for AI consumption across the organization.

> [!TIP]
> Copilot in Microsoft Fabric uses endorsement to prioritize which items to reference when answering user questions. Certifying your key semantic models and lakehouses directly improves the quality of Copilot responses across your organization.

## Evaluate governance decisions for AI scenarios

When planning governance for AI consumption, consider these decision criteria:

| Scenario | Governance action |
|----------|-------------------|
| A data agent answers executive questions about revenue | Ensure the source semantic model is certified, sensitivity-labeled, and thoroughly documented. |
| Copilot in Power BI generates DAX calculations | Copilot benefits from certified semantic models with well-defined measures and descriptions. |
| A team experiments with a new data source in notebooks | Don't promote data until validated. Apply sensitivity labels if the source contains personal data. |
| An operations agent monitors real-time data streams | Governing the source eventhouse data ensures the agent's rules and actions are based on trustworthy data. |

Governance isn't separate from your AI strategy. The classification, endorsement, and documentation practices you implement in this module directly determine how effectively AI agents serve your organization.
