For our example, we want to build a function, which is simulating telemetric data, send it to an Event Hub that another function can listen to this event, process, and store it into a Cosmos DB.

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
