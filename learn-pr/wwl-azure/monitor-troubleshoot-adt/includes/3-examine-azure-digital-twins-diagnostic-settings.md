Azure Digital Twins can collect logs for your service instance to monitor its performance, access, and other data. You can use these logs to get an idea of what is happening in your Azure Digital Twins instance, and perform root-cause analysis on issues without needing to contact Azure support.

After setting up logs, you can also query the logs to quickly gather custom insights.

You can configure diagnostic settings to start collecting logs from the Azure portal.

:::image type="content" source="../media/m11-l04-adt-diagnostic-settings-portal-051b29e9.png" alt-text="Screenshot that shows how to configure diagnostic settings and start collecting logs using the Azure portal.":::


> [!NOTE]
> New settings take effect after about 10 minutes. Logs will appear in the configured target on the Diagnostic settings page for your instance.

## Log categories

Here are more details about the categories of logs that Azure Digital Twins collects.

:::row:::
  :::column:::
    **Log category**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTModelsOperation
  :::column-end:::
  :::column:::
    Log all API calls pertaining to Models.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTQueryOperation
  :::column-end:::
  :::column:::
    Log all API calls pertaining to Queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTEventRoutesOperation
  :::column-end:::
  :::column:::
    Log all API calls pertaining to Event Routes as well as egress of events from Azure Digital Twins to an endpoint service like Event Grid, Event Hubs and Service Bus.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTDigitalTwinsOperation
  :::column-end:::
  :::column:::
    Log all API calls pertaining to Azure Digital Twins.
  :::column-end:::
:::row-end:::


Each log category consists of operations of write, read, delete, and action. These map to REST API calls as follows:

:::row:::
  :::column:::
    **Event type**
  :::column-end:::
  :::column:::
    **REST API operations**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Write
  :::column-end:::
  :::column:::
    PUT and PATCH
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Read
  :::column-end:::
  :::column:::
    GET
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delete
  :::column-end:::
  :::column:::
    DELETE
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Action
  :::column-end:::
  :::column:::
    POST
  :::column-end:::
:::row-end:::


Here is a comprehensive list of the operations and corresponding Azure Digital Twins REST API calls that are logged in each category.

> [!NOTE]
> Each log category contains several operations/REST API calls. In the table below, each log category maps to all operations/REST API calls underneath it until the next log category is listed.

:::row:::
  :::column:::
    **Log category**
  :::column-end:::
  :::column:::
    **Operation**
  :::column-end:::
  :::column:::
    **REST API calls and other events**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTModelsOperation
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/models/write
  :::column-end:::
  :::column:::
    Digital Twin Models Update API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/models/read
  :::column-end:::
  :::column:::
    Digital Twin Models Get By ID and List APIs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/models/delete
  :::column-end:::
  :::column:::
    Digital Twin Models Delete API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/models/action
  :::column-end:::
  :::column:::
    Digital Twin Models Add API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTQueryOperation
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/query/action
  :::column-end:::
  :::column:::
    Query Twins API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTEventRoutesOperation
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/eventroutes/write
  :::column-end:::
  :::column:::
    Event Routes Add API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/eventroutes/read
  :::column-end:::
  :::column:::
    Event Routes Get By ID and List APIs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/eventroutes/delete
  :::column-end:::
  :::column:::
    Event Routes Delete API.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/eventroutes/action
  :::column-end:::
  :::column:::
    Failure while attempting to publish events to an endpoint service (not an API call).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ADTDigitalTwinsOperation
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/digitaltwins/write
  :::column-end:::
  :::column:::
    Digital Twins Add, Add Relationship, Update, Update Component.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/digitaltwins/read
  :::column-end:::
  :::column:::
    Digital Twins Get By ID, Get Component, Get Relationship by ID, List Incoming Relationships, List Relationships.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/digitaltwins/delete
  :::column-end:::
  :::column:::
    Digital Twins Delete, Delete Relationship.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/digitaltwins/action
  :::column-end:::
  :::column:::
    Digital Twins Send Component Telemetry, Send Telemetry.
  :::column-end:::
:::row-end:::


## Log schemas

Each log category has a schema that defines how events in that category are reported. Each individual log entry is stored as text and formatted as a JSON blob. The fields in the log and example JSON bodies are provided for each log type below.

