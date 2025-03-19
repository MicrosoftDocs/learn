[Azure Monitor agent (AMA)](/azure/azure-monitor/agents/azure-monitor-agent-overview) is used to collect data from Azure virtual machines, Virtual Machine scale sets, and Arc-enabled servers. [Data collection rules (DCR)](/azure/azure-monitor/essentials/data-collection-rule-overview) define the data to collect from the agent and where that data should be sent. This article describes how to use the Azure portal to create a DCR to collect different types of data and install the agent on any machines that require it.

If you're new to Azure Monitor or have basic data collection requirements, then you may be able to meet all of your requirements using the Azure portal and the guidance in this article. If you want to take advantage of additional DCR features such as [transformations](/azure/azure-monitor/essentials/data-collection-transformations), then you may need to create a DCR using other methods or edit it after creating it in the portal. You can also use different methods to manage DCRs and create associations if you want to deploy using CLI, PowerShell, ARM templates, or Azure Policy.

> [!NOTE]
> To send data across tenants, you must first enable [Azure Lighthouse](/azure/lighthouse/overview).

> [!WARNING]
> The following cases may collect duplicate data which may result in additional charges.

 -  Creating multiple DCRs with the same data source and associating them to the same agent. Ensure that you're filtering data in the DCRs such that each collects unique data.
 -  Creating a DCR that collects security logs and enabling Sentinel for the same agents. In this case, you may collect the same events in the Event table and the SecurityEvent table.
 -  Using both the Azure Monitor agent and the legacy Log Analytics agent on the same machine. Limit duplicate events to only the time when you transition from one agent to the other.

## Data sources

The table below lists the types of data you can currently collect with the Azure Monitor Agent and where you can send that data. The link for each is to an article describing the details of how to configure that data source. Follow this article to create the DCR and assign it to resources, and then follow the linked article to configure the data source.

| **Data source**                                                                                            | **Description**                                                                                | **Client OS**    | **Destinations**                                           |
| ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------- | ---------------------------------------------------------- |
| [Windows events](/azure/azure-monitor/agents/data-collection-windows-events)    | Information sent to the Windows event logging system, including sysmon events.                 | Windows          | Log Analytics workspace                                    |
| [Performance counters](/azure/azure-monitor/agents/data-collection-performance) | Numerical values measuring performance of different aspects of operating system and workloads. | Windows<br>Linux | Azure Monitor Metrics (Preview)<br>Log Analytics workspace |
| [Syslog](/azure/azure-monitor/agents/data-collection-syslog)                    | Information sent to the Linux event logging system.                                            | Linux            | Log Analytics workspace                                    |
| [Text log](/azure/azure-monitor/agents/data-collection-log-text)                | Information sent to a text log file on a local disk.                                           | Windows<br>Linux | Log Analytics workspace                                    |
| [JSON log](/azure/azure-monitor/agents/data-collection-log-json)                | Information sent to a JSON log file on a local disk.                                           | Windows<br>Linux | Log Analytics workspace                                    |
| [IIS logs](/azure/azure-monitor/agents/data-collection-iis)                     | Internet Information Service (IIS) logs from the local disk of Windows machines                | Windows          | Log Analytics workspace                                    |

> [!NOTE]
> Azure Monitor Agent also supports Azure service [SQL Best Practices Assessment](/sql/sql-server/azure-arc/assess/) which is currently Generally available. For more information, refer [Configure best practices assessment using Azure Monitor Agent](/sql/sql-server/azure-arc/assess#enable-best-practices-assessment).

## Prerequisites

 -  [Permissions to create Data Collection Rule objects](/azure/azure-monitor/essentials/data-collection-rule-create-edit#permissions) in the workspace.

## Overview

When you create a DCR in the Azure portal, you're walked through a series of pages to provide the information needed to collect data from the machines you specify. The following table describes the information you need to provide on each page.

| **Section** | **Description**                                                                                                                                                                                                                                                                                                                                                             |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Resources   | Machines that will use the DCR. When you add a machine to the DCR, it creates a [data collection rule association (DCRA)](/azure/azure-monitor/essentials/data-collection-rule-overview#data-collection-rule-associations-dcra) between the machine and the DCR. You can edit the DCR to add or remove machines after it's created.              |
| Data source | The type of data to collect from the machine. The list of available data sources are listed above in [Data sources](/azure/azure-monitor/agents/azure-monitor-agent-data-collection#data-sources). Each data source has its own configuration settings and potentially prerequisites, so see the individual article for each for details.        |
| Destination | Destination where the data collected from the data source should be sent. If you have multiple data sources in the DCR, they can be sent to separate destinations, and data from a single data source may be sent to multiple destinations. See the article for each data source for more details about their destination such as the table in the Log Analytics workspace. |

For detailed steps on how to create a DCR using the Azure portal, see [Create data collection rules](/azure/azure-monitor/essentials/data-collection-rule-create-edit?tabs=portal#create-with-azure-portal).
