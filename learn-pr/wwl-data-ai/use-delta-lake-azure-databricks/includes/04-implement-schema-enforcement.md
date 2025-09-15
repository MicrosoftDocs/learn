Schema enforcement in Delta Lake, sometimes called "schema on write," ensures that data being written to a Delta table matches the table’s defined schema. This prevents corrupt or inconsistent records from being introduced into the dataset. For example, if a column is defined as INT and an incoming DataFrame tries to write a STRING into that column, the operation fails. By enforcing strict schema rules, Delta Lake guarantees that all data adheres to the expected format, which helps maintain data quality and consistency across pipelines.

Consider the following SQL statements. The first example is expected to fail, because the amount is a string in the second row. The second example is expected to succeed, because of the explicit cast to a double data type.

```sql
-- Create a Delta table with an enforced schema
CREATE TABLE IF NOT EXISTS main.default.payments (
  id INT,
  amount DOUBLE
) USING DELTA;

-- ❌ Expected to FAIL: 'amount' is a string in the second row
INSERT INTO main.default.payments VALUES
(1, 12.50), (2, 'oops');  -- type mismatch for amount

-- ✅ Expected to SUCCEED: explicitly cast or provide the correct type
INSERT INTO main.default.payments (id, amount) VALUES
(3, CAST('7.25' AS DOUBLE)),
(4, 18.00);
```

This enforcement is important in big data environments where data often comes from diverse sources with varying formats. Without schema enforcement, subtle errors—like mismatched types or missing fields—could propagate silently and break downstream processes or analytics. With Delta Lake, schema enforcement acts as a safeguard that catches these problems at write time instead of leaving them to be discovered later.


## Schema evolution

While schema enforcement protects data integrity, sometimes the schema legitimately needs to change over time. Schema evolution in Delta Lake allows you to update a table’s schema in a controlled way, for example by adding new columns or relaxing certain constraints. This can be done automatically with settings like `spark.databricks.delta.schema.autoMerge.enabled = true`, which lets Delta Lake reconcile incoming data with the existing schema by adding missing columns where appropriate. This flexibility enables teams to adapt to changing business requirements without recreating tables or losing historical data.

Consider the following Python example:

```python
from pyspark.sql import Row

# Step 1: Create a Delta table with a simple schema
base_df = spark.createDataFrame([Row(id=1, amount=100.0)], ["id", "amount"])
base_df.write.format("delta").mode("overwrite").saveAsTable("main.default.sales")

# Step 2: New data arrives with an extra column 'currency'
new_df = spark.createDataFrame(
    [Row(id=2, amount=200.0, currency="USD"),
     Row(id=3, amount=50.0,  currency="EUR")]
)

# Step 3: Write with schema evolution enabled
new_df.write \
  .format("delta") \
  .option("mergeSchema", "true") \
  .mode("append") \
  .saveAsTable("main.default.sales")

# Now the 'sales' table has 3 columns: id, amount, currency
spark.sql("DESCRIBE TABLE main.default.sales").show()
spark.sql("SELECT * FROM main.default.sales").show()
```

What happens is that the original table contains only the columns id and amount, while the new DataFrame introduces an additional column called currency. When you write the DataFrame with the option `.option("mergeSchema", "true")`, Delta Lake automatically evolves the table schema to include this new column, allowing the write to succeed. If this option isn't enabled, however, the write operation fails because the schema of the incoming data doesn't match the existing table schema.

In the following SQL example, the `MERGE` statement explicitly includes `WITH SCHEMA EVOLUTION`. Delta Lake automatically updates the table schema to add currency as part of the operation. The merge then updates existing rows, inserts new rows, and deletes rows not present in the source, all while evolving the schema in a single transaction.

```sql
-- Step 1: Create a Delta table without the 'currency' column
CREATE TABLE IF NOT EXISTS main.default.sales_merge_sql (
  id INT,
  amount DOUBLE
) USING DELTA;

-- Step 2: Perform a MERGE that evolves the schema inline
MERGE WITH SCHEMA EVOLUTION INTO main.default.sales_merge_sql AS t
USING (
  SELECT 1 AS id, 110.0 AS amount, 'USD' AS currency
  UNION ALL
  SELECT 2 AS id, 220.0 AS amount, 'EUR' AS currency
) AS s
ON t.id = s.id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *
WHEN NOT MATCHED BY SOURCE THEN DELETE;
```

By following these steps, you can effectively utilize Delta Lake's schema enforcement capabilities within Azure Databricks to maintain data quality and integrity.
