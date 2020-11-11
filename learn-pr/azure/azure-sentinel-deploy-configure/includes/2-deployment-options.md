To deploy the proof-of-concept environment, your first step is to understand the capabilities and deployment considerations of Azure Sentinel.

## Use Azure Sentinel to retrieve data and monitor incidents

Azure Sentinel detects data incidents from connected sources, and then alerts you when action is necessary. You can use Azure Sentinel overviews, dashboards, and custom queries to gain insights into raw data and potentially malicious events.

Deploy connectors from Azure Sentinel to services to retrieve data from different data sources that Contoso's management wants to monitor. After Azure Sentinel retrieves the log data from the services, it performs correlation across data sources. You can manage that data by using the Azure Monitor Log Analytics workspace.

Azure Sentinel uses machine learning and AI to perform:

- Threat hunting
- Alert detection
- Fast responses to an incident

### Onboard Azure Sentinel

To onboard Azure Sentinel, you need to enable it, and then connect your data sources.

Azure Sentinel comes with a number of connectors for Microsoft and other solutions that are available out of the box. There are connectors for:

- Security Center
- Microsoft 365 sources, including Office 365
- Azure AD
- Azure ATP
- Cloud App Security
- Built-in connectors for partner solutions
- Built-in connector for Amazon Web Services

Additionally, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use Common Event Format (CEF), Syslog, or a REST API to connect your data sources with Azure Sentinel. The following image shows this connectivity capability.

:::image type="content" source="../media/sentinel-connections.png" alt-text="Diagram showing multiple data connections to Azure Sentinel." border="false":::

### Key factors for Azure Sentinel deployment

The lead system engineer at Contoso performed research and determined these key points:

- Azure Sentinel needs access to a Log Analytics workspace. The process is to create a Log Analytics workspace and enable Azure Sentinel on top of that workspace.
- Azure Sentinel is a paid service.
- Data retention for a customized workspace is based on the workspace pricing tier. If the Log Analytics workspace is used with Azure Sentinel, the first 90 days of retention are free.
- To enable Azure Sentinel, you need Contributor permissions to the subscription in which the Azure Sentinel workspace resides.
- To use Azure Sentinel, you need either Contributor or Reader permissions for the resource group to which the workspace belongs.

Azure Sentinel runs on workspaces in any general availability region of Log Analytics except the China and Germany regions. Certain data that Azure Sentinel generates might contain customer data sourced from these workspaces. For example, incidents, bookmarks, and alert rules. This data is saved in Europe for European workspaces, in Australia for Australian workspaces, or in East US for workspaces in any other region.

### How to deploy Azure Sentinel

Follow these steps to enable Azure Sentinel:

1. Sign in to the Azure portal.
1. Select the subscription that Azure Sentinel is to be created in. This account should have:
    1. Contributor permissions to the subscription where the Azure Sentinel workspace will be created.
    1. Contributor or Reader permissions on the resource group that the Azure Sentinel workspace will belong to.
1. Search for and select **Azure Sentinel**, and then select **Add**. The message **No Azure Sentinel workspace to display** opens.
1. Select **Create a new workspace**. The **Log analytics workspace** dialog box opens.
1. Enter a name for the workspace.
1. Use the drop-down lists to select the:
    1. Subscription to use
    1. Resource group
    1. Location
    1. Pricing tier
1. On the Azure Sentinel **Choose a workspace** blade, select the workspace that you created, and then select the **Add Azure Sentinel** button. The Azure Sentinel dashboard opens.

### Monitor data feeds

The lead system engineer at Contoso discovered that after you connect security sources, you can monitor data feeds. Monitor features include:

|Data feeds|Description|
|---|---|
|Workbooks|Monitor data by using Azure Sentinel with Monitor workbooks.|
|Analytics|Azure Sentinel uses analytics to correlate alerts with incidents. Analytics help reduce noise and minimize the number of alerts to review and investigate.|
|Security automation and orchestration|Automate common tasks and simplify security orchestration with playbooks that interoperate with Azure services. They can work with existing tools.|
|Investigation|Use the deep investigation tools to understand the scope and find the root cause of potential security threats.|
|Hunting|Use the powerful hunting search-and-query tools that are based on the MITRE ATT&CK framework. Use these tools to proactively hunt for security threats across your organization's data sources.|
|Community|Microsoft security analysts constantly create and add new workbooks, playbooks, hunting queries, and more. They post them to the community for all to use.|

The following screenshot shows the **Azure Sentinel - Overview** page. The page contains charts and graphs to help you understand events, alerts, and incidents.

:::image type="content" source="../media/azure-sentinel-dashboard.png" alt-text="Screenshot of Azure Sentinel - Overview page with several graphs and charts, including events and alerts over time, recent incidents, potential malicious events, and the total number of events, alerts, and incidents." border="false":::
