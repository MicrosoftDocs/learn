Raw data rarely arrives ready for analysis. Tables might contain duplicate rows from repeated data loads, null values from optional form fields, inconsistent column names from source systems, or columns in the wrong data type for downstream calculations. If you query this data directly, aggregations overcount, joins fail silently, and reports display misleading results.

Shaping and cleaning data addresses these issues early in the pipeline, before they compound into bigger problems. In this unit, you walk through a realistic sequence of transformations on a sales dataset, using both Spark SQL and PySpark. Select your preferred syntax using the tabs. When you choose a tab, all code samples on this page switch to that language.

## Read data from a lakehouse table

The first step in any notebook transformation is reading the data. With a default lakehouse pinned, you can reference tables by name without specifying a full path. This makes your code portable across environments.

# [Spark SQL](#tab/sparksql)

```sql
SELECT * FROM raw_sales
```

# [PySpark](#tab/pyspark)

```python
df = spark.table("raw_sales")
df.display()
```

---

Imagine the results show a sales table with 11 rows, including some that look identical and a few cells showing `null` where a region wasn't recorded. The following transformations clean up these issues one at a time.

## Remove duplicate rows

Duplicate rows are common when data is loaded from multiple batches or when a source system retries failed writes. Duplicates inflate counts, sums, and averages. Removing them first ensures that every subsequent transformation operates on accurate data.

If you started with 11 rows and two were identical, deduplication reduces the count to 10. When rows differ in some fields but match on a business key like `order_id`, you can deduplicate on that specific column instead.

# [Spark SQL](#tab/sparksql)

```sql
-- Remove exact duplicate rows
SELECT DISTINCT * FROM raw_sales

-- Or deduplicate by a business key (keeps one row per order_id)
SELECT * FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_date) AS rn
    FROM raw_sales
) WHERE rn = 1
```

# [PySpark](#tab/pyspark)

```python
# Remove exact duplicate rows
deduped_df = df.dropDuplicates()

# Or deduplicate by a business key (keeps one row per order_id)
deduped_df = df.dropDuplicates(["order_id"])
```

---

## Handle null values

Null values cause different problems depending on where they appear. A null in a numeric column produces `null` results for any calculation that involves it. A null in a grouping column creates an "Unknown" group that's easy to overlook. Handling nulls explicitly ensures predictable behavior.

You have two main strategies: replace nulls with meaningful defaults, or drop rows that are unusable without a value. For example, a missing region can be filled with "Unknown," but a sales record without a `customer_id` can't be joined to customer data and might be better removed.

# [Spark SQL](#tab/sparksql)

```sql
-- Replace nulls with default values
SELECT
    order_id,
    customer_id,
    amount,
    COALESCE(region, 'Unknown') AS region,
    COALESCE(discount, 0) AS discount
FROM raw_sales

-- Or drop rows where a required column is null
SELECT * FROM raw_sales
WHERE customer_id IS NOT NULL
```

# [PySpark](#tab/pyspark)

```python
# Replace nulls with default values
clean_df = deduped_df.fillna({"region": "Unknown", "discount": 0})

# Or drop rows where a required column is null
clean_df = deduped_df.dropna(subset=["customer_id"])
```

---

After replacing nulls, rows that previously showed blank regions now display "Unknown," and discount calculations use zero instead of propagating nulls.

## Filter rows

Filtering narrows your dataset to the rows that matter for your analysis. This reduces data volume for downstream steps and ensures your results reflect the correct scope. For example, you might filter to a specific year, exclude test transactions, or focus on a region.

# [Spark SQL](#tab/sparksql)

```sql
SELECT * FROM raw_sales
WHERE YEAR(order_date) = 2024
    AND amount > 0
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.functions import col, year

filtered_df = clean_df.filter(
    (year(col("order_date")) == 2024) & (col("amount") > 0)
)
```

---

In PySpark, wrap each condition in parentheses and use `&` for AND and `|` for OR. This avoids operator precedence issues that can produce wrong results.

## Select and rename columns

