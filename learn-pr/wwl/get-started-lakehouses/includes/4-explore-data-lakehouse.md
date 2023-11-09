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
