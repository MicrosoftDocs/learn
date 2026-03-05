SQL Server offers several index types to support different workloads. At a high level, an index can be thought of as an on-disk structure associated with a table or view, enabling SQL Server to more easily find the row or rows associated with the index key (which consists of one or more columns in the table or view), compared to scanning the entire table.

## Clustered indexes

A common DBA job interview question is to ask the candidate the difference between a clustered and nonclustered index, as indexes are fundamental data storage technologies in SQL Server. A clustered index is the underlying table, stored in sorted order based on the key value. There can only be one clustered index on a given table because the rows can be stored in only one order. A table without a clustered index is called a heap, and heaps are typically used only as staging tables. An important performance design principle is to keep your clustered index key as narrow as possible. When considering one or more key columns for your clustered index, you should choose columns that are unique or contain many distinct values. Another property of a good clustered index key is for records that are accessed sequentially and are used frequently to sort the data retrieved from the table. Having the clustered index on the column used for sorting can prevent the cost of sorting every time that query executes because the data will already be stored in the desired order.

> [!NOTE]
> When we say that the table is 'stored' in a particular order, we're referring to the logical order, not the physical, on-disk order. Indexes have pointers between pages, and the pointers help create the logical order. When scanning an index *in order*, SQL Server follows the pointers from page to page. Immediately after creating an index, it's most likely also stored in physical order on the disk, but after you start making modifications to the data and new pages need to be added to the index, the pointers will still give us the correct logical order, but the new pages will most likely not be in physical disk order.

## Nonclustered indexes

Nonclustered indexes are separate structures from the data rows. A nonclustered index contains the key values defined for the index and a pointer to the data row that contains the key value. You can add extra nonkey columns to the leaf level of the nonclustered index using the included columns feature in SQL Server, allowing you to cover more columns. You can create multiple nonclustered indexes on a table.

The following example shows when you need to add an index or add columns to an existing nonclustered index.

