Azure Virtual Desktop uses [Azure Monitor](/azure/azure-monitor/overview) for monitoring and alerts like many other Azure services. This lets admins identify issues through a single interface. The service creates activity logs for both user and administrative actions. Each activity log falls under the following categories:

| **Category**                     | **Description**                                                                                            |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Management Activities            | Whether attempts to change Azure Virtual Desktop objects using APIs or PowerShell are successful.          |
| Feed                             | Whether users can successfully subscribe to workspaces.                                                    |
| Connections                      | When users initiate and complete connections to the service.                                               |
| Host registration                | Whether a session host successfully registered with the service upon connecting.                           |
| Errors                           | Where users encounter issues with specific activities.                                                     |
| Checkpoints                      | Specific steps in the lifetime of an activity that were reached.                                           |
| Agent Health Status              | Monitor the health and status of the Azure Virtual Desktop agent installed on each session host.           |
| Network                          | The average network data for user sessions to monitor for details including the estimated round-trip time. |
| Connection Graphics              | Performance data from the Azure Virtual Desktop graphics stream.                                           |
| Session Host Management Activity | Management activity of session hosts.                                                                      |
| Autoscale                        | Scaling operations.                                                                                        |

Connections that don't reach Azure Virtual Desktop won't show up in diagnostics results because the diagnostics role service itself is part of Azure Virtual Desktop. Azure Virtual Desktop connection issues can happen when the user is experiencing network connectivity issues.

Azure Monitor lets you analyze Azure Virtual Desktop data and review virtual machine (VM) performance counters, all within the same tool. This article will tell you more about how to enable diagnostics for your Azure Virtual Desktop environment.

Before you can use Azure Virtual Desktop with Log Analytics, you need:

 -  A Log Analytics workspace. For more information, see [Create a Log Analytics workspace in Azure portal](/azure/azure-monitor/logs/quick-create-workspace) or [Create a Log Analytics workspace with PowerShell](/azure/azure-monitor/logs/powershell-workspace-configuration). After you've created your workspace, follow the instructions in [Connect Windows computers to Azure Monitor](/azure/azure-monitor/agents/agent-windows#workspace-id-and-key) to get the following information:
    
    
     -  The workspace ID
     -  The primary key of your workspace
    
    You'll need this information later in the setup process.
 -  Access to specific URLs from your session hosts for diagnostics to work. For more information, see [Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/safe-url-list) where you'll see entries for Diagnostic output.
 -  Make sure to review permission management for Azure Monitor to enable data access for users who monitor and maintain your Azure Virtual Desktop environment. For more information, see [Get started with roles, permissions, and security with Azure Monitor](/azure/azure-monitor/roles-permissions-security).

## Push diagnostics data to your workspace

You can push diagnostics data from your Azure Virtual Desktop objects into the Log Analytics for your workspace. You can set up this feature right away when you first create your objects.

To set up Log Analytics for a new object:

1.  Sign in to the Azure portal and go to **Azure Virtual Desktop**.
2.  Navigate to the object (such as a host pool, application group, or workspace) that you want to capture logs and events for.
3.  Select **Diagnostic settings**
4.  Select **Add diagnostic setting**. The options shown in the **Diagnostic Settings** page will vary depending on what kind of object you're editing. Remember to enable diagnostics for each Azure Resource Manager object that you want to monitor. Data will be available for activities after diagnostics has been enabled. It might take a few hours after first set-up.
5.  Enter a name for your settings configuration, then select **Send to Log Analytics**. The name you use shouldn't have spaces and should conform to [Azure naming conventions](/azure/azure-resource-manager/management/resource-name-rules).
6.  Select **Save**.

## How to access Log Analytics

You can access Log Analytics workspaces on the Azure portal or Azure Monitor.

### Access Log Analytics on a Log Analytics workspace

1.  Sign in to the Azure portal.
2.  Search for **Log Analytics workspace**.
3.  Under **Services**, select **Log Analytics workspaces**.
4.  From the list, select the workspace you configured for your Azure Virtual Desktop object.
5.  Once in your workspace, select **Logs**. You can filter out your menu list with the Search function.

### Access Log Analytics on Azure Monitor

1.  Sign in to the Azure portal.
2.  Search for and select **Monitor**.
3.  Select **Logs**.
4.  Follow the instructions in the logging page to set the scope of your query.
5.  You're ready to query diagnostics. All diagnostics tables have a "WVD" prefix.
