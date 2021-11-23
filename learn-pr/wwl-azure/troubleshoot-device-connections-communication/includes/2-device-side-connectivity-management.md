The connectivity and reliable messaging features in Azure IoT device SDKs can help you to design device applications that are more resilient.

Applying proper guidance to device-side code can help you to address the following scenarios:

 -  Fixing a dropped network connection
 -  Switching between different network connections
 -  Reconnecting because of service transient connection errors

## Designing for resiliency

IoT devices often rely on non-continuous or unstable network connections (for example, GSM or satellite). Errors can occur when devices interact with cloud-based services because of intermittent service availability and infrastructure-level or transient faults. An application that runs on a device has to manage the mechanisms for connection, reconnection, and the retry logic for sending and receiving messages. Also, the retry strategy requirements depend heavily on the device's IoT scenario, context, capabilities.

The Azure IoT Hub device SDKs aim to simplify connecting and communicating from cloud-to-device and device-to-cloud. These SDKs provide a robust way to connect to Azure IoT Hub and a comprehensive set of options for sending and receiving messages. Developers can also modify existing implementation to customize a better retry strategy for a given scenario.

## Connection and retry

This section gives an overview of the reconnection and retry patterns available when managing connections. It details implementation guidance for using a different retry policy in your device application and lists relevant APIs from the device SDKs.

### Error patterns

Connection failures can happen at many levels:

 -  Network errors: disconnected socket and name resolution errors
 -  Protocol-level errors for HTTP, AMQP, and MQTT transport: detached links or expired sessions
 -  Application-level errors that result from either local mistakes: invalid credentials or service behavior (for example, exceeding the quota or throttling)

The device SDKs detect errors at all three levels. OS-related errors and hardware errors are not detected and handled by the device SDKs.

### Retry patterns

The following steps describe the retry process when connection errors are detected:

1.  The SDK detects the error and the associated error in the network, protocol, or application.
2.  The SDK uses the error filter to determine the error type and decide if a retry is needed.
3.  If the SDK identifies an unrecoverable error, operations like connection, send, and receive are stopped. The SDK notifies the user. Examples of unrecoverable errors include an authentication error and a bad endpoint error.
4.  If the SDK identifies a recoverable error, it retries according to the specified retry policy until the defined timeout elapses. The SDK uses Exponential back-off with jitter retry policy by default.
5.  When the defined timeout expires, the SDK stops trying to connect or send. It notifies the user.
6.  The SDK allows the user to attach a callback to receive connection status changes.

The SDKs provide three retry policies:

 -  Exponential back-off with jitter: This default retry policy tends to be aggressive at the start and slow down over time until it reaches a maximum delay. The design is based on Retry guidance from Azure Architecture Center.
 -  Custom retry: For some SDK languages, you can design a custom retry policy that is better suited for your scenario and then inject it into the RetryPolicy. Custom retry isn't available on the C SDK.
 -  No retry: You can set retry policy to "no retry," which disables the retry logic. The SDK tries to connect once and send a message once, assuming the connection is established. This policy is typically used in scenarios with bandwidth or cost concerns. If you choose this option, messages that fail to send are lost and can't be recovered.

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
    C/iOS
  :::column-end:::
  :::column:::
    IOTHUB\_CLIENT\_RESULT IoTHubClient\_SetRetryPolicy
  :::column-end:::
  :::column:::
    Default: IOTHUB\_CLIENT\_RETRY\_EXPONENTIAL\_BACKOFF
Custom: use available retryPolicy
No retry: IOTHUB\_CLIENT\_RETRY\_NONE
  :::column-end:::
  :::column:::
    C/iOS implementation
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
    Java implementation
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
    C\# implementation
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
    Node implementation
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Python
  :::column-end:::
  :::column:::
    Coming soon
  :::column-end:::
  :::column:::
    Coming soon
  :::column-end:::
  :::column:::
    Coming soon
  :::column-end:::
:::row-end:::


The following C\# code samples illustrate this flow:

#### .NET implementation guidance

The following code sample shows how to define and set the default retry policy:

```
// define/set default retry policy
IRetryPolicy retryPolicy = new ExponentialBackoff(int.MaxValue, TimeSpan.FromMilliseconds(100), TimeSpan.FromSeconds(10), TimeSpan.FromMilliseconds(100));
SetRetryPolicy(retryPolicy);

```

To avoid high CPU usage, the retries are throttled if the code fails immediately. For example, when there's no network or route to the destination. The minimum time to execute the next retry is 1 second.

If the service responds with a throttling error, the retry policy is different and can't be changed via public API:

```
// throttled retry policy
IRetryPolicy retryPolicy = new ExponentialBackoff(RetryCount, TimeSpan.FromSeconds(10), 
  TimeSpan.FromSeconds(60), TimeSpan.FromSeconds(5)); SetRetryPolicy(retryPolicy);

```

The retry mechanism stops after DefaultOperationTimeoutInMilliseconds, which is currently set at 4 minutes.
