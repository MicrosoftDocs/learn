
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

### View Endpoints API documentation

Start by reviewing the [Endpoints API documentation](/rest/api/digital-twins/controlplane/endpoints). Notice that unlike previous API sets used so far in this module, the Endpoints API is part of the **Control plane** collection, because it's scoped beyond Azure Digital Twins and needs to interact with other Azure resources in your subscription. The API contains operations for creating/updating, deleting, getting, and listing endpoints.

:::image type="content" source="../media/6-endpoints.png" alt-text="Reference doc screenshot showing the Endpoints operations." border="true" lightbox="../media/6-endpoints.png":::

### Prepare the endpoint resource

Next, create an Event Grid topic in Azure, and record some key values as parameters in your Visual Studio project. Later, you'll register this Event Grid as an Azure Digital Twins endpoint.

1. In a browser tab, navigate to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

1. Run the following command in the Cloud Shell to create an Event Grid topic. This command uses the console variables defined in previous units for `$RESOURCE_GROUP` and `$REGION`.
    
    ```azurecli
    EVENT_GRID_TOPIC="event-grid-smart-building$RANDOM"
    az eventgrid topic create --resource-group $RESOURCE_GROUP --location $REGION --name $EVENT_GRID_TOPIC
    ```

1. Copy the value of `endpoint` in the result.

1. In Visual Studio, open the second `.http` file, *control.http*. Underneath the variables already defined in the file, add the following new variable to hold your endpoint details. Replace the placeholder with the value of `endpoint` that you copied in the previous step.

    ```http
    @endpoint=<paste-endpoint>
    ```

    :::image type="content" source="../media/6-variables-control-endpoint.png" alt-text="Visual Studio screenshot showing endpoint variable in control.http." border="true" lightbox="../media/6-variables-control-endpoint.png":::

1. Return to Cloud Shell and run the following command to get the shared access keys of the topic.

    ```azurecli
    az eventgrid topic key list --name $EVENT_GRID_TOPIC --resource-group $RESOURCE_GROUP
    ```

    Copy the value of `key1` in the result.
1. Return to *control.http* in Visual Studio. Add the following new variable to hold your key details. Replace the placeholder with the value of `key1` that you copied in the previous step.

    ```http
    @key=<paste-key1>
    ```

### Send the endpoint request

Follow these steps to create an endpoint using the [DigitalTwinsEndpoint CreateOrUpdate](/rest/api/digital-twins/controlplane/endpoints/digital-twins-endpoint-create-or-update) API.

1. In *control.http*, enter a new line below the variable declarations and paste the following PUT request. This is the [DigitalTwinsEndpoint CreateOrUpdate](/rest/api/digital-twins/controlplane/endpoints/digital-twins-endpoint-create-or-update) request copied from the reference documentation, with parameters filled in for your control plane variables: subscription, resource group, Azure Digital Twins instance, and control plane version. It also has a parameter for a name for the endpoint (*trainingtestendpoint*), the authorization header specifying use of your bearer token, and a header specifying the `Content-Type` of the body. The body says that you want to create an Event Grid-type endpoint, and provides your endpoint and key value variables so the request can find and authenticate with your endpoint resource.

    ```http
    PUT https://management.azure.com/subscriptions/{{subscription}}/resourceGroups/{{resourceGroup}}/providers/Microsoft.DigitalTwins/digitalTwinsInstances/{{instance}}/endpoints/trainingtestendpoint?api-version={{CPversion}}
    Authorization: Bearer {{CPtoken}}
    Content-Type: application/json
    
    {
        "properties": {
            "endpointType": "EventGrid",
            "TopicEndpoint": "<saved-endpoint-value>",
            "authenticationType": "KeyBased",
            "accessKey1": "<saved-key1-value>"
        }
    }
    ```

    :::image type="content" source="../media/6-endpoint-create-request.png" alt-text="Visual Studio screenshot showing the Endpoint Create request." border="true" lightbox="../media/6-endpoint-create-request.png":::

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:

    :::image type="content" source="../media/6-endpoint-create-response.png" alt-text="Visual Studio screenshot showing the Endpoint Create response." border="true" lightbox="../media/6-endpoint-create-response.png":::
    
    >[!TIP]
    >If your control plane bearer token from [Unit 2](../2-set-up-http-file.yml) has expired, you'll get a *401 Unauthorized* error. Remember that you can re-run the `az account get-access-token --resource https://management.azure.com/` command to get a new token, and update the value of the `CPtoken` variable at the top of *control.http*.
    
    A successful 201 response contains information about the endpoint that has been created. In the screenshot shown above, the `provisioningState` shows a value of *Provisioning*, which indicates that the endpoint is still in the process of being created.

### Check endpoint status

