In this module, you explored the strategies and tools for loading data into a Microsoft Fabric data warehouse.

A Copy job handles the bulk CSV import through a guided wizard. T-SQL COPY statements give you precise control over data types and transformation logic for the SQL Server data. Dataflow Gen2 provides a visual Power Query interface for the activity logs that need cleansing and business rule validation before loading. These are three common approaches, but Fabric also supports loading data through notebooks, REST APIs, and shortcuts depending on your scenario.

You also explored the data load strategies behind these tools. Full loads replace entire tables and work well for initial migrations or small reference tables. Incremental loads bring in only new or changed rows — essential for large fact tables that grow continuously. Slowly changing dimensions preserve historical attribute changes, and surrogate keys keep dimension records stable across source system changes.

For additional reading:

- [Ingest data into the warehouse](/fabric/data-warehouse/ingest-data?azure-portal=true)
- [Incremental load with data pipelines](/fabric/data-factory/tutorial-incremental-copy-data-warehouse-lakehouse?azure-portal=true)
- [Ingest data into your warehouse using data pipelines](/fabric/data-warehouse/ingest-data-pipelines?azure-portal=true)