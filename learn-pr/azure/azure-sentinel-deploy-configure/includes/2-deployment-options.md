As the Contoso lead system engineer and Azure administrator who is tasked with deploying a proof of concept environment for Azure Sentinel, your first step is to understand its capabilities and deployment considerations.

## What can Contoso do with Azure Sentinel?

By deploying connectors from Azure Sentinel to services, you can retrieve data that the management at Contoso is interested in monitoring. Because the data comes from different data sources, Azure Sentinel is ideal for this purpose. After Azure Sentinel retrieves the log data from those services, it can perform data correlation across the data sources, and then you can manage the data using the Log Analytics workspace. 

Azure Sentiinel can detect incidents in the data from those connected data sources and alert you that something needs your attention. You can get insights into the raw data and potential malicious events and incidents through overviews, dashboards and custom queries. 

Azure Sentinel uses machine learning and AI to perform:

- Threat hunting.
- Alert detection.
- Fast responses to an incident.

### Onboard Azure Sentinel

To onboard Azure Sentinel, you must:

1. Enable Azure Sentinel.
1. Connect your data sources.

Azure Sentinel comes with a number of connectors for Microsoft and other solutions that are available out of the box. There are connectors for:

- Security Center.
- Microsoft 365 sources, including Office 365.
- Azure AD.
- Azure ATP.
- Cloud App Security.
- Built-in connectors for partner solutions.
- Built-in connector for Amazon Web Services.

Additionally, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use Common Event Format (CEF), Syslog, or a REST API to connect your data sources with Azure Sentinel. The following image depicts this connectivity capability.

:::image type="content" source="../media/Sentinel-connections.png" alt-text="The diagram depicts multiple data connections to Azure Sentinel." border="false":::

### Key factors for Azure Sentinel deployment

The research by the lead system engineer at Contoso determined the following key points:

- Azure Sentinel needs access to a Log Analytics workspace. The process is to create a Log Analytics workspace and enable Azure Sentinel on top of that workspace.
- Azure Sentinel is a paid service.
- Data retention for a customized workspace is based on the workspace pricing tier. If the Log Analytics workspace is used with Azure Sentinel then the first 90 days of retention are free.
- To enable Azure Sentinel, you need Contributor permissions to the subscription in which the Azure Sentinel workspace resides.
- To use Azure Sentinel, you need either Contributor or Reader permissions for the resource group to which the workspace belongs.

Azure Sentinel can run on workspaces in any general availability region of Log Analytics except the China and Germany regions. Data that Azure Sentinel generates such as incidents, bookmarks, and alert rules, which might contain some customer data that's sourced from these workspaces, is saved in Europe for European workspaces, in Australia for Australian workspaces, or in East US for workspaces in any other region.

### How to deploy Azure Sentinel

Follow these steps to enable Azure Sentinel:

1. Sign in to the Azure portal. Make sure that the subscription in which Azure Sentinel is to be created is selected. This account should have:
    1. Contributor permissions to the subscription where the Azure Sentinel workspace will be created.
    1. Either Contributor or Reader permissions on the resource group that the Azure Sentinel workspace will belong to.
1. Search for and select **Azure Sentinel**, and then select **Add**. Notice the message that there's **No Azure Sentinel workspace to display**.
1. Select **Create a new workspace**. The **Log analytics workspace** form opens.
1. Enter a name for the workspace.
1. From the drop-down lists on the form, select:
    1. The subscription to use.
    1. The resource group.
    1. The location.
    1. The pricing tier.
1. Back on the Azure Sentinel **Choose a workspace** blade, select the workspace that you just created, and then select the **Add Azure Sentinel** button. The Azure Sentinel dashboard should now display.

### Monitor data feeds

The lead system engineer at Contoso discovered that after connecting security sources, monitoring the resulting data feeds using multiple features became possible. These include:

|Data feeds|Description|
|---|---|
|Workbooks|Monitor data by using Azure Sentinel with Monitor workbooks.|
|Analytics|To help reduce noise and minimize the number of alerts to review and investigate, Azure Sentinel uses analytics to correlate alerts with incidents.|
|Security automation and orchestration|Automate common tasks and simplify security orchestration with playbooks that interoperate with Azure services. They can work with existing tools.|
|Investigation|Use the deep investigation tools to help understand the scope and find the root cause of potential security threats.|
|Hunting|Use the powerful hunting search-and-query tools that are based on the MITRE ATT&CK framework, which enables you to proactively hunt for security threats across your organization's data sources.|
|Community|Microsoft security analysts constantly create and add new workbooks, playbooks, hunting queries, and more, posting them to the community for all to use.|

The following screenshot depicts the **Azure Sentinel - Overview** page, which contains charts and graphs to help you understand events, alerts, and incidents.

:::image type="content" source="../media/Azure-Sentinel-dashboard.png" alt-text="The screenshot depicts the Azure Sentinel - Overview page with several graphs and charts, including events and alerts over time, recent incidents, potential malicious events, and the total number of events, alerts, and incidents." border="false":::
