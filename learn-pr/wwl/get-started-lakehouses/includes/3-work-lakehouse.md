---
ms.custom:
  - build-2023
---
Now that you understand the core capabilities of a Microsoft Fabric Lakehouse, let's explore how to work with one.

## Create and explore a lakehouse

You create and configure a new Lakehouse in the Data Engineering workload. Each lakehouse produces three named items in the Fabric-enabled workspace:

- **Lakehouse** is the lakehouse storage and metadata, where you interact with files, folders, and table data.
- **Dataset (default)** is an automatically created data model based on the tables in the lakehouse. Power BI reports can be built from the dataset.
- **SQL Endpoint** is a read-only SQL endpoint through which you can connect and query data with Transact-SQL.

![The three Lakehouse items as described](../media/lakehouse-items.png)

You can work with the data in the lakehouse in two modes:

- **Lakehouse** enables you to add and interact with tables, files, and folders in the Lakehouse.
- **SQL Endpoint** enables you to use SQL to query the tables in the lakehouse and manage its relational data model.

![The two Lakehouse Explorer modes](../media/explorer-modes.png)

## Ingest data into a lakehouse

You can load data into the Lakehouse multiple ways, including:

- **Upload**: Upload local files or folders to the lakehouse. You can then explore and process the file data, and load the results into tables.

- **Dataflows (Gen2)**: Import and transform data from a range of sources using Power Query Online, and load it directly into a table in the lakehouse.

- **Data Factory pipelines**: Copy data and orchestrate data processing activities, loading the results into tables or files in the lakehouse.

- **Shortcuts**: Connect to external file storage, such as OneLake or Azure Data Lake Store Gen2 locations.

  > [!NOTE]
  > Fabric *Shortcuts* enable you to integrate data into your lakehouse while keeping it stored in external storage. For more information, see [OneLake shortcuts documentation](https://learn.microsoft.com/fabric/onelake/onelake-shortcuts) in the Microsoft Fabric documentation.

## Explore and transform data in a lakehouse

After loading data into the lakehouse, you can use various tools and techniques to explore and transform it, including:

- **Apache Spark**: Each Fabric lakehouse can use Spark pools through *Notebooks* or *Spark Job Definitions* to process data in files and tables in the lakehouse using Scala, PySpark, or Spark SQL.

  - **Notebooks**: Interactive coding interfaces in which you can use code to read, transform, and write data directly to the lakehouse as tables and/or files.

  - **Spark Job Definitions**: On-demand or scheduled scripts that use the Spark engine to process data in the lakehouse.

- **SQL Endpoint**: Each lakehouse includes a SQL endpoint through which you can run Transact-SQL statements to query, filter, aggregate, and otherwise explore data in lakehouse tables.

- **Dataflows (Gen2)**: In addition to using a dataflow to ingest data into the lakehouse, you can create a dataflow to perform subsequent transformations through Power Query, and optionally land transformed data back to the Lakehouse.

- **Data Pipelines**: Orchestrate complex data transformation logic that operates on data in the lakehouse through a sequence of activities (such as dataflows, Spark jobs, and other control flow logic).

## Analyze and visualize data in a lakehouse

The data in your lakehouse tables is included in a dataset that defines a relational model for your data. You can edit this dataset (or create other datasets), defining custom measures, hierarchies, aggregations, and other elements of a data model. You can then use the dataset as the source for a Power BI report that enables you to visualize and analyze the data.

By combining the data visualization capabilities of Power BI with the centralized storage and tabular schema of a data lakehouse, you can implement an end-to-end analytics solution on a single platform.
