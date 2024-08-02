Azure Virtual Desktop Insights is a dashboard built on Azure Monitor Workbooks that helps IT professionals understand their Azure Virtual Desktop environments. This unit will walk you through how to set up Azure Virtual Desktop Insights to monitor your Azure Virtual Desktop environments.

Before you start using Azure Virtual Desktop Insights, you'll need to set up the following things:

 -  All Azure Virtual Desktop environments you monitor must be based on the latest release of Azure Virtual Desktop that’s compatible with Azure Resource Manager.
 -  At least one configured Log Analytics Workspace. Use a designated Log Analytics workspace for your Azure Virtual Desktop session hosts to ensure that performance counters and events are only collected from session hosts in your Azure Virtual Desktop deployment.
 -  Enable data collection for the following things in your Log Analytics workspace:
    
    
     -  Diagnostics from your Azure Virtual Desktop environment
     -  Recommended performance counters from your Azure Virtual Desktop session hosts
     -  Recommended Windows Event Logs from your Azure Virtual Desktop session hosts
    
    The data setup process described in this unit is the only one you'll need to monitor Azure Virtual Desktop. You can disable all other items sending data to your Log Analytics workspace to save costs.
 -  Anyone monitoring Azure Virtual Desktop Insights for your environment will also need to have the following Azure role-based access control (RBAC) roles assigned as a minimum:
    
    
     -  [Desktop Virtualization Reader](/azure/role-based-access-control/built-in-roles#desktop-virtualization-reader) assigned on the resource group or subscription where the host pools, workspaces and session hosts are.
     -  [Log Analytics Reader](/azure/role-based-access-control/built-in-roles#log-analytics-reader) assigned on any Log Analytics workspace used with Azure Virtual Desktop Insights.

## Log Analytics settings

To start using Azure Virtual Desktop Insights, you'll need at least one Log Analytics workspace. Use a designated Log Analytics workspace for your Azure Virtual Desktop session hosts to ensure that performance counters and events are only collected from session hosts in your Azure Virtual Desktop deployment. If you already have a workspace set up, skip ahead to [Set up the configuration workbook](/azure/virtual-desktop/insights?tabs=monitor#set-up-the-configuration-workbook). To set one up, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).

## Set up the configuration workbook

If it's your first time opening Azure Virtual Desktop Insights, you'll need to set up Azure Virtual Desktop Insights for your Azure Virtual Desktop environment. To configure your resources:

1.  Open Azure Virtual Desktop Insights in the Azure portal at [aka.ms/avdi](https://aka.ms/avdi).
2.  Select **Workbooks**, then select **Check Configuration**.
3.  Select an Azure Virtual Desktop environment to configure from the drop-down lists for **Subscription**, **Resource Group**, and **Host Pool**.

The configuration workbook sets up your monitoring environment and lets you check the configuration after you've finished the setup process. It's important to check your configuration if items in the dashboard aren't displaying correctly, or when the product group publishes updates that require new settings.

### Resource diagnostic settings

To collect information on your Azure Virtual Desktop infrastructure, you'll need to enable several diagnostic settings on your Azure Virtual Desktop host pools and workspaces (this is your Azure Virtual Desktop workspace, not your Log Analytics workspace).

To set your resource diagnostic settings in the configuration workbook:

1.  Select the **Resource diagnostic settings** tab in the configuration workbook.
2.  Select **Log Analytics workspace** to send Azure Virtual Desktop diagnostics.

#### Host pool diagnostic settings

To set up host pool diagnostics using the resource diagnostic settings section in the configuration workbook:

1.  Under **Host pool**, check to see whether Azure Virtual Desktop diagnostics are enabled. If they aren't, an error message will appear that says "No existing diagnostic configuration was found for the selected host pool." You'll need to enable the following supported diagnostic tables:
    
    
     -  Management Activities
     -  Feed
     -  Connections
     -  Errors
     -  Checkpoints
     -  HostRegistration
     -  AgentHealthStatus

#### Workspace diagnostic settings

To set up workspace diagnostics using the resource diagnostic settings section in the configuration workbook:

1.  Under **Workspace**, check to see whether Azure Virtual Desktop diagnostics are enabled for the Azure Virtual Desktop workspace. If they aren't, an error message will appear that says "No existing diagnostic configuration was found for the selected workspace." You'll need to enable the following supported diagnostics tables:
    
    
     -  Management Activities
     -  Feed
     -  Errors
     -  Checkpoints

### Session host data settings

You can use either the Azure Monitor Agent or the Log Analytics agent to collect information on your Azure Virtual Desktop session hosts. We recommend you use the Azure Monitor Agent as the Log Analytics Agent will be deprecated on August 31st, 2024. Select the relevant tab for your scenario.

 -  [Azure Monitor Agent](/azure/virtual-desktop/insights?tabs=monitor#tabpanel_1_monitor)
 -  [Log Analytics agent](/azure/virtual-desktop/insights?tabs=monitor#tabpanel_1_analytics)

To collect information on your Azure Virtual Desktop session hosts, you must configure a [Data Collection Rule (DCR)](/azure/azure-monitor/essentials/data-collection-rule-overview) to collect performance data and Windows Event Logs, associate the session hosts with the DCR, install the Azure Monitor Agent on all session hosts in host pools you're collecting data from, and ensure the session hosts are sending data to a Log Analytics workspace.

The Log Analytics workspace you send session host data to doesn't have to be the same one you send diagnostic data to.

To configure a DCR and select a Log Analytics workspace destination using the configuration workbook:

1.  From the Azure Virtual Desktop overview page, select **Host pools**, then select the pooled host pool you want to monitor.
2.  From the host pool overview page, select **Insights**, then select **Open Configuration Workbook**.
3.  Select the **Session host data settings** tab in the configuration workbook.
4.  For **Workspace destination**, select the **Log Analytics workspace** you want to send session host data to.
5.  For **DCR resource group**, select the resource group in which you want to create the DCR.
6.  Select **Create data collection rule** to automatically configure the DCR using the configuration workbook. This option only appears once you've selected a workspace destination and a DCR resource group.
