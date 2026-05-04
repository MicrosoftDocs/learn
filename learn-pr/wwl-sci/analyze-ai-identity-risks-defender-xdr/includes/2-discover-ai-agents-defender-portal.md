Organizations deploying AI agents often discover they have more agents than expected, with some created by business units outside of central IT oversight. As a security engineer at Contoso Financial Services, you need to discover all AI agents operating in your environment before you can assess their risk. Here, you learn how to use the AI agent inventory in Microsoft Defender XDR to discover agents and understand their basic properties.

## Access the AI agent inventory

> [!NOTE]
> The AI agent inventory is currently in **Preview**. Before the inventory appears in the Defender portal, you must opt in to preview features for both Microsoft Defender XDR and Microsoft Defender for Cloud in their respective settings pages.

The AI agent inventory provides a centralized view of agents built with Microsoft Copilot Studio, Microsoft Foundry, AWS Bedrock, and GCP Vertex AI. Before you can view the inventory, you need to enable the required integrations for each platform you want to monitor.

**Licensing prerequisites:** You need either a Microsoft Agent 365 license, or both a Microsoft Defender for Cloud Apps license and a Microsoft Copilot Studio license (for Copilot Studio agent discovery).

To enable discovery, configure the integration for each platform:

- **Copilot Studio agents**: Go to **System** > **Settings** > **Security for AI** in the Microsoft Defender portal and turn on **Security for AI Agents**. Work with a Power Platform administrator to complete the integration in the Power Platform admin portal under **Security** > **Threat Protection** > **Microsoft Defender - Copilot Studio AI Agents**.
- **Microsoft Foundry, AWS Bedrock, and GCP Vertex AI agents**: Enable the Microsoft Foundry integration in Microsoft Defender for Cloud.

Once integrations are enabled, navigate to **Assets** > **AI Agents** in the Microsoft Defender portal. A list of all discovered agents appears, with tabs to filter by platform.

At Contoso, the security team enables the Copilot Studio integration and opens the AI agent inventory. They find 34 agents—more than the 22 they expected based on central deployment records. The other 12 agents built by business units using Copilot Studio are outside the security team's visibility. This discovery highlights why continuous monitoring matters: organizations often have more AI agents running than their central teams realize.

## Explore what the inventory shows

Each agent entry in the inventory displays key properties that help you identify and categorize agents.

| Property | Description |
|----------|-------------|
| Agent name | The display name assigned when the agent was created |
| Product source | The platform where the agent was built (Microsoft Copilot Studio, Microsoft Foundry, AWS Bedrock, or GCP Vertex AI) |
| Status | Whether the agent is active, inactive, or disabled |
| Associated identities | The service principal or managed identity used by the agent |
| Last activity | The most recent time the agent was invoked or accessed resources |

The agent name and product source tell you what the agent is and where it was created. The associated identities field shows which service principal or managed identity the agent uses to authenticate—this identity is what you assess for risk.

The status field indicates whether an agent is currently active. Active agents are processing requests and accessing resources. Inactive agents can still have permissions but aren't currently being invoked. Disabled agents are intentionally turned off but retain their identity and permissions until fully removed.

Last activity provides a timestamp of the most recent agent operation. The agent operations list helps you distinguish between production agents that run frequently and experimental or abandoned agents that are never used. Agents with no recent activity but broad permissions still represent risk—a dormant agent identity is as exploitable as an active one.

## Filter and search for specific agents

When you manage dozens or hundreds of agents, filtering becomes essential. The AI agent inventory supports filtering by product source, status, and risk level. You can filter to show only Copilot Studio agents, only active agents, or only agents flagged as high risk by Defender XDR's scoring engine.

The search function lets you find agents by name or associated identity. If you know a specific business unit created an agent, search for keywords in the agent name. If you're investigating an alert that references a service principal, search by the principal's object ID to find the associated agent.

Risk level filtering is useful for prioritization. Defender XDR assigns risk scores based on the agent's permissions, knowledge sources, and configuration. Filtering to high-risk agents lets you focus your assessment effort on the agents most likely to cause damage if compromised.

:::image type="content" source="../media/agent-inventory-portal-view.png" alt-text="Diagram of the AI Agents inventory showing agents from Copilot Studio, Foundry, AWS Bedrock, and GCP Vertex AI with risk levels." lightbox="../media/agent-inventory-portal-view.png":::

> [!NOTE]
> Agents that don't use Microsoft Entra-backed identities can’t appear in the inventory. Some external or custom agents authenticate using API keys or external identity providers. These agents require separate discovery methods outside Defender XDR.

## Review discovery limitations

Discovery in Defender XDR relies on process data from Microsoft services and Microsoft Entra identity activity. An agent appears in the inventory when its platform integration is enabled and the agent's identity has activity in monitored resources.

Agents built on non-Microsoft platforms or using custom authentication mechanisms can’t be discovered automatically. If your organization uses external AI frameworks or builds custom agents with API key authentication, you need supplementary discovery methods. Defender for Cloud can help discover Azure-hosted workloads, but agents running entirely outside Microsoft ecosystems require manual inventory processes.

At Contoso, the 34 discovered agents represent only those using Microsoft Entra identities. The security team knows they also have several custom Python agents running in Azure Container Instances that authenticate with managed identities. Those appear in the inventory. However, a legacy chatbot using an external service and API key authentication doesn't appear—it requires manual documentation and monitoring.
