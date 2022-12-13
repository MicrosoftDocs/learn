While SQL is commonly used by data analysts to query data and support analytical and reporting workloads, data engineers often need to use SQL to *transform* data; often as part of a data ingestion pipeline or extract, transform, and load (ETL) process.

In this module, you'll learn how to use `CREATE EXTERNAL TABLE AS SELECT` (CETAS) statements to transform data, and store the results in files in a data lake that can be queried through a relational table in a serverless SQL database or processed directly from the file system.

After completing this module, you'll be able to:

- Use a CREATE EXTERNAL TABLE AS SELECT (CETAS) statement to transform data.
- Encapsulate a CETAS statement in a stored procedure.
- Include a data transformation stored procedure in a pipeline.

## Prerequisites

Before starting this module, you should have the following prerequisite skills and knowledge:

- Familiarity with Azure Synapse Analytics.
- Experience using Transact-SQL to query and manipulate data.
