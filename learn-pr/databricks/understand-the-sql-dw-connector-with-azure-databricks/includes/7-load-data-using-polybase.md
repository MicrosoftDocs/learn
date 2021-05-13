PolyBase is a technology that accesses data outside of a database via the T-SQL language. In Azure Synapse Analytics, you can import and export data to and from Azure Blob storage and Azure Data Lake Store.

In this unit, you'll learn how to load data from Azure Blob storage into Azure Synapse Analytics by using PolyBase.

## Make a connection to SQL Data Warehouse

1. Open Azure Data Studio.

1. Go to the **Servers** list in the menu on the left side of Azure Data Studio. Right-click the connection that you made to the Azure Synapse Analytics database, and select **New Query**.

    ![Right-click the Azure Synapse Analytics connection and select New Query](../media/azure-data-studio-new-query-dw.png)

## Create an external data source

Run the following statements in the query window to create an external data source. The statements define connection details to the labdata container of the Azure storage account that you set up in your resource group.

Replace the token `<Name_Of_Storage_Account>` with the name of the Azure storage account that you set up in your resource group in the final section of the "Set up the environment" unit.

   ```sql
    CREATE EXTERNAL DATA SOURCE LabAzureStorage
    WITH
    (
      TYPE = Hadoop,
      LOCATION = 'wasbs://labdata@<Name_Of_Storage_Account>.blob.core.windows.net/'
    );
   ```

![External data source query](../media/sql-dw-external-datasource.png)

- TYPE = `[ HADOOP | SHARD_MAP_MANAGER | RDBMS | BLOB_STORAGE ]`

  Specifies the data source type. Use `HADOOP` when the external data source is Hadoop or Azure Blob storage  for Hadoop.

- LOCATION = `<location_path>`

  For Azure Blob storage with Hadoop, specifies the URI for connecting to Azure Blob storage.

- LOCATION = `wasb[s]://container@account_name.blob.core.windows.net`

## Define the external file format

A definition of the external file format helps Azure Synapse Analytics parse the format of the external file to be loaded. It defines the field terminator, string delimiter, and date field format. These properties help with capturing the fields in a file.

- Clear the query window and execute these statements to define the external file format.

    ```sql
    CREATE EXTERNAL FILE FORMAT TextFileFormat
    WITH
    (
      FORMAT_TYPE = DELIMITEDTEXT,
      FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '',
        DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.fff',
        USE_TYPE_DEFAULT = FALSE
      )
    );
    ```

   - FIELD_TERMINATOR = `field_terminator`. Applies only to delimited text files. This property specifies one or more characters that mark the end of each field (column) in the
  text-delimited file. The external file used for this exercise uses the comma (,) as the text delimiter.

   - STRING_DELIMITER = `string_delimiter`. Specifies the field terminator for data of type string in the text-delimited file.

   - DATE_FORMAT = `datetime_format`. Specifies a custom format for all date and time data that appears in a delimited text file. The TransactionDate field holds date values (for example, "2017-01-24 00:00:00.000").

## Create a schema for the external table

- Clear the query window and run this statement to create a schema for the external table.

    ```sql
    CREATE SCHEMA [asb];
    ```

## Create the external table

External tables refer to data from an external data source. Data isn't stored in Azure Synapse Analytics.

