
Databricks use DataFrames, where the core structure of data is immutable, to query, process, and analyze a large volume of data. Being immutable means that the data stored cannot be changed once it's created. So how do you use Databrciks if there is a requirement to change the original data creaed using DataFrame? This can be done using transformation. 

Data transformation is one the most important aspect of data integration during data warehousing process. When you receive data from variety of sources in different unstructured format, it is essential that you transform and structure it into a common format before warehousing it. This transformation makes your data easy to use for any further analysis purposes.

There are different transformation techniques that can be selected based on the complexity of the raw data and the final output requirements. The basic transformation includes applying simple schemas to a semi-structured or tabular raw data or using built-in functions to clean corrupt data.

Databricks provide the capabilities to perform the end-to-end process of data extraction from the source, transformation, and finally loading into the target database. This entire process is call extract, transform, load (ETL).

## Learning objectives

In this module, you will:

- Transform data in Azure Databricks by applying schemas to JSON data
- Handle corrupt records
- Load and productionalize data
- Apply standard and custom transformations
- Clean data 
- Manage tables