> [!NOTE]
> ADTDigitalTwinsOperation, ADTModelsOperation, and ADTQueryOperation use a consistent API log schema; ADTEventRoutesOperation has its own separate schema.

### API log schemas

This log schema is consistent for ADTDigitalTwinsOperation, ADTModelsOperation, and ADTQueryOperation. It contains information pertinent to API calls to an Azure Digital Twins instance.

Here are the field and property descriptions for API logs.

:::row:::
  :::column:::
    **Field name**
  :::column-end:::
  :::column:::
    **Data type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time
  :::column-end:::
  :::column:::
    DateTime
  :::column-end:::
  :::column:::
    The date and time that this event occurred, in UTC.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResourceID
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The Azure Resource Manager Resource ID for the resource where the event took place.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    OperationName
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The type of action being performed during the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    OperationVersion
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The API Version utilized during the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Category
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The type of resource being emitted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResultType
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Outcome of the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResultSignature
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Http status code for the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResultDescription
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Additional details about the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DurationMs
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    How long it took to perform the event in milliseconds.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CallerIpAddress
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    A masked source IP address for the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CorrelationId
  :::column-end:::
  :::column:::
    Guid
  :::column-end:::
  :::column:::
    Customer provided unique identifier for the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Level
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The logging severity of the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Location
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The region where the event took place.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    RequestUri
  :::column-end:::
  :::column:::
    Uri
  :::column-end:::
  :::column:::
    The endpoint utilized during the event.
  :::column-end:::
:::row-end:::


Here is an example of a JSON body for these types of logs.

```json
{
"time": "2020-03-14T21:11:14.9918922Z",
"resourceId": "/SUBSCRIPTIONS/BBED119E-28B8-454D-B25E-C990C9430C8F/RESOURCEGROUPS/MYRESOURCEGROUP/PROVIDERS/MICROSOFT.DIGITALTWINS/DIGITALTWINSINSTANCES/MYINSTANCENAME",
"operationName": "Microsoft.DigitalTwins/digitaltwins/write",
"operationVersion": "2020-10-31",
"category": "DigitalTwinOperation",
"resultType": "Success",
"resultSignature": "200",
"resultDescription": "",
"durationMs": "314",
"callerIpAddress": "13.68.244.*",
"correlationId": "2f6a8e64-94aa-492a-bc31-16b9f0b16ab3",
"level": "4",
"location": "southcentralus",
"uri": "https://myinstancename.api.scus.digitaltwins.azure.net/digitaltwins/factory-58d81613-2e54-4faa-a930-d980e6e2a884?api-version=2020-10-31"
}

```

### Egress log schemas

This is the schema for ADTEventRoutesOperation logs. These contain details pertaining to exceptions and the API operations around egress endpoints connected to an Azure Digital Twins instance.

:::row:::
  :::column:::
    **Field name**
  :::column-end:::
  :::column:::
    **Data type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time
  :::column-end:::
  :::column:::
    DateTime
  :::column-end:::
  :::column:::
    The date and time that this event occurred, in UTC.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResourceId
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The Azure Resource Manager Resource ID for the resource where the event took place.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    OperationName
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The type of action being performed during the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Category
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The type of resource being emitted.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResultDescription
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Additional details about the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Level
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The logging severity of the event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Location
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The region where the event took place.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EndpointName
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    The name of egress endpoint created in Azure Digital Twins.
  :::column-end:::
:::row-end:::


Here is an example of a JSON body for these types of logs.

```json
{
"time": "2020-11-05T22:18:38.0708705Z",
"resourceId": "/SUBSCRIPTIONS/BBED119E-28B8-454D-B25E-C990C9430C8F/RESOURCEGROUPS/MYRESOURCEGROUP/PROVIDERS/MICROSOFT.DIGITALTWINS/DIGITALTWINSINSTANCES/MYINSTANCENAME",
"operationName": "Microsoft.DigitalTwins/eventroutes/action",
"category": "EventRoutesOperation",
"resultDescription": "Unable to send EventGrid message to [my-event-grid.westus-1.eventgrid.azure.net] for event Id [f6f45831-55d0-408b-8366-058e81ca6089].",
"correlationId": "7f73ab45-14c0-491f-a834-0827dbbf7f8e",
"level": "3",
"location": "southcentralus",
"properties": {
    "endpointName": "endpointEventGridInvalidKey"
}
}

```
