This unit explains the quotas for an Azure IoT hub, and provides information to help you understand how throttling works.

Each Azure subscription can have at most 50 IoT hubs, and at most one Free hub.

Each IoT hub is provisioned with one or more units in a specific tier. The tier and number of units determine the maximum daily quota of messages that you can send to your hub per day. The message size used to calculate the daily quota is 0.5 KB for a free tier hub and 4 KB for all other tiers.

You can find your hub's quota limit under the column **Total number of messages /day** on the [Azure IoT Hub pricing page](https://azure.microsoft.com/pricing/details/iot-hub/) in the Azure portal.

The tier also determines the throttling limits that IoT Hub enforces on all operations.

## Operation throttles

Operation throttles are rate limitations that are applied in minute ranges and are intended to prevent abuse. They're also subject to traffic shaping.

It's a good practice to throttle your calls so that you don't hit/exceed the throttling limits. If you do hit the limit, IoT Hub responds with error code 429, and the client should back off and retry. These limits are per hub (or in some cases per hub/unit).

## Basic and standard tier operations

The following table shows the enforced throttles for messaging operations that are available in all IoT Hub tiers. Values refer to an individual hub.

| Throttle | Free, B1, and S1 | B2 and S2 | B3 and S3 |
|----------|-------------------|-----------|-----------|
| Device-to-cloud sends | Higher of 100 send operations/sec or 12 send operations/sec/unit (for example, two S1 units are 24/sec, but you have at least 100 send operations/sec across your units). With nine S1 units, you have 108 send operations/sec (9 * 12) across your units. | 120 send operations/sec/unit | 6,000 send operations/sec/unit |
| File upload | 1.67 file upload initiations/sec/unit (100/min/unit) | 1.67 file upload initiations/sec/unit (100/min/unit) | 83.33 file upload initiations/sec/unit (5,000/min/unit) |
| Queries | 20/min/unit | 20/min/unit | 1,000/min/unit |

## Standard tier operations

The following table shows the enforced throttles for messaging operations that are available in standard tiers only. Values refer to an individual hub.

| Throttle | Free and S1 | S2 | S3 |
|----------|--------------|----|----|
| Cloud-to-device sends | 1.67 send operations/sec/unit (100 messages/min/unit) | 1.67 send operations/sec/unit (100 send operations/min/unit) | 83.33 send operations/sec/unit (5,000 send operations/min/unit) |
| Cloud-to-device receives (only when device uses HTTPS) | 16.67 receive operations/sec/unit (1,000 receive operations/min/unit) | 16.67 receive operations/sec/unit (1,000 receive operations/min/unit) | 833.33 receive operations/sec/unit (50,000 receive operations/min/unit) |
| Device stream initiation rate | 5 new streams/sec | 5 new streams/sec | 5 new streams/sec |
| Maximum number of concurrently connected device streams | 50 | 50 | 50 |
| Maximum device stream data transfer (aggregate volume per day) | 300 MB | 300 MB | 300 MB |

### Throttling details

* The meter size determines at what increments your throttling limit is consumed. If your direct call's payload is between 0 KB and 4 KB, it is counted as 4 KB. You can make up to 40 calls per second per unit before hitting the limit of 160 KB/sec/unit.

  Similarly, if your payload is between 4 KB and 8 KB, each call accounts for 8 KB and you can make up to 20 calls per second per unit before hitting the max limit.
  
  Finally, if your payload size is between 156 KB and 160 KB, you'll be able to make only one call per second per unit in your hub before hitting the limit of 160 KB/sec/unit.
* For Jobs device operations (update twin, invoke direct method) for tier S3, 50/sec/unit only applies to when you invoke methods using jobs. If you invoke direct methods directly, the original throttling limit of 24 MB/sec/unit (for S3) applies.
* Quota is the aggregate number of messages you can send in your hub per day. You can find your hub's quota limit under the column Total number of messages /day on the IoT Hub pricing page.
* Your cloud-to-device and device-to-cloud throttles determine the maximum rate at which you can send messages irrespective of 4 KB chunks. Device-to-cloud messages can be up to 256 KB; cloud-to-device messages can be up to 64 KB. These are the maximum message sizes for each type of message.

### Traffic shaping

To accommodate burst traffic, IoT Hub accepts requests above the throttle for a limited time. The first few of these requests are processed immediately. However, if the number of requests continues violate the throttle, IoT Hub starts placing the requests in a queue and processed at the limit rate. This effect is called traffic shaping. Furthermore, the size of this queue is limited. If the throttle violation continues, eventually the queue fills up, and IoT Hub starts rejecting requests with `429 ThrottlingException`.

For example, you use a simulated device to send 200 device-to-cloud messages per second to your S1 IoT Hub (which has a limit of 100/sec D2C sends). For the first minute or two, the messages are processed immediately. However, since the device continues to send more messages than the throttle limit, IoT Hub begins to only process 100 messages per second and puts the rest in a queue. You start noticing increased latency. Eventually, you start getting `429 ThrottlingException` as the queue fills up, and the "number of throttle errors" in IoT Hub's metrics starts increasing.

## Other limits

IoT Hub enforces other operational limits:

| Operation | Limit |
| --- | --- |
| File uploads | 10 concurrent file uploads per device. |
| Additional routing endpoints | Basic and standard SKU hubs may have 10 endpoints in addition to the built-in endpoint. Free SKU hubs may have one additional endpoint. |
| Message routing queries | Basic and standard SKU hubs may have 100 routing queries. Free SKU hubs may have five routing queries. |
| Message enrichments | Basic and standard SKU hubs can have up to 10 message enrichments. Free SKU hubs can have up to two message enrichments. |
| Device-to-cloud messaging | Maximum message size 256 KB |
| Cloud-to-device messaging¹ | Maximum message size 64 KB. Maximum pending messages for delivery are 50 per device. |
| Direct method¹ | Maximum direct method payload size is 128 KB for the request and 128 KB for the response. |

¹ This feature is not available in the basic tier of IoT Hub.

## Increasing the quota or throttle limit

At any given time, you can increase quotas or throttle limits by increasing the number of provisioned units in an IoT hub.

## Latency

IoT Hub strives to provide low latency for all operations. However, due to network conditions and other unpredictable factors it cannot guarantee a certain latency. When designing your solution, you should:

* Avoid making any assumptions about the maximum latency of any IoT Hub operation.
* Provision your IoT hub in the Azure region closest to your devices.
* Consider using Azure IoT Edge to perform latency-sensitive operations on the device or on a gateway close to the device.

Multiple IoT Hub units affect throttling as described previously, but do not provide any other latency benefits or guarantees.
