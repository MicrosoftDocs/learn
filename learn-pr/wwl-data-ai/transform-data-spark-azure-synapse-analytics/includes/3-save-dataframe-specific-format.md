

Partitioning is an optimization technique that enables spark (and other engines) to help maximize performance across the worker nodes. More gains can be found with the use of filtering in the user queries by eliminating unnecessary disk IO.

![Diagram representing partitioned file folder structure.](../media/3-partition-data-files.png)

### Partition the output file

In the code cell below you'll create two derived fields in your DataFrame, which include **Year** and **Month**. The DataFrame is then saved to a parquet file, which is partitioned by year and month.

```python

from pyspark.sql.functions import year, month, col

dated_df = transformed_df.withColumn("Year", year(col("OrderDate"))).withColumn("Month", month(col("OrderDate")))
display(dated_df.limit(5))
dated_df.write.partitionBy("Year","Month").mode("overwrite").parquet("/partitioned_data")
print ("Transformed data saved!")

```

>[!Note] The folder names generated when partitioning a DataFrame include the partitioning column name and value in a “column=value” format.

### Filter the parquet files

When reading data from parquet files into a DataFrame, you have the ability to pull data from any folder within the hierarchical folders. This filtering process is done with the use of explicit values and wildcards against the partitioned fields.

In the example below, the following code will pull the sales orders, which were placed in 2020 for all months.

```python

orders_2020 = spark.read.parquet('/partitioned_data/Year=2020/Month=*')
display(orders_2020.limit(5))

```

> [!NOTE]
> the partitioning columns specified in the file path are omitted in the resulting DataFrame.
