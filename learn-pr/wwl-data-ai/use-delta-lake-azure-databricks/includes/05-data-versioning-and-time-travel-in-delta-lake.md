Data versioning and time travel are standout features of Delta Lake that allow you to access and revert to earlier versions of your data. This capability is useful for auditing changes, reproducing experiments, rolling back errors, and maintaining historical accuracy. 

This lesson shows how to implement and use data versioning and time travel with Delta Lake in Azure Databricks.

### Understand Delta Lake time travel

Delta Lake tracks versions of data in a Delta table using a transaction log that records details about every change made to the table. Each transaction has a unique version number, starting from zero. These versions allow you to access the state of the data at a specific point in time.

### Create the Delta table

```sql
-- Create the Delta table
CREATE TABLE person_data (
    id INT,
    name STRING,
    age INT
);
```

### Insert some data

Insert some initial data into the table.

```sql
-- Insert initial data
INSERT INTO person_data (id, name, age)
VALUES
(1, 'Alice', 30),
(2, 'Bob', 25);

```

### Perform updates

Perform some updates on the table. Each update creates a new version of the Delta table.

```sql
-- Update age of Bob
UPDATE person_data
SET age = 26
WHERE name = 'Bob';

-- Insert a new record
INSERT INTO person_data (id, name, age)
VALUES
(3, 'Charlie', 28);
```

### Query table history

You can view the history of the Delta table to see all the changes made to it. The DESCRIBE HISTORY command displays a list of all the versions of the table, along with details such as the operation performed, timestamp, and user who performed the operation. 

```sql
-- View table history
DESCRIBE HISTORY person_data;
```

### Time travel queries

You can query previous versions of the table using the VERSION AS OF or TIMESTAMP AS OF syntax.

```sql
-- Query data as of version 0
SELECT * FROM person_data VERSION AS OF 0;

-- Query data as of a specific timestamp
SELECT * FROM person_data TIMESTAMP AS OF '2024-07-22T10:00:00Z';

```

### Revert to a previous version

If you need to revert the table to a previous state, you can use the RESTORE command.

```sql
-- Restore the table to version 0
RESTORE TABLE person_data TO VERSION AS OF 0;

-- Restore the table to a specific timestamp
RESTORE TABLE person_data TO TIMESTAMP AS OF '2024-07-22T10:00:00Z';
```
> [!TIP]
> **Immutability:** Even though you can revert to previous states, treat data as immutable to avoid complex transaction histories and ensure consistent data lineage.
>
> **Retention Policy:** Manage the retention period of old versions depending on storage capacity and compliance needs using the VACUUM command.