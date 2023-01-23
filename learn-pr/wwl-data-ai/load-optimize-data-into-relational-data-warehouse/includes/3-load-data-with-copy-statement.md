

When loading data into Azure Synapse Analytics on a scheduled basis, it’s important to try to reduce the time taken to perform the data load, and minimize the resources needed as much as possible to maintain good performance cost-effectively. One quick and easy approach is with the use of the `COPY` command in SQL.

## Loading data into staging tables

If you use *external* tables for staging, there's no need to load the data into them because they already reference the data files in the data lake. However, if you use "regular" relational tables, you can use the `COPY` statement to load data from the data lake, as shown in the following example:

```sql
COPY INTO dbo.StageProducts
    (ProductID, ProductName, ProductCategory, Color, Size, ListPrice, Discontinued)
FROM 'https://mydatalake.blob.core.windows.net/data/stagedfiles/products/*.parquet'
WITH
(
    FILE_TYPE = 'PARQUET',
    MAXERRORS = 0,
    IDENTITY_INSERT = 'OFF'
);
```
The COPY statement provides the most flexibility for high-throughput data ingestion into Azure Synapse Analytics. Use COPY for the following capabilities:

- Use lower privileged users to load without needing strict CONTROL permissions on the data warehouse
- Execute a single T-SQL statement without having to create any additional database objects
- Properly parse and load CSV files where delimiters (string, field, row) are escaped within string delimited columns
- Specify a finer permission model without exposing storage account keys using Share Access Signatures (SAS)
- Use a different storage account for the ERRORFILE location (REJECTED_ROW_LOCATION)
- Customize default values for each target column and specify source data fields to load into specific target columns
- Specify a custom row terminator for CSV files
- Leverage SQL Server Date formats for CSV files
- Specify wildcards and multiple files in the storage location path
- Automatic schema discovery simplifies the process of defining and mapping source data into target tables
- The automatic table creation process automatically creates the tables and works alongside with automatic schema discovery

### File Splitting

There are recommendations for splitting CSV files when loading using the `COPY` command; which is determined by the number of compute nodes multiplied by the number of distributions (60). There is no need to split Parquet and ORC files because the `COPY` command will automatically split files. Parquet and ORC files in the Azure storage account should be 256 MB or larger for best performance.
