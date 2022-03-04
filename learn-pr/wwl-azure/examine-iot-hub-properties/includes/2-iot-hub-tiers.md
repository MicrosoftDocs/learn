Since IoT solutions come in all shapes and sizes, Azure IoT Hub offers several options that help you to match the planned scale and price of your solution.

Selecting the appropriate IoT Hub tier and other scaling factors is generally a decision made by the solution architect, however, understanding how these decisions affect message throughput and other factors is important for the IoT developer who will be implementing and supporting the solution.

To evaluate which IoT Hub tier is right for your solution, consider these two questions:

 -  What features do I plan to use? Azure IoT Hub offers two tiers, basic and standard, that differ in the number of features they support. If your IoT solution is based around collecting data from devices and analyzing it centrally, then the basic tier is probably right for you. If you want to use more advanced configurations to control IoT devices remotely or distribute some of your workloads onto the devices themselves, then you should consider the standard tier.
 -  How much data do I plan to move daily? Each IoT Hub tier is available in three sizes, based around how much data throughput they can handle in any given day. These sizes are numerically identified as 1, 2, and 3. For example, each unit of a level 1 IoT hub can handle 400 thousand messages a day, while a level 3 unit can handle 300 million.

## Basic and standard tiers

The standard tier of IoT Hub enables all features, and is required for any IoT solutions that want to make use of the bi-directional communication capabilities. The basic tier enables a subset of the features and is intended for IoT solutions that only need uni-directional communication from devices to the cloud. Both tiers offer the same security and authentication features.

> [!NOTE]
> IoT Hub also offers a free tier that is meant for testing and evaluation. It has all the capabilities of the standard tier, but limited messaging allowances. You cannot upgrade from the free tier to either basic or standard.

:::row:::
  :::column:::
    **Capability**
  :::column-end:::
  :::column:::
    **Basic tier**
  :::column-end:::
  :::column:::
    **Free/Standard tier**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device-to-cloud telemetry
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Per-device identity
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Message routing, message enrichments, and Event Grid integration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HTTP, AMQP, and MQTT protocols
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device Provisioning Service
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitoring and diagnostics
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device messaging
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device twins, Module twins, and Device management
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device streams (preview)
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure IoT Edge
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Plug and Play Preview
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::


## Message throughput

Message traffic is measured for your IoT hub on a per-unit basis. When you create an IoT hub, you choose its tier and edition, and set the number of units available. You can purchase up to 200 units for the B1, B2, S1, or S2 edition, or up to 10 units for the B3 or S3 edition. After your IoT hub is created, you can change the number of units available within its edition, upgrade or downgrade between editions within its tier (B1 to B2), or upgrade from the basic to the standard tier (B1 to S1) without interrupting your existing operations.

Only one type of edition within a tier can be chosen per IoT Hub. For example, you can create an IoT Hub with multiple units of S1, but not with a mix of units from different editions, such as S1 and S2.

As an example of each tier's traffic capabilities, device-to-cloud messages follow these sustained throughput guidelines:

:::row:::
  :::column:::
    **Tier edition**
  :::column-end:::
  :::column:::
    **Sustained throughput**
  :::column-end:::
  :::column:::
    **Sustained send rate**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    B1, S1
  :::column-end:::
  :::column:::
    Up to 1111 KB/minute per unit
(1.5 GB/day/unit)
  :::column-end:::
  :::column:::
    Average of 278 messages/minute per unit
(400,000 messages/day per unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    B2, S2
  :::column-end:::
  :::column:::
    Up to 16 MB/minute per unit
(22.8 GB/day/unit)
  :::column-end:::
  :::column:::
    Average of 4,167 messages/minute per unit
(6 million messages/day per unit)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    B3, S3
  :::column-end:::
  :::column:::
    Up to 814 MB/minute per unit
(1144.4 GB/day/unit)
  :::column-end:::
  :::column:::
    Average of 208,333 messages/minute per unit
(300 million messages/day per unit)
  :::column-end:::
:::row-end:::


## Partitions

Azure IoT hubs contain many of the core components of Azure Event Hubs, including Partitions.

The event streams for IoT hubs are often populated with incoming telemetry data that is reported by various IoT devices. The partitioning of the event stream is used to reduce contentions that could occur when concurrently reading and writing to event streams.

The partition limit is chosen when IoT Hub is created and cannot be changed, so long-term scale should be considered when setting partition count. The maximum partition limit is 32 for both the basic and standard tiers of IoT Hub, but most IoT hubs only need four partitions. The number of partitions is directly related to the number of concurrent readers you expect to have.

The decision on how many partitions are needed is made by the solution architect. The default value of four partitions should be used unless otherwise specified by the architect.

## Tier upgrade

Once you create your IoT hub, you can upgrade from the basic tier to the standard tier without interrupting your existing operations. The partition configuration remains unchanged when you migrate from basic tier to standard tier.

> [!NOTE]
> If you want to downgrade your IoT hub, you can remove units and reduce the size of the IoT hub but you cannot downgrade to a lower tier. For example, you can move from the S2 tier to the S1 tier, but not from the S2 tier to the B1 tier.
