For our example, we want to build a function, which is simulating telemetric data and send it to an Event Hub. Later, another function can listen to this event, process, and store it into a Cosmos DB.

## Prepare your environment

Let's define some environment variables to keep the following commands as short and understandable as possible.

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

### Build, Configure and Deploy the Azure Function

To make this example as realistic as possible, you'll create an Azure Functions and simulate telemetric data. You could also bind an IoT device to your Azure Function, which would then take real data.

``` bash
az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT \
    --sku Standard_LRS
az functionapp create \
    --resource-group $RESOURCE_GROUP \
    --name $FUNCTION_APP \
    --storage-account $STORAGE_ACCOUNT \
    --consumption-plan-location $LOCATION \
    --runtime java \
    --functions-version 2
```

> [!NOTE]
> In order to use Java for the Azure Functions application we need to use at least the functions-version 2.

When the `az functionapp create` command creates your function application, it also creates an Application Insights resource with the same name. We will use this later for our monitoring.

To retrieve the connection strings for the storage account and the Event Hub, we can use the following commands and save them in environment variables. They will be also displayed as you print them with the `echo` command.

```bash
AZURE_WEB_JOBS_STORAGE=$( \
    az storage account show-connection-string \
        --name $STORAGE_ACCOUNT \
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
