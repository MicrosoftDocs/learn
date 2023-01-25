
When you initially create a notebook with Azure Synapse Analytics, simply select a primary language like Python, and if you or a colleague prefers to use another language this is where the integrated platform experience allows you to switch between multiple other languages based on data engineering tasks applicable to the expertise you have in-house using nothing more than what's referred to as a 'magic' key and looks like: 
 
 ```python
%%sql #SparkSQL
%%md #MarkDown
%%spark #Scala
%%pyspark #Python
%%csharp #.NET for Spark C#
%%sparkr  #R
 ```
 As a result, an Apache Spark-orientated data engineer can easily communicate and work with a SQL-based data engineer on the same platform or other professionals within the same collaborative notebook.

The interoperability between Apache Spark and SQL helps you achieve as follows:

- Work with SQL and Apache Spark to directly explore and analyze Parquet, CSV, TSV, and JSON files stored in the data lake.

In the below example we're reading a csv file from a blob storage account into a dataframe (df) that displays the header and is pipe '|' delimited.

```python

from pyspark.sql import SparkSession

# Azure storage access info
blob_account_name = 'Your account name' # replace with your blob name
blob_container_name = 'Your container name' # replace with your container name
blob_relative_path = 'Your path' # replace with your relative folder path
linked_service_name = 'Your linked service name' # replace with your linked service name

blob_sas_token = mssparkutils.credentials.getConnectionStringOrCreds(linked_service_name)

# Allow SPARK to access from Blob remotely

wasb_path = 'wasbs://%s@%s.blob.core.windows.net/%s' % (blob_container_name, blob_account_name, blob_relative_path)

spark.conf.set('fs.azure.sas.%s.%s.blob.core.windows.net' % (blob_container_name, blob_account_name), blob_sas_token)
print('Remote blob path: ' + wasb_path)

df = spark.read.option("header", "true") \
            .option("delimiter","|") \
            .schema(schema) \
            .csv(wasbs_path)
```

- Enable fast, scalable loads for data transferring between SQL and Apache Spark databases.
- Make use of a shared Hive-compatible metadata system that enables you to define tables on files in the data lake such that it can be consumed by either Apache Spark or Hive.

### Parquet formats

Your data stored in a data lake is also likely to reside in a parquet file format and this is for optimal storage and performance across the distribued file architecutre. Within notebooks you can easily query this data with a query like the one below:

```python
select top 10 *
from openrowset(
    bulk 'https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.parquet',
    format = 'parquet') as rows
```

In many cases, we will want to write our cleansed data frames into a parquet format and this can be accomplished fairly easily as well. In our earlier example we created a dataframe, named 'df' which was populated from a CSV stored in blob storage. Now, to write this data to a parquet file in another location in an Azure Data Lake we would execute a command similar to:

```python

df.write.parquet('abfss://<<TheNameOfAStorageAccountFileSystem>>@<<TheNameOfAStorageAccount>>.dfs.core.windows.net/demodata/demo_df', mode='overwrite')

```