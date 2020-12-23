A function can listen to events of the specific namespace in the Azure Event Hub, process, and store them into a Cosmos DB.

## Create an Azure Cosmos DB

```bash
az cosmosdb create \
    --resource-group $RESOURCE_GROUP \
    --name $COSMOS_DB_ACCOUNT
az cosmosdb sql database create \
    --resource-group $RESOURCE_GROUP \
    --account-name $COSMOS_DB_ACCOUNT \
    --name TelemetryDb
az cosmosdb sql container create \
    --resource-group $RESOURCE_GROUP \
    --account-name $COSMOS_DB_ACCOUNT \
    --database-name TelemetryDb \
    --name TelemetryInfo \
    --partition-key-path '/temperatureStatus'
```

## Retrieve the Cosmos DB Connection String

``` bash
COSMOS_DB_CONNECTION_STRING=$( \
    az cosmosdb keys list \
        --resource-group $RESOURCE_GROUP \
        --name $COSMOS_DB_ACCOUNT \
        --type connection-strings \
        --query 'connectionStrings[0].connectionString' \
        --output tsv)
echo $COSMOS_DB_CONNECTION_STRING
```

## Update the function settings

The `host.json` file is needed for the Cosmos DB output binding in your data analysis function.

## Add dependencies and data analysis function

``` Java
import com.microsoft.azure.functions.annotation.CosmosDBOutput;


```
