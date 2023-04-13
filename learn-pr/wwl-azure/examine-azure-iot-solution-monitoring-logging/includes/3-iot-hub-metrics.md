IoT Hub metrics provide you with access to data that describes the state of the Azure IoT resources in your Azure subscription. IoT Hub metrics enable you to assess the overall health of the IoT Hub service and provide information related to device connections and device twins. User-facing statistics are important because they help you see what is going on with your IoT hub and help root-cause issues without needing to contact Azure support.

Metrics are enabled by default.

> [!NOTE]
> You can use IoT Hub metrics to view information about IoT Plug and Play devices connected to your IoT Hub. IoT Plug and Play devices are part of the IoT Plug and Play public preview.

## How to view IoT Hub metrics

On the Overview blade of your IoT hub, select **Metrics**.

:::image type="content" source="../media/m09-l01-monitoring-logging-enable-metrics-1-ad5cfc68.png" alt-text="Screenshot that shows where to find metrics for IoT Hub using the Azure portal.":::


On the Metrics blade, you can view the metrics for your IoT hub and create custom views of your metrics.

:::image type="content" source="../media/m09-l01-monitoring-logging-enable-metrics-2-ce3e10af.png" alt-text="Screenshot that shows how to view the metrics for IoT Hub.":::


To send your metrics data to an Event Hubs endpoint or an Azure Storage account, select**Diagnostics settings**, then select **Add diagnostic setting**.

## IoT Hub metrics and how to use them

IoT Hub provides metrics that give you an overview of the health of your hub, the total number of connected devices, and metrics that give you specific details related to key operations. You can combine information from multiple metrics to paint a bigger picture of the state of the IoT hub.

The following tables provide a partial listing of the metrics that each IoT hub tracks, and describe how each of the metric listed relates to the overall status of the IoT hub. You can also find a single table that lists all of the IoT Hub platform metrics by metric name under Microsoft.Devices/IotHubs in the Azure Monitor documentation here: [Supported metrics with Azure Monitor](/azure/azure-monitor/essentials/metrics-supported).

### D2C telemetry ingress and egress

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    d2c.telemetry.ingress.allProtocol
  :::column-end:::
  :::column:::
    Telemetry message send attempts
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of device-to-cloud telemetry messages attempted to be sent to your IoT hub.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.telemetry.ingress.success
  :::column-end:::
  :::column:::
    Telemetry messages sent
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of device-to-cloud telemetry messages sent successfully to your IoT hub.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.telemetry.ingress.sendThrottle
  :::column-end:::
  :::column:::
    Number of throttling errors
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of throttling errors due to device throughput throttles.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::


### C2D commands and methods

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    c2d.commands.egress.complete.success
  :::column-end:::
  :::column:::
    Commands completed
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of cloud-to-device commands completed successfully by the device.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.commands.egress.abandon.success
  :::column-end:::
  :::column:::
    Commands abandoned
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of cloud-to-device commands abandoned by the device.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.commands.egress.reject.success
  :::column-end:::
  :::column:::
    Commands rejected
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of cloud-to-device commands rejected by the device.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.methods.success
  :::column-end:::
  :::column:::
    Successful direct method invocations
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful direct method calls.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.methods.failure
  :::column-end:::
  :::column:::
    Failed direct method invocations
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed direct method calls.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.methods.requestSize
  :::column-end:::
  :::column:::
    Request size of direct method invocations
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max of all successful direct method requests.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.methods.responseSize
  :::column-end:::
  :::column:::
    Response size of direct method invocations
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max of all successful direct method responses.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::


### Hub and devices

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    dailyMessageQuotaUsed
  :::column-end:::
  :::column:::
    Total number of messages used
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    Number of total messages used today. This is a cumulative value that is reset to zero at 00:00 UTC every day.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deviceDataUsagedeviceDataUsageV2
  :::column-end:::
  :::column:::
    Total device data usage
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Bytes transferred to and from any devices connected to IotHub
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    totalDeviceCount
  :::column-end:::
  :::column:::
    Total devices (preview)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    Number of devices registered to your IoT hub
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    connectedDeviceCount
  :::column-end:::
  :::column:::
    Connected devices (preview)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    Number of devices connected to your IoT hub
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    devices.totalDevices
  :::column-end:::
  :::column:::
    Total devices (deprecated)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of devices registered to your IoT hub
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    devices.connectedDevices.allProtocol
  :::column-end:::
  :::column:::
    Connected devices (deprecated)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    Number of devices connected to your IoT hub
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::


### D2C endpoints

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    d2c.endpoints.egress.eventHubs
  :::column-end:::
  :::column:::
    Routing: messages delivered to Event Hubs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing successfully delivered messages to Event Hubs endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.latency.eventHubs
  :::column-end:::
  :::column:::
    Routing: message latency for Event Hubs
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) between message ingress to IoT Hub and message ingress into an Event Hubs endpoint.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.serviceBusQueues
  :::column-end:::
  :::column:::
    Routing: messages delivered to Service Bus Queue
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing successfully delivered messages to Service Bus queue endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.latency.serviceBusQueues
  :::column-end:::
  :::column:::
    Routing: message latency for Service Bus Queue
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) between message ingress to IoT Hub and telemetry message ingress into a Service Bus queue endpoint.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.serviceBusTopics
  :::column-end:::
  :::column:::
    Routing: messages delivered to Service Bus Topic
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing successfully delivered messages to Service Bus topic endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.latency.serviceBusTopics
  :::column-end:::
  :::column:::
    Routing: message latency for Service Bus Topic
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) between message ingress to IoT Hub and telemetry message ingress into a Service Bus topic endpoint.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.builtIn.events
  :::column-end:::
  :::column:::
    Routing: messages delivered to messages/events
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing successfully delivered messages to the built-in endpoint (messages/events). This metric only starts working when routing is enabled for the IoT hub.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.latency.builtIn.events
  :::column-end:::
  :::column:::
    Routing: message latency for messages/events
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) between message ingress to IoT Hub and telemetry message ingress into the built-in endpoint (messages/events). This metric only starts working when routing is enabled for the IoT hub.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.storage
  :::column-end:::
  :::column:::
    Routing: messages delivered to storage
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing successfully delivered messages to storage endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.latency.storage
  :::column-end:::
  :::column:::
    Routing: message latency for storage
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) between message ingress to IoT Hub and telemetry message ingress into a storage endpoint.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.storage.bytes
  :::column-end:::
  :::column:::
    Routing: data delivered to storage
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The amount of data (bytes) IoT Hub routing delivered to storage endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.endpoints.egress.storage.blobs
  :::column-end:::
  :::column:::
    Routing: blobs delivered to storage
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of times IoT Hub routing delivered blobs to storage endpoints.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::


