A query that ran fine yesterday now takes three times longer. A job that processed millions of records suddenly fails with memory errors. These situations often trace back to four common performance issues: **caching problems**, **data skew**, **memory spill**, and **excessive shuffle**. Knowing how to investigate these issues using Azure Databricks diagnostic tools helps you restore performance quickly.

## Use diagnostic tools to identify issues

Azure Databricks provides three primary tools for investigating performance problems. Each offers a different perspective on what's happening during query execution.

The **Directed Acyclic Graph (DAG)** visualizes your query's execution plan. It shows how data flows through operators and where transformations occur. By examining the DAG, you identify where bottlenecks happen and understand the sequence of operations Spark performs.

The **Spark UI** provides detailed metrics about job execution, including stages, tasks, and resource consumption. You access it by navigating to your cluster's page and selecting **Spark UI**. The Jobs page shows timeline views, stage durations, and task distributions that reveal problems with skew, spill, and shuffle.

The **query profile** offers a breakdown of query execution for SQL warehouse workloads. It highlights slow operations and shows metrics like time spent, rows processed, and memory consumption for each operator. Access it through **Query History** in the sidebar, then select a query and choose **See query profile**.

> [!TIP]
> Start your investigation with the DAG to understand the overall execution flow. Then use the Spark UI or query profile to drill into specific stages where time is spent.

## Investigate caching issues

Caching keeps frequently accessed data in memory or on local disks, avoiding repeated reads from remote storage. Azure Databricks uses **disk cache** (formerly called Delta cache) to automatically cache Parquet data files on worker nodes. This caching happens transparently when you read data.

To check if disk cache is enabled, run:

```python
spark.conf.get("spark.databricks.io.cache.enabled")
```

When investigating caching problems, consider these scenarios:

:::image type="content" source="../media/5-investigate-cache-issues.png" alt-text="Diagram showing how to investigate caching issues." border="false" lightbox="../media/5-investigate-cache-issues.png":::

**Under-caching** means data is read repeatedly from remote storage when it could be served from cache. The Spark UI shows high **Input** values for stages that read the same data multiple times. Enable disk cache and use worker nodes with SSD storage for better performance.

**Over-caching** consumes memory that Spark needs for processing. If you see memory pressure or out-of-memory errors, review whether cached data is actually being reused. Spark cache (using `.cache()` or `.persist()`) requires explicit management, unlike automatic disk caching.

Unlike automatic disk cache, Spark cache requires you to call `.unpersist()` when you no longer need the cached data:

```python
df.unpersist()
```

## Investigate data skew

Data skew occurs when some partitions contain significantly more data than others. This imbalance causes a few tasks to run much longer than the rest, leaving most cluster resources idle while waiting for slow tasks to complete.

:::image type="content" source="../media/5-investigate-data-skew.png" alt-text="Diagram showing how to investigate data skew." border="false" lightbox="../media/5-investigate-data-skew.png":::

To identify skew in the Spark UI, navigate to the stage's page and scroll to **Summary Metrics**. Compare the **Max** duration to the **75th percentile**. If the Max is more than 50% higher than the 75th percentile, you likely have skew.

Common causes of skew include:

- **Uneven key distribution** in joins or aggregations (for example, a single customer ID appearing in 90% of records)
- **Null values** that all route to the same partition
- **Time-based partitioning** where recent dates have far more data

To resolve skew:

- **Enable Adaptive Query Execution (AQE)**, which dynamically handles skewed joins. Verify it's enabled:

```python
spark.conf.get("spark.databricks.optimizer.adaptive.enabled")
```

- **Salt skewed keys** by adding a random component to distribute data more evenly across partitions.

- **Broadcast smaller tables** for joins where one table fits in memory to avoid shuffle-based skew.

## Investigate memory spill

Spill happens when Spark runs out of memory during processing and writes intermediate data to disk. This disk I/O significantly slows down operations. Spill commonly occurs during shuffle operations, aggregations, or when partitions are too large.

:::image type="content" source="../media/5-investigate-memory-spill.png" alt-text="Diagram explaining memory spill." border="false" lightbox="../media/5-investigate-memory-spill.png":::

The Spark UI shows spill metrics at the top of each stage's page. Look for **Shuffle Spill (Memory)** and **Shuffle Spill (Disk)** values. Any non-zero spill indicates memory pressure.

To reduce spill:

- **Increase partition count** to reduce data per partition. Set shuffle partitions to `auto` for dynamic optimization:

```python
spark.conf.set("spark.sql.shuffle.partitions", "auto")
```

- **Add more memory** by choosing worker nodes with higher memory-to-core ratios or increasing the number of workers.

- **Optimize data size** by selecting only needed columns and filtering early in your pipeline. Reducing the data processed at each stage lowers memory requirements.

> [!IMPORTANT]
> Spill often accompanies skew. When a single partition grows too large for memory, it spills to disk. Address skew first, and spill problems often resolve as a side effect.

## Investigate shuffle issues

Shuffle moves data between nodes during operations like joins, aggregations, and repartitioning. While sometimes necessary, excessive shuffle is expensive because it involves serializing data, writing to disk, transferring across the network, and deserializing.

:::image type="content" source="../media/5-investigate-shuffle-issues.png" alt-text="Diagram explaining how to investigate shuffle issues" border="false" lightbox="../media/5-investigate-shuffle-issues.png":::

In the Spark UI, check the **Shuffle Read** and **Shuffle Write** columns for each stage. Large shuffle values indicate significant data movement. The DAG shows where shuffle operations occur as exchange nodes.

Reduce unnecessary shuffle with these approaches:

- **Filter data early** before joins or aggregations to reduce the data that must be shuffled.

- **Use broadcast joins** when one table is small (under 30 MB by default). AQE can automatically convert sort-merge joins to broadcast joins when it detects a small table at runtime.

- **Avoid unnecessary repartitioning**. Each call to `repartition()` triggers a full shuffle.

- **Colocate related data**. If you frequently join two tables on the same key, consider bucketing or partitioning them similarly to minimize shuffle at query time.

The query profile in SQL warehouses visualizes shuffle as **Exchange** nodes in the DAG. Select these nodes to see metrics like data size and number of partitions exchanged.

By systematically checking for skew and spill in the Spark UI, reviewing shuffle metrics, and understanding your caching behavior, you can diagnose most performance issues and apply targeted fixes.