Source systems often use cryptic or inconsistent column names like `cust_id`, `CUST_ID`, or `CustomerIdentifier` across different tables. Selecting only the columns you need and renaming them to a consistent convention simplifies downstream joins and makes your data easier for colleagues (and AI tools like Copilot) to interpret.

# [Spark SQL](#tab/sparksql)

```sql
SELECT
    order_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    order_date,
    region
FROM raw_sales
```

# [PySpark](#tab/pyspark)

```python
result_df = filtered_df.select(
    "order_id",
    "customer_id",
    col("prod_code").alias("product_id"),
    "quantity",
    col("price_per_unit").alias("unit_price"),
    "order_date",
    "region"
)
```

---

## Add calculated columns

Calculated columns derive new values that don't exist in the source data but are important for analysis. A `line_total` column (quantity times unit price) saves every downstream query from repeating the same calculation. Extracting date parts like year or month creates convenient grouping columns.

# [Spark SQL](#tab/sparksql)

```sql
SELECT *,
    quantity * unit_price AS line_total,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month
FROM clean_sales
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.functions import year, month

result_df = clean_df \
    .withColumn("line_total", col("quantity") * col("unit_price")) \
    .withColumn("order_year", year(col("order_date"))) \
    .withColumn("order_month", month(col("order_date")))
```

---

After this step, each row includes a pre-computed `line_total` and extracted date parts. A row with quantity 5 and unit_price 29.99 now shows a `line_total` of 149.95.

## Create conditional columns

Conditional columns categorize data based on business rules. Instead of repeating CASE logic in every report, you define the categorization once in the transformation layer. This ensures consistent classification everywhere the data is consumed.

# [Spark SQL](#tab/sparksql)

```sql
SELECT *,
    CASE
        WHEN line_total > 500 THEN 'High'
        WHEN line_total > 100 THEN 'Medium'
        ELSE 'Low'
    END AS value_tier
FROM clean_sales
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.functions import when

result_df = result_df.withColumn(
    "value_tier",
    when(col("line_total") > 500, "High")
    .when(col("line_total") > 100, "Medium")
    .otherwise("Low")
)
```

---

An order with a `line_total` of 149.95 is now categorized as "Medium," while a 199.99 order for a single premium device falls into the same tier. The thresholds reflect your business definitions and stay consistent across every downstream use.

## Convert data types

Type mismatches happen when data is loaded from CSV files (where everything is a string) or when source systems use different precision than you need. A string column that looks like a number causes errors in math operations. A low-precision decimal rounds off values that matter for financial reporting. Converting types explicitly catches these issues at transformation time rather than in a downstream report.

# [Spark SQL](#tab/sparksql)

```sql
SELECT
    CAST(amount AS DECIMAL(10,2)) AS amount,
    CAST(order_date AS DATE) AS order_date,
    CAST(quantity AS INT) AS quantity
FROM raw_sales
```

# [PySpark](#tab/pyspark)

```python
result_df = clean_df \
    .withColumn("amount", col("amount").cast("decimal(10,2)")) \
    .withColumn("order_date", col("order_date").cast("date")) \
    .withColumn("quantity", col("quantity").cast("int"))
```

---

> [!NOTE]
> Spark SQL and PySpark support the same underlying data types. You can mix both languages in the same notebook using the `%%sql` magic command. Choose whichever syntax feels more natural for each task.

## The cleaned dataset

After applying these transformations in sequence, your dataset has changed substantially:

| Before | After |
|--------|-------|
| 11 rows with duplicates | 10 unique rows |
| Null values in region and discount | Filled with "Unknown" and 0 |
| All original columns | Only needed columns, consistently named |
| No derived values | `line_total`, `order_year`, `order_month`, `value_tier` added |
| Raw data types from source | Explicit types for decimals, dates, integers |

Each transformation addressed a specific data quality problem. In production, you typically chain these steps together in a single notebook, verifying results at each stage before moving on.

You can now shape individual tables into clean, consistent formats. In the next unit, you learn to combine data from multiple tables and calculate aggregated results.
