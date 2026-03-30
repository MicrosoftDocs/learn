Before you can tune queries or troubleshoot concurrency, you need the right infrastructure underneath. Azure SQL Database gives you two resource models and multiple service tiers. The combination you choose sets the ceiling on compute, memory, I/O, and storage for your workload. Choose too little and performance suffers. Choose too much and you waste budget.

## Compare resource models

Azure SQL Database supports two resource models: **vCore** and **DTU**. They measure and bill resources differently, so understanding the distinction helps you make the right choice from the start.

The **vCore model** gives you direct control over virtual cores, memory, and storage. You pick the hardware generation, service tier, and compute tier independently. If you're migrating from on-premises SQL Server, this model maps cleanly to physical CPU and memory, which makes capacity planning more straightforward. It also supports reserved instance pricing and the Azure Hybrid Benefit for cost savings.

The **DTU model** bundles CPU, memory, and I/O into a single unit called a **Database Transaction Unit** (DTU). DTU-based tiers (Basic, Standard, and Premium) offer preconfigured resource packages. This model works when you don't need fine-grained control over individual resource dimensions.

For most new deployments, Microsoft recommends the vCore model. It provides higher resource limits, greater scaling granularity, and more pricing flexibility.

## Understand service tiers in the vCore model

The vCore model has three service tiers: General Purpose, Business Critical, and Hyperscale. Each tier uses a different architecture, which affects storage type, I/O performance, and availability.

**General Purpose** separates compute and storage. The database engine runs on a compute node while data files reside on Azure Blob Storage. Storage latency is typically between 5 milliseconds and 10 milliseconds. This architecture provides budget-friendly pricing and works well for most business workloads. If the compute node fails, Azure Service Fabric moves the process to a spare node and reattaches the remote storage files.

Consider the e-commerce application from the introduction. During normal business hours, General Purpose handles the order volume without issue. But during a holiday flash sale, I/O latency of 5 milliseconds to 10 milliseconds might not be fast enough for the checkout flow.

**Business Critical** integrates compute and storage on each node. The database engine and data files both use locally attached SSDs in an Always On availability group with three secondary replicas. This design gives you the lowest I/O latency (1 millisecond to 2 milliseconds on average), the highest IOPS (input/output operations per second), and a free read-only replica you can use for reporting queries. The trade-off is cost, roughly 2.7 times more than General Purpose for the same vCore count. For the e-commerce team, Business Critical makes sense if their checkout transactions need consistent sub-2-millisecond latency.

**Hyperscale** uses a decoupled storage architecture with independent page servers and a multi-tiered cache. It supports databases up to 128 TB, allows zero to four high-availability replicas, and scales compute up or down without copying data. You're billed only for allocated storage, not maximum storage. Hyperscale removes the practical storage and scaling limits of the other tiers and is suitable for the widest variety of workloads.

The following table summarizes the key differences:

| Feature | General Purpose | Business Critical | Hyperscale |
|---|---|---|---|
| Storage type | Remote (Azure Blob Storage) | Local SSD | Decoupled with local SSD cache |
| Max storage | 4 TB | 4 TB | 128 TB |
| Max IOPS per vCore | 320 | 4,000 | 5,500 (local SSD) |
| Availability replicas | 1 (no read replicas) | 3 + 1 read replica | 0 to 4 (configurable) |
| Best for | Budget-oriented workloads | Low latency, high I/O | Large databases, flexible scaling |

## Choose a compute tier

Within the vCore model, you also choose between two compute tiers: **provisioned** and **serverless**.

**Provisioned compute** allocates a fixed number of vCores that stay available regardless of workload activity. You pay a fixed hourly rate. This tier fits workloads with consistent or predictable resource consumption, like the e-commerce application that processes orders throughout the day.

**Serverless compute** automatically scales vCores based on demand and bills per second for the compute used. When the database is idle, it can autopause and eliminate compute costs entirely, though autopause is currently supported only in General Purpose. Serverless compute itself is available for both General Purpose and Hyperscale tiers. It works well for development environments, internal tools, or applications with intermittent traffic.

## Match the configuration to your workload

Now that you understand the options, how do you decide? Evaluate your workload against these factors:

- **Latency requirements**: If your application needs I/O latency under 2 milliseconds consistently, choose Business Critical. For moderate latency tolerance, General Purpose is sufficient.
- **Storage size**: If your database exceeds 4 TB or you expect rapid growth, Hyperscale is the only option that accommodates up to 128 TB.
- **Read-heavy workloads**: Business Critical includes a free read-only replica. Hyperscale supports named replicas for flexible read scale-out.
- **Cost sensitivity**: General Purpose with provisioned compute offers predictable pricing. Serverless compute in General Purpose or Hyperscale reduces costs for intermittent workloads.
- **Availability requirements**: Business Critical provides the highest resiliency with three synchronous replicas and the fastest failover. Hyperscale lets you configure the number of replicas to balance resiliency with cost.

> [!TIP]
> When migrating from on-premises SQL Server, use the vCore model because it maps directly to physical CPU and memory. The DTU model doesn't expose individual resource dimensions, which makes capacity planning harder for migrations.

## Configure database-level settings

You picked your tier and compute model. Now look inside the database itself. Several settings affect how Azure SQL Database handles parallelism, query optimization, and recovery. You adjust these settings without changing your service tier.

### Control parallelism with MAXDOP