In this section, you check the status of the endpoint to verify when it is finished being created. Follow these steps to check the endpoint using the control plane's [DigitalTwinsEndpoint Get](/rest/api/digital-twins/controlplane/endpoints/digital-twins-endpoint-get) API.

1. In *control.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwinsEndpoint Get](/rest/api/digital-twins/controlplane/endpoints/digital-twins-endpoint-get) request copied from the reference documentation, with parameters filled in for your control plane variables: subscription, resource group, Azure Digital Twins instance, and control plane version. It also has a parameter specifying the name of your endpoint (*trainingtestendpoint*), and the authorization header specifying use of your bearer token. 

    ```http
    GET https://management.azure.com/subscriptions/{{subscription}}/resourceGroups/{{resourceGroup}}/providers/Microsoft.DigitalTwins/digitalTwinsInstances/{{instance}}/endpoints/trainingtestendpoint?api-version={{CPversion}}
    Authorization: Bearer {{CPtoken}}
    ```

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/6-endpoint-get-response.png" alt-text="Visual Studio screenshot showing the Endpoint Get response." border="true" lightbox="../media/6-endpoint-get-response.png":::

    This 200 response contains information about the endpoint. Look for the `provisioningState` field. If the value is *Succeeded*, the endpoint is finished provisioning and you can proceed to the next section. If it still says *Provisioning,* wait a few minutes and repeat this section.

## Create an event route

In this section, you'll use the Event Routes API to create a new event route that directs digital twin data to the endpoint you set up in the previous section.

### View Event Routes API documentation

Start by reviewing the [Event Routes API documentation](/rest/api/digital-twins/dataplane/event-routes). This is a data plane API that contains operations for adding, deleting, getting, and listing event routes.

:::image type="content" source="../media/6-event-routes.png" alt-text="Reference doc screenshot showing the Event Routes operations." border="true" lightbox="../media/6-event-routes.png":::

### Send the event route request

Follow these steps to check the endpoint using the [Event Routes - Add](/rest/api/digital-twins/dataplane/event-routes/add) API.

1. In Visual Studio, open *data.http*. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following PUT request on the next line. This is the [Event Routes - Add](/rest/api/digital-twins/dataplane/event-routes/add) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and an ID for the event route (*trainingtestroute*). It also has the authorization header specifying use of your bearer token, and a header specifying the `Content-Type` of the body. The body of the request contains information to create an event route that sends twin update events to your endpoint (*trainingtestendpoint*).

    ```http
    PUT https://{{hostName}}/eventroutes/trainingtestroute?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
    {
        "endpointName": "trainingtestendpoint",
        "filter": "type = 'Microsoft.DigitalTwins.Twin.Update'"
    }
    ```

  >[!TIP]
  >To create an event route that sends all event types, not just update events, you can use `"filter": "true"`. For more filter options, see [Supported route filters](/azure/digital-twins/how-to-create-routes?tabs=portal2%2Cportal3#supported-route-filters) in the Azure Digital Twins documentation.

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    [!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]
    
    :::image type="content" source="../media/6-event-routes-add-response.png" alt-text="Visual Studio screenshot showing the Event Routes Add response." border="true" lightbox="../media/6-event-routes-add-response.png":::
    
    This 204 response doesn't show any details about the event route.

### View event route

In this section, you retrieve information about the event route that you created to verify its existence.

Follow these steps to check the endpoint using the [Event Routes - Get By Id](/rest/api/digital-twins/dataplane/event-routes/get-by-id) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [Event Routes - Get By Id](/rest/api/digital-twins/dataplane/event-routes/get-by-id) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and the event route ID (*trainingtestroute*). It also has the authorization header specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/eventroutes/trainingtestroute?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

The response from a successful request looks something like this:

    :::image type="content" source="../media/6-event-routes-get-response.png" alt-text="Visual Studio screenshot showing the Event Routes Get by ID response." border="true" lightbox="../media/6-event-routes-get-response.png":::
    
    This 200 response returns the details of your event route, including its ID, the endpoint where it connects, and any filters it applies.

After this process, digital twin update events will be sent to the Event Grid endpoint. Event Grid is capable of sending the events to other Azure services for downstream processing, or for defining update logic for other twins in your Azure Digital Twins graph.

In the scenario for this module, endpoints and event routes are the first step in keeping your Azure Digital Twins graph updated with data from your city grid environment. When digital twins that represent consumers or power lines change their values, this information can be exported automatically to a Power BI report for stakeholders, or into a Logic Apps flow that emails flagged values to operators. You can also use endpoints and event routes to propagate changes throughout the graph, like if the capacity on a power line changes and you need to subsequently adjust the capacity of recipients that are fed by that power line. Creating endpoints and event routes is an important step towards building a responsive digital representation of your environment.
