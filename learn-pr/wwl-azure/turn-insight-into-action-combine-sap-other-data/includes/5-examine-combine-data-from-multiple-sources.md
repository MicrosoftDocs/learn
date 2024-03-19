To help your business select vendors, you need quality data and on-time delivery metrics. That’s why you’ll combine the QA data in your Cosmos DB with your SAP business data for joint analysis. Here is a recap of your activities thus far:

1. You’ve set up an Azure Synapse Studio workspace.
2. You’ve created a link to your SAP Business Warehouse to bring in vendor purchase data.
3. You’ve created a link to your Cosmos DB to bring in vendor quality data.
4. Next you’ll ingest and combine that data. This critical step enables you to run historical analysis and predictive analytics on your joined records.

Now it’s time to use the dedicated SQL pool that Azure Synapse Studio workspace created automatically during setup.

## SQL scripts and pipelines

Because you’re working with a dedicated SQL pool for storing the combined data, you’ll use the SQL scripts capability in Synapse Studio to author SQL queries. The flexible SQL script web interface enables you to develop new scripts, use or modify existing scripts, and select scripts from a gallery of samples.

Pipelines in Azure Synapse Analytics perform data integration, similar to the Azure Data Factory service. The pipeline pulls the data into your dedicated SQL pool. The SQL pool serves as your data source for native Transact-SQL (T-SQL) analytics and predictive analytics using the PREDICT function. Transact-SQL (T-SQL) is a proprietary Microsoft extension to SQL that enables interaction with relational databases.

## Building and running the pipeline

To build and run the pipeline and bring in data using your two linked services, go the Integrate hub in Synapse Studio.

Select **+** and select **Pipeline**. Synapse Studio opens a drag-and-drop pipeline canvas. Drag in the actions you need and set the properties. Select OK and debug if needed. When you select Run the pipeline, you copy data from your data sources into the dedicated SQL pool.

You can run a pipeline once or create a schedule to run a pipeline daily. Every time you run a pipeline, it adds updated data from your data sources.

## Summary

To combine data for analysis, run a pipeline in Synapse Studio. Synapse extracts appropriate data from your two sources, transforms the data, and places it in the dedicated SQL pool ready for analytics and machine learning using the SQL Script interface.
