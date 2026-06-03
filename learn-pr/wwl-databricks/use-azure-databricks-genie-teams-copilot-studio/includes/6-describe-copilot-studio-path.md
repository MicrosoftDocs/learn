The Copilot Studio path exists for scenarios the Databricks app in Microsoft Teams doesn't cover. When you need to **combine Genie data with SharePoint content, email context, or custom conversation flows**—or when you want a branded, organization-specific agent experience—you build a **Copilot Studio agent** that uses a Genie Space as a tool.

> [!IMPORTANT]
> Connecting Genie Spaces to Copilot Studio via Model Context Protocol (MCP) is in **Public Preview** as of the time this content was written. Verify current availability before deploying to a production environment.

## How the Copilot Studio path works

A maker creates a Copilot Studio agent and adds a Genie Space as an **MCP (Model Context Protocol) tool**. MCP is an open standard that defines how AI agents communicate with external tools and data sources. Once connected, the agent can route user questions to the Genie Space, receive the Genie response, and incorporate it into a broader answer that draws on other tools or knowledge sources in the same conversation.

The finished agent is published to **Microsoft Teams** as a custom agent, where users interact with it exactly as they would with any other Teams bot.

## Prerequisites

Before you can build this integration, confirm the following are in place:

- **Managed MCP Servers preview** enabled in your Azure Databricks workspace (workspace admin setting).
- **Power Apps connection to Azure Databricks** created for your tenant.
- A **Copilot Studio license** with access to an environment.
- **Generative AI orchestration** must be enabled in the agent settings—required for MCP tools to function.

## Authentication: two options with different governance implications

When you configure the Azure Databricks Genie MCP tool in Copilot Studio, you choose how the agent authenticates to Databricks:

| Option | How it works | Governance implications |
|---|---|---|
| **End user credentials** (OBO flow) | The authenticated user's credentials are passed through to Databricks. Unity Catalog applies each user's individual grants. | Users must have a preexisting Power Apps connection to Azure Databricks, or connection parameter sharing must be enabled in your Copilot Studio environment. |
| **Maker-provided credentials** | All queries run as a single identity—the maker's. | All users receive data according to the maker's Unity Catalog grants. Users may see data beyond their own individual access rights. |

**On-behalf-of flow is the recommended option** when per-user data governance matters. The requirement for a per-user Power Apps connection is a one-time setup cost, not a permanent operational limitation.

## What the Copilot Studio agent can and can't do

| Capability | Behavior |
|---|---|
| **Data scope** | Genie data combined with SharePoint, email context, approved topics, or other MCP tools—all in a single conversation. |
| **Custom flows** | Topics, approved responses, fallback handling, and multi-tool routing—all configurable in Copilot Studio. |
| **Publishing** | Microsoft Teams (as a custom agent) or Power Apps. |
| **Per-user data governance** | Supported via OBO flow. Not supported when using maker-provided credentials. |
| **Data policies** | Subject to Power Platform data loss prevention (DLP) policies. The Azure Databricks connector may be restricted in your tenant—coordinate with your Power Platform admin before building. |
| **Known limitation** | Without a specific polling instruction in agent settings, the agent may return repeated "still processing" messages during queries that take longer to compute. |
| **Maker required** | Yes. A Copilot Studio license and maker skills are required to build and maintain the agent. |

## Choosing between the two paths

By this point you've seen both integration paths. Here's a summary decision guide:

| Scenario | Recommended path |
|---|---|
| Business users need direct Genie access with minimal setup | Databricks app |
| No Copilot Studio license or maker resources available | Databricks app |
| The agent needs to combine Genie data with SharePoint, email, or other Microsoft 365 content | Copilot Studio MCP |
| Custom conversation flows, topic restrictions, or a branded agent experience are required | Copilot Studio MCP |
| Per-user data governance is a requirement | Either—but use OBO flow in Copilot Studio (requires per-user Power Apps connection) |
| You need to avoid a Public Preview dependency | Databricks app |

If your scenario fits the Databricks app, that path is the **simpler choice**. If you need more than direct Genie access—combining data sources, building custom flows, or creating a branded experience—**Copilot Studio** is the right direction, with the understanding that it requires more setup and currently carries a Public Preview dependency.
