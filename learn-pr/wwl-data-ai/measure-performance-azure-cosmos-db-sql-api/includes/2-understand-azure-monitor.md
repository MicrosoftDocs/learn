Most applications using an Azure resource will create availability, performance, and operations metrics on both the application and Azure resource side. Azure Monitor is used to monitor the Azure resource availability, performance, and operations metrics.

Cosmos DB monitors its server-side counters using:

- **Azure Monitor to monitor metrics:** Azure Monitor collects Cosmos DB metrics by default. Metrics are collected every minute. The default retention period is 30 days. The collection includes throughput, storage availability, latency, consistency, and system level metrics. The dimension values for the metrics such as container name are case-insensitive.
- **Azure Monitor to monitor diagnostic logs:** Telemetries like events and traces are stored as logs.  For example, changing the throughput properties of a container will be a logged event.  Queries can then be run against these logs to analyze the data collected.
- **The Azure Cosmos DB portal:** The throughput, storage availability, latency, consistency, and system level metrics can be found under the **Metrics** tab of the Azure Cosmos DB account.  The default retention period for these metrics is seven days.
- **The Cosmos DB NoSQL API SDKs to programmatically monitor the account:** Use the .NET, Java, Python, Node.js SDKs, and the headers in REST API to programmatically monitor a Cosmos DB account.

    :::image type="content" source="../media/2-monitor-cosmos-db.png" alt-text="Diagram that shows the options available to monitor Azure Cosmos DB.":::

In this module, the lesson will be limited to how Cosmos DB applies its monitoring using the Azure Monitor.  Azure Monitor for Cosmos DB can be used to:

- Monitor data
- Collection and routing
- Analyze metrics
- Analyze logs
- Create Alerts
- Monitor Azure Cosmos DB Programmatically 

## Monitor data
The Overview page in the Azure portal for each Azure Cosmos database includes a brief view including the requests and hourly billing for the database.  This summary is just a small set of the metrics being collected by the Azure Monitor.  Besides the hourly billing and request metrics that the Cosmos Database Overview page displays, Azure Monitor collects other request metrics plus request units, storage, latency, availability, and Cassandra API metrics.

## Collection and routing
By default Azure Monitor collects and stores Cosmos DB metrics automatically.  Azure Monitor can also route those metrics to other locations by using a diagnostic setting.  Unlike metrics, Resource Logs aren't collected and stored without first creating a diagnostic setting to route them.

## Analyze metrics
To analyze Cosmos DB metrics, use the metrics explorer by opening **Metrics** from the **Azure Monitor** menu in the Azure portal. To filter by the Cosmos DB metrics, pick  *Cosmos DB standard metrics* from the *Metric Namespace* pulldown.  Other filters can be added for the collection name, database name, operation type, region, and status code dimensions.

## Analyze logs
Azure Monitor Logs data is stored into tables.  Queries can be run against these tables to analyze their data. Azure Cosmos DB stores log data into the `AzureDiagnostics` and `AzureActivity` tables. To search the AzureDiagnostics table for Azure Cosmos DB entries, include a filter with the `resourceprovider` field equal to `MICROSOFT.DOCUMENTDB` in your queries. Additionally, Azure Cosmos DB also logs data to several resource-specific tables.

## Alerts
Azure Monitor can trigger alerts based on defined conditions.  These alerts can be set on metrics, logs, and the activity log. For example, you can get an alert when a container or a database has exceeded the provisioned throughput limit.

## Monitor Azure Cosmos DB programmatically
The NoSQL APIs don't include account level metrics like storage usage and total requests. The NoSQL APIs however, provide collection level metrics either using the REST API or the .NET SDK.