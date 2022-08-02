By using the CREATE EXTERNAL TABLE AS statement, you can use Azure Synapse serverless SQL pool to transform data as part of a data ingestion pipeline or an extract, transform, and load (ETL) process. The transformed data is persisted in files in the data lake with a relational table based on the file location; enabling you to work with the transformed data using SQL in the serverless SQL database, or directly in the file data lake.

In this lesson, you learned how to:

- Use a CREATE EXTERNAL TABLE AS SELECT (CETAS) statement to transform data.
- Encapsulate a CETAS statement in a stored procedure.
- Include a data transformation stored procedure in a pipeline.

> [!TIP]
> For more information about using the CETAS statement, see [CETAS with Synapse SQL](/azure/synapse-analytics/sql/develop-tables-cetas) in the Azure Synapse Analytics documentation.
