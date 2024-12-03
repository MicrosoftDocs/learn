Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines and delivers it to Azure Monitor for use by features, insights, and other services such as [Microsoft Sentinel](/azure/sentinel/overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction). This article provides an overview of Azure Monitor Agent's capabilities and supported use cases.

See a short video introduction to Azure Monitor agent, which includes a demo of how to deploy the agent from the Azure portal: [ITOps Talk: Azure Monitor Agent](https://www.youtube.com/watch?v=f8bIrFU8tCs)

> [!NOTE]
> Azure Monitor Agent replaces the [legacy Log Analytics agent](/azure/azure-monitor/agents/log-analytics-agent) for Azure Monitor. The Log Analytics agent has been deprecated and has no support as of August 31, 2024. If you use the Log Analytics agent to ingest data to Azure Monitor, [migrate now to the new Azure Monitor agent](/azure/azure-monitor/agents/azure-monitor-agent-migration).

## Installation<br>

The Azure Monitor agent is one method of [data collection for Azure Monitor](/azure/azure-monitor/data-sources). It's installed on virtual machines running in Azure, in other clouds, or on-premises where it has access to local logs and performance data. Without the agent, you could only collect data from the host machine since you would have no access to the client operating system and running processes.

The agent can be installed using different methods as described in [Install and manage Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage). You can install the agent on a single machine or at scale using Azure Policy or other tools. In some cases, the agent will be automatically installed when you enable a feature that requires it, such as Microsoft Sentinel.

## Data collection

All data collected by the Azure Monitor agent is done with a [data collection rule (DCR)](/azure/azure-monitor/essentials/data-collection-rule-overview) where you define the following:

 -  Data type being collected.
 -  Transforming the data, including filtering, aggregating, and shaping.
 -  Destination for collected data.

A single DCR can contain multiple data sources of different types. Depending on your requirements, you can choose whether to include several data sources in a few DCRs or create separate DCRs for each data source. This allows you to centrally define the logic for different data collection scenarios and apply them to different sets of machines. See [Best practices for data collection rule creation and management in Azure Monitor](/azure/azure-monitor/essentials/data-collection-rule-best-practices) for recommendations on how to organize your DCRs.

The DCR is applied to a particular agent by creating a [data collection rule association (DCRA)](/azure/azure-monitor/essentials/data-collection-rule-overview#data-collection-rule-associations-dcra) between the DCR and the agent. One DCR can be associated with multiple agents, and each agent can be associated with multiple DCRs. When an agent is installed, it connects to Azure Monitor to retrieve any DCRs that are associated with it. The agent periodically checks back with Azure Monitor to determine if there are any changes to existing DCRs or associations with new ones.

:::image type="content" source="../media/data-collection-rule-associations-2887d79f.png" alt-text="Diagram showing an example of Data collection rule association.":::


### Windows agents

\| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \| \|

### Linux agents

| **Category**                    | **Area**                                                     | **Azure Monitor Agent**                                                                                                                                | **Legacy Agent** |
| ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------- |
| Environments supported          |                                                              |                                                                                                                                                        |                  |
|                                 | Azure                                                        | ✓                                                                                                                                                      | ✓                |
|                                 | Other cloud (Azure Arc)                                      | ✓                                                                                                                                                      | ✓                |
|                                 | On-premises (Azure Arc)                                      | ✓                                                                                                                                                      | ✓                |
| Data collected                  |                                                              |                                                                                                                                                        |                  |
|                                 | Syslog                                                       | ✓                                                                                                                                                      | ✓                |
|                                 | Performance                                                  | ✓                                                                                                                                                      | ✓                |
|                                 | File based logs                                              | ✓                                                                                                                                                      |                  |
| Data sent to                    |                                                              |                                                                                                                                                        |                  |
|                                 | Azure Monitor Logs                                           | ✓                                                                                                                                                      | ✓                |
| Services and features supported |                                                              |                                                                                                                                                        |                  |
|                                 | Microsoft Sentinel                                           | ✓ ([View scope](/azure/azure-monitor/agents/azure-monitor-agent-migration#understand-additional-dependencies-and-services)) | ✓                |
|                                 | VM Insights                                                  | ✓                                                                                                                                                      | ✓                |
|                                 | Microsoft Defender for Cloud - Only use MDE agent            |                                                                                                                                                        |                  |
|                                 | Automation Update Management - Moved to Azure Update Manager | ✓                                                                                                                                                      | ✓                |
|                                 | Update Manager - no longer uses agents                       |                                                                                                                                                        |                  |
|                                 | Change Tracking                                              | ✓                                                                                                                                                      | ✓                |

## Costs

There's no cost for the Azure Monitor Agent, but you might incur charges for the data ingested and stored. For information on Log Analytics data collection and retention and for customer metrics, see [Azure Monitor Logs cost calculations and options](/azure/azure-monitor/logs/cost-logs) and [Analyze usage in a Log Analytics workspace](/azure/azure-monitor/logs/analyze-usage).

## Supported regions

Azure Monitor Agent is available in all public regions, Azure Government and China clouds, for generally available features. It's not yet supported in air-gapped clouds. For more information, see [Product availability by region](https://azure.microsoft.com/global-infrastructure/services/?products=monitor&rar=true&regions=all).

## Supported services and features

The following tables identify the different environments and features that are currently supported by Azure Monitor agent in addition to those supported by the legacy agent. This information will assist you in determining whether Azure Monitor agent can support your current requirements. See [Migrate to Azure Monitor Agent from Log Analytics agent](/azure/azure-monitor/agents/azure-monitor-agent-migration) for guidance on migrating specific features.
