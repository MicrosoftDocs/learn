So far in this module, we've talked about the three cloud-management disciplines, which we call a management baseline. This unit looks beyond the default management baseline. 

There are most likely workloads in your environment that require more management services than the ones described in the management baseline. An *enhanced* management baseline is often a low-operations investment, compared to workload or platform specialization.

:::image type="content" source="../media/overview-002.png" alt-text="Diagram of management baselines showing enhanced baseline, platform specialization, and workload specialization." border="false":::

If most of your workloads require more than your default management baseline, it's a good idea to review the management baseline. It's also a good idea to review your management baseline when new services are implemented or new Azure features are released. For example, if your company implements an IT Service Management (ITSM) solution, a connection to automate incident creation adds to the enhanced operations baseline.

*Workload specialization* is for the most mission-critical workloads, which make up about 20 percent of the workloads.

*Platform specialization* is for the platform or platforms that run the most high-criticality workloads. The specialized platform investment is often divided over many workloads.

The following table shows some of the most common enhancements to a management baseline:

| Tool | Description | Link to more information |
| -----|-------------|--------------------------|
| Azure Resource Graph | Visibility into changes to Azure resources that might help detect negative effects sooner or remediate faster | [Azure Resource Graph product page](https://azure.microsoft.com/features/resource-graph/) |
| IT Service Management Connector | Automated ITSM connection to create awareness sooner and enrich work items |  [IT Service Management Connector overview](/azure/azure-monitor/alerts/itsmc-overview) |
| Azure Automation | Automation of: <li> Responses to changes</li><li>Resource-specific scaling or sizing issues</li><li> Operations across multiple clouds</li> |  [Azure Automation product page](https://azure.microsoft.com/services/automation/) |
| Azure Automation State Configuration 	| Code-based configuration of guest operating systems to reduce configuration drifting and quickly find errors | [State Configuration overview](/azure/automation/automation-dsc-overview) |
| Microsoft Defender for Cloud	| Extended protection to include recovery triggers for security breaches | [Microsoft Defender for Cloud product page](https://azure.microsoft.com/services/security-center/) |
