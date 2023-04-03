
Since a columnstore index scans a table by scanning column segments of individual row groups, maximizing the number of rows in each row group enhances query performance. When rowgroups have a high number of rows, data compression improves which means there is less data to read from disk. The number of rows in a rowgroup determines the rowgroup's quality.

For best query performance, the goal is to maximize the number of rows per rowgroup in a columnstore index. A rowgroup can have a maximum of 1,048,576 rows. It's okay to not have the maximum number of rows per rowgroup. Columnstore indexes achieve good performance when rowgroups have at least 100,000 rows.

During a bulk load or columnstore index rebuild, sometimes there isn't enough memory available to compress all the rows designated for each rowgroup. When memory pressure is present, columnstore indexes trim the rowgroup sizes so compression into the columnstore can succeed.

The DMV [sys.dm_pdw_nodes_db_column_store_row_group_physical_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-column-store-row-group-physical-stats-transact-sql?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true) exposes useful information such as number of rows in rowgroups and the reason for trimming, if there was trimming.

There are two columns from `dm_pdw_nodes_db_column_store_row_group_physical_stats` worth looking into in detail. The `state_desc` column provides useful information on the state of a row group:

For additional content on optimizing row group and clustered columnstore indexes review the content [Investigating Row Group Health](/training/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/5-use-indexes-to-improve)

Name         | Description
-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
`INVISIBLE`  | A rowgroup which is being compressed.
`OPEN`       | A deltastore rowgroup that is accepting new rows. It is important to remember that an open rowgroup is still in rowstore format and has not been compressed to columnstore format.
`CLOSED`     | A deltastore rowgroup that contains the maximum number of rows, and is waiting for the tuple mover process to compress it to the columnstore.
`COMPRESSED` | A row group that is compressed with columnstore compression and stored in the columnstore.
`TOMBSTONE`  | A row group that was formerly in the deltastore and is no longer used.

Additionally, the `trim_reason_desc` column describes the reason that triggered the `COMPRESSED` rowgroup to have less than the maximum number of rows:

Name                                     | Description
-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
`UNKNOWN_UPGRADED_FROM_PREVIOUS_VERSION` | Occurred when upgrading from the previous version of SQL Server.
`NO_TRIM`                                | The row group was not trimmed. The row group was compressed with the maximum of 1,048,576 rows. The number of rows could be less if a subset of rows was deleted after delta rowgroup was closed.
`BULKLOAD`                               | The bulk-load batch size limited the number of rows. This is what you should be looking for when optimizing data loading, as it is an indicator of resource starvation during the loading process.
`REORG`                                  | Forced compression as part of REORG command.
`DICTIONARY_SIZE`                        | Dictionary size grew too large to compress all of the rows together.
`MEMORY_LIMITATION`                      | Not enough available memory to compress all the rows together.
`RESIDUAL_ROW_GROUP`                     | Closed as part of last row group with rows < 1 million during index build operation.