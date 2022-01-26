By default, messages are routed to the built-in service-facing endpoint (messages/events) which is compatible with Event Hubs. This endpoint is currently only exposed using the AMQP protocol on port 5671. An IoT hub exposes the following properties to enable you to control the built-in endpoint.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partition count
  :::column-end:::
  :::column:::
    Set this property at creation to define the number of partitions for device-to-cloud event ingestion.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Retention time
  :::column-end:::
  :::column:::
    This property specifies how long in days messages are retained by IoT Hub. The default is one day, but it can be increased to seven days.
  :::column-end:::
:::row-end:::


IoT Hub allows data retention in the built-in endpoint for a maximum of 7 days. You can set the retention time during creation of your IoT Hub. Data retention time in IoT Hub depends on your IoT hub tier and unit type. In terms of size, the built-in Event Hubs endpoint can retain messages of the maximum message size up to at least 24 hours of quota. For example, for 1 S1 unit IoT Hub provides enough storage to retain at least 400K messages of 4k size each. If your devices are sending smaller messages, they may be retained for longer (up to 7 days) depending on how much storage is consumed. We guarantee retaining the data for the specified retention time as a minimum.

IoT Hub also enables you to manage consumer groups on the built-in device-to-cloud receive endpoint. You can have up to 20 consumer groups for each IoT Hub.

If you're using message routing and the fallback route is enabled, all messages that don't match a query on any route go to the built-in endpoint. If you disable this fallback route, messages that don't match any query are dropped.

You can modify the retention time, either programmatically using the IoT Hub resource provider REST APIs, or with the Azure portal.

IoT Hub exposes the messages/events built-in endpoint for your back-end services to read the device-to-cloud messages received by your hub. This endpoint is Event Hubs-compatible, which enables you to use any of the mechanisms the Event Hubs service supports for reading messages.

## Accessing the Built-in endpoint

Some product integrations and Event Hubs SDKs are aware of IoT Hub and let you use your IoT hub service connection string to connect to the built-in endpoint.

When you use Event Hubs SDKs or product integrations that are unaware of IoT Hub, you need an Event Hubs-compatible endpoint and Event Hubs-compatible name. You can retrieve these values from IoT hub service in the Azure portal by opening the **Built-in endpoints** blade.

The Events section contains the following values: Partitions, Event Hubs-compatible name, Event Hubs-compatible endpoint, Retention time, and Consumer groups.

:::image type="content" source="../media/m04-l02-built-in-endpoints-event-hub-compatible-5d025c6e.png" alt-text="Screenshot that shows the Events section for the Built-in endpoint properties for IoT hub.":::


In the portal, the Event Hubs-compatible endpoint field contains a complete Event Hubs connection string that looks like: `Endpoint=sb://abcd1234namespace.servicebus.windows.net/;SharedAccessKeyName=iothubowner;SharedAccessKey=keykeykeykeykeykey=;EntityPath=iothub-ehub-abcd-1234-123456`. If the SDK you're using requires other values, then they would be:

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoint
  :::column-end:::
  :::column:::
    sb://abcd1234namespace.servicebus.windows.net/
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Hostname
  :::column-end:::
  :::column:::
    abcd1234namespace.servicebus.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Namespace
  :::column-end:::
  :::column:::
    abcd1234namespace
  :::column-end:::
:::row-end:::


You can then use any shared access policy that has the ServiceConnect permissions to connect to the specified Event Hubs.

The SDKs you can use to connect to the built-in Event Hubs-compatible endpoint that IoT Hub exposes include:

:::row:::
  :::column:::
    **Language**
  :::column-end:::
  :::column:::
    **SDK**
  :::column-end:::
  :::column:::
    **Example**
  :::column-end:::
  :::column:::
    **Notes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    .NET
  :::column-end:::
  :::column:::
    [.NET SDK link](https://github.com/Azure/azure-event-hubs-dotnet)
  :::column-end:::
  :::column:::
    [Quickstart](/azure/iot-develop/quickstart-send-telemetry-iot-hub?pivots=programming-language-csharp)
  :::column-end:::
  :::column:::
    Uses Event Hubs-compatible information
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Java
  :::column-end:::
  :::column:::
    [Java SDK link](https://mvnrepository.com/artifact/com.azure/azure-messaging-eventhubs)
  :::column-end:::
  :::column:::
    [Quickstart](/azure/iot-develop/quickstart-send-telemetry-iot-hub?pivots=programming-language-java)
  :::column-end:::
  :::column:::
    Uses Event Hubs-compatible information
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Node.js
  :::column-end:::
  :::column:::
    [Node.js SDK link](https://www.npmjs.com/package/@azure/event-hubs)
  :::column-end:::
  :::column:::
    [Quickstart](/azure/iot-develop/quickstart-send-telemetry-iot-hub?pivots=programming-language-nodejs)
  :::column-end:::
  :::column:::
    Uses IoT Hub connection string
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Python
  :::column-end:::
  :::column:::
    [Python SDK link](https://pypi.org/project/azure-eventhub/)
  :::column-end:::
  :::column:::
    [Quickstart](/azure/iot-develop/quickstart-send-telemetry-iot-hub?pivots=programming-language-python)
  :::column-end:::
  :::column:::
    Uses IoT Hub connection string
  :::column-end:::
:::row-end:::


The product integrations you can use with the built-in Event Hubs-compatible endpoint that IoT Hub exposes include:

 -  Azure Functions.
 -  Azure Stream Analytics.
 -  Time Series Insights.
 -  Apache Storm spout.
 -  Apache Spark integration.
 -  Azure Databricks.