### Event Grid

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    EventGridDeliveries
  :::column-end:::
  :::column:::
    Event Grid deliveries (preview)
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The number of IoT Hub events published to Event Grid. Use the Result dimension for the number of successful and failed requests. EventType dimension shows the type of event. To see where the requests come from, use the EventType dimension.
  :::column-end:::
  :::column:::
    Result, EventType
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventGridLatency
  :::column-end:::
  :::column:::
    Event Grid latency (preview)
  :::column-end:::
  :::column:::
    Milliseconds
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average latency (milliseconds) from when the Iot Hub event was generated to when the event was published to Event Grid. This number is an average between all event types. Use the EventType dimension to see latency of a specific type of event.
  :::column-end:::
  :::column:::
    EventType
  :::column-end:::
:::row-end:::


### Device twins

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    d2c.twin.read.success
  :::column-end:::
  :::column:::
    Successful twin reads from devices
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful device-initiated twin reads.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.twin.read.failure
  :::column-end:::
  :::column:::
    Failed twin reads from devices
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed device-initiated twin reads.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.twin.read.size
  :::column-end:::
  :::column:::
    Response size of twin reads from devices
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max of all successful device-initiated twin reads.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.twin.update.success
  :::column-end:::
  :::column:::
    Successful twin updates from devices
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful device-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.twin.update.failure
  :::column-end:::
  :::column:::
    Failed twin updates from devices
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed device-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    d2c.twin.update.size
  :::column-end:::
  :::column:::
    Size of twin updates from devices
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max size of all successful device-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.read.success
  :::column-end:::
  :::column:::
    Successful twin reads from back end
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful back-end-initiated twin reads. This count doesn't include twin reads initiated from twin queries.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.read.failure
  :::column-end:::
  :::column:::
    Failed twin reads from back end
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed back-end-initiated twin reads.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.read.size
  :::column-end:::
  :::column:::
    Response size of twin reads from back end
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max of all successful back-end-initiated twin reads.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.update.success
  :::column-end:::
  :::column:::
    Successful twin updates from back end
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful back-end-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.update.failure
  :::column-end:::
  :::column:::
    Failed twin updates from back end
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed back-end-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    c2d.twin.update.size
  :::column-end:::
  :::column:::
    Size of twin updates from back end
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max size of all successful back-end-initiated twin updates.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    twinQueries.success
  :::column-end:::
  :::column:::
    Successful twin queries
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful twin queries.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    twinQueries.failure
  :::column-end:::
  :::column:::
    Failed twin queries
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed twin queries.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    twinQueries.resultSize
  :::column-end:::
  :::column:::
    Twin queries result size
  :::column-end:::
  :::column:::
    Bytes
  :::column-end:::
  :::column:::
    Average
  :::column-end:::
  :::column:::
    The average, min, and max of the result size of all successful twin queries.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::


### IoT Hub jobs

:::row:::
  :::column:::
    **Metric**
  :::column-end:::
  :::column:::
    **Metric Display Name**
  :::column-end:::
  :::column:::
    **Unit**
  :::column-end:::
  :::column:::
    **Aggregation Type**
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
    jobs.createTwinUpdateJob.success
  :::column-end:::
  :::column:::
    Successful creations of twin update jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful creation of twin update jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.createTwinUpdateJob.failure
  :::column-end:::
  :::column:::
    Failed creations of twin update jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed creation of twin update jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.createDirectMethodJob.success
  :::column-end:::
  :::column:::
    Successful creations of method invocation jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful creation of direct method invocation jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.createDirectMethodJob.failure
  :::column-end:::
  :::column:::
    Failed creations of method invocation jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed creation of direct method invocation jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.listJobs.success
  :::column-end:::
  :::column:::
    Successful calls to list jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful calls to list jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.listJobs.failure
  :::column-end:::
  :::column:::
    Failed calls to list jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed calls to list jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.cancelJob.success
  :::column-end:::
  :::column:::
    Successful job cancellations
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful calls to cancel a job.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.cancelJob.failure
  :::column-end:::
  :::column:::
    Failed job cancellations
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed calls to cancel a job.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.queryJobs.success
  :::column-end:::
  :::column:::
    Successful job queries
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all successful calls to query jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.queryJobs.failure
  :::column-end:::
  :::column:::
    Failed job queries
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed calls to query jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.completed
  :::column-end:::
  :::column:::
    Completed jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all completed jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobs.failed
  :::column-end:::
  :::column:::
    Failed jobs
  :::column-end:::
  :::column:::
    Count
  :::column-end:::
  :::column:::
    Total
  :::column-end:::
  :::column:::
    The count of all failed jobs.
  :::column-end:::
  :::column:::
    No Dimensions
  :::column-end:::
:::row-end:::