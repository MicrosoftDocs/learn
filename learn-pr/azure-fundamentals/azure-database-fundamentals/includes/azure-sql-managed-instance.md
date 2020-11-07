:::row:::
  :::column span="3":::
Azure SQL Managed Instance is a scalable cloud data service that provides the broadest SQL Server database engine compatibility with all the benefits of a fully managed platform as a service. Depending on your scenario, Azure SQL Managed Instance might offer more options for your database needs.
  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-service-managed-sql-instance.png" border="false":::
  :::column-end:::
:::row-end:::

## Features

Like Azure SQL Database, Azure SQL Managed Instance is a platform as a service (PaaS) database engine. However, even though Azure SQL Database and Azure SQL Managed Instance offer many of the same features, Azure SQL Managed Instance provides several options that might not available to Azure SQL Database. For a detailed list of the differences, see [Features comparison: Azure SQL Database and Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/database/features-comparison/?azure-portal=true).

## Migration

Tailwind Traders currently uses several on-premises servers running SQL Server, and they would like to migrate their existing databases to a SQL database running in the cloud. However, several of their databases use Cyrillic characters for collation. In this scenario, Tailwind Traders should migrate their databases to an Azure SQL Managed Instance, since Azure SQL Database only uses the default `SQL_Latin1_General_CP1_CI_AS` server collation.
