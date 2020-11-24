An external data source is used to define the location of the data and the credential that should be used to access it. You can create external data source to a public storage account as follows:

```sql
CREATE EXTERNAL DATA SOURCE YellowTaxi 
WITH ( LOCATION = 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/') 
```

If storage is protected, you must specify which credentials should be used like this: 

```sql
CREATE EXTERNAL DATA SOURCE SqlOnDemandDemo WITH ( 
    LOCATION = 'https://sqlondemandstorage.blob.core.windows.net', 
    CREDENTIAL = sqlondemand 
); 
```

External data source are typically used in the **OPENROWSET** function or as part of the external table definition. 
