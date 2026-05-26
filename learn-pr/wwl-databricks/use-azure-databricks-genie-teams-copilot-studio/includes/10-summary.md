In this module, you explored how Azure Databricks Genie Spaces can be accessed from within Microsoft 365, and what each of the three roles involved in a Genie deployment needs to know.

## What you learned

**Business users** can chat with a Genie Space directly from the Databricks app in Microsoft Teams—in a personal DM or in a team channel. Queries run under their own identity, so **Unity Catalog grants apply per user**. Writing **effective questions** (with time period, calculation type, and specific metric) produces more reliable answers. Multi-turn conversation context is maintained in the thread. And when a result looks wrong, the feedback controls—thumbs up/down, "fix it," "request review"—are in the **Databricks Genie Space UI**, reached by following the source link in the Teams response, not in Teams itself.

**Data engineers** share a Genie Space with Microsoft 365 consumers through two separate steps: granting CAN VIEW or CAN USE on the Genie Space itself, and granting the correct Unity Catalog data permissions (SELECT on tables, CAN USE on the SQL warehouse, and the consumer access entitlement). For the Databricks app, authentication flows automatically through Entra ID SSO. For a Copilot Studio agent using OBO flow, each user needs a Power Apps connection to Azure Databricks, or the Power Platform admin must enable connection parameter sharing.

**Makers** build a Copilot Studio agent by adding a Genie Space as an **MCP tool**, configuring the Genie Space ID and credential type, enabling **generative AI orchestration**, and including a **polling instruction** to prevent repeated "still processing" responses. **OBO flow** is the recommended credential option because it respects per-user Unity Catalog grants. The finished agent is published to Teams as a custom agent.

## Key tradeoffs

The **Databricks app** is simpler to deploy, requires no maker involvement, and needs no Copilot Studio license. Its scope is limited to Databricks data, with no custom conversation flows.

The **Copilot Studio agent** is more flexible—it combines Genie data with other Microsoft 365 content, supports custom conversation flows, and can be branded for your organization. It requires maker effort, a Copilot Studio license, a per-user Power Apps connection for OBO flow, and as of this writing the MCP integration is in **Public Preview**.

## Learn more

- [Configure AI/BI Genie instructions](/training/modules/create-and-organize-objects-in-unity-catalog/configure-ai-bi-genie-instructions) — knowledge store setup for Genie Spaces
- [Use a Genie Space to explore business data](/azure/databricks/genie/talk-to-genie)
- [Use Azure Databricks data on Microsoft Power Platform](/azure/databricks/integrations/msft-power-platform-usage)
- [Extend your agent with MCP in Copilot Studio](/microsoft-copilot-studio/agent-extend-action-mcp)