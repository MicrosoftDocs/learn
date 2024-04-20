---
ms.custom:
  - build-2023
---
Data virtualization in SQL Server 2022 is the ability to access data where it lives. Data virtualization integrates data at query time, without replicating or moving the original data.

The following figure shows the full extent of data virtualization support in SQL Server 2022.

:::image type="content" source="../media/sql-server-2022-data-virtualization.png" alt-text="Diagram of the data virtualization options in SQL Server 2022." border="false":::

This training module reviews the data virtualization options in SQL Server 2022, including:

- PolyBase services
- REST API connectors such as Azure Data Lake Storage, Azure Blob Storage, and Amazon S3-compatible object storage that allow for new access with data virtualization
- Transact-SQL (T-SQL) used for data virtualization, including OPENROWSET, CREATE EXTERNAL TABLE (CET), and CREATE EXTERNAL TABLE AS SELECT (CETAS)

## Principles of data virtualization

Data virtualization relies on three principles:

- **Data abstraction:** Data abstraction hides the complexities of data access from the underlying data system, formats, and structures.

- **Zero replication:** Unlike traditional extract-transform-load (ETL), data virtualization doesn't need to collect the data into a separate repository to transform it to the destination format, but handles transformation and aggregation on the fly.

- **Real-time data:** Because data virtualization connects to the data source on the fly, it always uses the latest available data.

## Benefits of data virtualization

Data virtualization has the following major benefits:

- **No data movement:** Accesses data in its current location.

- **T-SQL language:** Uses all the benefits of the T-SQL language, its commands, enhancements, and familiarity.

- **One source for all your data:** Uses SQL Server 2022 as a single data source and data hub for all required data, hiding data complexity from applications. Database administrators and data engineers can maintain a single environment.

- **Security**: Uses SQL Server security features for granular permissions, credential management, and control.

- **Cost flexibility:** Is available in all SQL Server 2022 editions.

## Data virtualization use cases

SQL Server 2022 offers the following major data virtualization use cases:

- **In-database analytics:** Use and combine all SQL Server capabilities and familiarity when using data virtualization.
- **Offload or export data to other data sources.**
- **Data hub:** Use SQL Server as a centralized hub to connect, protect, and query different data sources and files, hiding the complexity from applications. There's no need to use an ETL tool to aggregate, copy, or move the data to a staging area.

  :::image type="content" source="../media/sql-server-data-hub.png" alt-text="Image of SQL Server as a data hub for data virtualization." border="false":::

## Learning objectives

After you complete this module, you:

  - Understand the benefits and principles of data virtualization.
  - Know what PolyBase is and how to use its capabilities.
  - Are familiar with object storage solutions and SQL Server 2022 support for S3-compatible object storage.
  - Know how to install and configure PolyBase on SQL Server 2022.
  - Know how to access and query external data by using PolyBase in SQL Server 2022.

## Prerequisites

- Basic working knowledge of SQL Server 2022
- Fundamental knowledge of T-SQL and SQL query execution
- SQL Server 2022 installed
- SQL Server Management Studio (SSMS) installed
