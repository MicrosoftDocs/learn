The SparkSQL library, which provides the dataframe structure also enables you to use SQL as a way of working with data. With this approach, You can query and transform data in dataframes by using SQL queries, and persist the results as tables.

> [!NOTE]
> Tables are metadata abstractions over files. The data is not stored in a relational table, but the table provides a relational layer over files in the data lake.

## Define tables and views

Table definitions in Spark are stored in the *metastore*, a metadata layer that encapsulates relational abstractions over files. *External* tables are relational tables in the metastore that reference files in a data lake location that you specify. You can access this data by querying the table or by reading the files directly from the data lake.

>[!NOTE]
> External tables are "loosely bound" to the underlying files and deleting the table *does not* delete the files. This allows you to use Spark to do the heavy lifting of transformation then persist the data in the lake. After this is done you can drop the table and downstream processes can access these optimized structures. You can also define *managed* tables, for which the underlying data files are stored in an internally managed storage location associated with the metastore. Managed tables are "tightly-bound" to the files, and dropping a managed table deletes the associated files.

The following code example saves a dataframe (loaded from CSV files) as an external table name **sales_orders**. The files are stored in the **/sales_orders_table** folder in the data lake.

```python
order_details.write.saveAsTable('sales_orders', format='parquet', mode='overwrite', path='/sales_orders_table')
```

## Use SQL to query and transform the data

After defining a table, you can use of SQL to query and transform its data. The following code creates two new derived columns named **Year** and **Month** and then creates a new table *transformed_orders* with the new derived columns added.

```python
# Create derived columns
sql_transform = spark.sql("SELECT *, YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month FROM sales_orders")

# Save the results
sql_transform.write.partitionBy("Year","Month").saveAsTable('transformed_orders', format='parquet', mode='overwrite', path='/transformed_orders_table')
```

The data files for the new table are stored in a hierarchy of folders with the format of **Year=\*NNNN\* / Month=\*N\***, with each folder containing a parquet file for the corresponding orders by year and month.

## Query the metastore

Because this new table was created in the metastore, you can use SQL to query it directly with the *%%sql* magic key in the first line to indicate that the SQL syntax will be used as shown in the following script:

```sql
%%sql

SELECT * FROM transformed_orders
WHERE Year = 2021
    AND Month = 1
```

## Drop tables

When working with external tables, you can use the `DROP` command to delete the table definitions from the metastore without affecting the files in the data lake. This approach enables you to clean up the metastore after using SQL to transform the data, while making the transformed data files available to downstream data analysis and ingestion processes.

```sql
%%sql

DROP TABLE transformed_orders;
DROP TABLE sales_orders;
```
