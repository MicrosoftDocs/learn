You can use Transact-SQL to create temporary tables. Temporary tables come in two types:

- **Local temporary tables**
- **Global temporary tables**

## Create local temporary tables

Use local temporary tables to create tables scoped to your current session. This means that your temporary table is only visible to you, and when the session is over, the table no longer exists. Multiple users can create tables using the same name, and they would have no effect on each other.

To create a local temporary table, you use the same approach as you would when creating a regular table. However, you'd add **#** before the table name to signify that it's a local temporary table:

```sql
CREATE TABLE #Products (
    ProductID INT PRIMARY KEY,
    ProductName varchar,
    ...
);
```

## Create global temporary tables

You can also create global temporary tables. A global temporary table is accessible across all sessions. But this means that a global temporary table must have a unique name, unlike a local temporary table.  Global temporary tables are dropped automatically when the session that created it ends, and all tasks referencing it across all sessions have also ended. You create a global temporary table in the same way you would create a local temporary table, except you'd use **##** instead of the single **#** specify it as a global temporary table:

```sql
CREATE TABLE ##Products (
    ProductID INT PRIMARY KEY,
    ProductName varchar,
    ...
);
```

## Insert and read data from a temporary table 

You can insert data into your temporary tables (both local and global) using the same approach as regular tables, using INSERT. You just need to make sure to append the **#** or **##** to the table name. For example:

```sql
INSERT #Products (ProductID, ProductName, ProductDescription)  
    VALUES (1, 'The temporary time leap', 'A novel about temporary time leaping.');  
```

You can also retrieve results from a temporary table using SELECT. For example, to retrieve all rows and columns for your **#Products** temporary table, and order the results by product name, you'd run:

```sql
SELECT *  
FROM #Products  
ORDER BY ProductName;
```
