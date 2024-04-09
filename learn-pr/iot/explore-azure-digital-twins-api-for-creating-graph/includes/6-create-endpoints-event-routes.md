
In this unit, you'll use the Endpoints API to create a new endpoint for your Azure Digital Twins instance. An **endpoint** is a recognized destination outside of Azure Digital Twins that can receive digital twin events.

Then, you'll use the Event Routes API to create a new **event route** that directs data from Azure Digital Twins to the endpoint. Together, endpoints and event routes form the basis of data movement in Azure Digital Twins. 

## Understand event handling in Azure Digital Twins

In a fully connected Azure Digital Twins solution, endpoints and event routes are used to send twin data both inside and outside of Azure Digital Twins.

The first step is to create an Azure Digital Twins endpoint, powered by one of these Azure event handling services:
* Event Hubs
* Event Grid
* Service Bus

Then, create an event route to define what types of graph events should be sent to that endpoint.

From there, the event handling service at the endpoint receives the specified events and delivers them to final destinations, such as Azure Maps, Logic Apps, or Azure Functions. If the event needs to be sent back into Azure Digital Twins and used to update other twins in the graph, you can define this logic in an Azure function.

In this unit, you create an endpoint that's capable of using Event Grid to deliver Azure Digital Twins events outside of the service. Then, you create an event route that sends twin events to that endpoint. By setting up this event structure on the Azure Digital Twins side, you begin to lay the groundwork for a complete future solution where data is exported to and handled by external destinations. (Full configuration of these external destinations is out of scope for this module.)

>[!TIP]
>An in-depth exercise to set up the full data flow in Azure Digital Twins is included in Module 3 of this learning path, [Synchronize Azure Digital Twins with IoT Device Data](../../synchronize-azure-digital-twins-with-iot-device-data/index.yml).

## Create an endpoint

In this section, you use the Endpoints API to create a new endpoint in your Azure Digital Twins instance.

Start by reviewing the [Endpoints API documentation](/rest/api/digital-twins/controlplane/endpoints). Notice that unlike previous API sets used so far in this module, the Endpoints API is part of the **Control plane** collection, because it's scoped beyond Azure Digital Twins and needs to interact with other Azure resources in your subscription. The API contains operations for creating/updating, deleting, getting, and listing endpoints.

:::image type="content" source="../media/6-endpoints.png" alt-text="Reference doc screenshot showing the Endpoints operations." border="true" lightbox="../media/6-endpoints.png":::

### Prepare the endpoint resource

Next, create an Event Grid topic in Azure. Later, you'll register this Event Grid as an Azure Digital Twins endpoint.

In a browser tab, navigate to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

Run the following command in the Cloud Shell to create an Event Grid topic. This command uses the console variables defined in previous units for `$RESOURCE_GROUP` and `$REGION`.

```azurecli
EVENT_GRID_TOPIC="event-grid-smart-building$RANDOM"
az eventgrid topic create --resource-group $RESOURCE_GROUP --location $REGION --name $EVENT_GRID_TOPIC
```

Copy and save the value of `endpoint` in the result, as you'll need it for a request parameter in the next section.

Next, run the following command to get the shared access keys of the topic.

```azurecli
az eventgrid topic key list --name $EVENT_GRID_TOPIC --resource-group $RESOURCE_GROUP
```

Copy and save the value of `key1` in the result, as you'll need it for a request parameter in the next section.

### Send the endpoint request

