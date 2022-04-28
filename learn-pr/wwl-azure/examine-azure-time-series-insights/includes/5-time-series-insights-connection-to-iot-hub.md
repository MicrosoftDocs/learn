Once you have IoT Hub and TSI instances up and running, you are ready to create a dedicated consumer group in the IoT hub for the Time Series Insights environment to consume from. Each Time Series Insights event source must have its own dedicated consumer group that isn't shared with any other consumer. If multiple readers consume events from the same consumer group, all readers are likely to see failures.

## Create an IoT Hub consumer group for TSI

Applications use consumer groups to pull data from Azure IoT Hub. To reliably read data from your IoT hub, provide a dedicated consumer group that's used only by this Time Series Insights environment.

:::image type="content" source="../media/m05-l01-tsi-connection-iot-hub-iot-hub-consumer-group-5a87d9c2.png" alt-text="Screenshot that shows where to configure an IoT Hub consumer group for Time Series Insights.":::


Under **Consumer groups**, enter a unique name for the consumer group. You will use this same name in your Time Series Insights environment when you create your event source.

## Create a TSI event source for IoT Hub

Switching over to the TSI side, you need to create the Event Source that you will be using to access IoT Hub data.

:::image type="content" source="../media/m05-l01-tsi-connection-iot-hub-tsi-event-source-b02a1461.png" alt-text="Screenshot that shows where to configure a Time Series Insights event source for IoT Hub.":::


To begin the process of creating your new event source, you will first provide an Event source name (a name that's unique to this Time Series Insights environment) and specify that your Source will be an IoT Hub. Once you have these properties set, you will have a choice between using an IoT Hub from an available subscription and providing IoT Hub settings manually. The property settings requirements will be different based on your choice.

> [!NOTE]
> If you want to choose advanced options, you should choose the Provide IoT Hub settings manually option.

### Use IoT Hub from available subscriptions

The following table describes the properties that are required for the **Use IoT Hub from available subscriptions** option:

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
    Subscription
  :::column-end:::
  :::column:::
    The subscription the desired iot hub belongs to.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub name
  :::column-end:::
  :::column:::
    The name of the selected iot hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub policy name
  :::column-end:::
  :::column:::
    Select the shared access policy. You can find the shared access policy on the IoT hub settings tab. Each shared access policy has a name, permissions that you set, and access keys. The shared access policy for your event source must have service connect permissions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub policy key
  :::column-end:::
  :::column:::
    The key is prepopulated.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub consumer group
  :::column-end:::
  :::column:::
    The consumer group that reads events from the IoT hub. We highly recommend that you use a dedicated consumer group for your event source.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    Currently, JSON is the only available serialization format. The event messages must be in this format or no data can be read.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Timestamp property name
  :::column-end:::
  :::column:::
    To determine this value, you need to understand the message format of the message data that's sent to the IoT hub. This value is the name of the specific event property in the message data that you want to use as the event timestamp. The value is case-sensitive. If left blank, the event enqueue time in the event source is used as the event timestamp.
  :::column-end:::
:::row-end:::


### Provide IoT Hub settings manually

The following table describes the properties that are required for the **Use IoT Hub from available subscriptions** option:

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
    Subscription ID
  :::column-end:::
  :::column:::
    The subscription the desired iot hub belongs to.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource group
  :::column-end:::
  :::column:::
    The resource group name in which the IoT hub was created.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub name
  :::column-end:::
  :::column:::
    The name of your IoT hub. When you created your IoT hub, you entered a name for the IoT hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub policy name
  :::column-end:::
  :::column:::
    The shared access policy. You can create the shared access policy on the IoT hub settings tab. Each shared access policy has a name, permissions that you set, and access keys. The shared access policy for your event source must have service connect permissions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub policy key
  :::column-end:::
  :::column:::
    The shared access key that's used to authenticate access to the Azure Service Bus namespace. Enter the primary or secondary key here.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT hub consumer group
  :::column-end:::
  :::column:::
    The consumer group that reads events from the IoT hub. We highly recommend that you use a dedicated consumer group for your event source.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    Currently, JSON is the only available serialization format. The event messages must be in this format or no data can be read.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Timestamp property name
  :::column-end:::
  :::column:::
    To determine this value, you need to understand the message format of the message data that's sent to the IoT hub. This value is the name of the specific event property in the message data that you want to use as the event timestamp. The value is case-sensitive. If left blank, the event enqueue time in the event source is used as the event timestamp.
  :::column-end:::
:::row-end:::
