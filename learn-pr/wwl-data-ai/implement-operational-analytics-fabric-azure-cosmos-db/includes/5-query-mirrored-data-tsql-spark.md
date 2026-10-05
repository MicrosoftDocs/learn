The mirrored data is Delta in OneLake, and Delta is the format every Fabric engine reads. That single fact is what makes the rest of this unit straightforward: Transact-SQL (T-SQL) and Spark aren't two integrations you configure. They're two engines pointed at the same files. In this unit, you query the mirror both ways, expand the nested JSON a document database inevitably produces, and learn which engine to reach for when the two disagree.

## The SQL analytics endpoint

Every mirrored database gets an automatically generated SQL analytics endpoint over its Delta tables. You reach it by switching the experience selector from **Mirrored Azure Cosmos DB** to **SQL analytics endpoint**, and each container in the source database appears as a table.

The endpoint is **read-only**. Familiar T-SQL defines and queries objects, and it doesn't manipulate the data, because the tables are a replicated copy. Writing back to Azure Cosmos DB from either the endpoint or the mirrored database's source view isn't permitted.

What you can do is most of what analytics needs: aggregate, filter, and join.

```sql
SELECT
    categoryName,
    COUNT(*) AS productCount,
    AVG(price) AS averagePrice
FROM
    cosmicworks_product
GROUP BY
    categoryName
ORDER BY
    productCount DESC
```

You can also save a query as a view and build a report on it, or use the visual query editor to compose one without writing T-SQL at all. Beyond the portal, the endpoint is reachable from SQL Server Management Studio, the MSSQL extension for Visual Studio Code, and any Open Database Connectivity (ODBC) or Java Database Connectivity (JDBC) client, so existing SQL tooling works against it unchanged.

### Nested JSON, and the two functions that differ

Here is where a document source stops behaving like a warehouse table. **Nested JSON objects and arrays arrive as JSON string columns**, not as structured columns. A CosmicWorks product carries a `tags` array of objects, and in the mirrored table, `tags` is one column holding text like `[{"id":"...","name":"Tag-42"}]`.

T-SQL expands the `tags` column with `OPENJSON`, combined with either `CROSS APPLY` or `OUTER APPLY`. Declaring the shape gives you typed columns:

```sql
SELECT
    p.name,
    p.categoryName,
    t.tagId,
    t.tagName
FROM
    cosmicworks_product AS p
    CROSS APPLY OPENJSON(p.tags) WITH (
        tagId   varchar(100) '$.id',
        tagName varchar(100) '$.name'
    ) AS t
```

**The choice between `CROSS APPLY` and `OUTER APPLY` is the choice of what happens to items with nothing in the array, and on this dataset, it's measurable.** Of the 295 CosmicWorks products, 250 carry tags and 45 have an empty `tags` array, and the 250 tagged products hold 767 tag elements between them. `CROSS APPLY` behaves like an inner join and returns 767 rows, dropping every untagged product. `OUTER APPLY` keeps them, emitting one row with null tag columns each, for 812 rows. A report counting products by tag wants the first. A report listing the catalog wants the second, or it quietly loses 45 products.

When the nested shape is unpredictable, you can skip the `WITH` clause and let auto schema inference flatten a level for you:

```sql
SELECT
    p.name,
    t.*
FROM
    cosmicworks_product AS p
    CROSS APPLY OPENJSON(p.tags) AS t
```

Auto schema inference returns the generic `key`, `value`, and `type` columns `OPENJSON` produces without a schema, which is what you want when you're exploring rather than reporting. `CROSS APPLY` and `OUTER APPLY` nest, so deeper structures expand one level per pair.

> [!TIP]
> When you declare types in `OPENJSON`, prefer `varchar(n)` over `varchar(max)`. Query performance degrades with `varchar(max)`, and the smaller `n` is, the better the query tends to run.

There's one boundary condition to know about. Mirrored tables **created before November 18, 2025** support only `varchar(8000)`, and a JSON string column holding a moderately nested document commonly exceeds that limit. The symptom is a malformed-JSON error when you query the table, not a length error, which sends people looking in the wrong place. Tables created after that date use `varchar(max)`. To pick up the newer type, an older table has to be recreated, which in practice means removing the container from the mirror and adding it back.

### Joining across sources

The endpoint isn't limited to one mirrored database. Use **+ Warehouses** to add another SQL analytics endpoint, warehouse, or lakehouse in the same workspace, and then join across them with three-part names, with no data movement in either direction:

```sql
SELECT
    c.firstName,
    c.lastName,
    o.orderDate
FROM
    [ContosoOrders].[dbo].[cosmicworks_customer] AS o
    INNER JOIN cosmicworks_customer AS c
        ON o.customerId = c.customerId
WHERE
    o.type = 'salesOrder'
    AND c.type = 'customer'
```

This join is the capability the merchandising question needed: operational data from Azure Cosmos DB joined to whatever else the organization landed in the workspace, answered in one query.

## Spark over the same files

Spark reads the mirrored data through a **shortcut**, which is a pointer rather than a copy. In a lakehouse, choose **Get data**, then **New shortcut**, then **Microsoft OneLake**, and select the tables you want from the mirrored database. They then behave like lakehouse tables:

```python
df = spark.sql("SELECT * FROM cosmicworks_product LIMIT 1000")
display(df)
```

From there, it's ordinary Spark. Nested JSON is still a string column, so you parse it with Spark's own JSON functions rather than `OPENJSON`, and you can join mirrored tables to anything else in the lakehouse.

**Notice what this path doesn't need: a Cosmos DB connector.** Reading mirrored data is reading Delta, and Spark reads Delta natively. Reading mirrored data without a Cosmos DB connector surprises people who expect an analytics integration to require a driver, and it's worth stating because there *is* a Cosmos DB Spark connector and it solves a different problem.

The connector connects **directly to the Cosmos DB endpoint**, not to OneLake. You'd use it for reverse ETL, writing an analytical result back into an operational container so an application can serve it with low latency and high concurrency. Setting up the connector means creating a custom Spark environment and uploading the connector libraries, and every read and write through it **consumes request units on the account**, because it's talking to the database rather than to a replicated copy. Reading through OneLake costs the source nothing; reading through the connector costs it request units. Choose accordingly.

One practical asymmetry between the two engines is worth remembering. When a recently written item appears in Spark but not in the SQL analytics endpoint, the replication is fine and the endpoint is still catching up. **Spark reads the latest state of the Delta files directly**, so it's the faster check on whether data landed. If an item is missing from both, the question concerns replication and belongs in the previous unit's escalation order.

## Beyond queries

Once the data is in OneLake, Power BI can build a semantic model on it and report in Direct Lake mode, reading the Delta files without importing them. Building those reports is its own subject and out of scope here, but it's the reason the format matters: one replicated copy serves T-SQL, Spark, notebooks, and business intelligence without another hop.

In this unit, you learn how to query mirrored data from an Azure Cosmos DB account in Fabric OneLake using both T-SQL and Spark, understand the differences between the two approaches, and make informed decisions about which tool to use for different analytical workloads.