Return to your Postman window. From your Postman collections, start by opening the request template at _Control plane > subscriptions > {subscriptionId} > resourceGroups > {resourceGroupName} > providers > Microsoft.DigitalTwins > digitalTwinsInstances > {resourceName} > endpoints > {endpointName} > **PUT Digital Twins Endpoint Create Or Update**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-01-31*. This is a different API version than previous calls in this module, because this is the latest version of the control plane API set.
  * Fill the **subscriptionId**, **resourceGroupName**, and **resourceName** with the name of your subscription, resource group, and Azure Digital Twins instance. (You can find these values in the `$AZURE_SUBSCRIPTION`, `$RESOURCE_GROUP`, and `$INSTANCE_NAME` console variables, or by searching for your instance in the [Azure portal](https://portal.azure.com) and pulling up its details.) Fill **endpointName** with a friendly name for your endpoint, like *trainingtestendpoint*.
* In the **Body** tab, replace the contents with the following information, and fill the placeholders with the endpoint and key values you saved in the previous section. This says that you want to create an Event Grid-type endpoint, and provides the information needed to find and authenticate with it.

  ```json
  {
    "properties": {
      "endpointType": "EventGrid",
      "TopicEndpoint": "<saved-endpoint-value>",
      "authenticationType": "KeyBased",
      "accessKey1": "<saved-key1-value>"
    }
  }
  ```

Send the request.

>[!TIP]
>If your control plane bearer token from [Unit 2](../2-configure-postman-api-collections.yml) has expired, you'll get a *401 Unauthorized* error. Remember that you can re-run the `az account get-access-token --resource https://management.azure.com/` command to get a new token, and update it in the **Authorization** tab of your control plane Postman collection.

The response from a successful request looks something like this:

:::image type="content" source="../media/6-digital-twins-endpoint-create-or-update.png" alt-text="Postman screenshot showing the results of the Digital Twins Endpoint Create Or Update request." border="true" lightbox="../media/6-digital-twins-endpoint-create-or-update.png":::

This 201 response contains information about the endpoint that has been created. In the screenshot shown above, the `provisioningState` shows a value of *Provisioning*, which indicates that the endpoint is still in the process of being created.

### Check endpoint status

In this section, you check the status of the endpoint to verify when it is finished being created.

From the same Postman collection folder, open the request template for **GET Digital Twins Endpoint Get**.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-01-31*. 
  * Fill the **subscriptionId**, **resourceGroupName**, and **resourceName** with the name of your subscription, resource group, and Azure Digital Twins instance. Fill **endpointName** with the friendly name that you chose for your endpoint (the default suggestion was *trainingtestendpoint*).

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/6-digital-twins-endpoint-get.png" alt-text="Postman screenshot showing the results of the Digital Twins Endpoint Get request." border="true" lightbox="../media/6-digital-twins-endpoint-get.png":::

This 200 response contains information about the endpoint. Look for the `provisioningState` field. If the value is *Succeeded*, the endpoint is finished provisioning and you can proceed to the next section. If it still says *Provisioning,* wait a few minutes and repeat this section.

## Create an event route

In this section, you'll use the Event Routes API to create a new event route that directs digital twin data to the endpoint you set up in the previous section.

### View Event Routes API documentation

Start by reviewing the [Event Routes API documentation](/rest/api/digital-twins/dataplane/event-routes). This is a data plane API that contains operations for adding, deleting, getting, and listing event routes.

:::image type="content" source="../media/7-event-routes.png" alt-text="Reference doc screenshot showing the Event Routes operations." border="true" lightbox="../media/7-event-routes.png":::

### Send the event route request

From your Postman collections, start by opening the request template at _Data plane > eventroutes > {id} > **PUT Event Routes Add**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31*. In the **id** field, enter a friendly name for your new event route, such as *trainingtestroute*. 
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.
* In the **Body** tab, replace the contents with the following information and fill in the friendly name of your endpoint from earlier in this unit (the default suggestion was *trainingtestendpoint*). This text creates an event route that sends twin update events to the endpoint.

  >[!TIP]
  >To create an event route that sends all event types, not just update events, you can use `"filter": "true"`. For more filter options, see [Supported route filters](/azure/digital-twins/how-to-create-routes?tabs=portal2%2Cportal3#supported-route-filters) in the Azure Digital Twins documentation.

  ```json
  {
    "endpointName": "<endpoint-name>",
    "filter": "type = 'Microsoft.DigitalTwins.Twin.Update'"
  }
  ```

Send the request.

[!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

The response from a successful request looks something like this:

:::image type="content" source="../media/6-event-routes-add.png" alt-text="Postman screenshot showing the results of the Event Routes Add request." border="true" lightbox="../media/6-event-routes-add.png":::

This 204 response doesn't show any details about the event route.

### View event route

In this section, you retrieve information about the event route that you created to verify its existence.

From the same Postman collection folder, open the request template for **GET Event Routes Get By Id**.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31*. In the **id** field, enter the event route name that you chose in the previous section (the default suggestion was *trainingtestroute*).
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/6-event-routes-get-by-id.png" alt-text="Postman screenshot showing the results of the Event Routes Get by ID request." border="true" lightbox="../media/6-event-routes-get-by-id.png":::

This 200 response returns the details of your event route, including its ID, the endpoint where it connects, and any filters it applies.

After this process, digital twin update events will be sent to the Event Grid endpoint. Event Grid is capable of sending the events to other Azure services for downstream processing, or for defining update logic for other twins in your Azure Digital Twins graph.

In the scenario for this module, endpoints and event routes are the first step in keeping your Azure Digital Twins graph updated with data from your city grid environment. When digital twins that represent consumers or power lines change their values, this information can be exported automatically to a Power BI report for stakeholders, or into a Logic Apps flow that emails flagged values to operators. You can also use endpoints and event routes to propagate changes throughout the graph, like if the capacity on a power line changes and you need to subsequently adjust the capacity of recipients that are fed by that power line. Creating endpoints and event routes is an important step towards building a responsive digital representation of your environment.
