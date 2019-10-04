
Azure Databricks uses DataFrames to query, process, and analyze large volumes of data. The core structure of the data in a DataFrame is immutable. Being immutable means that the data structure can't be changed after it's created. 

So how do you use Databricks if you need to change the structure of the original data? You can change the format for the original data through *data transformation*.

Data transformation is one of the most important aspects of the data-warehousing process. When you receive data in different unstructured formats, you need to integrate the data into a common format before warehousing it. This transformation makes your data easy to use for any further analysis.

Based on the complexity of the raw data and your final output requirements, there are different transformation techniques you can use. For example, you might apply schemas to semistructured or tabular raw data. You might also use built-in functions to clean up corrupt data.

Databricks supports the end-to-end process of extracting data from the source, transforming that data, and finally loading the data into the target database. This entire process is known as extract, transform, and load (ETL).

[!INCLUDE [azure-databricks-free-trial-note](../../../includes/azure-databricks-free-trial-note.md)]

## Learning objectives

In this module, you'll:

- Transform data in Azure Databricks by applying schemas to JSON data.
- Handle corrupt records.
- Load data and put it into production.
- Apply standard and custom transformations.
- Clean up data.
- Manage tables.
