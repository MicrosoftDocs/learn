Before you create a dataset, you must create a **linked service** to link your data store to the data factory. Linked services are much like connection strings, which define the connection information needed for Data Factory to connect to external resources. Data Factory supports a wide range of connectors that you can use to define a linked service. For the list, see the [connector overview](/azure/data-factory/connector-overview).

A linked service in Data Factory can be defined using the Copy Data Activity in the ADF designer, or you can create them independently to point to a data store or a compute resource. The Copy Activity copies data between the source and destination, and you define a linked service as part of the copy activity definition.

Alternatively you can programmatically define a linked service in the JSON format to be used via REST APIs or the SDK, using the following notation:


```JSON
{
    "name": "<Name of the linked service>",
    "properties": {
        "type": "<Type of the linked service>",
        "typeProperties": {
              "<data store or compute-specific type properties>"
        },
        "connectVia": {
            "referenceName": "<name of Integration Runtime>",
            "type": "IntegrationRuntimeReference"
        }
    }
}
```

The following table describes properties in the above JSON:

| Property        | Description           | Required  |
| ------------- |-------------| -----|
| name    | Name of the linked service. |Yes |
| type     | Type of the linked service. For example: AzureBlobStorage (data store) or AzureBatch (compute). See the description for typeProperties.    |   Yes |
| typeProperties | The type properties are different for each data store or compute. For the supported data store types and their type properties, see the [dataset type table](/azure/data-factory/concepts-datasets-linked-services#dataset-type). Navigate to the data store connector article to learn about type properties specific to a data store.     |    Yes |
| connectVia | The [Integration Runtime](/azure/data-factory/concepts-integration-runtime) to be used to connect to the data store. You can use Azure Integration Runtime or Self-hosted Integration Runtime (if your data store is located in a private network). If not specified, it uses the default Azure Integration Runtime.  |    No|

## Example of a linked service

### Azure SQL Database

The following example creates a linked service named "AzureSqlLinkedService" that connects to an Azure SQL Database named "ctosqldb" using the data factory's system-assigned managed identity. Managed identity eliminates the need to store credentials in the linked service definition.

```JSON
{
  "name": "AzureSqlLinkedService",
  "properties": {
    "type": "AzureSqlDatabase",
    "typeProperties": {
      "server": "<server-name>.database.windows.net",
      "database": "ctosqldb",
      "authenticationType": "SystemAssignedManagedIdentity"
    }
  }
}
```

### Azure Blob Storage

The following example creates a linked service named "StorageLinkedService" that connects to an Azure Blob Storage account named "ctostorageaccount" using the data factory's system-assigned managed identity.

```JSON
{
  "name": "StorageLinkedService",
  "properties": {
    "type": "AzureBlobStorage",
    "typeProperties": {
      "serviceEndpoint": "https://ctostorageaccount.blob.core.windows.net/",
      "accountKind": "StorageV2"
    }
  }
}
```

