After ingesting data from your sources, you can use the Azure Databricks platform to collaboratively explore and analyze your data.

Let's explore the tools you use when working with data in Azure Databricks.

## Collaborate and run code with notebooks

You can use **notebooks** in Azure Databricks to write Python, SQL, Scala, or R code to explore and visualize data. Notebooks support interactive data exploration and can be shared among team members. It also supports data profiling capabilities for data scientists to understand the shape and content of the data.

:::image type="content" source="../media/azure-databricks-language.png" alt-text="Screenshot of available languages in Azure Databricks notebooks." lightbox="../media/azure-databricks-language.png":::

You can use the built-in **visualizations** to quickly understand data distributions, trends, and patterns. Next to the built-in features, Azure Databricks allows you to integrate with commonly used open-source libraries like Matplotlib, Seaborn, or D3.js for more complex visualizations.

## Work with Spark DataFrames

When you work with data in notebooks, you make use of **Spark DataFrames** that are built on Apache Spark. DataFrames allow you to manipulate large datasets efficiently.

To create a simple DataFrame, you can run the following code:

```python
data = [("Alice", 34), ("Bob", 45), ("Cathy", 29)]
columns = ["Name", "Age"]
df = spark.createDataFrame(data, columns)
```

DataFrames support operations like filtering, aggregation, and joining, which are crucial for data exploration.

For example, you can filter a DataFrame:

```python
filtered_df = df.filter(df["Age"] > 30)
```

Azure Databricks also supports **SQL** by allowing to switch between DataFrame operations and SQL queries to interact with the data in a way that feels most natural.

To filter the DataFrame using a SQL query, you first create a temporary view:

```sql
df.createOrReplaceTempView("people")

sql_df = spark.sql("SELECT Name, Age FROM people WHERE Age > 30")
```

> [!Tip]
> For more information, learn how to [load and transform data using Apache Spark DataFrames](/azure/databricks/getting-started/dataframes?azure-portal=true).

## Explore data using libraries and APIs

Depending on what you want to do with your data, you need to use specific libraries and APIs to provide you with the functionality to perform your desired data processing steps.

### Install open-source libraries

As a data analyst, data engineer, or data scientist, you can use your preferred open-source libraries to explore and process data. Azure Databricks allows you to install Python libraries such as Pandas, NumPy, or Scikit-learn for additional data analysis capabilities.

### Use MLlib for machine learning workloads

You can train machine learning models to help you explore and process your data. With Spark's MLlib, you make optimal use of the distributed compute clusters that are attached to your notebooks. With the MLlib library, you can apply machine learning techniques like clustering, regression, and classification, helping you to uncover hidden and complex patterns in your data.

### Visualize data with external visualization tools

Besides built-in chart options, Azure Databricks integrates with external visualization tools like Tableau or Power BI through **data visualization APIs** for enhanced dashboarding capabilities.

> [!Tip]
> Learn more on how to work with [libraries](/azure/databricks/libraries/?azure-portal=true).

## Manage your compute clusters

When you want to run code in notebooks, you have to attach a notebook to a compute cluster to access the necessary processing power.

:::image type="content" source="../media/azure-databricks-cluster.png" alt-text="Screenshot of Azure Databricks cluster.":::

There are two benefits to managing your compute clusters in Azure Databricks:

- **Auto-scaling clusters:** You can automatically scale your computational resources depending on the workload, which helps in optimizing costs and performance during the exploration phase.
- **Managed clusters:** You can simplify your cluster management as Azure Databricks manages the configuration, setup, and maintenance.

> [!Tip]
> Learn more about how to [manage compute](/azure/databricks/compute/clusters-manage?azure-portal=true)

These tools make Azure Databricks a flexible platform for data exploration, handling everything from basic data cleaning to advanced machine learning projects.
