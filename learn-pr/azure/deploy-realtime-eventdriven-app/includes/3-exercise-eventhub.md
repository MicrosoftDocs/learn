For our example, we'll use Event Sourcing in a CQRS context. So let's build a function, which is simulating telemetric data and send it to an Event Hub. Later, another function can listen to this event, process, and store it into a Cosmos DB.

## Prepare your environment

Let's define some environment variables to keep all following commands as short and understandable as possible.

```bash
RESOURCE_GROUP=<value>
EVENT_HUB_NAMESPACE=<value>
EVENT_HUB_NAME=<value>
EVENT_HUB_AUTHORIZATION_RULE=<value>
COSMOS_DB_ACCOUNT=<value>
STORAGE_ACCOUNT=<value>
FUNCTION_APP=<value>
LOCATION=<value>
```

> To set the LOCATION variable, you can check the `az functionapp list-consumption-locations` command and take the closest.

## Create the required components

Provisioning the resources on Azure will take some time. So let's start with the component creation as early as possible to avoid long waits later on.

### Create Resource Group

It's always a good idea to have all the resources of a training, proof of concept or a prototype in one resource group. That allows you to clean up all used services with one command to prevent any inconveniences.

``` bash
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION
```

### Create and Configure an Event Hub

For the Event Hub, it's necessary to specify the namespace it should listen to. Also, you can't forget to configure the authorization rule to `Listen` and `Send`.

``` bash
az eventhubs namespace create \
    --resource-group $RESOURCE_GROUP \
    --name $EVENT_HUB_NAMESPACE
az eventhubs eventhub create \
    --resource-group $RESOURCE_GROUP \
    --name $EVENT_HUB_NAME \
    --namespace-name $EVENT_HUB_NAMESPACE \
    --message-retention 1
az eventhubs eventhub authorization-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $EVENT_HUB_AUTHORIZATION_RULE \
    --eventhub-name $EVENT_HUB_NAME \
    --namespace-name $EVENT_HUB_NAMESPACE \
    --rights Listen Send
```

### Build, Configure, and Deploy the Azure Function

To make this example as realistic as possible, you'll create an Azure Function and simulate telemetric data. You could also bind an IoT device to your Azure Function, which would then take real data.

``` bash
az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT"-producer" \
    --sku Standard_LRS
az functionapp create \
    --resource-group $RESOURCE_GROUP \
    --name $FUNCTION_APP"-producer"\
    --storage-account $STORAGE_ACCOUNT"-producer" \
    --consumption-plan-location $LOCATION \
    --runtime java \
    --functions-version 2
```

> [!NOTE]
> In order to use Java for the Azure Functions application we need to use at least the functions-version 2.

When the `az functionapp create` command creates your function application, it also creates an Application Insights resource with the same name. We'll use that resource later for our monitoring.

To retrieve the connection strings for the storage account and the Event Hub, we can use the following commands and save them in environment variables. They'll be also displayed as you print them with the `echo` command.

```bash
AZURE_WEB_JOBS_STORAGE=$( \
    az storage account show-connection-string \
        --name $STORAGE_ACCOUNT"-producer" \
        --query connectionString \
        --output tsv)
echo $AZURE_WEB_JOBS_STORAGE
EVENT_HUB_CONNECTION_STRING=$( \
    az eventhubs eventhub authorization-rule keys list \
        --resource-group $RESOURCE_GROUP \
        --name $EVENT_HUB_AUTHORIZATION_RULE \
        --eventhub-name $EVENT_HUB_NAME \
        --namespace-name $EVENT_HUB_NAMESPACE \
        --query primaryConnectionString \
        --output tsv)
echo $EVENT_HUB_CONNECTION_STRING
```

These connection strings need to be stored in the application settings at your Azure Functions account.

```bash
az functionapp config appsettings set \
    --resource-group $RESOURCE_GROUP \
    --name $FUNCTION_APP"-producer" \
    --settings \
        AzureWebJobsStorage=$AZURE_WEB_JOBS_STORAGE \
        EventHubConnectionString=$EVENT_HUB_CONNECTION_STRING
```

Your Azure resources event hub and Azure Function have now been created and configured to work properly together.

Next, create a local functions project with Maven.

