The Databricks Genie integration crosses Azure Databricks, Microsoft Entra, Microsoft 365, and Teams administrative boundaries. Understanding the request path and ownership model helps you configure each control in the correct service.

## Follow a question through the architecture

The Databricks Genie app from Microsoft Marketplace is the integration point for both Teams and Microsoft Copilot. It isn't a custom app that your organization hosts, and it doesn't require a Microsoft Copilot Studio agent.

When a business user asks a question, the request follows this path:

1. The user opens Databricks Genie in Teams or Microsoft Copilot.
2. The app connects to the Azure Databricks workspace selected for the conversation.
3. The user signs in to Azure Databricks with their own organizational identity.
4. The app sends the question to the Genie One application programming interface (API).
5. Genie One routes the question across available governed assets or sends it to the specific Genie Agent selected for a channel.
6. A pro or serverless SQL warehouse provides the compute that runs the generated query.
7. Unity Catalog evaluates access with the signed-in user's data permissions.
8. The answer returns to the originating Teams or Microsoft Copilot conversation.

:::image type="content" source="../media/genie-collaboration-architecture.png" alt-text="Diagram showing Genie One routing questions from Teams or Microsoft Copilot to governed Azure Databricks data.":::

The app doesn't copy the user's Azure Databricks privileges into Microsoft 365. It preserves the separation between collaboration access and data access. A person might be able to open the app but receive no data from a source that Unity Catalog doesn't permit them to query.

## Distinguish Genie One from a Genie Agent

**Genie One** is the routing layer used by the Teams app. Without a selected Genie Agent, Genie One chooses among the governed assets and agents available to the user.

A **Genie Agent** is a domain-focused conversational interface prepared by a data team. It contains business context, data objects, instructions, and a default SQL warehouse. A channel owner can select a specific agent when a Teams channel should consistently answer questions about one business domain.

Both paths use the Genie One API. Selecting an agent narrows the destination. It doesn't replace the user's Unity Catalog authorization.

## Assign administrative responsibilities

No single role owns every control. Define the handoffs before deployment.

| Role | Primary responsibility |
|---|---|
| Azure Databricks account administrator | Enables the account-level preview and manages account-wide partner-powered AI settings. |
| Azure Databricks workspace administrator | Configures workspace collaboration settings, user entitlements, and network access. |
| Data engineer or Genie Agent editor | Maintains the agent, its data objects, embedded warehouse credential, sharing access, and business context. |
| Microsoft 365 or Teams administrator | Reviews the marketplace app, makes it available, and assigns or installs it for users. |
| Global Administrator | Grants organization-wide Microsoft Graph consent through Teams admin center when the approved deployment uses that consent flow. |
| Teams channel owner | Selects the workspace, response visibility, and Genie scope for a channel. |
| Business user | Signs in to Azure Databricks and asks questions within their assigned permissions. |

In Contoso's setup, the data engineer supplies a prepared sales agent. The system engineer coordinates the account, workspace, identity, and Microsoft 365 administrators. This ownership model keeps semantic design with the data team while the system engineer focuses on making the governed experience available.

## Preserve two separate access decisions

The architecture makes two independent decisions for each user:

- **Can the user access the app?** Microsoft 365 app availability and assignment answer this question.
- **Can the user access the requested data?** Azure Databricks workspace access, the Genie Agent access control list (ACL), and Unity Catalog answer this question.

Both decisions must allow access for the experience to work. Making the app available doesn't grant data access, and sharing a Genie Agent doesn't make the Microsoft 365 app appear for a user.