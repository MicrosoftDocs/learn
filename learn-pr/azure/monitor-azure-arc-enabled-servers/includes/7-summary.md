Over the course of this module, you explored the monitoring capabilities of Azure Arc-enabled servers. You learned about observability services including Azure Monitor Logs, metrics, alerts, and VM insights. These services offer improved visibility across hybrid and multicloud environments, helping customers like Tailwind Manufacturing.

First, you explored ways of managing and deploying Azure observability agents. Next, you learned about onboarding to VM insights. Additionally, you learned about Azure Monitor metrics and Azure Monitor Logs. Finally, you learned about Azure Monitor’s alerting capabilities.

Azure Arc-enabled servers offer a powerful way to streamline and improve monitoring across your firm’s infrastructure. Microsoft’s monitoring solutions aren't limited to Azure; through Azure Arc, you can extend these capabilities across your digital estate.

## More Info

The following resources support the procedures, prerequisites, and review evidence for this module.

### Azure Arc and portal

Use these resources for Azure Arc concepts and portal access:

- [Azure Arc overview](https://azure.microsoft.com/services/azure-arc/)
- [Azure Arc-enabled servers](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/)
- [Azure portal](https://portal.azure.com/)

### Agents, connectivity, and onboarding

Review these guides before you deploy monitoring agents or troubleshoot connectivity:

- [Connected Machine agent overview](/azure/azure-arc/servers/agent-overview)
- [Connected Machine agent components](/azure/azure-arc/servers/agent-overview#agent-components)
- [AMA deployment options for Arc-enabled servers](/azure/azure-arc/servers/azure-monitor-agent-deployment)
- [Manage VM extensions](/azure/azure-arc/servers/manage-vm-extensions)
- [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements)
- [Monitor a hybrid machine](/azure/azure-arc/servers/tutorial-enable-vm-insights)
- [AMA support and migration guidance](/azure/azure-monitor/agents/azure-monitor-agent-migration)
- [AMA network requirements](/azure/azure-monitor/agents/azure-monitor-agent-network-configuration)
- [AMA-supported operating systems](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems)

### Data collection and log workspaces

Use these guides to configure data collection, workspace access, and log queries:

- [DCR creation and association permissions](/azure/azure-monitor/data-collection/data-collection-rule-create-edit#permissions)
- [Collect Windows events](/azure/azure-monitor/agents/data-collection-windows-events)
- [Windows event collection destinations](/azure/azure-monitor/agents/data-collection-windows-events#add-destinations)
- [Log Analytics workspace access](/azure/azure-monitor/logs/manage-access)
- [Log Analytics overview](/azure/azure-monitor/logs/log-analytics-overview)
- [Log Analytics tables and empty-table visibility](/azure/azure-monitor/logs/log-analytics-overview#left-sidebar)
- [Logs Ingestion API](/azure/azure-monitor/logs/logs-ingestion-api-overview)

### Metrics and monitoring experiences

Compare the supported monitoring experiences and their capabilities:

- [Metrics-based and logs-based monitoring experiences](/azure/azure-monitor/vm/metrics-opentelemetry-guest)
- [Metrics Explorer](/azure/azure-monitor/metrics/metrics-explorer)
- [Supported Autoscale services](/azure/azure-monitor/autoscale/autoscale-overview#supported-services-for-autoscale)
- [VM insights performance limitations](/azure/azure-monitor/vm/vminsights-performance#limitations)

### Alerts and notifications

Use these references to configure and troubleshoot alerts:

- [Azure Monitor alert concepts](/azure/azure-monitor/alerts/alerts-overview)
- [Action groups](/azure/azure-monitor/alerts/action-groups)
- [Roles for testing action groups](/azure/azure-monitor/alerts/action-groups#role-requirements-for-test-action-groups)
- [Create log search alerts](/azure/azure-monitor/alerts/alerts-create-log-alert-rule)
- [Manage alerts programmatically with Azure Resource Graph](/azure/azure-monitor/alerts/alerts-manage-alert-instances#manage-your-alerts-programmatically)
- [Alert processing rules](/azure/azure-monitor/alerts/alerts-processing-rules)
- [Secure Webhook integration](/azure/azure-monitor/alerts/it-service-management-connector-secure-webhook-connections)
- [Individual-disk alert queries](/azure/azure-monitor/vm/monitor-virtual-machine-alerts#disk-alerts)
- [Agent heartbeat monitoring](/azure/azure-monitor/vm/monitor-virtual-machine-alerts#agent-heartbeat)
- [Arc disconnected-server alerts](/azure/azure-arc/servers/troubleshoot-connectivity#disconnected-server-alerts)

### Availability and lifecycle

Review these announcements and lifecycle guides before you change your monitoring configuration:

- [June 2026 Azure Monitor release entry](/azure/azure-monitor/fundamentals/whats-new#june-2026)
- [Dependency-mapping lifecycle and replacement guidance](/azure/azure-monitor/vm/vminsights-maps-retirement)
