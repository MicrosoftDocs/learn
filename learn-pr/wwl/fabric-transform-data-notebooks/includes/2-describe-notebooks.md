Notebooks in Microsoft Fabric provide an interactive coding environment for transforming and analyzing data. You write and run code in individual cells, see results immediately, and iterate on your transformations step by step. Before you start writing transformations, it helps to understand how notebooks work, what they connect to, and when to use them.

## What are Fabric notebooks

A Fabric notebook is a web-based coding surface that runs on Apache Spark. You write code in cells and run each cell independently, which makes it easy to develop and test transformations incrementally. Notebooks support multiple languages, including PySpark (Python), Spark SQL, Scala, and R.

Each notebook connects to a Spark session that provides distributed computing power. When you run the first cell, Fabric starts a Spark session automatically. This session persists until you stop it or it times out due to inactivity. All cells in the notebook share the same session, so variables and temporary views you create in one cell are available in subsequent cells.

You can mix code cells with markdown cells to document your logic, making notebooks useful for both development and collaboration. This combination of executable code and narrative text helps other team members understand your transformation pipeline.

## Key notebook concepts

Understanding a few core concepts helps you work effectively with Fabric notebooks.

**Cells** are the building blocks of a notebook. Each cell contains either code or markdown text. You run code cells individually or run all cells in sequence. Results appear directly below each cell after execution. This cell-by-cell approach lets you verify each transformation step before moving to the next.

**Lakehouse attachment** connects your notebook to one or more lakehouses. When you attach a lakehouse, its tables and files become accessible in the notebook's explorer panel. You pin a default lakehouse, which sets the Hive metastore context for Spark SQL queries. With a default lakehouse pinned, you can query tables by name without specifying a full path.

**Magic commands** let you switch languages within a single notebook. For example, if your notebook's default language is PySpark, you can run a Spark SQL query in any cell by adding `%%sql` at the top of the cell. This flexibility means you can use the best language for each task without creating separate notebooks.

## When to use notebooks versus Dataflows Gen2

Both notebooks and Dataflows Gen2 transform data in Fabric. Choosing between them depends on your transformation complexity and team preferences.

| Factor | Notebooks | Dataflows Gen2 |
|--------|-----------|----------------|
| **Complexity** | Complex logic, custom functions, multi-step processing | Simple to moderate transformations |
| **Interface** | Code-based (SQL, Python) | Visual, low-code (Power Query) |
| **Scale** | Large datasets with Spark distributed processing | Smaller to mid-size datasets |
| **Flexibility** | Full programming language capabilities | Prebuilt transformations and connectors |
| **Collaboration** | Version control, code review | Visual design, less technical barrier |

Use notebooks when your transformations require complex joins, window functions, conditional logic, or when you're working with large datasets that benefit from Spark's distributed processing. Use Dataflows Gen2 when your team prefers a visual interface or when the transformations are straightforward.

## What data stores can notebooks access

Because notebooks run on Apache Spark, they can read from and write to multiple data stores across the Fabric platform. Understanding these connection points helps you design pipelines that span different stores when your scenario requires it.

| Data store | How notebooks connect | Common use case |
|---|---|---|
| **Lakehouse** | Pin as default lakehouse; query Delta tables by name | Core transformation of raw-to-curated data |
| **Warehouse** | Cross-database queries via three-part naming (`warehouse.schema.table`) | Reading dimension tables managed by a SQL team |
| **KQL database** | KQL connector or Spark connector for Kusto | Writing processed events for real-time analytics |
| **External sources** | Spark connectors (JDBC, Azure Blob, ADLS, REST APIs) | Ingesting data from systems outside Fabric |

The lakehouse is the most common source and destination for notebook transformations, because Spark natively reads and writes the Delta format that lakehouses use. The remaining units in this module focus on lakehouse data as the primary teaching example, but the Spark SQL and PySpark patterns you learn apply to any data store that Spark can reach.

## Common development patterns

Notebooks support several development patterns depending on where you are in the project lifecycle.

**Interactive development** is the most common starting point. You write code in cells, run each cell, inspect the output, and refine your logic before committing to a final version. This iterative approach is ideal for exploring unfamiliar data, prototyping transformations, and debugging issues.

**Parameterized notebooks** let you pass values into a notebook at run time: date ranges, file paths, or environment names. You designate a cell as a parameters cell, and the calling process injects values that override the defaults. This pattern turns a development notebook into a reusable component that handles different inputs without code changes.

**Pipeline integration** lets you add notebooks to your workflow orchestration. You add a notebook activity to a Data Factory pipeline, pass parameters, and chain it with other activities like data copies or dataflow refreshes. The pipeline handles orchestration, retries, and monitoring so the notebook focuses purely on transformation logic.

Data in Fabric typically moves through stages: from raw ingestion to curated, analytics-ready tables. Notebooks are well-suited for the transformation steps in the middle, turning raw or lightly processed data into clean, structured formats for downstream reporting and analysis.

> [!TIP]
> Copilot in Fabric notebooks can help you write and debug Spark SQL and PySpark code. Describe a transformation in natural language, and Copilot generates the corresponding code. This is useful when you're learning a new syntax or converting between Spark SQL and PySpark.

Now that you understand how notebooks work and where they fit, you're ready to start transforming data. In the next unit, you learn to shape and clean data using common transformation patterns.
