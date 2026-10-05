Contoso's finance request, cost by customer for the quarter, is the kind of question that per-account monitoring answers badly. Metrics live in each account. They're retained for 93 days, and joining 200 of them by hand is a week of work that has to be repeated every quarter. Fleet analytics exists for that class of question. This unit covers what it collects, how to send it somewhere you can query, and how to read the schema it produces.

## What fleet analytics collects, and when to reach for it

Fleet analytics consolidates cost, usage, and configuration data for every account in a fleet, aggregated at an hourly grain, and delivers it as open-source Apache Delta Lake tables in Microsoft Fabric OneLake or Azure Data Lake Storage Gen2. It's designed for three jobs: tracking resource usage and provisioning trends across the estate, analyzing cost at scale by account, subscription, or fleetspace, and publishing those findings with tools such as Power BI and Spark.

:::image type="content" source="../media/fleet-analytics-pipeline.png" alt-text="Diagram of accounts in a fleet aggregated hourly into Delta Lake fact and dimension tables, then queried and visualized." lightbox="../media/fleet-analytics-pipeline.png":::

It doesn't replace the monitoring you already have; it answers a different question at a different grain. The comparison includes SQL (Structured Query Language) endpoints. A useful way to hold the three apart:

| Feature | Azure Monitor metrics | Azure Monitor logs | Fleet analytics |
| :--- | :--- | :--- | :--- |
| Scope | Account | Account | Fleet-wide |
| Aggregation | 1 minute, preaggregated | Per request, raw | 1 hour, preaggregated |
| Retention | 93 days | User-defined | User-defined |
| Extra cost | No | Yes, storage costs apply | Yes, Fabric or storage costs apply |
| Analysis tool | Metrics Explorer | Log Analytics workspace | Fabric SQL endpoint or Kusto Query Language, Data Lake Storage Gen2 |
| Alerting | Metric alert rules | Log alert rules | Fabric alert rules |

Reach for metrics when you need to know what's happening now in one account, logs when you need the individual request behind an incident, and fleet analytics when the question spans accounts or spans months. An hourly grain is deliberate: it's coarse enough to keep a year of estate-wide history cheap and fine enough to see a daily pattern.

Fleet analytics supports Azure Cosmos DB for NoSQL accounts that are configured with the fleet.

## Choose a destination and grant access

Enabling fleet analytics is two steps, and the second one is the step people skip.

First, add a destination. On the fleet's resource menu, select **Fleet analytics** in the **Monitoring** section, select **Add destination**, and choose either **Send to Fabric workspace** or **Send to storage account**. For Fabric, select the workspace and an existing OneLake lakehouse; for Azure Storage, select the account and a container. Save the destination.

Second, grant the Azure Cosmos DB fleet analytics service principal permission to write to that destination. A shared service principal named **Cosmos DB Fleet Analytics** does the writing, and until it has a role assignment, nothing arrives:

- For a Fabric workspace, add the principal to the workspace with the **Contributor** role in the workspace's **Manage** section.
- For an Azure Storage account, assign the principal the **Storage Blob Data Contributor** role from the storage account's **Access Control (IAM)** page.

The destinations must meet their prerequisites before you enable fleet analytics. A Fabric workspace has to use OneLake as its default storage location and sit on a licensed or trial Fabric capacity. For Azure Storage, the documented fleet analytics setup enables hierarchical namespace at account creation. Azure Storage also supports a [one-way upgrade](/azure/storage/blobs/upgrade-to-data-lake-storage-gen2-how-to) for eligible existing accounts, but this exercise uses a new account. Because the Fabric service principal needs Contributor access to the entire workspace, a dedicated workspace for fleet analytics is the recommended arrangement rather than pointing it at a workspace that holds other work.

Data takes up to an hour to start appearing at the destination. If nothing arrives after 24 hours, check the missing role assignment first; a support ticket is the next step. Once data is flowing, the storage and the query compute are billed to your own Fabric workspace or storage account at standard rates.

## Read the star schema

The dataset follows a star schema: a few fact tables holding measurements, surrounded by dimension tables that give those measurements meaning. Facts carry the numbers, and dimensions carry the names.

The fact tables are:

| Table | Holds |
| :--- | :--- |
| `FactRequestHourly` | Request counts, request and response sizes, and request charges in request units, by operation, resource name, status code, and substatus code |
| `FactResourceUsageHourly` | Storage, document and partition counts, provisioned and consumed throughput, and configuration flags such as autoscale, serverless, and time to live |
| `FactAccountHourly` | Account-level settings including consistency level, backup mode and retention, API kind, and the dates the account keys were last rotated |
| `FactMeterUsageHourly` | Consumed units per billing meter, which is the basis for cost analysis |
| `FactFleetHourly` | Fleet membership over time |

The dimension tables include `DimResource`, which maps a `ResourceId` to a fleet, subscription, account name, region, database, and container, and `DimMeter`, which maps a `MeterId` to a product, meter name, description, and base price. Others cover fleets, regions, time, status codes, substatus codes, operation names, and resource names.

`DimResource` is the one to remember. The usage fact tables identify their subject only by `ResourceId`, so a query over one of them on its own produces rows you can't attribute to a customer. Joining to `DimResource` is what turns a measurement into an answer.

## Query the estate

The queries that follow the schema are ordinary joins. This query finds the most active accounts over the last week by joining request facts to the resource dimension:

```sql
SELECT TOP 100
    DR.[SubscriptionId],
    DR.[AccountName],
    SUM(FRH.[TotalRequestCount]) AS sum_total_requests
FROM
    [FactRequestHourly] FRH
JOIN
    [DimResource] DR
    ON FRH.[ResourceId] = DR.[ResourceId]
WHERE
    FRH.[Timestamp] >= DATEADD(DAY, -7, GETDATE())
    AND ResourceName IN ('Document', 'StoredProcedure')
GROUP BY
    DR.[AccountName],
    DR.[SubscriptionId]
ORDER BY
    sum_total_requests DESC;
```

The `ResourceName` filter restricts the count to data-plane operations, so control-plane activity doesn't inflate a customer's apparent traffic.

Cost analysis works the same way against `FactMeterUsageHourly`, joined to `DimMeter` for the meter's name and base price and to `DimResource` for the account it belongs to. Storage rankings come from `FactResourceUsageHourly`, whose `MaxDataStorageInKB` and `MaxIndexStorageInKB` columns are reported in kilobytes and usually want converting before they're charted.

In a Fabric workspace, save a query as a view and visualize it with Power BI directly from the SQL endpoint. Against Data Lake Storage Gen2, create Delta tables over the exported folders in a Spark notebook and query them with SQL. The schema is identical either way; only the surrounding tooling changes.