``` bash
mvn archetype:generate --batch-mode \
    -DarchetypeGroupId=com.microsoft.azure \
    -DarchetypeArtifactId=azure-functions-archetype \
    -DappName=$FUNCTION_APP"-producer" \
    -DresourceGroup=$RESOURCE_GROUP \
    -DgroupId=com.learn \
    -DartifactId=telemetry-functions
```

This command generates several files inside a telemetry-functions folder:

- The `pom.xml` build file with predefined Azure dependencies.
- The `local.settings.json` file to hold the application settings for local deployment and manual testing.
- A `host.json` file that enables the Azure Functions Extension Bundle.
- A `Function.java` file that includes the default Http trigger function.
- A few test files that this MS Learn module doesn't use.

As we won't touch the test files in this learn module, feel free to delete it.

``` Bash
cd telemetry-functions
rm -r src/test
```

For local execution, the application settings need to be retrieved and stored at the `local.settings.json` file. You can do that automatically by running the `fetch-app-settings` command.

``` Bash
cd telemetry-functions
func azure functionapp fetch-app-settings $FUNCTION_APP
```

Next, open the `Functions.java` file and replace the content with the following code.

``` Java
package com.learn;

import com.learn.TelemetryItem.status;
import com.microsoft.azure.functions.annotation.EventHubOutput;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.TimerTrigger;
import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.OutputBinding;
public class Function {

    @FunctionName("generateSensorData")
    @EventHubOutput(
        name = "event",
        eventHubName = "", // blank because the value is included in the connection string
        connection = "EventHubConnectionString")
    public TelemetryItem generateSensorData(
        @TimerTrigger(
            name = "timerInfo",
            schedule = "*/10 * * * * *") // every 10 seconds
            String timerInfo,
        final ExecutionContext context) {
            context.getLogger().info("Java Timer trigger function executed at: " + java.time.LocalDateTime.now());
            double temperature = Math.random() * 100;
            double pressure = Math.random() * 50;
        return new TelemetryItem(temperature, pressure);
    }
```

The `generateSensorData` function simulates a sensor that sends temperature and pressure readings to the event hub. A timer trigger runs the function every 10 seconds, and an event hub output binding sends the return value to the event hub.

When the event hub receives the message, it generates an event.

The data used by this function is stored using a class called TelemetryItem, which you'll need to implement. Create a new file called TelemetryItem.java in the same location as Function.java and add the following code:

``` Java
package com.learn;

public class TelemetryItem {

    private String id;
    private double temperature;
    private double pressure;
    private boolean isNormalPressure;
    private status temperatureStatus;
    static enum status {
        COOL,
        WARM,
        HOT
    }

    public TelemetryItem(double temperature, double pressure) {
        this.temperature = temperature;
        this.pressure = pressure;
    }

    public String getId() {
        return id;
    }

    public double getTemperature() {
        return temperature;
    }

    public double getPressure() {
        return pressure;
    }

    @Override
    public String toString() {
        return "TelemetryItem={id=" + id + ",temperature="
            + temperature + ",pressure=" + pressure + "}";
    }

    public boolean isNormalPressure() {
        return isNormalPressure;
    }

    public void setNormalPressure(boolean isNormal) {
        this.isNormalPressure = isNormal;
    }

    public status getTemperatureStatus() {
        return temperatureStatus;
    }

    public void setTemperatureStatus(status temperatureStatus) {
        this.temperatureStatus = temperatureStatus;
    }
}
```

## Run locally

``` Bash
mvn clean package
mvn azure-functions:run
```

After some build and startup messages, you'll see output similar to the following example for each time the functions run:

``` Output
[10/22/19 4:01:30 AM] Executing 'Functions.generateSensorData' (Reason='Timer fired at 2019-10-21T21:01:30.0016769-07:00', Id=c1927c7f-4f70-4a78-83eb-bc077d838410)
[10/22/19 4:01:30 AM] Java Timer trigger function executed at: 2019-10-21T21:01:30.015
[10/22/19 4:01:30 AM] Function "generateSensorData" (Id: c1927c7f-4f70-4a78-83eb-bc077d838410) invoked by Java Worker
[10/22/19 4:01:30 AM] Executed 'Functions.generateSensorData' (Succeeded, Id=c1927c7f-4f70-4a78-83eb-bc077d838410)
[10/22/19 4:01:30 AM] Event hub message received: TelemetryItem={id=null,temperature=32.728691307527015,pressure=10.122563042388165}

```