**Max degree of parallelism (MAXDOP)** controls how many processor threads the engine assigns to a single query. Azure SQL Database defaults to **8**, which works for the widest variety of workloads. Before September 2020, new databases defaulted to 0, unlimited parallelism, and that caused problems. A single analytical query could consume every available thread, starving the checkout flow of CPU.

You set MAXDOP at the database level with `ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP`. You can also set a different value for secondary replicas when your read-write and read-only workloads have different concurrency needs. For a specific query, use the `OPTION (MAXDOP)` hint. The one rule: avoid MAXDOP 0 in production. Unlimited parallelism leads to resource exhaustion, query timeouts, and application outages.

### Let automatic tuning catch regressions

The query optimizer doesn't always pick the best plan. Statistics go stale, data distributions shift, and a plan that was fast yesterday becomes slow today. **Automatic tuning** monitors query performance and applies corrections without waiting for you to notice.

Azure SQL Database supports three options:

- **FORCE_LAST_GOOD_PLAN** detects plan regressions and forces the previous fast plan. Enabled by default.
- **CREATE_INDEX** identifies missing indexes, creates them, and verifies the improvement. Disabled by default.
- **DROP_INDEX** removes unused and duplicate indexes. Disabled by default. Unique indexes, including indexes supporting primary key and unique constraints, are never dropped.

Every change goes through a validation window, 30 minutes to 72 hours depending on query frequency. If performance gets worse, the change is automatically reverted.

```sql
ALTER DATABASE CURRENT
SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON,
                      CREATE_INDEX = ON,
                      DROP_INDEX = OFF);
```

Think about the e-commerce application during a holiday sale. Query patterns shift as different product pages spike in popularity. FORCE_LAST_GOOD_PLAN catches those regressions automatically, so a bad plan change at 2 AM doesn't slow down checkout until someone notices Monday morning. You probably want to leave CREATE_INDEX and DROP_INDEX off until what they propose is reviewed.

### Unlock optimizer features with compatibility level

Every database has a **compatibility level** that determines which query optimizer behaviors are available. New databases in Azure SQL Database default to level **170**, or the highest available level. Each level unlocks a set of **intelligent query processing (IQP)** features:

- **Level 150**: batch mode on rowstore, table variable deferred compilation, scalar user-defined function (UDF) inlining.
- **Level 160**: parameter sensitive plan optimization (PSP), cardinality estimation feedback.
- **Level 170**: optional parameter plan optimization.

Existing databases can run at a lower compatibility level because Microsoft never automatically upgrades this setting. A database created when a lower default was in effect keeps its original level. For example, if you created an Azure SQL Database in 2024, the database is still at level 160 if the level isn't manually updated. Likewise, if you imported a database through a BACPAC file, the imported database's compatibility level is based on the source database's compatibility level. To move up:

```sql
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 170;
```

Don't change this setting blindly in production. Use Query Store to capture a performance baseline at the current level, upgrade in a test environment, and compare. If a query regresses, you can force the old plan while you investigate.

### Reduce plan cache bloat with OPTIMIZE_FOR_AD_HOC_WORKLOADS

The e-commerce application generates product search queries with dozens of filter combinations. Each unique query text gets its own compiled plan in the cache, even if that query never runs again. Over time, the plan cache fills with thousands of single-use plans, pushing out the frequently executed plans that actually matter.

**OPTIMIZE_FOR_AD_HOC_WORKLOADS** solves this issue. When enabled, the engine stores a tiny **compiled plan stub** on first execution instead of the full plan. Only when the same query runs a second time does the engine compile and cache the full plan.

```sql
ALTER DATABASE SCOPED CONFIGURATION
SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = ON;
```

This setting keeps the cache lean and ensures that plans for your most important queries stay resident in memory.

### Understand accelerated database recovery

**Accelerated database recovery** is always enabled in Azure SQL Database. You can't turn it off, and you don't need to. Accelerated database recovery (ADR) redesigns the recovery process so that recovery time stays constant regardless of how many active transactions were running when a failure occurred. It also provides instantaneous transaction rollback and aggressive log truncation.

ADR stores row versions in a **persistent version store** (PVS) inside the database rather than in `tempdb`. Depending on the size of the row being modified, versions are stored either in-row on data pages or off-row in a separate internal table. Write-intensive workloads can see increased page splits and higher log generation because every row version is logged. To minimize that overhead, keep transactions short and reduce unnecessary aborted transactions.

The PVS shares your database's allocated storage, so a growing PVS reduces the space available for your data. To monitor off-row PVS overhead, query `sys.dm_tran_persistent_version_store_stats` and check the `persistent_version_store_size_kb` column, which reports the size of off-row versions only and doesn't include in-row versions stored on data pages. To establish a baseline during typical workloads, compare that value to your total database size. If PVS grows significantly beyond that baseline, look for long-running transactions or high abort rates that delay version cleanup.

## Key takeaways

Azure SQL Database gives you two resource models, three service tiers, and two compute tiers. The vCore model with General Purpose covers most workloads. Business Critical adds sub-2-millisecond latency. Hyperscale removes storage and scaling limits. Inside the database, MAXDOP 8 is the safe default, automatic tuning catches plan regressions, and upgrading your compatibility level unlocks the latest intelligent query processing (IQP) features. Enable OPTIMIZE_FOR_AD_HOC_WORKLOADS to keep the plan cache clean, and monitor PVS storage usage from ADR using `sys.dm_tran_persistent_version_store_stats`, especially in write-heavy scenarios. Next, you explore how isolation levels and concurrency control affect the queries running inside this infrastructure.
