Contoso has a hybrid infrastructure. Some workloads run as Azure IaaS VMs, while others run on physical or virtual servers in Contoso datacenters. Azure Arc-enabled servers provides an Azure resource representation for machines hosted outside Azure so you can apply Azure management and monitoring services consistently.

## Prepare hybrid machines

Complete these prerequisites before you enable Azure Monitor for a hybrid machine:

- Connect the machine to Azure Arc-enabled servers by installing the Azure Connected Machine agent.
- Verify that the operating system supports Azure Monitor Agent.
- Allow outbound HTTPS traffic to the required Azure Resource Manager and Azure Monitor endpoints.
- Create or select a destination workspace.
- Obtain permission to create DCRs and associate them with the Arc-enabled server.

Azure Monitor Agent uses the managed identity created for the Arc-enabled server. You don't join the server to a workspace by using a workspace ID and shared key.

## Enable monitoring

To enable monitoring for one Arc-enabled server in the Azure portal:

1. Search for and select **Azure Arc**.
2. Under **Infrastructure**, select **Machines**, and then select the connected server.
3. Under **Monitoring**, select **Insights**.
4. Select **Configure**.
5. Select the monitoring configuration and destination workspace.
6. Select **Review + Enable**, and then select **Enable**.

The portal installs the Azure Monitor Agent extension and creates or associates the required DCR. For larger environments, use Azure Policy to deploy the agent and DCR associations at scale.

## Configure data collection rules

DCRs separate data collection configuration from the agent. A DCR specifies:

- Resources that use the rule.
- Data sources, such as Windows events, performance counters, Syslog, and file-based logs.
- Optional transformations that filter or modify data before ingestion.
- Destinations, such as a Log Analytics workspace.

One DCR can apply to many machines, and one machine can use multiple DCRs. This model lets you manage collection centrally without editing settings on each server.

> [!NOTE]
> VM insights creates a DCR for its predefined performance data. Create additional DCRs when you need Windows events, custom performance counters, or other guest data.

## Verify hybrid monitoring

On the Arc-enabled server, select **Extensions** and confirm that `AzureMonitorWindowsAgent` or `AzureMonitorLinuxAgent` shows **Provisioning succeeded**. Then review **Insights** for performance data or query the `Heartbeat` table in the destination Log Analytics workspace.

Monitor ingestion volume after deployment. DCR scope, collection frequency, and selected data sources affect network usage and Azure Monitor costs.

## Learn more

- [Tutorial: Monitor a hybrid machine with VM insights](/azure/azure-arc/servers/tutorial-enable-vm-insights)
- [Deployment options for Azure Monitor Agent on Azure Arc-enabled servers](/azure/azure-arc/servers/azure-monitor-agent-deployment)
- [Data collection rules in Azure Monitor](/azure/azure-monitor/data-collection/data-collection-rule-overview)