[![Query and Query Execution Plan with a Key Lookup operator](../media/module-55-optimize-queries-final-12.png)](../media/module-55-optimize-queries-final-12.png#lightbox)

The query plan indicates that for each row retrieved using the index seek, more data need to be retrieved from the clustered index (the table itself). There's a nonclustered index, but it only includes the product column. If you add the other columns in the query to a nonclustered index, you can see the execution plan change to eliminate the key lookup.

[![Changing the Index and the Query Plan with No Key Lookup](../media/module-55-optimize-queries-final-13.png)](../media/module-55-optimize-queries-final-13.png#lightbox)

The index created above is an example of a covering index. In addition to the key column, you're including extra columns to cover the query and eliminate the need to access the table itself.

Both nonclustered and clustered indexes can be defined as unique, meaning there can be no duplication of the key values. Unique indexes are automatically created when you create a PRIMARY KEY or UNIQUE constraint on a table.

This section focuses on b-tree indexes in SQL Server, also known as row store indexes. The following image represents the general structure of a b-tree:

:::image type="content" source="../media/module-55-optimize-queries-final-14.png" alt-text="The B-tree architecture of an index in SQL Server and Azure SQL":::

Each page in an index b-tree is called an index node, and the top node of the b-tree is called the root node. The bottom nodes in an index are called leaf nodes, and the collection of leaf nodes is the leaf level.

Index design is a blend of art and science. A narrow index with few columns in its key requires less time to update and has lower maintenance overhead; however, it may not be useful for as many queries as a wider index that includes more columns. You may need to experiment with several indexing approaches based on the columns selected by your application's queries. The query optimizer will generally choose what it considers to be the best existing index for a query; however, that doesn't mean there isn't a better index that could be built.

Properly indexing a database can be a complex task. When planning your indexes for a table, you should keep a few basic principles in mind:

* Understand the system's workloads. Tables primarily used for insert operations benefit less from extra indexes compared to tables used for data warehouse operations with high read activity.
* Optimize indexes around the most frequently run queries.
* Choose appropriate data types for columns in your queries. Indexes work best with integer data types, unique, or non-null columns.
* Create nonclustered indexes on columns frequently used in predicates and join clauses, keeping them as narrow as possible to minimize overhead.
* Consider data size/volume. Table scans on small tables are relatively cheap, while scans on large tables are costly.

Another option provided by SQL Server is the creation of filtered indexes. Filtered indexes are ideal for columns in large tables where a significant percentage of rows share the same value in that column. The following example is an employee table that stores records of all employees, including those who have left or retired.

```sql
CREATE TABLE [HumanResources].[Employee](
     [BusinessEntityID] [int] NOT NULL,
     [NationalIDNumber] [nvarchar](15) NOT NULL,
     [LoginID] [nvarchar](256) NOT NULL,
     [OrganizationNode] [hierarchyid] NULL,
     [OrganizationLevel] AS ([OrganizationNode].[GetLevel]()),
     [JobTitle] [nvarchar](50) NOT NULL,
     [BirthDate] [date] NOT NULL,
     [MaritalStatus] [nchar](1) NOT NULL,
     [Gender] [nchar](1) NOT NULL,
     [HireDate] [date] NOT NULL,
     [SalariedFlag] [bit] NOT NULL,
     [VacationHours] [smallint] NOT NULL,
     [SickLeaveHours] [smallint] NOT NULL,
     [CurrentFlag] [bit] NOT NULL,
     [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL,
     [ModifiedDate] [datetime] NOT NULL)
```

In this table, there's a column called `CurrentFlag`, which indicates if an employee is currently employed. This example uses the `bit` datatype, representing two values: one for currently employed and zero for not currently employed. Creating a filtered index with `WHERE CurrentFlag = 1` on the `CurrentFlag` column allows for efficient queries of current employees.

Also, you can create indexes on views, which can provide significant performance gains when views contain query elements like aggregations and/or table joins.

## Columnstore indexes

Columnstore indexes offer enhanced performance for queries involving large aggregation workloads. Initially targeted at data warehouses, columnstore indexes have since been adopted for various other workloads to address query performance issues on large tables. Like b-tree indexes, a clustered columnstore index represents the table itself stored in a special way, while nonclustered columnstore indexes are stored independently of the table. Clustered columnstore indexes inherently include all columns in a table but aren't sorted.

Nonclustered columnstore indexes are typically used in two scenarios. The first is when a column's data type isn't supported in a columnstore index (for example, XML, CLR, sql_variant, ntext, text, and image). Since a clustered columnstore index always contains all columns of the table, a nonclustered index is the only option. The second scenario involves filtered indexes, used in hybrid transactional analytic processing (HTAP) architectures, where data is loaded into the table while reports are simultaneously run. Filtering the index (typically on a date field) allows for efficient insert and reporting performance.

Columnstore indexes store each column independently, offering two benefits: reduced IO by scanning only necessary columns and greater compression due to similar data within columns. They perform best on analytic queries scanning large data sets, such as fact tables in data warehouses. You can augment a columnstore index with a b-tree nonclustered index for singleton value lookups.

These indexes also benefit from batch execution mode, processing sets of rows (typically around 900) at a time instead of one by one. This approach reduces CPU instructions significantly.

```sql
SELECT SUM(Sales) FROM SalesAmount;
```

Batch mode can provide performance increase over traditional row processing. While batch mode for rowstore doesn't have the same level of read performance as a columnstore index, analytical queries may see up to a 5x performance improvement.

Another advantage of columnstore indexes for data warehouse workloads is the optimized load path for bulk insert operations of 102,400 rows or more. While 102,400 is the minimum value to load directly into the columnstore, each collection of rows, called a rowgroup, can be up to approximately 1,024,000 rows. Having fewer, but fuller, rowgroups makes your `SELECT` queries more efficient because fewer rowgroups need to be scanned to retrieve the requested records. These loads occur in memory and are directly loaded into the index. For smaller volumes, data is written to a b-tree structure called a delta store and asynchronously loaded into the index.

:::image type="content" source="../media/module-55-optimize-queries-final-15.png" alt-text="Columnstore Index Load Example":::

In this example, the same data is being loaded into two tables, *FactResellerSales_CCI_Demo* and *FactResellerSales_Page_Demo*. The *FactResellerSales_CCI_Demo* has a clustered columnstore index, and the *FactResellerSales_Page_Demo* has a clustered b-tree index with two columns and is page compressed. As you can see each table is loading 1,024,000 rows from the *FactResellerSalesXL_CCI* table. When `SET STATISTICS TIME` is `ON`, SQL Server keeps track of the elapsed time of the query execution. Loading the data into the columnstore table took roughly 8 seconds, where loading into the page compressed table took nearly 20 seconds. In this example, all the rows going into the columnstore index are loaded into a single rowgroup.

If you load less than 102,400 rows of data into a columnstore index in a single operation, it's loaded in a b-tree structure known as a delta store. The database engine moves this data into the columnstore index using an asynchronous process called the tuple mover. Having open delta stores can affect the performance of your queries, because reading those records is less efficient than reading from the columnstore. You can also reorganize the index with the `COMPRESS_ALL_ROW_GROUPS` option in order to force the delta stores to be added and compressed into the columnstore indexes.
