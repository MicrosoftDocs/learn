Whenever you apply a model to new data, the most important thing is to ensure that the schema of the input data aligns with the model's expectations of the input data. 

More specifically, you need to verify that the data types of the input columns are the same as defined in the model's signature.

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

When you're working with data in Microsoft Fabric as a data scientist, you can choose to transform data with Python or PySpark. When you prepare your new data before applying the model, you can set the data type of each column for your data by 


- list data type
- change data type