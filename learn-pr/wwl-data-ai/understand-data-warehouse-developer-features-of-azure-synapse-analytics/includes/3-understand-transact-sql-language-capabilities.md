Azure Synapse Analytics supports querying both relational (dedicated and serverless SQL endpoints) and non-relational data (Azure Data Lake Storage Gen 2, Cosmos DB and Azure Blob Storage) at petabyte-scale using Transact SQL, supporting ANSI-compliant SQL language. 

The Azure Synapse SQL query language supports different features based on the resource model being used. The table below outlines which Transact-SQL statements work against each resource model.

|T-SQL Statement|Dedicated|Serverless|
|---|---|---|
|SELECT statement|Yes|Yes|
|INSERT statement|Yes|No|
|UPDATE statement|Yes|No|
|DELETE statement|Yes|No|
|MERGE statement|No|No|
|Transactions|Yes|No|
|Labels|Yes|No|
|Data load|Yes|No|
|Data export|Yes, using CETAS|Yes, using CETAS|
|Cross database queries|No|Yes|
|Built-in functions (analysis, text, table-value)|Yes|Yes|
|Aggregates|T-SQL built-in aggregates|T-SQL built-in aggregates|
|Operators|Yes|Yes|
|Control flow|Yes|Yes|
|DDL statements|Yes|Yes|
