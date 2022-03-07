DataFrames allow the processing of huge amounts of data. Spark uses an optimization engine to generate logical queries. Data is distributed over your cluster and you get huge performance for massive amounts of data.

Spark SQL is a component that introduced the DataFrames, which provides support for structured and semi-structured data. 

Spark has multiple interfaces (APIs) for dealing with DataFrames:

- We have seen the `.sql()` method, which allows to run arbitrary SQL queries on table data.
- Another option is to use the Spark domain-specific language for structured data manipulation, available in Scala, Java, Python, and R.

## DataFrame API

The Apache Spark DataFrame API provides a rich set of functions (select columns, filter, join, aggregate, and so on) that allow you to solve common data analysis problems efficiently.

A complex operation where tables are joined, filtered, and restructured is easy to write, easy to understand, type safe, feels natural for people with prior sql experience, and comes with the added speed of parallel processing given by the Spark engine.

To load or save data use `read` and `write`:

```python
df = spark.read.format('json').load('sample/trips.json')
df.write.format('parquet').bucketBy(100, 'year', 'month').mode("overwrite").saveAsTable('table1'))
```

To get the available data in a DataFrame use `select`:
```python
df.select('*')
df.select('tripDistance', 'totalAmount')
```

To extract the first rows, use `take`:

```python
df.take(15)
```

To order the data, use the `sort` method:

```python
df.sort(df.tripDistance.desc())
```

To combine the rows in multiple DataFrames use `union`:

```python
df1.union(df2)
```

This operation is equivalent to `UNION ALL` in SQL. 
To do a SQL-style set union (that does deduplication of elements), use this function followed by `distinct()`.

The dataframes must have the same structure/schema.

To add or update columns use `withColumn` or `withColumnRenamed`:

```python
df.withColumn('isHoliday', False)
df.withColumnRenamed('isDayOff', 'isHoliday')
```

To use aliases for the whole DataFrame or specific columns:

```python
df.alias("myTrips")
df.select(df.passengerCount.alias("numberOfPassengers"))
```

To create a temporary view:

```python
df.createOrReplaceTempView("tripsView")
```

To aggregate on the entire DataFrame without groups use `agg`:

```python
df.agg({"age": "max"})
```

To do more complex queries, use `filter`, `groupBy` and `join`:

```python
people \
  .filter(people.age > 30) \
  .join(department, people.deptId == department.id) \
  .groupBy(department.name, "gender")
  .agg({"salary": "avg", "age": "max"})
```

These join types are supported: inner, cross, outer, full, full_outer, left, left_outer, right, right_outer, left_semi, and left_anti.

Note that `filter` is an alias for `where`.

To use columns aggregations using windows:

```python
w = Window.partitionBy("name").orderBy("age").rowsBetween(-1, 1)
df.select(rank().over(w), min('age').over(window))
```

To use a list of conditions for a column and return an expression use `when`:

```python
df.select(df.name, F.when(df.age > 4, 1).when(df.age < 3, -1).otherwise(0)).show()
```

To check the presence of data use `isNull` or `isNotNull`:

```python
df.filter(df.passengerCount.isNotNull())
df.filter(df.totalAmount.isNull())
```

To clean the data use `dropna`, `fillna` or `dropDuplicates`:

```python
df1.fillna(1) #replace nulls with specified value
df2.dropna #drop rows containing null values
df3.dropDuplicates #drop duplicate rows
```

To get statistics about the DataFrame use `summary` or `describe`:

```python
df.summary().show()
df.summary("passengerCount", "min", "25%", "75%", "max").show()
df.describe(['age']).show()
```

Available statistics are: 
- Count 
- Mean 
- Stddev 
- Min 
- Max 
- Arbitrary approximate percentiles specified as a percentage (for example, 75%).

To find correlations between specific columns use `corr`. This operation currently only supports the Pearson Correlation Coefficient:

```python
df.corr('tripDistance', 'totalAmount')
```

> [!NOTE]
> **More information:** for more information about the Spark API, see the [DataFrame API](https://spark.apache.org/docs/2.4.0/api/python/pyspark.sql.html#pyspark.sql.DataFrame?azure-portal=true) and the [Column API](https://spark.apache.org/docs/2.4.0/api/python/pyspark.sql.html#pyspark.sql.Column?azure-portal=true) in the Spark documentation.
