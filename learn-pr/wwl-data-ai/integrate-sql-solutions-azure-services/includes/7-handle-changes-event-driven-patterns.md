Modern applications often need to respond to database changes in real time. When a customer places an order, updates their profile, or when inventory levels change, downstream systems need notification. SQL Server and Azure SQL provide several mechanisms for capturing and streaming these changes, each with different characteristics for latency, throughput, and implementation complexity.

Data API Builder integrates with these change mechanisms through Azure Functions SQL trigger bindings. Understanding when to use each approach helps you build responsive, event-driven architectures that react to data changes efficiently.

## Understand change capture mechanisms

SQL platforms offer multiple approaches for tracking data changes, each suited to different scenarios:

- [Change Data Capture (CDC)](/sql/relational-databases/track-changes/about-change-data-capture-sql-server?azure-portal=true) records insert, update, and delete operations to special change tables. It captures the complete before-and-after state of changed rows, making it ideal for audit requirements and data synchronization.

- [Change Tracking](/sql/relational-databases/track-changes/about-change-tracking-sql-server?azure-portal=true) provides a lighter-weight alternative that records which rows changed without capturing the actual values. Applications query change information to determine what data needs synchronization.

- [Change Event Streaming (CES)](/sql/relational-databases/track-changes/about-change-event-streaming-sql-server?azure-portal=true) is a newer feature that pushes changes to event streams without polling. It integrates directly with Azure Event Hubs for high-throughput scenarios.

| Feature | CDC | Change Tracking | CES |
|---------|-----|-----------------|-----|
| Captures changed values | Yes | No | Yes |
| Polling required | Yes | Yes | No |
| Historical data | Yes | Limited | Stream only |
| Setup complexity | Moderate | Low | Moderate |

## Enable Change Data Capture for audit scenarios

CDC is appropriate when you need a complete history of changes for compliance or debugging. Enable it on specific tables:

```sql
-- Enable CDC at the database level
EXEC sys.sp_cdc_enable_db;

-- Enable CDC on a specific table
EXEC sys.sp_cdc_enable_table
    @source_schema = 'dbo',
    @source_name = 'Orders',
    @role_name = NULL,
    @capture_instance = 'dbo_Orders',
    @supports_net_changes = 1;
```

Once enabled, SQL Server creates change tables that store historical records. Query these tables to retrieve changes within a time range:

```sql
DECLARE @from_lsn binary(10), @to_lsn binary(10);
SET @from_lsn = sys.fn_cdc_get_min_lsn('dbo_Orders');
SET @to_lsn = sys.fn_cdc_get_max_lsn();

SELECT *
FROM cdc.fn_cdc_get_all_changes_dbo_Orders(@from_lsn, @to_lsn, 'all');
```

This query returns all changes between the minimum and maximum log sequence numbers, including the operation type (`__$operation`) indicating insert, update, or delete.

> [!NOTE]
> CDC requires SQL Server Agent to be running. The capture and cleanup jobs run on schedules you can configure. Monitor job performance in high-transaction environments.

## Configure Azure Functions SQL trigger binding

[Azure Functions SQL trigger binding](/azure/azure-functions/functions-bindings-azure-sql-trigger?azure-portal=true) provides the most direct integration for responding to database changes. The trigger monitors tables using Change Tracking and invokes your function when rows change.

First, enable Change Tracking on your database and table:

```sql
-- Enable Change Tracking at database level
ALTER DATABASE [YourDatabase]
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON);

-- Enable Change Tracking on the table
ALTER TABLE dbo.Orders
ENABLE CHANGE_TRACKING;
```

Create an Azure Function with the SQL trigger:

```csharp
[FunctionName("OrderChangedTrigger")]
public static void Run(
    [SqlTrigger("[dbo].[Orders]", "SqlConnectionString")]
    IReadOnlyList<SqlChange<Order>> changes,
    ILogger log)
{
    foreach (var change in changes)
    {
        log.LogInformation($"Change operation: {change.Operation}");
        log.LogInformation($"Order ID: {change.Item.OrderId}");
        
        if (change.Operation == SqlChangeOperation.Update)
        {
            // Process order update
            ProcessOrderUpdate(change.Item);
        }
    }
}

public class Order
{
    public int OrderId { get; set; }
    public int CustomerId { get; set; }
    public DateTime OrderDate { get; set; }
    public string Status { get; set; }
}
```

The `SqlChange<T>` type wraps each changed row with its operation type. Your function receives batches of changes, which helps efficiency when multiple rows change simultaneously.

Configure the connection string in your function app settings:

```json
{
  "Values": {
    "SqlConnectionString": "@Microsoft.KeyVault(SecretUri=https://myvault.vault.azure.net/secrets/sql-connection)"
  }
}
```

> [!IMPORTANT]
> The SQL trigger binding requires Change Tracking, not CDC. If you need CDC's historical capabilities alongside real-time triggers, enable both features on your tables.

## Stream changes with Change Event Streaming

For high-throughput scenarios where polling latency is unacceptable, Change Event Streaming pushes changes directly to Azure Event Hubs. This approach eliminates polling delays and scales to millions of events per second.

Configure CES on your database:

```sql
-- Create an event streaming group
CREATE EVENT STREAMING GROUP MyOrderStream
WITH (
    TARGET_TYPE = 'eventhub',
    TARGET_NAME = 'orders-eventhub',
    TARGET_CONNECTION = '<event-hub-connection-string>'
);

-- Add tables to the streaming group
ALTER EVENT STREAMING GROUP MyOrderStream
ADD TABLE dbo.Orders;
```

Changes flow to Event Hubs immediately as transactions commit. Downstream consumers process events using Azure Functions Event Hubs triggers, Stream Analytics, or custom applications.

The Event Hubs message contains:

- Operation type (insert, update, delete)
- Timestamp
- Full row data for inserts and updates
- Key values for deletes

## Choose the right change pattern

Selecting the appropriate change mechanism depends on your requirements:

Use **CDC** when:

- You need complete before-and-after values
- Compliance requires historical change records
- Batch synchronization is acceptable

Use **change tracking** with Functions when:

- You need real-time response to changes
- You only need current values, not history
- You're building event-driven microservices

Use **change event streaming** when:

- You need sub-second latency
- High transaction volumes require streaming
- You're building real-time analytics pipelines

Consider combining approaches. Use CDC for audit and compliance while using Functions triggers for real-time notifications. This pattern provides both historical records and immediate responses.
