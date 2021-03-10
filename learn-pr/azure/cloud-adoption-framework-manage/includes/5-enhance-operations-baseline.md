So far in this module, we have talked about the three cloud management disciplines, which we call management baseline. This unit will look beyond the default management baseline. There are most likely workloads in your environment that require more management services than described in the management baseline. Enhanced management baseline is often a low operations investment, compared to workload or platform specialization.

:::image type="content" source="../media/overview-002.png" alt-text="Overview of management baselines showing enhanced baseline, platform specialization and workload specialization." border="false":::

If most of your workloads require more than your default management baseline, reviewing the management baseline is a good idea. When new services are implemented or new features of Azure is released, a management baseline review is a good idea. For example, if the company implements an ITSM solution, a connection to automate create incident adds to the enhanced operations baseline.

Workload specialization is for workloads the most mission-critical workloads. This is approximately 20% of the workloads.

Platform specialization is for the platform or platforms that run the most high-criticality workloads. The specialized platform investment is often divided over many workloads.

The following table shows some of the most common enhancements to a management baseline.

| Tool | Description | Link to more information |
| -----|-------------|--------------------------|
| Azure Resource Graph | Visibility into changes to Azure resources might help detect negative effects sooner or remediate faster. | [More information at Microsoft Docs](https://azure.microsoft.com/features/resource-graph/) |
| IT Service Management Connector | Automated ITSM connection to create awareness sooner and enriched work items. |  [More information at Microsoft Docs](https://docs.microsoft.com/azure/azure-monitor/platform/itsmc-overview) |
| Azure Automation | Azure Automation can support in multiple ways; <li> Automate response to changes</li><li>Automate resource specific scaling or sizing issues</li><li> Automate operations across multiple clouds</li> |  [More information at Microsoft Docs](https://azure.microsoft.com/services/automation/) |	
| Desired State Configuration (DSC)	| Code-based configuration of guest operating systems to reduce configuration drifting and quickly find errors. | [More information at Microsoft Docs](https://docs.microsoft.com/azure/automation/automation-dsc-overview) |
| Azure Security Center	| Extended protection to include security breach recovery triggers. | [More information at Microsoft Docs](https://azure.microsoft.com/services/security-center/) |
