The vacuum process is configured using the **autovacuum** server parameters. These allow you to optimize the vacuum process for your workload. In the Azure portal, select your Azure Database for PostgreSQL server, and select **Server Parameters** from the left menu. In the search bar, enter **autovacuum**.

|Parameter name                             |Default    |Description                                                                                                                        |
|---------                                  |---------  |---------                                                                                                                          |
|autovacuum                                 |ON         |Enables or disables the autovacuum server process. Autovacuum should always be enabled.                                            |
|autovacuum_analyze_scale_factor            |0.1        |Specifies a fraction of the table to add to autovacuum_vacuum_threshold when deciding whether to trigger a vacuum operation. For example, 0.2 is 20 percent of the table size.             |
|autovacuum_analyze_threshold               |50         |The number of inserted, updated, or deleted rows needed to trigger analyze for any one table.                                      |
|autovacuum_freeze_max_age                  |200000000  |Maximum age (in transactions) before triggering autovacuum on a table to prevent transaction ID wraparound.                        |
|autovacuum_max_workers                     |3          |The maximum number of autovacuum processes running at any one time, other than the autovacuum launcher.                            |
|autovacuum_multixact_freeze_max_age        |400000000  |Maximum age (in multixact) before triggering autovacuum on a table to prevent multixact wraparound.                                |
|autovacuum_naptime                         |60 secs    |The delay between autovacuum processes on a database. In each round, the daemon examines the database and issues VACUUM and ANALYZE commands as needed for tables in that database.        |
|autovacuum_vacuum_cost_limit               |-1         |The maximum cost for automatic vacuum operations. If -1 is specified, which is the default, the regular vacuum_cost_limit value is used. If there's more than one worker, the value is distributed proportionally among the running autovacuum workers. The sum for each worker will not exceed the value of this variable.    |
|autovacuum_vacuum_insert_threshold         |1000       |The number of inserted rows that will trigger vacuum for any one table.                                                  |
|autovacuum_vacuum_scale_factor             |0.2        |Used in conjunction with autovacuum_vacuum_threshold. The fraction of a table used to decide whether to trigger a vacuum.          |
|autovacuum_vacuum_threshold                |50         |The minimum number of updated, inserted, or deleted rows to trigger a vacuum for a table.                                          |
|autovacuum_vacuum_insert_scale_factor      |0.2        |Specifies a fraction of the table size to add to autovacuum_vacuum_insert_threshold to trigger the vacuum process.                 |
|autovacuum_work_mem                        |-1 KB      |The maximum memory that can be used by each autovacuum process.                                                                    |
|log_autovacuum_min_duration                |-1         |The time in milliseconds above which autovacuum actions will be logged.                                                            |

The vacuum process shouldn't be run too frequently, or too infrequently. The optimal frequency will depend on the workload. Test each of the autovacuum parameters to find what works best for your workload. The cost of the vacuuming process includes:

- Data pages are locked when vacuum runs.
- The vacuum process consumes compute time and memory.

## Optimize vacuum at the table level

In Azure Database for PostgreSQL, autovacuum parameters can be set at the table level. When some tables are updated more than others, this can improve performance. An example of setting autovacuum at the table level:

```sql
ALTER TABLE mytable SET (autovacuum_vacuum_threshold = 1000);
​ALTER TABLE mytable SET (autovacuum_vacuum_scale_factor = 0.1);
ALTER TABLE mytable SET (autovacuum_vacuum_cost_limit = 1000);
ALTER TABLE mytable SET (autovacuum_vacuum_cost_delay = 10);
```

At the table level, autovacuum is a synchronous process. The greater the percentage of dead tuples that a table has, the greater the "cost" is incurred by the autovacuum process.

For tables with a high rate of updates, consider splitting the table into multiple tables. This helps to parallelize autovacuum and reduce the "cost" for any one table. You also can increase the number of parallel autovacuum workers.
