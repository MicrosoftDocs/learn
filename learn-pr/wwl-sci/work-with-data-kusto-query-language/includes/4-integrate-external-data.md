The externaldata operator returns a table whose schema is defined in the query itself and whose data is read from an external storage artifact, such as a blob in Azure Blob Storage or an Azure Data Lake Storage file.

Syntax

     externaldata ( ColumnName : ColumnType [, ...] )

      [ StorageConnectionString [, ...] ]

      [with ( PropertyName = PropertyValue [, ...] )]

Arguments

- ColumnName, ColumnType: The arguments define the schema of the table. The syntax is the same as the syntax used when defining a table in .create table.

- StorageConnectionString: Storage connection strings that describe the storage artifacts holding the data to return.

- PropertyName, PropertyValue, ...: Additional properties that describe how to interpret the data retrieved from storage, as listed under ingestion properties.

Currently, supported properties are:

ARGUMENTS

| Property| Type| Description|
| :--- | :--- | :--- |
| format| string| Data format. If not specified, an attempt is made to detect the data format from file extension (defaults to CSV). Any of the ingestion data formats are supported.|
| ignoreFirstRecord| bool| If set to true, indicates that the first record in every file is ignored. This property is useful when querying CSV files with headers.|
| ingestionMapping| string| A string value that indicates how to map data from the source file to the actual columns in the operator result set. See data mappings.|

Returns

The externaldata operator returns a data table of the given schema with data parsed from the specified storage artifact, indicated by the storage connection string.

> [!NOTE]
> This example is not available in the demo environment.
```kusto
Users

| where UserID in ((externaldata (UserID:string) [

    @"https://storageaccount.blob.core.windows.net/storagecontainer/users.txt" 

      h@"?...SAS..." // Secret token needed to access the blob

    ]))

| ...

```

