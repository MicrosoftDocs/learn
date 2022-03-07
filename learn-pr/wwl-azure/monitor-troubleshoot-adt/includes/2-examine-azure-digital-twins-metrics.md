Azure Digital Twins metrics help you assess the overall health of Azure Digital Twins service and the resources connected to it. These user-facing statistics help you see what is going on with your Azure Digital Twins and help perform root-cause analysis on issues without needing to contact Azure support.

Metrics are enabled by default. You can view Azure Digital Twins metrics from the Azure portal.

:::image type="content" source="../media/m11-l04-adt-metrics-portal-08c9bcb5.png" alt-text="Screenshot that shows how to view Azure Digital Twins metrics from the Azure portal.":::


## Azure Digital Twins metrics and how to use them

Azure Digital Twins provides several metrics to give you an overview of the health of your instance and its associated resources. You can also combine information from multiple metrics to paint a bigger picture of the state of your instance.

The following tables describe some of the metrics that can be tracked by each Azure Digital Twins instance, and how each metric relates to the overall status of your instance.

### Metrics for tracking service limits

You can configure these metrics to track when you're approaching a published service limit for some aspect of your solution. To set this up, use the alerts feature in Azure Monitor. You can define thresholds for these metrics so that you receive an alert when a metric reaches a certain percentage of its published limit.

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric display name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Dimensions**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    TwinCount
  :::column-end:::
  :::column:::
    Twin Count (Preview)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Total number of twins in the Azure Digital Twins instance. Use this metric to determine if you are approaching the service limit for max number of twins allowed per instance.
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ModelCount
  :::column-end:::
  :::column:::
    Model Count (Preview)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Total number of models in the Azure Digital Twins instance. Use this metric to determine if you are approaching the service limit for max number of models allowed per instance.
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::


### Ingress metrics

Metrics having to do with data ingress:

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric display name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Dimensions**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IngressEvents
  :::column-end:::
  :::column:::
    Ingress Events
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of incoming telemetry events into Azure Digital Twins.
  :::column-end:::
  :::column:::
    Result
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IngressEventsFailureRate
  :::column-end:::
  :::column:::
    Ingress Events Failure Rate
  :::column-end:::
  :::column:::
    Percent
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The percentage of incoming telemetry events for which the service returns an internal error (500) response code.
  :::column-end:::
  :::column:::
    Result
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IngressEventsLatency
  :::column-end:::
  :::column:::
    Ingress Events Latency
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The time from when an event arrives to when it is ready to be egressed by Azure Digital Twins, at which point the service sends a success/fail result.
  :::column-end:::
  :::column:::
    Result
  :::column-end:::
:::row-end:::


### Routing metrics

Metrics having to do with routing:

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric display name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Dimensions**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MessagesRouted
  :::column-end:::
  :::column:::
    Messages Routed
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of messages routed to an endpoint Azure service such as Event Hubs, Service Bus, or Event Grid.
  :::column-end:::
  :::column:::
    Endpoint Type, Result
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    RoutingFailureRate
  :::column-end:::
  :::column:::
    Routing Failure Rate
  :::column-end:::
  :::column:::
    Percent
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The percentage of events that result in an error as they are routed from Azure Digital Twins to an endpoint Azure service such as Event Hubs, Service Bus, or Event Grid.
  :::column-end:::
  :::column:::
    Endpoint Type, Result
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    RoutingLatency
  :::column-end:::
  :::column:::
    Routing Latency
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    Time elapsed between an event getting routed from Azure Digital Twins to when it is posted to the endpoint Azure service such as Event Hubs, Service Bus, or Event Grid.
  :::column-end:::
  :::column:::
    Endpoint Type, Result
  :::column-end:::
:::row-end:::


### Additional metrics categories

Here are some more metrics categories that a business may want to track.

 -  API request metrics: Metrics having to do with API requests, such as the number of API requests, response latency, and the percentage of requests that result in an error message (failure rate)
 -  Billing metrics: Metrics having to do with billing, such as the total number of API requests hitting the Azure Digital Twins service, the number of messages sent to external endpoints, and the number of query units consumed (service usage).

## Dimensions

Metrics that help identify more details about the metrics. Some of the routing metrics provide information per endpoint. The table below lists possible values for these dimensions.

:::row:::
  :::column:::
    **Dimension**
  :::column-end:::
  :::column:::
    **Values**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication
  :::column-end:::
  :::column:::
    OAuth
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Operation (for API Requests)
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins/digitaltwins/delete,
Microsoft.DigitalTwins/digitaltwins/write,
Microsoft.DigitalTwins/digitaltwins/read,
Microsoft.DigitalTwins/eventroutes/read,
Microsoft.DigitalTwins/eventroutes/write,
Microsoft.DigitalTwins/eventroutes/delete,
Microsoft.DigitalTwins/models/read,
Microsoft.DigitalTwins/models/write,
Microsoft.DigitalTwins/models/delete,
Microsoft.DigitalTwins/query/action
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoint Type
  :::column-end:::
  :::column:::
    Event Grid,
Event Hubs,
Service Bus
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Protocol
  :::column-end:::
  :::column:::
    HTTPS
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Result
  :::column-end:::
  :::column:::
    Success, Failure
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Status Code
  :::column-end:::
  :::column:::
    200, 404, 500, and so on.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Status Code Class
  :::column-end:::
  :::column:::
    2xx, 4xx, 5xx, and so on.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Status Text
  :::column-end:::
  :::column:::
    Internal Server Error, Not Found, and so on.
  :::column-end:::
:::row-end:::
