Linux foundation *Delta Lake* is an open-source storage layer for Spark that enables relational database capabilities for batch and streaming data. By using Delta Lake, you can implement a *[data lakehouse](/azure/databricks/lakehouse)* architecture in Spark to support SQL_based data manipulation semantics with support for transactions and schema enforcement. The result is an analytical data store that offers many of the advantages of a relational database system with the flexibility of data file storage in a data lake.

In this module, you'll learn how to:

- Describe core features and capabilities of Delta Lake.
- Create and use Delta Lake tables in Azure Databricks.
- Create Spark catalog tables for Delta Lake data.
- Use Delta Lake tables for streaming data.

> [!NOTE]
> The version of Delta Lake available in an Azure Databricks cluster depends on the version of the Databricks Runtime being used. The information in this module reflects Delta Lake version 3.x, which is installed with Spark 3.5.0 in Databricks Runtime version 14.3.
