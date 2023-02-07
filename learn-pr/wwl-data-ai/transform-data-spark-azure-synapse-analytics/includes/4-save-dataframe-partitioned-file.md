

The SparkSQL library, which provides the DataFrame structure also allows you the ability to use SQL as a way of working with data. With this approach, You can query and transform data in DataFrames by using SQL queries, and persist the results as tables. 

> [!NOTE] 
> the persisted tables are metadata abstractions over physical files.

### Define the tables and views

The metastore enables you to write SQL queries as an internal view that return a DataFrame. You can then write this view as an external table. External tables are relational tables in the metastore that reference files in a data lake location that you specify. You can access this data by querying the table or by reading the files directly from the data lake.

>[!NOTE]
external tables are 'loosely bound' to the underlying files and deleting the table *does not* delete the files. This allows you to use Spark to do the heavy lifting of transformation then persist the data in the lake. Once this is done you can drop the table and downstream processes can access these optimized structures.

The following code to saves the original sales orders data (loaded from CSV files) as a table within sales_orders metastore while the files are physically stored in the data lake **/sales_orders_table** as a folder with individual .parquet files split across the distributions located within the folder, this is done automatically and increases the performance for data analytic workloads.

```python

order_details.write.saveAsTable('sales_orders', format='parquet', mode='overwrite', path='/sales_orders_table')

```

Technically, *sales_orders* is an external table because the path parameter, which is */sales_orders_table* is used to specify where the data files for the table are stored. 

### Use SQL to query and transform the data

The use of SQL can now be used to transform the table. The following code creates two new derived columns named **Year** and **Month** and then creates a new table *transformed_orders* with the new derived columns added.

```python

sql_transform = spark.sql("SELECT *, YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month FROM sales_orders")
display(sql_transform.limit(5))
sql_transform.write.partitionBy("Year","Month").saveAsTable('transformed_orders', format='parquet', mode='overwrite', path='/transformed_orders_table')
     
```

When looking at these files in the directory folder */transformed_orders_table* you'll note that  the same data transformation as before has occurred by creating a hierarchy in the folders with the format of **Year=\*NNNN\* / Month=\*N\***, with each folder containing a .parquet file for the corresponding orders by year and month.

### Query the metastore

Since this new table was created in the metastore and is loosely connected to the files, we can use SQL to query it directly with the *%%sql* magic key in the first line to indicate that the SQL syntax will be used as shown in the following script:

```python

%%sql

SELECT * FROM transformed_orders
WHERE Year = 2021
    AND Month = 1

```

Again, these structures are *external* tables and we can **drop** them from the metastore without the command deleting the files from our data lake making it available to downstream data analysis and ingestion processes. Again, we accomplish this using the magic key.

```python

%%sql

DROP TABLE transformed_orders;
DROP TABLE sales_orders;

```

In the exercise module section, you can perform all of these steps in your own subscription.