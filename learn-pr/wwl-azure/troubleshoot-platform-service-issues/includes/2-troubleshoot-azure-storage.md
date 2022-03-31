Troubleshooting Azure Storage issues is complex, and it's advisable to proactively monitor and log Azure Storage to detect any unexpected changes.

Your application might use one or more storage systems including Microsoft Azure Storage Tables, Blobs, Queues, or Files. Furthermore, data might be stored in relational or non-relational databases.

You should aim to remove the need for retrospectively troubleshooting problems with Azure Storage by proactively monitoring and reviewing logs for Storage services. Metrics such as slow response times would lead to a review of logs which can then determine the nature of the issue and allow for focused troubleshooting.

To monitor your Storage services, you can use Azure Monitor for Storage accounts to view key Storage metrics for performance, capacity, and availability without any further configuration. Azure Monitor for Storage accounts provides a selection of dashboards and charts to give you detailed monitoring data for your Storage services. You can also enable storage metrics. The counters for storage metrics can be aggregated by hour or by minute and you can choose to display key metrics in the Azure portal. Storage metrics aren't in preview, but it does require configuration.

:::image type="content" source="../media/2-storage-accounts.png" alt-text="Screenshot of Azure Monitor Storage account.":::

For more information on troubleshooting Azure Storage, see [Monitor, diagnose, and troubleshoot Microsoft Azure Storage](/azure/storage/common/storage-monitoring-diagnosing-troubleshooting?tabs=dotnet).

