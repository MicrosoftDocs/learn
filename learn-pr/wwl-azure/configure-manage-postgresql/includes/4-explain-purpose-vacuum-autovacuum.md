
When a row is updated, each update is made up of an insert and a delete. The modified data is inserted, and the old row is deleted. In PostgreSQL, the original row is retained so that a transaction can roll back if there's a problem. Rather than deleting the original row, it's marked for deletion later, resulting in "dead" rows (or tuples) that are still on disk but no longer required.

The aptly named vacuum process permanently removes these rows, reclaiming space that might otherwise be lost, and updating statistics.

The process of cleaning up the dead rows is called the vacuum process. If these rows were left on disk, the database would take up more disk space that it required, known as database "bloat." The [**VACUUM**](https://www.postgresql.org/docs/14/sql-vacuum.html) process is important for the following reasons:

- To recover disk space occupied by rows marked for deletion.
- To update data statistics for use by the query planner.
- To update the visibility map, which speeds up [index-only scans](https://www.postgresql.org/docs/14/indexes-index-only-scans.html).
- To protect against loss of old data due to transaction ID wraparound.

PostgreSQL uses a process called vacuum to permanently delete rows and reclaim the space. In addition to reclaiming space, it also ensures indexes are effective.

When the vacuum process is triggered automatically, the process is known as **autovacuum**. The frequency with which the process needs to run depends on the amount of update and delete operations. You can also monitor the number of rows marked for deletion.

Running the vacuum process periodically ensures you don't:

- Experience "bloat," including larger than necessary databases and tables.
- Have large, suboptimal Indexes.
- Experience increased I/O.

To monitor the number of "dead" rows in a table, you can run a SELECT query:

```sql
SELECT relname, n_dead_tup, n_live_tup
FROM pg_catalog.pg_stat_all_tables
ORDER BY n_dead_tup DESC;
```

To run the vacuum process manually, type:

```sql
vacuum
```
