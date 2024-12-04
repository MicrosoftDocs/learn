
Diagnostic logging enables you to capture rich operational data for an Azure AI services resource, which can be used to analyze service usage and troubleshoot problems.

## Create resources for diagnostic log storage

To capture diagnostic logs for an AI services resource, you need a destination for the log data. You can use Azure Event Hubs as a destination in order to then forward the data on to a custom telemetry solution, and you can connect directly to some third-party solutions; but in most cases you'll use one (or both) of the following kinds of resource within your Azure subscription:

- **Azure Log Analytics** -  a service that enables you to query and visualize log data within the Azure portal.
- **Azure Storage** - a cloud-based data store that you can use to store log archives (which can be exported for analysis in other tools as needed).

You should create these resources before configuring diagnostic logging for your AI services resource. If you intend to archive log data to Azure Storage, create the Azure Storage account in the same region as your AI services resource.

## Configure diagnostic settings

With your log destinations in place, you can configure diagnostic settings for your AI services resource. You define diagnostic settings on the **Diagnostic settings** page of the blade for your AI services resource in the Azure portal. When you add diagnostic settings, you must specify:

- A name for your diagnostic settings.
- The categories of log event data that you want to capture.
- Details of the destinations in which you want to store the log data.

In the following example, the diagnostic settings store all available log data and metrics in Azure Log Analytics and Azure Storage.

:::image type="content" source="../media/diagnostic-settings.png" alt-text="A screenshot of diagnostic settings for an Azure AI services resource.":::

## View log data in Azure Log Analytics

It can take an hour or more before diagnostic data starts flowing to the destinations, but when the data has been captured, you can view it in your Azure log Analytics resource by running queries, as shown in this example.

:::image type="content" source="../media/azure-log-analytics.png" alt-text="A screenshot of an Azure log Analytics query returning diagnostic data logged for an Azure AI services resource.":::

> [!NOTE]
> For more information, see [Enable diagnostic logging for Azure AI services](/azure/ai-services/diagnostic-logging) in the Azure AI services documentation.
