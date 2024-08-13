Before you start using Azure Monitor for Azure Virtual Desktop, you'll need to set up the following things:<br>

 -  At least one configured Log Analytics Workspace. Use a designated Log Analytics workspace for your Azure Virtual Desktop session hosts to ensure that performance counters and events are only collected from session hosts.
 -  Enable data collection for the following things in your Log Analytics workspace:
    
    
     -  Diagnostics from your Azure Virtual Desktop environment
     -  Recommended performance counters from your Azure Virtual Desktop session hosts
     -  Recommended Windows Event Logs from your Azure Virtual Desktop session hosts

The data setup process described in this unit is the only one you'll need to monitor Azure Virtual Desktop. You can disable all other items sending data to your Log Analytics workspace to save costs.

Anyone monitoring Azure Monitor for Azure Virtual Desktop for your environment will also need the following read-access permissions:

 -  **Read-access** to the Azure subscriptions that hold your Azure Virtual Desktop resources.
 -  **Read-access** to the subscription's resource groups that hold your Azure Virtual Desktop session hosts.
 -  **Read-access** to the Log Analytics workspace or workspaces.

Read access only lets admins view data. They'll need different permissions to manage resources in the Azure Virtual Desktop portal.

## Open Azure Monitor for Azure Virtual Desktop

You can open Azure Monitor for Azure Virtual Desktop by doing the following:

 -  Go to the Azure portal.
 -  Search for and select **Azure Monitor** from the Azure portal. Select **Insights Hub** under **Insights**, then select **Azure Virtual Desktop**. Once you have the page open, enter the **Subscription, Resource group, Host pool**, and **Time range** of the environment you want to monitor.

## Log Analytics settings

To start using Azure Monitor for Azure Virtual Desktop, you'll need at least one Log Analytics workspace. Use a designated Log Analytics workspace for your Azure Virtual Desktop session hosts to ensure that performance counters and events are only collected from session hosts in your Azure Virtual Desktop deployment.
