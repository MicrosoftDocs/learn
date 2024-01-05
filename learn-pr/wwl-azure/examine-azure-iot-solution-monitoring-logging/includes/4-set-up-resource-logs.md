> [!NOTE]
> Resource logs were previously known as diagnostic logs. The name was changed in October 2019 as the types of logs gathered by Azure Monitor shifted to include more than just the Azure resource.

Businesses that implement Azure IoT Hub expect reliable performance from their resources. To help you maintain a close watch on your operations, IoT Hub is fully integrated with Azure Monitor and Azure Resource Health. These two services work to provide you with the data you need to keep your IoT solutions up and running in a healthy state.

Azure Monitor is a single source of monitoring and logging for all your Azure services. You can send the resource logs that Azure Monitor generates to Azure Monitor logs, Event Hubs, or Azure Storage for custom processing. Azure Monitor's metrics and diagnostics settings give you visibility into the performance of your resources. Continue reading this article to learn how to Use Azure Monitor with your IoT hub.

> [!IMPORTANT]
> The events emitted by the IoT Hub service using Azure Monitor resource logs are not guaranteed to be reliable or ordered. Some events might be lost or delivered out of order. Resource logs also aren't meant to be real-time, and it may take several minutes for events to be logged to your choice of destination.

Azure Resource Health helps you diagnose and get support when an Azure issue impacts your resources. A dashboard provides current and past health status for each of your IoT hubs.

## Resource logs and monitoring

Azure Monitor provides diagnostics information for Azure resources, which means that you can monitor operations that take place within your IoT hub. Azure Monitor's diagnostics settings replaces the IoT Hub operations monitor. If you currently use operations monitoring, you should migrate your workflows. For more information, see [Migrate from operations monitoring to diagnostics settings] (https://learn.microsoft.com/azure/iot-hub/iot-hub-migrate-to-diagnostics-settings).

