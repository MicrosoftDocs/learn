The Azure Monitor Agent collects monitoring data from the guest operating system of Azure and hybrid virtual machines (VMs). It delivers the data to Azure Monitor for use by features, insights, and other services, such as [Microsoft Sentinel](/azure/sentinel/overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction). This article gives you an overview of the capabilities and supported use cases for the Azure Monitor Agent.

For a short introduction to the Azure Monitor Agent, including a demo of how to deploy the agent in the Azure portal, see the video [ITOps Talk: Azure Monitor Agent](https://www.youtube.com/watch?v=f8bIrFU8tCs).

> [!NOTE]
> The Azure Monitor Agent replaces the [legacy Log Analytics agent](/azure/azure-monitor/agents/log-analytics-agent) for Azure Monitor. The Log Analytics agent is deprecated and isn't supported as of August 31, 2024. If you use the Log Analytics agent to ingest data to Azure Monitor, [migrate now to the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-migration).

## Installation

The Azure Monitor Agent is one method of [data collection for Azure Monitor](/azure/azure-monitor/data-sources). It's installed on VMs running in Azure, in other clouds, or on-premises, where it has access to local logs and performance data. Without the agent, you can collect data only from the host machine because you would have no access to the client operating system and to running processes.

The agent can be installed by using different methods, as described in [Install and manage the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage). You can install the agent on a single machine or at scale by using Azure Policy or other tools. In some cases, the agent is automatically installed when you enable a feature that requires it, such as Microsoft Sentinel.

## Data collection

The Azure Monitor Agent collects all data by using a [data collection rule (DCR)](/azure/azure-monitor/essentials/data-collection-rule-overview). In a DCR, you define the following information:

 -  The data type that's collected
 -  How to transform the data, including filtering, aggregating, and shaping
 -  The destination for collected data

A single DCR can contain multiple data sources of different types. Depending on your requirements, you can choose whether to include several data sources in a few DCRs or create separate DCRs for each data source. If you create separate DCRs for each data source, you can centrally define the logic for different data collection scenarios and apply them to different sets of machines. For recommendations on how to organize your DCRs, see [Best practices for DCR creation and management in Azure Monitor](/azure/azure-monitor/essentials/data-collection-rule-best-practices).

A DCR is applied to a particular agent by creating a [data collection rule association (DCRA)](/azure/azure-monitor/essentials/data-collection-rule-overview#data-collection-rule-associations-dcra) between the DCR and the agent. One DCR can be associated with multiple agents, and each agent can be associated with multiple DCRs. When an agent is installed, it connects to Azure Monitor to retrieve any DCRs that are associated with it. The agent periodically checks back with Azure Monitor to determine if there are any changes to existing DCRs or associations with new ones.

## Cost

There's no cost to use the Azure Monitor Agent, but you might incur charges for the data that's ingested and stored. For information on Log Analytics data collection and retention and for customer metrics, see [Azure Monitor logs cost calculations and options](/azure/azure-monitor/logs/cost-logs) and [Analyze usage in a Log Analytics workspace](/azure/azure-monitor/logs/analyze-usage).

## Supported regions

The Azure Monitor Agent is available for general availability features in all global Azure regions, Azure Government, and Azure operated by 21Vianet. It's not yet supported in air-gapped clouds. For more information, see [Product availability by region](https://azure.microsoft.com/global-infrastructure/services/?products=monitor&rar=true&regions=all).

## Supported services and features

The following tables identify the different environments and features that are currently supported by the Azure Monitor Agent and those that are supported by the legacy agent. This information can help you determine whether the Azure Monitor Agent supports your current requirements. For guidance about migrating specific features, see [Migrate to the Azure Monitor Agent from the Log Analytics agent](/azure/azure-monitor/agents/azure-monitor-agent-migration).

### Windows agents

| **Category**                    | **Area**                                                                           | **Azure Monitor Agent**                                                                                                                           | **Legacy agent** |
| ------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| Support environments            |                                                                                    |                                                                                                                                                   |                  |
|                                 | Azure                                                                              | ✓                                                                                                                                                 | ✓                |
|                                 | Other clouds (Azure Arc)                                                           | ✓                                                                                                                                                 | ✓                |
|                                 | On-premises (Azure Arc)                                                            | ✓                                                                                                                                                 | ✓                |
|                                 | Windows Client OS                                                                  | ✓                                                                                                                                                 |                  |
| Data collected                  |                                                                                    |                                                                                                                                                   |                  |
|                                 | Event Logs                                                                         | ✓                                                                                                                                                 | ✓                |
|                                 | Performance                                                                        | ✓                                                                                                                                                 | ✓                |
|                                 | File-based logs                                                                    | ✓                                                                                                                                                 | ✓                |
|                                 | Internet Information Services (IIS) logs                                           | ✓                                                                                                                                                 | ✓                |
| Data sent to                    |                                                                                    |                                                                                                                                                   |                  |
|                                 | Azure Monitor logs                                                                 | ✓                                                                                                                                                 | ✓                |
| Supported services and features |                                                                                    |                                                                                                                                                   |                  |
|                                 | Microsoft Sentinel                                                                 | ✓ ([Scope](/azure/azure-monitor/agents/azure-monitor-agent-migration#understand-additional-dependencies-and-services)) | ✓                |
|                                 | VM insights                                                                        | ✓                                                                                                                                                 | ✓                |
|                                 | Microsoft Defender for Cloud (uses only the Microsoft Defender for Endpoint agent) |                                                                                                                                                   |                  |
|                                 | Automation Update Management (moved to Azure Update Manager)                       | ✓                                                                                                                                                 | ✓                |
|                                 | Azure Stack HCI                                                                    | ✓                                                                                                                                                 |                  |
|                                 | Update Manager (no longer uses agents)                                             |                                                                                                                                                   |                  |
|                                 | Change tracking                                                                    | ✓                                                                                                                                                 | ✓                |
|                                 | SQL Best Practices Assessment                                                      | ✓                                                                                                                                                 |                  |

### Linux agents

| **Category**                    | **Area**                                                                           | **Azure Monitor Agent**                                                                                                                           | **Legacy agent** |
| ------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| Supported environments          |                                                                                    |                                                                                                                                                   |                  |
|                                 | Azure                                                                              | ✓                                                                                                                                                 | ✓                |
|                                 | Other clouds (Azure Arc)                                                           | ✓                                                                                                                                                 | ✓                |
|                                 | On-premises (Azure Arc)                                                            | ✓                                                                                                                                                 | ✓                |
| Data collected                  |                                                                                    |                                                                                                                                                   |                  |
|                                 | Syslog                                                                             | ✓                                                                                                                                                 | ✓                |
|                                 | Performance                                                                        | ✓                                                                                                                                                 | ✓                |
|                                 | File-based logs                                                                    | ✓                                                                                                                                                 |                  |
| Data sent to                    |                                                                                    |                                                                                                                                                   |                  |
|                                 | Azure Monitor logs                                                                 | ✓                                                                                                                                                 | ✓                |
| Supported services and features |                                                                                    |                                                                                                                                                   |                  |
|                                 | Microsoft Sentinel                                                                 | ✓ ([Scope](/azure/azure-monitor/agents/azure-monitor-agent-migration#understand-additional-dependencies-and-services)) | ✓                |
|                                 | VM insights                                                                        | ✓                                                                                                                                                 | ✓                |
|                                 | Microsoft Defender for Cloud (uses only the Microsoft Defender for Endpoint agent) |                                                                                                                                                   |                  |
|                                 | Automation Update Management (moved to Azure Update Manager)                       | ✓                                                                                                                                                 | ✓                |
|                                 | Update Manager (no longer uses agents)                                             |                                                                                                                                                   |                  |
|                                 | Change tracking                                                                    | ✓                                                                                                                                                 | ✓                |

## Supported data sources

For a list of data sources the Azure Monitor Agent can collect and to learn how to configure them, see [Collect data with the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-data-collection).
