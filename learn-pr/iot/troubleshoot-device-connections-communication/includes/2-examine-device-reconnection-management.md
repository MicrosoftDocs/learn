This page provides high-level guidance to help you design resilient applications by adding a device reconnection strategy. It explains why devices disconnect and need to reconnect. And it describes specific strategies that developers can use to reconnect devices that have been disconnected.

The connectivity and reliable messaging features in Azure IoT device SDKs can help you to design device applications that are more resilient. Applying proper guidance to device-side code can help you to address the following scenarios:

* Fixing a dropped network connection
* Switching between different network connections
* Reconnecting because of service transient connection errors

For information on IoT Hub performance and high availability, including IoT Hub failover, see the following resources:

* [IoT Hub high availability and disaster recovery](/azure/iot-hub/iot-hub-ha-dr)
* [Tutorial: Perform manual failover for an IoT hub](/azure/iot-hub/tutorial-manual-failover)

## What causes disconnections?

The following are the most common reasons that devices disconnect from IoT Hub:

* Expired SAS token or X.509 certificate. The device's SAS token or X.509 authentication certificate expired.
* Network interruption. The device's connection to the network is interrupted.
* Service disruption. The Azure IoT Hub service experiences errors or is temporarily unavailable.
* Service reconfiguration. After you reconfigure IoT Hub service settings, it can cause devices to require reprovisioning or reconnection.

## Why you need a reconnection strategy

It's important to have a strategy to reconnect devices as described in the following sections. Without a reconnection strategy, you could see a negative effect on your solution's performance, availability, and cost.

### Mass reconnection attempts could cause a DDoS

A high number of connection attempts per second can cause a condition similar to a distributed denial-of-service attack (DDoS). This scenario is relevant for large fleets of devices numbering in the millions. The issue can extend beyond the tenant that owns the fleet, and affect the entire scale-unit. A DDoS could drive a large cost increase for your Azure IoT Hub resources, due to a need to scale out. A DDoS could also hurt your solution's performance due to resource starvation. In the worse case, a DDoS can cause service interruption.

### Hub failure or reconfiguration could disconnect many devices

After an IoT hub experiences a failure, or after you reconfigure service settings on an IoT hub, devices might be disconnected. For proper failover, disconnected devices require reprovisioning. To learn more about failover options, see [IoT Hub high availability and disaster recovery](/azure/iot-hub/iot-hub-ha-dr).

### To reprovision many devices can increase costs

After devices disconnect from IoT Hub, the optimal solution is to reconnect the device rather than reprovision it. If you use IoT Hub with IoT Hub Device Provisioning Service (DPS), DPS has a per provisioning cost. If you reprovision many devices on DPS, it increases the cost of your IoT solution.

## Design for resiliency

IoT devices often rely on noncontinuous or unstable network connections (for example, GSM or satellite). Errors can occur when devices interact with cloud-based services because of intermittent service availability and infrastructure-level or transient faults. An application that runs on a device has to manage the mechanisms for connection, reconnection, and the retry logic for sending and receiving messages. Also, the retry strategy requirements depend heavily on the device's IoT scenario, context, and capabilities.

The Azure IoT Hub device SDKs aim to simplify connecting and communicating from cloud-to-device and device-to-cloud. These SDKs provide a robust way to connect to Azure IoT Hub and a comprehensive set of options for sending and receiving messages. Developers can also modify existing implementation to customize a better retry strategy for a given scenario.

The relevant SDK features that support connectivity and reliable messaging are available in the following IoT Hub device SDKs. For more information, see the API documentation or specific SDK:

