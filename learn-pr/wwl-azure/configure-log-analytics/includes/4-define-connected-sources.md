Connected Sources are the computers and other resources that generate data collected by Log Analytics. This can include agents installed on [Windows](/azure/log-analytics/log-analytics-windows-agents) and [Linux](/azure/log-analytics/log-analytics-linux-agents) computers that connect directly or agents in a connected [System Center Operations Manager management group](/azure/log-analytics/log-analytics-om-agents) . Log Analytics can also collect data from [Azure storage](/azure/log-analytics/log-analytics-azure-storage).

:::image type="content" source="../media/connected-sources-8ed0246f.png" alt-text="VM agents in Azure and on-premises are providing data to a workspace.":::


This following diagram shows how Connected Sources flow data to the Log Analytics service.

:::image type="content" source="../media/connected-sources-details-37a12192.png" alt-text="Diagram showing who Connected Sources flow data to the Log Analytics service. The flow and steps in the graphic are numbered 1 to 5, and are described in the content.":::


Ensure you can locate each of the following.

 -  The Log Analytics service (1) collects data and stores it in the repository (2). The repository is hosted in Azure. Connected Sources provide information to the Log Analytics service.
 -  Computer agents (3) generate data to the Log Analytics service. These agents can run on Windows or Linux computers, virtual or physical computers, on-premises or cloud computers, and Azure or other cloud providers.
 -  A System Center Operations Manager management group can be connected to Log Analytics. Agents (4) communicate with management servers that forward events and performance data to Log Analytics.
 -  An Azure storage account (5) can also collect Azure Diagnostics data from a worker role, web role, or virtual machine in Azure. This information can be sent to the Log Analytics service.
