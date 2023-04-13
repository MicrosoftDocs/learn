
## Rules for minimally logged operations

Unlike fully logged operations, which use the transaction log to keep track of every row change, minimally logged operations keep track of extent allocations and meta-data changes only. Therefore, minimal logging involves logging only the required information to roll back the transaction after a failure or for an explicit request (ROLLBACK TRAN). If the database is damaged or lost when minimal logging is in effect, you cannot recover the database to the point of failure. As much less information is tracked in the transaction log, a minimally logged operation performs better than a similarly sized fully logged operation. Furthermore, because fewer writes go the transaction log, a much smaller amount of log data is generated, and so is more I/O efficient.

Some operations can be minimally logged to reduce their impact on transaction log size. The following operations are capable of being minimally logged:

- CREATE TABLE AS SELECT (CTAS)
- INSERT..SELECT
- CREATE INDEX
- ALTER INDEX REBUILD
- DROP INDEX
- TRUNCATE TABLE
- DROP TABLE
- ALTER TABLE SWITCH PARTITION

## Minimal logging with bulk load
  
CTAS and INSERT...SELECT are both bulk load operations. However, both are influenced by the target table definition and depend on the load scenario. The following table explains when bulk operations are fully or minimally logged:  

| Primary Index | Load Scenario | Logging Mode |
| --- | --- | --- |
| Heap |Any |**Minimal** |
| Clustered Index |Empty target table |**Minimal** |
| Clustered Index |Loaded rows do not overlap with existing pages in target |**Minimal** |
| Clustered Index |Loaded rows overlap with existing pages in target |Full |
| Clustered Columnstore Index |Batch size >= 102,400 per partition aligned distribution |**Minimal** |
| Clustered Columnstore Index |Batch size < 102,400 per partition aligned distribution |Full |

It is worth noting that any writes to update secondary or non-clustered indexes will always be fully logged operations.

> [!IMPORTANT]
> A Synapse Analytics SQL pool has 60 distributions. Therefore, assuming all rows are evenly distributed and landing in a single partition, your batch will need to contain 6,144,000 rows or larger to be minimally logged when writing to a Clustered Columnstore Index. If the table is partitioned and the rows being inserted span partition boundaries, then you will need 6,144,000 rows per partition boundary assuming even data distribution. Each partition in each distribution must independently exceed the 102,400 row threshold for the insert to be minimally logged into the distribution.

Loading data into a non-empty table with a clustered index can often contain a mixture of fully logged and minimally logged rows. A clustered index is a balanced tree (b-tree) of pages. If the page being written to already contains rows from another transaction, then these writes will be fully logged. However, if the page is empty then the write to that page will be minimally logged.