* [C SDK](https://github.com/Azure/azure-iot-sdk-c/blob/main/doc/connection_and_messaging_reliability.md)

* [.NET SDK](https://github.com/Azure/azure-iot-sdk-csharp/blob/main/iothub/device/devdoc/retrypolicy.md)

* [Java SDK](https://github.com/Azure/azure-iot-sdk-java/blob/main/iothub/device/iot-device-client/devdoc/requirement_docs/com/microsoft/azure/iothub/retryPolicy.md)

* [Node SDK](https://github.com/Azure/azure-iot-sdk-node/wiki/Connectivity-and-Retries)

* [Python SDK](https://github.com/Azure/azure-iot-sdk-python)

The following sections describe SDK features that support connectivity.

## Connection and retry

This section gives an overview of the reconnection and retry patterns available when managing connections. It details implementation guidance for using a different retry policy in your device application and lists relevant APIs from the device SDKs.

### Error patterns

Connection failures can happen at many levels:

* Network errors including disconnected socket and name resolution errors
* Protocol-level errors for HTTP, AMQP, and MQTT transport including detached links or expired sessions
* Application-level errors that result from either local mistakes including invalid credentials or service behavior (for example, exceeding the quota or throttling)

The device SDKs detect errors at all three levels. However, device SDKs don't detect and handle OS-related errors and hardware errors. The SDK design is based on The [Transient Fault Handling Guidance](/azure/architecture/best-practices/transient-faults#general-guidelines) from the Azure Architecture Center.

### Retry patterns

The following steps describe the retry process when connection errors are detected:

1. The SDK detects the error and any associated errors in the network, protocol, or application.
1. The SDK uses the error filter to determine the error type and decide if a retry is needed.
1. If the SDK identifies an **unrecoverable error**, operations like connection, send, and receive are stopped. The SDK notifies the user. Examples of unrecoverable errors include an authentication error and a bad endpoint error.
1. If the SDK identifies a **recoverable error**, it retries according to the specified retry policy until the defined timeout elapses. The SDK uses **Exponential back-off with jitter** retry policy by default.
1. When the defined timeout expires, the SDK stops trying to connect or send. It notifies the user.
1. The SDK allows the user to attach a callback to receive connection status changes.

The SDKs provide three retry policies:

* **Exponential back-off with jitter**: This default retry policy tends to be aggressive at the start and slow down over time until it reaches a maximum delay. The design is based on [Retry guidance from Azure Architecture Center](/azure/architecture/best-practices/retry-service-specific).
* **Custom retry**: For some SDK languages, you can design a custom retry policy that is better suited for your scenario and then inject it into the RetryPolicy. Custom retry isn't available in the C or Python SDK. The Python SDK reconnects as-needed.
* **No retry**: You can set retry policy to "no retry," which disables the retry logic. The SDK tries to connect once and send a message once, assuming the connection is established. This policy is typically used in scenarios with bandwidth or cost concerns. If you choose this option, messages that fail to send are lost and can't be recovered.

### Retry policy APIs

:::row:::
  :::column:::
    **SDK**
  :::column-end:::
  :::column:::
    **SetRetryPolicy method**
  :::column-end:::
  :::column:::
    **Policy implementations**
  :::column-end:::
  :::column:::
    **Implementation guidance**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    IOTHUB\_CLIENT\_RESULT IoTHubClient\_SetRetryPolicy
  :::column-end:::
  :::column:::
    IOTHUB_CLIENT_RETRY_POLICY
  :::column-end:::
  :::column:::
    [C implementation](https://www.github.com/Azure/azure-iot-sdk-c/blob/master/doc/connection_and_messaging_reliability.md)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Java
  :::column-end:::
  :::column:::
    SetRetryPolicy
  :::column-end:::
  :::column:::
    Default: ExponentialBackoffWithJitter class
Custom: implement RetryPolicy interface
No retry: NoRetry class
  :::column-end:::
  :::column:::
    [Java implementation](https://www.github.com/Azure/azure-iot-sdk-java/blob/main/iothub/device/iot-device-client/devdoc/requirement_docs/com/microsoft/azure/iothub/retryPolicy.md)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    .NET
  :::column-end:::
  :::column:::
    DeviceClient.SetRetryPolicy
  :::column-end:::
  :::column:::
    Default: ExponentialBackoff class
Custom: implement IRetryPolicy interface
No retry: NoRetry class
  :::column-end:::
  :::column:::
    [C\# implementation](https://www.github.com/Azure/azure-iot-sdk-csharp/blob/main/iothub/device/devdoc/retrypolicy.md)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Node
  :::column-end:::
  :::column:::
    setRetryPolicy
  :::column-end:::
  :::column:::
    Default: ExponentialBackoffWithJitter class
Custom: implement RetryPolicy interface
No retry: NoRetry class
  :::column-end:::
  :::column:::
    [Node implementation](https://www.github.com/Azure/azure-iot-sdk-node/wiki/Connectivity-and-Retries)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Python
  :::column-end:::
  :::column:::
    Not currently supported
  :::column-end:::
  :::column:::
    Not currently supported
  :::column-end:::
  :::column:::
    Built-in connection retries: Dropped connections are retried with a fixed 10-second interval by default. This functionality can be disabled if desired, and the interval can be configured.
  :::column-end:::
:::row-end:::

The following code samples illustrate this flow.

#### .NET implementation guidance

The following code sample shows how to define and set the default retry policy:

```csharp
// define/set default retry policy
IRetryPolicy retryPolicy = new ExponentialBackoff(int.MaxValue, TimeSpan.FromMilliseconds(100), TimeSpan.FromSeconds(10), TimeSpan.FromMilliseconds(100));
SetRetryPolicy(retryPolicy);
```

To avoid high CPU usage, the retries are throttled if the code fails immediately. For example, when there's no network or route to the destination. The minimum time to execute the next retry is 1 second.

If the service responds with a throttling error, the retry policy is different and can't be changed via public API:

```csharp
// throttled retry policy
IRetryPolicy retryPolicy = new ExponentialBackoff(RetryCount, TimeSpan.FromSeconds(10), 
  TimeSpan.FromSeconds(60), TimeSpan.FromSeconds(5)); SetRetryPolicy(retryPolicy);
```

The retry mechanism stops after DefaultOperationTimeoutInMilliseconds, which is currently set at 4 minutes.

## Hub reconnection flow

If you use IoT Hub only without DPS, use the following reconnection strategy.

When a device fails to connect to IoT Hub, or is disconnected from IoT Hub:

1. Use an exponential back-off with jitter delay function.
1. Reconnect to IoT Hub.

The following diagram summarizes the reconnection flow.

:::image type="content" source="../media/connect-retry-iot-hub.png" alt-text="Diagram showing the reconnection flow.":::

## Hub with DPS reconnection flow

If you use IoT Hub with DPS, use the following reconnection strategy.

When a device fails to connect to IoT Hub, or is disconnected from IoT Hub, reconnect based on the following cases.

:::row:::
  :::column:::
    **Reconnection scenario**
  :::column-end:::
  :::column:::
    **Reconnection strategy**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    For errors that allow connection retries (HTTP response code 500)
  :::column-end:::
  :::column:::
    Use an exponential back-off with jitter delay function.
    Reconnect to IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    For errors that indicate a retry is possible, but reconnection failed 10 consecutive times
  :::column-end:::
  :::column:::
    Reprovision the device to DPS.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    For errors that don't allow connection retries (HTTP responses 401, Unauthorized or 403, Forbidden or 404, Not Found)
  :::column-end:::
  :::column:::
    Reprovision the device to DPS.
  :::column-end:::
:::row-end:::

The following diagram summarizes the reconnection flow.

:::image type="content" source="../media/connect-retry-iot-hub-with-dps.png" alt-text="Diagram showing the reconnection flow with DPS.":::
