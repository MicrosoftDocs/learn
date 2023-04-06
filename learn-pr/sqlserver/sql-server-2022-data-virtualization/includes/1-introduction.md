Data virtualization in SQL Server 2022 integrates data at query time, without replicating or moving the original data. It is the ability to access the data where it lives.

The following figure shows the full extent of data virtualization support in SQL Server 2022.

:::image type="content" source="../media/sql-server-2022-data-virtualization.png" alt-text="Diagram of the data virtualization options in SQL Server 2022.":::

In this training module, we'll go over the data virtualization options offered in SQL Server 2022, including topics about:

- PolyBase
- REST API connectors such as Azure Data Lake Storage, Azure Blob storage, and S3 compatible object storage that allow for new access with data virtualization
- T-SQL for data virtualization

## Principles of data virtualization

Data virtualization relies on three principles:

- **Data abstraction:** hides the complexities of accessing data from the underlying data system, their formats and structures.

- **Zero replication:** Unlike traditional ETL, data virtualization does not need to “collect” the data into a separate repository to transform it to the destination format. It handles transformation and aggregation on-the-fly.

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

- **Data hub:** SQL Server can be used as a centralized hub that connects, protects, and query different data sources and files, hiding all the complexity of the application. There's no need to use an ETL tool to aggregate and to copy or move the data to a stagging area.

  :::image type="content" source="../media/sql-server-data-hub.png" alt-text="Image of SQL Server as a data hub for data virtualization.":::

- **In-database analytics:** Use and combine all SQL Server capabilities and familiarity when using data virtualization.

- Off-load or export data to other data sources.

## Learning objectives

By the end of this module, you'll be able to:

- Understand the benefits and principles of data virtualization
- The evolution of PolyBase starting with SQL Server 2016 through SQL Server 2022
- Enable and use the PolyBase feature

## Prerequisites

- Basic working knowledge of SQL Server
- Fundamental knowledge of the T-SQL language and be able to execute queries in SQL Server Management Studio on a SQL Server 2022 instance

## What is the main goal?
By the end of this session, you'll be able to (TODO)

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->