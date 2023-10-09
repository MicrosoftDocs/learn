

Before you can create a machine learning model, you need to prepare the data that you'll use to train and evaluate it. Data is ingested into Azure Databricks from its source, often as data files. Optionally, you can create delta tables based on the data files to simplify data exploration and analysis. After the data has been ingested, a data scientist prepares it for machine learning.

Typically, the preparation of data involves two key tasks:

- **Data cleansing**: Identifying and mitigating issues in the data that will affect its usefulness for machine learning.
- **Feature engineering and pre-processing**: Selecting and transforming suitable features for model training.

## Data cleansing

The specific steps required to clean data varies from project to project, but typical issues you need to address include:

- **Incomplete data**: Data often includes records in which individual fields are missing (often indicated by the presence of NULL values). You need to identify missing values and mitigate them by:
    - Substituting them with a suitable replacement - either by interpolating a value in a series, using a mean (or median) value, or creating some other appropriate value.
    - Removing incomplete rows entirely (assuming this leaves enough suitable representative data for modeling)
- **Errors**: It's not uncommon for data to include errors, caused by data entry mistakes or failed upstream data processing. Finding errors can be difficult, and usually involves substantial scrutiny of the data using queries and visualizations to summarize the data and look for values that don't align with most of the other values in a given field.
- **Outliers**: Outliers are values that are significantly outside (above or below) the statistical distribution of the data. Sometimes outliers are an indication of an error (for example, someone may have a value with an extra zero or omitted a decimal point) and sometimes they're genuine values that are unusually high or low compared to most observations. In either case, extreme outliers can negatively impact the training of a machine learning model; so it's usually best to handle them by resetting them to an upper or lower threshold value, or by removing records that contain outliers from the dataset.
- **Incorrect data types**: Machine learning algorithms can be sensitive to the data types assigned to the feature values. It's common for datasets that were based on text files containing errors or null values to miscast numeric fields to a **string** data type, and often values that represent discrete integer values can be miscast to decimal numbers (or vice-versa). You should examine the schema of your data and assign the appropriate data types that most effectively reflect the data values.
- **Unbalanced data**: Machine learning training works best if the training data has adequate representation for all of the different feature and label combinations that might be encountered. In an unbalanced dataset, records that include a particular categorical value or combination of fields are over-represented; which can influence the training algorithm and introduce bias into the model. A common technique to mitigate this problem is to *oversample* under-represented values by included duplicated rows, or to *undersample* over-represented rows (by removing them from the dataset).

On Azure Databricks, the most common way to detect and handle these kinds of issue is to write code in a notebook that explores and manipulates the data. The primary class used for this kind of data manipulation is the Spark **dataframe**.

For example, the following code loads data from a text file into a dataframe:

```python
df = spark.read.format("csv").option("header", "true").load("/myfolder/mydata.csv")
```

Alternatively, if the data has been loaded into a delta table in the Azure Databricks workspace, you can use a SQL query to load its data into a dataframe:

```python
df = spark.sql("SELECT * FROM mytable")
```

After the data is loaded into a dataframe, you can use its methods and other functions in the Spark SQL library to explore and transform the data. For example, the following code uses the **dropna** method to remove any rows that include null values, and assigns specific data types to columns in the dataframe.

```python
clean_data = df.dropna().select(col("column1").astype("string"),
                                col("column2").astype("float"))
```

> [!TIP]
> For more information about Spark dataframe functionality, see the [Spark Dataframe documentation](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/dataframe.html?azure-portal=true).

## Feature engineering and preprocessing

After ensuring that the dataset is complete and clean, you can start to prepare the features for machine learning. Feature engineering is an iterative approach that often involves some trial and error to determine which feature columns have predictive value, and how best to represent the features. Common feature engineering and preprocessing tasks include:

- **Deriving new features**: Often you can derive new, more predictive features from existing ones. For example, suppose a dataset includes a *date* column and you suspect that the complete date may not be an important predictive factor in identifying the label, but that the day of the week might be. You could create a new *day_of_week* feature derived from the date and test your theory.
- **Discretizing numeric features**: In some cases, a numeric value might prove more predictive when *discretized* into categories that represent specific ranges of values. For example, you might take the numeric values in a *price* feature and assign them into *low*, *medium*, and *high* categories based on appropriate thresholds.
- **Encoding categorical features**: Many datasets include categorical data that is represented by string values. However, most machine learning algorithms work best with numeric data. It's therefore common to assign numeric codes to represent categories instead of strings. For example, a dataset of product details might include a feature for *color* that can have a value of "Green", "Red", or "Blue". You could encode these values using simple integer codes such as **0** for "Green", **1** for "Red", and **2** for "Blue". Alternatively, you could use a *one-hot encoding* technique in which you create a new column for each possible category, and assign the value **1** or **0** to each column as appropriate for each row, like this:

    | *Original Color Column* | Green | Red | Blue |
    | --- | --- | --- | --- |
    | *Green* | 1 | 0 | 0 |
    | *Blue* | 0 | 0 | 1 |
    | *Red* | 0 | 1 | 0 |

- **Scaling (normalizing) numeric values**: Numerical data values are often on different scales or units of measurement from one another. Machine learning algorithms process them all as absolute numeric values, and features larger values can often dominate the training of the model. To resolve this problem, it's common to scale all of the numeric columns so that the individual values for a single column maintain the same proportional relationship to one another, but all of the numeric columns are on a similar scale. For example, suppose a dataset contains *length* and *weight* values measured in meters and kilograms. You could convert both of these features to a scaled value between 0 and 1 like this:

    | length | weight | scaled_length | scaled_weight |
    |--|--|--|--|
    | 250.0 | 2.1 | 0.250 | 0.210 |
    | 176.0 | 0.9 | 0.176 | 0.09 |

Many machine learning libraries include classes that you can use to perform common feature engineering tasks. For example, the Spark MLlib library includes the **StringIndexer** class, which you can use to perform simple integer-based encoding for string values.

```python
from pyspark.ml.feature import StringIndexer

encoder = StringIndexer(inputCol="catCol", outputCol="catColCode")
encoded_data = encoder.fit(data).transform(data)
```

> [!NOTE]
> It's worth explaining the StringIndexer code sample in a little more detail. Spark MLlib classes can include *evaluators* that fit an algorithm for a specific transformation operation to some sample data. In this case, the StringIndexer fits an an encoding algorithm to the discrete string values in the **catCol** column in the **data** dataframe to determine the specific calculations required to generate a new **catColCode** column containing the encoded values. The output of an evaluator is a *transformer* that encapsulates the function defined by the evaluator, and which can apply that function to data and generate a new dataframe. In this example, we pass the same data used to *determine* the encoding function to the resulting transformer to actually *apply* the encoding.
>
> In Spark MLLib, you can chain a sequence of evaluators and transformers together in a *pipeline* that performs all the feature engineering and preprocessing steps you need to prepare your data. The pipeline can end with a machine learning algorithm that acts as an evaluator to determine the operations required to predict a label from the prepared features. The output of the pipeline is a machine learning model, which is in fact a transformer that can be used to apply the model function to features in a dataframe and predict the corresponding label values.
