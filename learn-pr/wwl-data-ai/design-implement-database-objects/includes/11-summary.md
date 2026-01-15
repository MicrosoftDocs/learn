Database objects form the foundation of every SQL solution. Throughout this module, you explored how to design and implement tables, indexes, constraints, and specialized structures across SQL Server, Azure SQL Database, Azure SQL Managed Instance, and SQL database in Microsoft Fabric.

In this module, you learned to select appropriate data types for storage efficiency and query performance, understanding the trade-offs between precision and space. You explored rowstore indexes for transactional workloads—including clustered indexes that define physical row order and nonclustered indexes for alternate access paths—and columnstore indexes for analytical queries, learning how rowgroups, column segments, and the tuple-mover optimize compression and query performance.

You implemented specialized table types including temporal tables for automatic change tracking, ledger tables for tamper-evident compliance scenarios, graph tables for relationship modeling, and memory-optimized tables for high-throughput OLTP workloads. You learned to enforce data integrity through constraints—`PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `UNIQUE`, and `DEFAULT`—and to generate unique values using both `IDENTITY` columns and `SEQUENCE` objects for cross-table numbering.

You explored JSON support for semi-structured data, including the native `json` data type in SQL Server 2025, and indexing strategies using computed columns. Finally, you designed partitioning strategies for large tables, understanding partition functions with RANGE RIGHT for datetime columns, partition schemes for filegroup placement, and the requirements for clustered indexes on partitioned tables.

## Additional resources

To deepen your understanding of database object design and implementation, explore these resources:

- [Tables](/sql/relational-databases/tables/tables?azure-portal=true)
- [Indexes](/sql/relational-databases/indexes/indexes?azure-portal=true)
- [Columnstore indexes overview](/sql/relational-databases/indexes/columnstore-indexes-overview?azure-portal=true)
- [Temporal tables](/sql/relational-databases/tables/temporal-tables?azure-portal=true)
- [Ledger overview](/sql/relational-databases/security/ledger/ledger-overview?azure-portal=true)
- [Graph processing with SQL Server](/sql/relational-databases/graphs/sql-graph-overview?azure-portal=true)
- [In-Memory OLTP overview](/sql/relational-databases/in-memory-oltp/overview-and-usage-scenarios?azure-portal=true)
- [JSON data in SQL Server](/sql/relational-databases/json/json-data-sql-server?azure-portal=true)
- [Partitioned tables and indexes](/sql/relational-databases/partitions/partitioned-tables-and-indexes?azure-portal=true)
- [SQL database in Microsoft Fabric](/fabric/database/sql/overview?azure-portal=true)

## Next steps

With strong database object design skills, you're ready to:

- Explore advanced T-SQL programming with views, functions, and stored procedures
- Implement security and data protection measures
- Optimize query performance using execution plans
- Integrate AI capabilities into your database solutions
- Manage CI/CD and deployment pipelines for database changes

Continue building your expertise in SQL solutions to create robust, scalable, and maintainable database systems.
