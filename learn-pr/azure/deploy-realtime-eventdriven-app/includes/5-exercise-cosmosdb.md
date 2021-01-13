A function can listen to events of the specific namespace in the Azure Event Hub, process, and store them into a Cosmos DB.

## Create an Azure Cosmos DB

To create the Cosmos DB, use the 'az cosmosdb create' command. You'll use a Cosmos DB account, a database, and an sql container.

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

For our scenario, the temperature is interesting. So we define 'temperatureStatus' as the partition key.

### Build, Configure, and Deploy another Azure Function

With Event Hubs, you can start with data streams in megabytes, and grow to gigabytes or terabytes. The Auto-inflate feature is one of the many options available to scale the number of throughput units to meet your usage needs.

The consuming applications to each have a separate view of the event stream. They read the stream independently at their own pace and with their own offsets.

For our scenario, you'll create one consuming Azure function as an example. To create the function, following the best practices, you'll create it independent, with its own storage account, and bindings. That leads into loose coupling, and scalability.

``` bash
az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT"-consumer" \
    --sku Standard_LRS
az functionapp create \
    --resource-group $RESOURCE_GROUP \
    --name $FUNCTION_APP"-consumer"\
    --storage-account $STORAGE_ACCOUNT"-consumer" \
    --consumption-plan-location $LOCATION \
    --runtime java \
    --functions-version 2
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
package com.learn;

import com.learn.TelemetryItem.status;
import com.microsoft.azure.functions.annotation.Cardinality;
import com.microsoft.azure.functions.annotation.CosmosDBOutput;
import com.microsoft.azure.functions.annotation.EventHubTrigger;

public class Function {

    @FunctionName("processSensorData")
    public void processSensorData(
        @EventHubTrigger(
            name = "msg",
            eventHubName = "", // blank because the value is included in the connection string
            cardinality = Cardinality.ONE,
            connection = "EventHubConnectionString")
            TelemetryItem item,
        @CosmosDBOutput(
            name = "databaseOutput",
            databaseName = "TelemetryDb",
            collectionName = "TelemetryInfo",
            connectionStringSetting = "CosmosDBConnectionString")
            OutputBinding<TelemetryItem> document,
        final ExecutionContext context) {
    
        context.getLogger().info("Event hub message received: " + item.toString());
    
        if (item.getPressure() > 30) {
            item.setNormalPressure(false);
        } else {
            item.setNormalPressure(true);
        }
    
        if (item.getTemperature() < 40) {
            item.setTemperatureStatus(status.COOL);
        } else if (item.getTemperature() > 90) {
            item.setTemperatureStatus(status.HOT);
        } else {
            item.setTemperatureStatus(status.WARM);
        }
    
        document.setValue(item);
    }
}
```

When the event hub receives the message, it generates an event. The `processSensorData` function runs when it receives the event. It then processes the event data and uses an Azure Cosmos DB output binding to send the results to Azure Cosmos DB. We'll use again the `TelemetryItem.java` class. The `TelemetryItem` objects can be seen as the Consumer Driven Contract between the participants of this event-driven system.

## Run locally

``` Bash
mvn clean package
mvn azure-functions:run
```

You can go to the Azure portal and navigate to your Azure Cosmos DB account. Select Data Explorer, expand TelemetryInfo, then select Items to view your data when it arrives.

// Add Screenshot

## Deploy on Azure

Now, let's shift the whole workload in the cloud. To deploy the functions to Azure Functions, you'll use the Maven command `mvn azure-functions:deploy`. Make sure, you're still in the correct repository __telemetry-functions__.

``` Bash
mvn azure-functions:deploy
```