1. Clear the query window, and run these statements to define an external table.

    ```sql
    CREATE EXTERNAL TABLE [asb].[Transaction]
    (
      [TransactionId] [int] NOT NULL,
      [ProductId] [int] NOT NULL,
      [DateApsId] [int] NULL,
      [StoreId] [int] NOT NULL,
      [StaffId] [int] NOT NULL,
      [RetailChannelId] [int] NOT NULL,
      [CustomerSegmentId] [int] NOT NULL,
      [PaymentMethodId] [int] NOT NULL,
      [COGS] [money] NULL,
      [SaleQuantity] [int] NOT NULL,
      [UnitPrice] [money] NULL,
      [SaleAmount] [money] NULL,
      [TaxRate] [money] NULL,
      [TaxAmount] [money] NULL,
      [GrossAmount] [money] NULL,
      [TenderedAmount] [money] NULL,
      [ProfitMargin] [money] NULL,
      [PaymentCount] [int] NULL,
      [ReturnQuantity] [int] NULL,
      [ReturnAmount] [money] NULL,
      [TransactionDate] [datetime] NULL,
      [CogsPerUnit] [money] NULL
    )
    WITH 
    (
      LOCATION='Transaction.txt', DATA_SOURCE = LabAzureStorage, FILE_FORMAT = TextFileFormat, REJECT_TYPE = VALUE, REJECT_VALUE = 1
    );
    ```

    - `CREATE EXTERNAL TABLE` allows one or more column definitions. The column definitions, including the data types and number of columns, need to match the data in the external files. If there's a mismatch, the file rows will be rejected when the data is queried.

    - LOCATION = `folder_or_filepath`. Specifies the folder or the file path and file name for the data in Hadoop or Azure Blob storage. The location starts at the *root folder*. The root folder is the data location specified in the external data source. In the previous statement, the `Transaction.txt` file contains the data. This file is in the container specified in the external data source.

    - DATA_SOURCE = `external_data_source_name`. Specifies the name of the external data source that contains the location of the external data. This location is either Hadoop or Azure Blob storage. Here we're referring to the `LabAzureStorage` external data store that you defined earlier. This external data store points to the container in the Azure Blob storage account.

    - FILE_FORMAT = `external_file_format_name`. Specifies the name of the external file format object that stores the file type and compression method for the external data. In the previous statement, `FILE_FORMAT` is set to the `TextFileFormat` object that you created earlier.

    - _Reject options_. You can specify reject parameters that determine how PolyBase will handle dirty records it retrieves from the external data source. A data record is considered *dirty* if its data types or the number of columns don't match the column definitions of the external table.

      - REJECT_TYPE = `value | percentage`. Specifies whether the `REJECT_VALUE` option is specified as a literal value or a percentage.

      - REJECT_VALUE. If `REJECT_TYPE` is `value`, the PolyBase query will fail when the number of rejected rows exceeds `REJECT_VALUE`. If `REJECT_TYPE` is `percentage`, the PolyBase query will fail when the percentage of failed rows exceeds `REJECT_VALUE`. The percentage of failed rows is calculated at intervals.

      In the previous statement, `REJECT_VALUE` is set to `1` to avoid headers in the external text file.

1. Clear the query window, and run this statement to get data from the external table.

    ```sql
    SELECT * FROM [asb].[Transaction]
    ```

## Create a schema for the table

- Clear the query window, and run this statement to create a schema for tables.

    ```sql
    CREATE SCHEMA [cso];
    ```

## Create an Azure Synapse Analytics table and load data

Create a table in Azure Synapse Analytics by using the CREATE TABLE AS SELECT (CTAS) statement. It's a fully parallelized operation that creates a new table based on the output of a SELECT statement.

In this exercise, the CTAS statement is used to create a table in Azure Synapse Analytics that's based on the external table that you defined earlier. CTAS doesn't just create tables. It also loads data obtained via the SELECT statement.

- Clear the query window, and run this statement to create a table in Azure Synapse Analytics.

    ```sql
    CREATE TABLE [cso].[Transaction]
    WITH
    (
      DISTRIBUTION = HASH([TransactionId])
    )
    AS
    SELECT * FROM [asb].[Transaction]
    OPTION (LABEL = 'CTAS : Load [cso].[Transaction]');
    ```

  - DISTRIBUTION = `[ HASH ( distribution_column_name ) | ROUND_ROBIN | REPLICATE ]`. The CTAS statement requires a distribution option. This option doesn't have a default value. The table in this example is created by using the `HASH` distribution method on the `TransactionId` column.

  - LABEL. This option labels the query, which makes it easy to identify.