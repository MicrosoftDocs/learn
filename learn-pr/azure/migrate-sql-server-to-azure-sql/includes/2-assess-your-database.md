You have decided to move your SQL Server databases to Azure SQL Database to benefit from Azure's scalability and availability. However, you want to validate that Azure SQL Server provides all of the functionality that you currently use in your on-premises SQL Server.

You'll use a tool called the **Data Migration Assistant** to help you to assess your existing database for compatibility with Azure SQL Server.

## What is the Data Migration Assistant (DMA)?

The Data Migration Assistant tool is specifically designed to analyze on-premises SQL Server instances. It will detect and report common issues that can impede SQL database migrations to Azure SQL Server.

It will detect compatibility issues that can block migration as well as recognize features used in your on-premises server that are either partially supported or unsupported.

It will also provide comprehensive recommendations to perform on your on-premises server before migration.

### Why do you need the Data Migration Assistant?

Azure SQL Database shares a common code base with SQL Server. However, not all features are present in the cloud. The Data Migration Assistant can help to identify features you are using in your on-premise SQL Server that are not available in Azure SQL Server. You can refer to the [Azure SQL Database feature list](https://docs.microsoft.com/azure/sql-database/sql-database-features) for an up-to-date list of what is different between the two products.

## How to assess your database using the Data Migration Assistant?

Assessing your database using the Data Migration Assistant typically involves the following steps:

1. **Install the Data Migration Assistant** – Download and install Data Migration Assistant from https://www.microsoft.com/download/details.aspx?id=53595. Azure SQL Database is regularly updated; Data Migration Assistant is also updated to reflect any new capabilities. It is recommended to run the installer to ensure you have the latest version installed.
2. **Create an assessment** – You create a new assessment that defines your on-premises database and the target database. You can also assess another target of SQL Server on Azure Virtual Machines to allow you to compare alternative migrations.
3. **Select options for assessment and database sources** – You select your options, for example, whether you want to check compatibility or feature parity among the two databases. Then, choose your source database. You can select multiple sources.
4. **Review results** - The detailed results allows you to review errors and take corrective action. The results show unsupported features with cross-database references and SQL Server Agent. It also gives a list of partially supported features, with full-text search and auditing. The result provides possible errors and advice on how to rectify those errors. You can export the Data Migration Assistant results as a .json file.
