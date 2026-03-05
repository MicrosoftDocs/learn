After you ingest and transform data, it's ready for analysis. A lakehouse in Microsoft Fabric provides multiple ways to query and analyze data, so you can choose the right tool for each task. Whether you prefer SQL for familiar querying patterns or Spark for complex analysis, the lakehouse accommodates your workflow.

## Query data using the SQL analytics endpoint

The SQL analytics endpoint provides read-only access to lakehouse tables using T-SQL queries. This endpoint is automatically created with every lakehouse. It allows you to query tables without affecting the underlying data files. You can write queries to explore data, filter rows, aggregate values, and join tables, just like you would with a traditional SQL database.

Common use cases for the SQL analytics endpoint include:

- **Ad-hoc queries**: Quickly investigate data to answer business questions.
- **Business intelligence connections**: Connect tools like Power BI, Excel, or Azure Data Studio to retrieve data for reports.
- **Data validation**: Verify transformation results after loading or processing data.

You can also create SQL views to store reusable query logic. Views are useful when you need to apply business rules, simplify complex joins, or provide curated data for downstream consumers. For example, you might create a view that joins sales and product tables and filters for active products only, making it easier for report authors to consume the data.

The SQL analytics endpoint also supports **row-level security** and **column-level security**, so you can control which users see which data when they query through SQL.

> [!TIP]
> Copilot for SQL queries can help you write T-SQL queries from natural language descriptions. You can describe what you want to analyze, and Copilot suggests query code to accomplish your goal. This approach accelerates query authoring and helps you learn T-SQL patterns.

## Query data using Spark notebooks

Notebooks provide a flexible, code-based environment for querying and analyzing lakehouse data. You can use Spark SQL for SQL-like queries or PySpark for programmatic data manipulation. Notebooks are valuable when you need to perform exploratory data analysis, apply statistical methods, or prepare data for machine learning models.

**Spark SQL vs PySpark:**

- **Spark SQL**: Use SQL syntax within a notebook cell to query lakehouse tables. Write queries like `SELECT * FROM schema.table` to retrieve and analyze data.
- **PySpark**: Use Python code to manipulate data. You can write SQL queries using `spark.sql()` or use the DataFrame API with Python methods like `df.select()` and `df.filter()`.

Choose the approach that fits your preference and the complexity of your analysis. Spark SQL works well for familiar SQL patterns. PySpark provides greater flexibility for complex transformations and integration with Python libraries.

Common use cases for Spark notebooks include:

- **Exploratory data analysis**: Investigate patterns, outliers, and relationships in data.
- **Complex transformations**: Apply business logic that's easier to express in code than SQL.
- **Cross-workspace queries**: Use the four-part namespace (`workspace.lakehouse.schema.table`) to join data across multiple lakehouses in a single query.

> [!TIP]
> Copilot for notebooks can generate PySpark or Spark SQL code from natural language prompts and explain existing code. This AI-powered assistance accelerates development and helps you learn Spark syntax as you work.

## Analyze and visualize with Power BI

Power BI is the business intelligence and reporting layer in Fabric. It serves as the consumption layer where business users access data through interactive reports and dashboards.

Power BI can connect to lakehouse data in two ways:

- **Query the SQL analytics endpoint**: Analysts can connect directly to the SQL analytics endpoint using Power BI or other tools like Excel to run ad-hoc queries and explore data before building reports.
- **Create a semantic model**: You can create a semantic model that references specific lakehouse tables. This model defines relationships, measures, and business logic that Power BI reports consume.

When you build reports on a lakehouse semantic model, Power BI uses **Direct Lake** mode by default. Direct Lake reads data directly from Delta Lake Parquet files without importing or copying data. This approach provides fast query performance while ensuring reports always reflect the current lakehouse data.

Semantic models also support downstream intelligent experiences. When you define clear relationships and business measures in a semantic model, Copilot in Power BI can generate visualizations and answer business questions by reasoning over your lakehouse data.
