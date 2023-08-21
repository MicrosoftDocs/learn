 
Now that we've connected to data, we need to save it into the lakehouse. You can either save as a file or load as a Delta table.

## Write to a file

Lakehouses support structured, semi-structured, and unstructured files. Load as a parquet file or Delta table to take advantage of the Spark engine.

```python
# Write DataFrame to Parquet file format
parquet_output_path = "dbfs:/FileStore/your_folder/your_file_name"
df.write.mode("overwrite").parquet(parquet_output_path)
print(f"DataFrame has been written to Parquet file: {parquet_output_path}")

# Write DataFrame to Delta table
delta_table_name = "your_delta_table_name"
df.write.format("delta").mode("overwrite").saveAsTable(delta_table_name)
print(f"DataFrame has been written to Delta table: {delta_table_name}")
```

## Write to a Delta table

Delta tables are one of the key features of Fabric lakehouses. Easily ingest and load your external data into a Delta table via notebooks.

```python
# Use format and save to load as a Delta table
table_name = "nyctaxi_raw"
filtered_df.write.mode("overwrite").format("delta").save(f"Tables/{table_name}")

# Confirm load as Delta table
print(f"Spark data frame saved to Delta table: {table_name}")
```

## Optimize Delta table writes

Fabric notebooks easily scale for large data, therefore read and write optimization is key. Consider these optimization functions for even more performant data ingestion.

**V-Order** enables faster and more efficient reads by various compute engines, such as Power BI, SQL, and Spark.V-order applies special sorting, distribution, encoding, and compression on parquet files at write-time.

**Optimize write** improves the performance and reliability by reducing the number of files written and increasing their size. It's useful for scenarios where the Delta tables have suboptimal or nonstandard file sizes, or where the extra write latency is tolerable.

```python
# Enable V-Order 
spark.conf.set("spark.sql.parquet.vorder.enabled", "true")

# Enable automatic Delta optimized write
spark.conf.set("spark.microsoft.delta.optimizeWrite.enabled", "true") 
```

> [!TIP]
> Learn more about [Delta Lake table optimization and V-Order](fabric/data-engineering/delta-optimization-and-v-order?tabs=sparksql).
