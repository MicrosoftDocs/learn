Whenever you apply a model to new data, the most important thing is to ensure that the schema of the input data aligns with the model's expectations of the input data. 

More specifically, you need to verify that the data types of the input columns are the same as defined in the model's signature. First, let's get the data you want to generate predictions on.

## Work with data in Delta tables

To apply a model on new data in Microsoft Fabric, you should store the new data as a **Delta table** in a lakehouse.

> [!Tip]
> Learn more about how to [ingest data into a Microsoft Fabric lakehouse](/training/modules/ingest-data-with-spark-fabric-notebooks/?azure-portal=true).

You can store a PySpark dataframe `df` as a Delta lake `new_table` in a lakehouse by using the following code:

```python
df.write.format("delta").save(f"Tables/new_table")
```

When you want to read data from a Delta table, you can use the following code:

```python
df = spark.read.format("delta").load(f"Tables/new_table")
```

## Understand data types in the model's signature

When you track a machine learning model and define the signature in the `MLmodel` file, you have two options to describe the expected inputs and outputs of a model. A model's signature can be:

- **Column-based** -  ideal for tabular data that is organized by columns.
- **Tensor-based** - ideal for input data that you want to pass as arrays, like images.

In Microsoft Fabric, you're likely to work with tabular data, which is why it's more common to work with column-based signatures. Having column-based signatures makes it easier to align the actual input columns with the model's expected input columns.

When you define the model's signature, you need to use [MLflow data types](https://mlflow.org/docs/latest/python_api/mlflow.types.html#mlflow.types.DataType?azure-portal=true) to specify the schema of the data. The most commonly used data types are:

- **Boolean**: Logical data (`True` or `False`)
- **Datetime**: 64b datetime data (for example `2023-10-23 14:30:00`).
- **Double**: 64b floating point numbers (for example `3.14159265359`).
- **Float**: 32b floating point numbers (for example `3.14`).
- **Integer**: 32b signed integer numbers (for example `42`).
- **Long**: 64b signed integer numbers (for example `1234567890`).
- **String**: Text data (for example `Amsterdam`).

## Set the data types of the input data

After ingesting the data into a Delta lake and understanding the model's signature, you need to ensure that the data types of the data are compatible with the model's expected input.

You can work with your data in a notebook to verify that the data types of each column are as expected and make changes if necessary.

To list the [data types](https://spark.apache.org/docs/latest/sql-ref-datatypes.html?azure-portal=true) of each column of a dataframe `df`, use the following code:

```python
df.dtypes
```

If you want to change the data type of a specific column, you can use the following code:

```python
from pyspark.sql.types import IntegerType, DoubleType

df = df.withColumn("S1", df["S1"].cast(IntegerType()))
df = df.withColumn("S2", df["S2"].cast(DoubleType()))
```

When you've set the data types of the input data to align with the model's expected inputs, you can save the data to a new Delta table. The new table is now ready to be used to generate batch predictions.
