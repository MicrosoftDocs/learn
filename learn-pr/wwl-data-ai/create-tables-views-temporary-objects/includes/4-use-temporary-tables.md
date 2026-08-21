You can use Transact-SQL to create temporary tables. Temporary tables come in two types:

- **Local temporary tables**
- **Global temporary tables**

## Create local temporary tables

Use local temporary tables to create tables scoped to your current session. This means that your temporary table is only visible to you, and when the session ends, the table is automatically dropped. Multiple users can create tables using the same name, and they would have no effect on each other.

> [!NOTE]
> If you create a local temporary table inside a stored procedure, it's dropped when the procedure returns — not at the end of the session. Tables created this way aren't visible to the calling session after the procedure exits.

To create a local temporary table, you use the same approach as you would when creating a regular table. However, you'd add **#** before the table name to signify that it's a local temporary table:

```sql
CREATE TABLE #Products (
    ProductID INT PRIMARY KEY,
    ProductName varchar(50),
    ...
);
```

## Create global temporary tables

You can also create global temporary tables. In SQL Server, a global temporary table is accessible across all sessions on the instance. In Azure SQL Database, global temporary tables are scoped to the database level — sessions in other databases on the same logical server can't access them. Because a global temporary table is shared, it must have a unique name, unlike a local temporary table. Global temporary tables are dropped automatically when the session that created it ends and all tasks referencing it across all sessions have also ended. You create a global temporary table in the same way you would create a local temporary table, except you'd use **##** instead of the single **#** specify it as a global temporary table:

```sql
CREATE TABLE ##Products (
    ProductID INT PRIMARY KEY,
    ProductName varchar(50),
    ...
);
```

## Insert and read data from a temporary table 

You can insert data into your temporary tables (both local and global) using the same approach as regular tables, using `INSERT`. You just need to make sure to append the **#** or **##** to the table name. For example:

```sql
INSERT #Products (ProductID, ProductName, ProductDescription)  
    VALUES (1, 'The temporary time leap', 'A novel about temporary time leaping.');  
```

You can also retrieve results from a temporary table using `SELECT`. For example, to retrieve all rows and columns for your **#Products** temporary table, and order the results by product name, you'd run:

```sql
SELECT *  
FROM #Products  
ORDER BY ProductName;
```
