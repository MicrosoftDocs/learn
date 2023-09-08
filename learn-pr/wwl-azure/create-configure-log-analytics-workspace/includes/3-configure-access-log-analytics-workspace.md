
The data in a Log Analytics workspace that you can access is determined by a combination of the following factors:
- The settings on the workspace itself.
- The access to resources sending data to the workspace.
- The method used to access the workspace.

## Access mode
The access mode refers to how you access a Log Analytics workspace and defines the data you can access during the current session. The mode is determined according to the scope you select in Log Analytics.

There are two access modes

- Workspace-context: You can view all logs in the workspace for which you have permission. Queries in this mode are scoped to all data in tables that you have access to in the workspace. This access mode is used when logs are accessed with the workspace as the scope, such as when you select **Logs** on the **Azure Monitor** menu in the Azure portal. This mode is appropriate for Administrators who need to configure data collection and users who need access to a wide variety of resources. When the workspace context is used, access is managed through Azure Role Based Access Control (RBAC).

- Resource-context: When you access the workspace for a particular resource, resource group, or subscription, such as when you select Logs from a resource menu in the Azure portal, you can view logs for only resources in all tables that you have access to. Queries in this mode are scoped to only data associated with that resource. This mode also enables granular Azure RBAC. Workspaces use a resource-context log model where every log record emitted by an Azure resource is automatically associated with this resource. This mode is appropriate for Administrators of Azure resources being monitored. It allows them to focus on their resource without filtering. Records are only available in resource-context queries if they're associated with the relevant resource.

You can view the current workspace access control mode on the Overview page for the workspace in the Log Analytics workspace menu.

:::image type="content" source="../media/la-workspace1.png" alt-text="Screenshot of the Overview page of a Log Analytics workspace with the Access control mode setting highlighted." border="true":::

You can switch which access control mode is being used by selecting the Properties page of the Log Analytics workspace, selecting **Use resource or workspace permissions**, and then selecting the appropriate permission.

:::image type="content" source="../media/la-workspace2.png" alt-text="Screenshot of the Properties page of a Log Analytics workspace with the Access control mode setting highlighted." border="true":::

## Log Analytics RBAC roles
There are two built in Log Analytics related RBAC roles. These are:
- Log Analytics Reader
- Log Analytics Contributor

### Log Analytics Reader
You can assign the Log Analytics Reader role at a particular scope to configure access to a Log Analytics workspace. Members of the Log Analytics Reader role can view all monitoring data and monitoring settings, including the configuration of Azure diagnostics on all Azure resources.

Members of the Log Analytics Reader role can:
- View and search all monitoring data.
- View monitoring settings, including viewing the configuration of Azure diagnostics on all Azure resources.
### Log Analytics Contributor
Members of the Log Analytics Contributor role can:
- Read all monitoring data granted by the Log Analytics Reader role.
- Edit monitoring settings for Azure resources, including:
    - Adding the VM extension to VMs.
    - Configuring Azure diagnostics on all Azure resources.
- Create and configure Automation accounts. Permission must be granted at the resource group or subscription level.
- Add and remove management solutions. Permission must be granted at the resource group or subscription level.
- Read storage account keys.
- Configure the collection of logs from Azure Storage.
- Configure data export rules.
- Run a search job.
- Restore archived logs.

## Log Analytics RBAC scopes
You can configure Log Analytics role access at the following scopes:
- Subscription: Access to all workspaces in the subscription
- Resource group: Access to all workspaces in the resource group
- Resource: Access to only the specified workspace

For example, if you assign the Log Analytics Reader role at the resource group level, the user assigned the role will have Log Analytics Reader level access to all Log Analytics workspaces in that specific resource group.

To configure Azure RBAC permissions at the workspace scope, perform the following steps:
1. Navigate to Log analytics workspace in the Azure portal.
1. Select **Access control (IAM)**.
1. Add a role assignment.
1. Select Log Analytics Reader or Log Analytics Contributor and click **Next**.
1. Add the security principal to which you wish to assign the role and click **Next**.
1. Click **Save**.



