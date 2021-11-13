It is important to separate IoT Hub service limits from performance issues when monitoring an IoT solution.

Each IoT hub is provisioned with one or more units in a specific tier. The tier and number of units determine the maximum daily quota of messages that you can send. The message size used to calculate the daily quota is 0.5 KB for a free tier hub and 4KB for all other tiers.

The tier also determines the throttling limits that IoT Hub enforces on all operations.

## Operation throttles

Operation throttles are rate limitations that are applied in minute ranges and are intended to prevent abuse. They're also subject to traffic shaping.

The following table shows the enforced throttles. Values refer to an individual hub.

:::row:::
  :::column:::
    **Throttle**
  :::column-end:::
  :::column:::
    **Free, B1, and S1**
  :::column-end:::
  :::column:::
    **B2 and S2**
  :::column-end:::
  :::column:::
    **B3 and S3**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Identity registry operations (create, retrieve, list, update, delete)
  :::column-end:::
  :::column:::
    1.67/sec/unit (100/min/unit)
  :::column-end:::
  :::column:::
    1.67/sec/unit (100/min/unit)
  :::column-end:::
  :::column:::
    83.33/sec/unit (5,000/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    New device connections (this limit applies to the rate of new connections, not the total number of connections)
  :::column-end:::
  :::column:::
    Higher of 100/sec or 12/sec/unit

For example, two S1 units are 2\*12 = 24 new connections/sec, but you have at least 100 new connections/sec across your units. With nine S1 units, you have 108 new connections/sec (9\*12) across your units.
  :::column-end:::
  :::column:::
    120 new connections/sec/unit.
  :::column-end:::
  :::column:::
    6,000 new connections/sec/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device-to-cloud sends
  :::column-end:::
  :::column:::
    Higher of 100 send operations/sec or 12 send operations/sec/unit

For example, two S1 units are 2\*12 = 24/sec, but you have at least 100 send operations/sec across your units. With nine S1 units, you have 108 send operations/sec (9\*12) across your units.
  :::column-end:::
  :::column:::
    120 send operations/sec/unit.
  :::column-end:::
  :::column:::
    6,000 send operations/sec/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device sends \*
  :::column-end:::
  :::column:::
    1.67 send operations/sec/unit (100 messages/min/unit)
  :::column-end:::
  :::column:::
    1.67 send operations/sec/unit (100 send operations/min/unit).
  :::column-end:::
  :::column:::
    83.33 send operations/sec/unit (5,000 send operations/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device receives \*
(only when device uses HTTPS)
  :::column-end:::
  :::column:::
    16.67 receive operations/sec/unit (1,000 receive operations/min/unit)
  :::column-end:::
  :::column:::
    16.67 receive operations/sec/unit (1,000 receive operations/min/unit).
  :::column-end:::
  :::column:::
    833.33 receive operations/sec/unit (50,000 receive operations/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    File upload
  :::column-end:::
  :::column:::
    1.67 file upload initiations/sec/unit (100/min/unit)
  :::column-end:::
  :::column:::
    1.67 file upload initiations/sec/unit (100/min/unit).
  :::column-end:::
  :::column:::
    83.33 file upload initiations/sec/unit (5,000/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Direct methods \*
  :::column-end:::
  :::column:::
    160KB/sec/unit \*\*
  :::column-end:::
  :::column:::
    480KB/sec/unit \*\*
  :::column-end:::
  :::column:::
    24MB/sec/unit \*\*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queries
  :::column-end:::
  :::column:::
    20/min/unit
  :::column-end:::
  :::column:::
    20/min/unit
  :::column-end:::
  :::column:::
    1,000/min/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twin (device and module) reads \*
  :::column-end:::
  :::column:::
    100/sec
  :::column-end:::
  :::column:::
    Higher of 100/sec or 10/sec/unit.
  :::column-end:::
  :::column:::
    500/sec/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twin updates (device and module) \*
  :::column-end:::
  :::column:::
    50/sec
  :::column-end:::
  :::column:::
    Higher of 50/sec or 5/sec/unit.
  :::column-end:::
  :::column:::
    250/sec/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Jobs operations \*
(create, update, list, delete)
  :::column-end:::
  :::column:::
    1.67/sec/unit (100/min/unit)
  :::column-end:::
  :::column:::
    1.67/sec/unit (100/min/unit)
  :::column-end:::
  :::column:::
    83.33/sec/unit (5,000/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Jobs device operations \*
(update twin, invoke direct method)
  :::column-end:::
  :::column:::
    10/sec
  :::column-end:::
  :::column:::
    Higher of 10/sec or 1/sec/unit
  :::column-end:::
  :::column:::
    50/sec/unit
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configurations and edge deployments \*
(create, update, list, delete)
  :::column-end:::
  :::column:::
    0.33/sec/unit (20/min/unit)
  :::column-end:::
  :::column:::
    0.33/sec/unit (20/min/unit)
  :::column-end:::
  :::column:::
    0.33/sec/unit (20/min/unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device stream initiation rate \*
  :::column-end:::
  :::column:::
    5 new streams/sec
  :::column-end:::
  :::column:::
    5 new streams/sec
  :::column-end:::
  :::column:::
    5 new streams/sec
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Maximum number of concurrently connected device streams \*
  :::column-end:::
  :::column:::
    50
  :::column-end:::
  :::column:::
    50
  :::column-end:::
  :::column:::
    50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Maximum device stream data transfer1 (aggregate volume per day)
  :::column-end:::
  :::column:::
    300 MB
  :::column-end:::
  :::column:::
    300 MB
  :::column-end:::
  :::column:::
    300 MB
  :::column-end:::
:::row-end:::


\* This feature is not available in the basic tier of IoT Hub.

\*\* Throttling meter size is 4 KB.

### Throttling details

 -  The meter size determines at what increments your throttling limit is consumed. If your direct call's payload is between 0 and 4 KB, it is counted as 4 KB. You can make up to 40 calls per second per unit before hitting the limit of 160 KB/sec/unit. Similarly, if your payload is between 4 KB and 8 KB, each call accounts for 8 KB and you can make up to 20 calls per second per unit before hitting the max limit. Finally, if your payload size is between 156KB and 160 KB, you'll be able to make only 1 call per second per unit in your hub before hitting the limit of 160 KB/sec/unit.
 -  For Jobs device operations (update twin, invoke direct method) for tier S3, 50/sec/unit only applies to when you invoke methods using jobs. If you invoke direct methods directly, the original throttling limit of 24 MB/sec/unit (for S3) applies.
 -  Quota is the aggregate number of messages you can send in your hub per day. You can find your hub's quota limit under the column Total number of messages /day on the IoT Hub pricing page.
 -  Your cloud-to-device and device-to-cloud throttles determine the maximum rate at which you can send messages -- number of messages irrespective of 4 KB chunks. Each message can be up to 256 KB, which is the maximum message size.

It's a good practice to throttle your calls so that you don't hit/exceed the throttling limits. If you do hit the limit, IoT Hub responds with error code 429 and the client should back-off and retry. These limits are per hub (or in some cases per hub/unit).

### Traffic shaping

To accommodate burst traffic, IoT Hub accepts requests above the throttle for a limited time. The first few of these requests are processed immediately. However, if the number of requests continues violate the throttle, IoT Hub starts placing the requests in a queue and processed at the limit rate. This effect is called traffic shaping. Furthermore, the size of this queue is limited. If the throttle violation continues, eventually the queue fills up, and IoT Hub starts rejecting requests with `429 ThrottlingException`.

For example, you use a simulated device to send 200 device-to-cloud messages per second to your S1 IoT Hub (which has a limit of 100/sec D2C sends). For the first minute or two, the messages are processed immediately. However, since the device continues to send more messages than the throttle limit, IoT Hub begins to only process 100 messages per second and puts the rest in a queue. You start noticing increased latency. Eventually, you start getting `429 ThrottlingException` as the queue fills up, and the "number of throttle errors" in IoT Hub's metrics starts increasing.

### Identity registry operations throttle

Device identity registry operations are intended for run-time use in device management and provisioning scenarios. Reading or updating a large number of device identities is supported through import and export jobs.

### Device connections throttle

The device connections throttle governs the rate at which new device connections can be established with an IoT hub. The device connections throttle does not govern the maximum number of simultaneously connected devices. The device connections rate throttle depends on the number of units that are provisioned for the IoT hub.

For example, if you buy a single S1 unit, you get a throttle of 100 connections per second. Therefore, to connect 100,000 devices, it takes at least 1,000 seconds (approximately 16 minutes). However, you can have as many simultaneously connected devices as you have devices registered in your identity registry.

## Other limits

IoT Hub enforces other operational limits:

:::row:::
  :::column:::
    **Operation**
  :::column-end:::
  :::column:::
    **Limit**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Devices
  :::column-end:::
  :::column:::
    The total number of devices plus modules that can be registered to a single IoT hub is capped at 1,000,000. The only way to increase this limit is to contact Microsoft Support.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    File uploads
  :::column-end:::
  :::column:::
    10 concurrent file uploads per device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Jobs \*
  :::column-end:::
  :::column:::
    Maximum concurrent jobs is 1 (for Free and S1), 5 (for S2), and 10 (for S3). However, the max concurrent device import/export jobs is 1 for all tiers.
Job history is retained up to 30 days.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Additional endpoints
  :::column-end:::
  :::column:::
    Paid SKU hubs may have 10 additional endpoints. Free SKU hubs may have one additional endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Message routing queries
  :::column-end:::
  :::column:::
    Paid SKU hubs may have 100 routing queries. Free SKU hubs may have five routing queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Message enrichments
  :::column-end:::
  :::column:::
    Paid SKU hubs can have up to 10 message enrichments. Free SKU hubs can have up to 2 message enrichments.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device-to-cloud messaging
  :::column-end:::
  :::column:::
    Maximum message size 256 KB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device messaging \*
  :::column-end:::
  :::column:::
    Maximum message size 64 KB. Maximum pending messages for delivery is 50 per device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Direct method \*
  :::column-end:::
  :::column:::
    Maximum direct method payload size is 128 KB.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Automatic device configurations \*
  :::column-end:::
  :::column:::
    100 configurations per paid SKU hub. 20 configurations per free SKU hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge automatic deployments \*
  :::column-end:::
  :::column:::
    50 modules per deployment. 100 deployments per paid SKU hub. 10 deployments per free SKU hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twins \*
  :::column-end:::
  :::column:::
    Maximum size of desired properties and reported properties sections are 32 KB each. Maximum size of tags section is 8 KB.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Shared access policies
  :::column-end:::
  :::column:::
    Maximum number of shared access policies is 16.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    x509 CA certificates
  :::column-end:::
  :::column:::
    Maximum number of x509 CA certificates that can be registered on IoT Hub is 25.
  :::column-end:::
:::row-end:::


\* This feature is not available in the basic tier of IoT Hub.

## Increasing the quota or throttle limit

At any given time, you can increase quotas or throttle limits by increasing the number of provisioned units in an IoT hub.

## Latency

IoT Hub strives to provide low latency for all operations. However, due to network conditions and other unpredictable factors it cannot guarantee a certain latency. When designing your solution, you should:

 -  Avoid making any assumptions about the maximum latency of any IoT Hub operation.
 -  Provision your IoT hub in the Azure region closest to your devices.
 -  Consider using Azure IoT Edge to perform latency-sensitive operations on the device or on a gateway close to the device.

Multiple IoT Hub units affect throttling as described previously, but do not provide any extra latency benefits or guarantees.
