---
ms.custom:
  - build-2023
---
Data virtualization in SQL Server 2022 integrates data at query time, without replicating or moving the original data. It's the ability to access the data where it lives.

The following figure shows the full extent of data virtualization support in SQL Server 2022.

:::image type="content" source="../media/sql-server-2022-data-virtualization.png" alt-text="Diagram of the data virtualization options in SQL Server 2022.":::

In this training module, we'll go over the data virtualization options in SQL Server 2022, including:

- PolyBase
- REST API connectors such as Azure Data Lake Storage, Azure Blob storage, and S3 compatible object storage that allow for new access with data virtualization
- Transact-SQL (T-SQL) used for data virtualization, including OPENROWSET, CREATE EXTERNAL TABLE (CET), and CREATE EXTERNAL TABLE as SELECT (CETAS)

## Principles of data virtualization

Data virtualization relies on three principles:

- **Data abstraction:** Hides the complexities of accessing data from the underlying data system, their formats and structures.

- **Zero replication:** Unlike traditional ETL, data virtualization doesn't need to collect the data into a separate repository to transform it to the destination format. It handles transformation and aggregation on-the-fly.

- **Real-time data:** Since data virtualization connects to the data source on-the-fly, it always delivers the latest available data.

## Benefits of data virtualization

Major benefits of data virtualization:

- **No data movement:** Access the data where it is.

- **Transact-SQL (T-SQL) language:** Ability to leverage all the benefits of the T-SQL language, its commands, enhancements, and familiarity.

- **One source for all your data:** Users and applications can use SQL Server 2022 as its single data source for all of the required data, as a data hub, hiding the complexity from the application. While database administrators and data engineers have a single environment to maintain.

- **Security:** Leverage SQL Server security features for granular permissions, credential management, and control.

- **Cost:** PolyBase is available in all SQL Server 2022 editions.

## Data virtualization use cases

Data virtualization use cases:

- **Data hub:** SQL Server can be used as a centralized hub that connects, protects, and query different data sources and files, hiding all the complexity of the application. There's no need to use an ETL tool to aggregate and to copy or move the data to a staging area.

   :::image type="content" source="../media/sql-server-data-hub.png" alt-text="Image of SQL Server as a data hub for data virtualization.":::

- **In-database analytics:** Use and combine all SQL Server capabilities and familiarity when using data virtualization.

- Off-load or export data to other data sources.

## Learning objectives

By the end of this module, you'll be able to:

- Understand the benefits and principles of data virtualization
- Know what PolyBase is, and how you can leverage its capabilities
- Be familiar with object storage solutions
- Install and configure PolyBase on SQL Server 2022
- Access external data on SQL Server 2022 using PolyBase

## Prerequisites

- Basic working knowledge of SQL Server
- Fundamental knowledge of the T-SQL language and be able to execute queries in SQL Server Management Studio on a SQL Server 2022 instance