To learn more about the specific metrics and events that Azure Monitor watches, see [Supported metrics with Azure Monitor] (https://learn.microsoft.com/azure/azure-monitor/platform/metrics-supported) and Supported services, schemas, and categories for Azure Diagnostic Logs [https://learn.microsoft.com/azure/azure-monitor/platform/metrics-supported](/azure/azure-monitor/platform/metrics-supported).

Choose where you want to send the logs. You can select any combination of the three options:

 -  Archive to a storage account
 -  Stream to an Event Hubs
 -  Send to Log Analytics

See Azure Monitor pricing: [https://azure.microsoft.com/pricing/details/monitor/](https://azure.microsoft.com/pricing/details/monitor/)

Choose which operations you want to monitor, and enable logs for those operations. The operations that diagnostic settings can report on are:

 -  Connections
 -  DeviceTelemetry
 -  C2DCommands
 -  DeviceIdentityOperations
 -  FileUploadOperations
 -  Routes
 -  D2CTwinOperations
 -  C2DTwinOperations
 -  TwinQueries
 -  JobsOperations
 -  DirectMethods
 -  DistributedTracing
 -  Configurations
 -  DeviceStreams
 -  AllMetrics

If you want to turn on diagnostics settings with PowerShell, use the following code:

```powershell
Connect-AzAccount
Select-AzSubscription -SubscriptionName <subscription that includes your IoT Hub>
Set-AzDiagnosticSetting -ResourceId <your resource Id> -ServiceBusRuleId <your service bus rule Id> -Enabled $true

```

New settings take effect in about 10 minutes. After that, logs appear in the configured archival target on the Diagnostics settings blade.

### Understand the logs

Azure Monitor tracks different operations that occur in IoT Hub. Each category has a schema that defines how events in that category are reported.

#### Connections

The connections category tracks device connect and disconnect events from an IoT hub and errors. This category is useful for identifying unauthorized connection attempts and/or alerting you when the connection to devices is lost.

> [!NOTE]
> For reliable connection status of devices check Device heartbeat.

```json
{
  "records":
  [
        {
            "time": " UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "deviceConnect",
            "category": "Connections",
            "level": "Information",
            "properties": "{\"deviceId\":\"<deviceId>\",\"protocol\":\"<protocol>\",\"authType\":\"{\\\"scope\\\":\\\"device\\\",\\\"type\\\":\\\"sas\\\",\\\"issuer\\\":\\\"iothub\\\",\\\"acceptingIpFilterRule\\\":null}\",\"maskedIpAddress\":\"<maskedIpAddress>\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Cloud-to-device commands

The cloud-to-device commands category tracks errors that occur at the IoT hub and are related to the cloud-to-device message pipeline. This category includes errors that occur from:

 -  Sending cloud-to-device messages (like unauthorized sender errors).
 -  Receiving cloud-to-device messages (like delivery count exceeded errors).
 -  Receiving cloud-to-device message feedback (like feedback expired errors).

This category does not catch errors when the cloud-to-device message is delivered successfully but then improperly handled by the device.

```json
{
    "records":
    [
        {
            "time": " UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "messageExpired",
            "category": "C2DCommands",
            "level": "Error",
            "resultType": "Event status",
            "resultDescription": "MessageDescription",
            "properties": "{\"deviceId\":\"<deviceId>\",\"messageId\":\"<messageId>\",\"messageSizeInBytes\":\"<messageSize>\",\"protocol\":\"Amqp\",\"deliveryAcknowledgement\":\"<None, NegativeOnly, PositiveOnly, Full>\",\"deliveryCount\":\"0\",\"expiryTime\":\"<timestamp>\",\"timeInSystem\":\"<timeInSystem>\",\"ttl\":<ttl>, \"EventProcessedUtcTime\":\"<UTC timestamp>\",\"EventEnqueuedUtcTime\":\"<UTC timestamp>\", \"maskedIpAddress\": \"<maskedIpAddress>\", \"statusCode\": \"4XX\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Device identity operations

The device identity operations category tracks errors that occur when you attempt to create, update, or delete an entry in your IoT hub's identity registry. Tracking this category is useful for provisioning scenarios.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "get",
            "category": "DeviceIdentityOperations",
            "level": "Error",
            "resultType": "Event status",
            "resultDescription": "MessageDescription",
            "properties": "{\"maskedIpAddress\":\"<maskedIpAddress>\",\"deviceId\":\"<deviceId>\", \"statusCode\":\"4XX\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Routes

The message routing category tracks errors that occur during message route evaluation and endpoint health as perceived by IoT Hub. This category includes events such as:

 -  A rule evaluates to "undefined".
 -  IoT Hub marks an endpoint as dead.
 -  Any errors received from an endpoint.

This category does not include specific errors about the messages themselves (like device throttling errors), which are reported under the "device telemetry" category.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "endpointUnhealthy",
            "category": "Routes",
            "level": "Error",
            "properties": "{\"deviceId\": \"<deviceId>\",\"endpointName\":\"<endpointName>\",\"messageId\":<messageId>,\"details\":\"<errorDetails>\",\"routeName\": \"<routeName>\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Device telemetry

The device telemetry category tracks errors that occur at the IoT hub and are related to the telemetry pipeline. This category includes errors that occur when sending telemetry events (such as throttling) and receiving telemetry events (such as unauthorized reader). This category cannot catch errors caused by code running on the device itself.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "ingress",
            "category": "DeviceTelemetry",
            "level": "Error",
            "resultType": "Event status",
            "resultDescription": "MessageDescription",
            "properties": "{\"deviceId\":\"<deviceId>\",\"batching\":\"0\",\"messageSizeInBytes\":\"<messageSizeInBytes>\",\"EventProcessedUtcTime\":\"<UTC timestamp>\",\"EventEnqueuedUtcTime\":\"<UTC timestamp>\",\"partitionId\":\"1\"}",
            "location": "Resource location"
        }
    ]
}

```

#### File upload operations

The file upload category tracks errors that occur at the IoT hub and are related to file upload functionality. This category includes:

 -  Errors that occur with the SAS URI, such as when it expires before a device notifies the hub of a completed upload.
 -  Failed uploads reported by the device.
 -  Errors that occur when a file is not found in storage during IoT Hub notification message creation.

This category cannot catch errors that directly occur while the device is uploading a file to storage.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "ingress",
            "category": "FileUploadOperations",
            "level": "Error",
            "resultType": "Event status",
            "resultDescription": "MessageDescription",
            "durationMs": "1",
            "properties": "{\"deviceId\":\"<deviceId>\",\"protocol\":\"<protocol>\",\"authType\":\"{\\\"scope\\\":\\\"device\\\",\\\"type\\\":\\\"sas\\\",\\\"issuer\\\":\\\"iothub\\\",\\\"acceptingIpFilterRule\\\":null}\",\"blobUri\":\"http//bloburi.com\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Cloud-to-device twin operations

The cloud-to-device twin operations category tracks service-initiated events on device twins. These operations can include get twin, update or replace tags, and update or replace desired properties.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "read",
            "category": "C2DTwinOperations",
            "level": "Information",
            "durationMs": "1",
            "properties": "{\"deviceId\":\"<deviceId>\",\"sdkVersion\":\"<sdkVersion>\",\"messageSize\":\"<messageSize>\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Device-to-cloud twin operations

The device-to-cloud twin operations category tracks device-initiated events on device twins. These operations can include get twin, update reported properties, and subscribe to desired properties.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "update",
            "category": "D2CTwinOperations",
            "level": "Information",
            "durationMs": "1",
            "properties": "{\"deviceId\":\"<deviceId>\",\"protocol\":\"<protocol>\",\"authenticationType\":\"{\\\"scope\\\":\\\"device\\\",\\\"type\\\":\\\"sas\\\",\\\"issuer\\\":\\\"iothub\\\",\\\"acceptingIpFilterRule\\\":null}\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Twin queries

The twin queries category reports on query requests for device twins that are initiated in the cloud.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "query",
            "category": "TwinQueries",
            "level": "Information",
            "durationMs": "1",
            "properties": "{\"query\":\"<twin query>\",\"sdkVersion\":\"<sdkVersion>\",\"messageSize\":\"<messageSize>\",\"pageSize\":\"<pageSize>\", \"continuation\":\"<true, false>\", \"resultSize\":\"<resultSize>\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Jobs operations

The jobs operations category reports on job requests to update device twins or invoke direct methods on multiple devices. These requests are initiated in the cloud.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "jobCompleted",
            "category": "JobsOperations",
            "level": "Information",
            "durationMs": "1",
            "properties": "{\"jobId\":\"<jobId>\", \"sdkVersion\": \"<sdkVersion>\",\"messageSize\": <messageSize>,\"filter\":\"DeviceId IN ['1414ded9-b445-414d-89b9-e48e8c6285d5']\",\"startTimeUtc\":\"Wednesday, September 13, 2017\",\"duration\":\"0\"}",
            "location": "Resource location"
        }
    ]
}

```

#### Direct methods

The direct methods category tracks request-response interactions sent to individual devices. These requests are initiated in the cloud.

```json
{
    "records":
    [
        {
            "time": "UTC timestamp",
            "resourceId": "Resource Id",
            "operationName": "send",
            "category": "DirectMethods",
            "level": "Information",
            "durationMs": "1",
            "properties": "{\"deviceId\":<messageSize>, \"RequestSize\": 1, \"ResponseSize\": 1, \"sdkVersion\": \"2017-07-11\"}",
            "location": "Resource location"
        }
    ]
}

```

### Read logs from Azure Event Hubs

After you set up event logging through diagnostics settings, you can create applications that read out the logs so that you can take action based on the information in them. This sample code retrieves logs from an Event Hubs:

```
class Program
{
    static string connectionString = "{your AMS eventhub endpoint connection string}";
    static string monitoringEndpointName = "{your AMS Event Hubs endpoint name}";
    static EventHubClient eventHubClient;
    //This is the Diagnostic Settings schema
    class AzureMonitorDiagnosticLog
    {
        string time { get; set; }
        string resourceId { get; set; }
        string operationName { get; set; }
        string category { get; set; }
        string level { get; set; }
        string resultType { get; set; }
        string resultDescription { get; set; }
        string durationMs { get; set; }
        string callerIpAddress { get; set; }
        string correlationId { get; set; }
        string identity { get; set; }
        string location { get; set; }
        Dictionary<string, string> properties { get; set; }
    };

    static void Main(string[] args)
    {
        Console.WriteLine("Monitoring. Press Enter key to exit.\n");
        eventHubClient = EventHubClient.CreateFromConnectionString(connectionString, monitoringEndpointName);
        var d2cPartitions = eventHubClient.GetRuntimeInformationAsync().PartitionIds;
        CancellationTokenSource cts = new CancellationTokenSource();
        var tasks = new List<Task>();
        foreach (string partition in d2cPartitions)
        {
            tasks.Add(ReceiveMessagesFromDeviceAsync(partition, cts.Token));
        }
        Console.ReadLine();
        Console.WriteLine("Exiting...");
        cts.Cancel();
        Task.WaitAll(tasks.ToArray());
    }

    private static async Task ReceiveMessagesFromDeviceAsync(string partition, CancellationToken ct)
    {
        var eventHubReceiver = eventHubClient.GetDefaultConsumerGroup().CreateReceiver(partition, DateTime.UtcNow);
        while (true)
        {
            if (ct.IsCancellationRequested)
            {
                await eventHubReceiver.CloseAsync();
                break;
            }
            EventData eventData = await eventHubReceiver.ReceiveAsync(new TimeSpan(0,0,10));
            if (eventData != null)
            {
                string data = Encoding.UTF8.GetString(eventData.GetBytes());
                Console.WriteLine("Message received. Partition: {0} Data: '{1}'", partition, data);
                var deserializer = new JavaScriptSerializer();
                //deserialize json data to azure monitor object
                AzureMonitorDiagnosticLog message = new JavaScriptSerializer().Deserialize<AzureMonitorDiagnosticLog>(result);
            }
        }
    }
}

```

## IoT Hub service health monitoring

Use Azure Resource Health to monitor whether your IoT hub is up and running. You can also learn whether a regional outage is impacting the health of your IoT hub. To understand specific details about the health state of your Azure IoT Hub, we recommend that you use Azure Monitor as described in the previous section.

Azure IoT Hub indicates health at a regional level. If a regional outage impacts your IoT hub, the health status shows as Unknown. To learn more, see [Resource types and health checks in Azure resource health] (https://learn.microsoft.com/azure/service-health/resource-health-checks-resource-types).

To check the health of your IoT hubs, follow these steps:

 -  Sign in to the Azure portal.
 -  Navigate to Service Health &gt; Resource health.
 -  From the drop-down boxes, select your subscription then select IoT Hub as the resource type.

To learn more about how to interpret health data, see [Azure resource health overview] (https://learn.microsoft.com/azure/service-health/resource-health-overview).
