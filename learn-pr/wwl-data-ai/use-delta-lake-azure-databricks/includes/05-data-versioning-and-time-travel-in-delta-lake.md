Data versioning and time travel are standout features of Delta Lake that allow you to access and revert to earlier versions of your data. This capability is useful for auditing changes, reproducing experiments, rolling back errors, and maintaining historical accuracy. 

This lesson shows how to implement and use data versioning and time travel with Delta Lake in Azure Databricks.

## Understand Delta Lake time travel

Delta Lake tracks versions of data in a Delta table using a transaction log that records details about every change made to the table. Each transaction has a unique version number, starting from zero. These versions allow you to access the state of the data at a specific point in time.

In the following SQL example, we create a delta table and insert 2 records. We then perform some updates on the table. Each update creates a new version of the Delta table.

```sql
-- Create the Delta table
CREATE TABLE person_data (
    id INT,
    name STRING,
    age INT
);

-- Insert initial data
INSERT INTO person_data (id, name, age)
VALUES (1, 'Alice', 30), (2, 'Bob', 25);

-- Update age of Bob
UPDATE person_data
SET age = 26
WHERE name = 'Bob';

-- Insert a new record
INSERT INTO person_data (id, name, age)
VALUES (3, 'Charlie', 28);
```

These versions are immutable, meaning the state of the table at any point in time can be revisited using features like **time travel**. Under the hood, the **transaction log** functions as a ledger, recording all changes such as newly added files, removed files, and metadata or schema updates. As a result, Delta Lake allows you to reliably reproduce the table exactly as it existed at any version, audit who made specific changes and when, and roll back or rerun computations in a fully deterministic way.

The DESCRIBE HISTORY command displays a list of all the versions of the table, along with details such as the operation performed, timestamp, and user who performed the operation. 

```sql
-- View table history
DESCRIBE HISTORY person_data;
```

Here’s a simplified example output for the sequence of operations:

| version | timestamp           | userName                   | operation    | operationParameters        | operationMetrics                                               |
|---------|---------------------|----------------------------|--------------|----------------------------|----------------------------------------------------------------|
| 3       | 2025-09-11 12:40:00 | alice@adventureworks.com   | WRITE        | mode = Append              | numFiles = 1, numOutputRows = 1                                |
| 2       | 2025-09-11 12:35:00 | alice@adventureworks.com   | UPDATE       | predicate = (name = 'Bob') | numRemovedFiles = 1, numAddedFiles = 1, numUpdatedRows = 1     |
| 1       | 2025-09-11 12:30:00 | alice@adventureworks.com   | WRITE        | mode = Append              | numFiles = 1, numOutputRows = 2                                |
| 0       | 2025-09-11 12:25:00 | alice@adventureworks.com   | CREATE TABLE |                            |                                                                |


- **Version 0** → table created (schema only).
- **Version 1** → initial insert (Alice + Bob).
- **Version 2** → update Bob’s age (remove + add file).
- **Version 3** → insert Charlie.

## Time travel queries

In Delta Lake, the `VERSION AS OF` and `TIMESTAMP AS OF` clauses let you query a table as it existed at a specific point in time. When you query using `VERSION AS OF`, you explicitly select a table state by its commit number, while `TIMESTAMP AS OF` looks up the most recent commit that was created at or before the given time. Either way, what you are really doing is telling Delta to materialize a particular historical snapshot of the table.

```sql
-- Query data as of version 0
SELECT * FROM person_data VERSION AS OF 0;

-- Query data as of a specific timestamp
SELECT * FROM person_data TIMESTAMP AS OF '2025-09-10T10:00:00Z';
```

This mechanism ensures strongly consistent reads: when you query a historical version, every part of the query sees exactly that snapshot and nothing else, even if newer commits have been written since then. This is particularly useful when you want to compare data across time, rerun a report as it was originally generated, or audit how a table has evolved.

Time travel is also bounded by retention. Older data files and tombstones are only available until they're cleaned up by the `VACUUM` operation, which means historical queries will fail once those files have been permanently removed. Organizations that rely heavily on audits or reproducibility often configure retention periods carefully so that historical versions remain available as long as needed.

## Revert to a previous version

Because the snapshots are immutable, you can't modify older versions directly; instead, you can restore a past state by copying or recreating the table from an earlier version, or by using a `RESTORE TABLE` command if it's available.

```sql
-- Restore the table to version 0
RESTORE TABLE person_data TO VERSION AS OF 0;

-- Restore the table to a specific timestamp
RESTORE TABLE person_data TO TIMESTAMP AS OF '2025-09-10T10:00:00Z';
```

> [!TIP]
> **Immutability:** Even though you can revert to previous states, treat data as immutable to avoid complex transaction histories and ensure consistent data lineage.
>
> **Retention Policy:** Manage the retention period of old versions depending on storage capacity and compliance needs using the `VACUUM` command.