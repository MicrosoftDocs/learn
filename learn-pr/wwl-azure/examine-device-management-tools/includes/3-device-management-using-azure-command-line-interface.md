The IoT extension for Azure CLI gives IoT developers command-line access to all IoT Hub, IoT Edge, and IoT Hub Device Provisioning Service capabilities. This includes the device management capabilities provided by the IoT Hub service.

:::row:::
  :::column:::
    **Management option**
  :::column-end:::
  :::column:::
    **Task**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Direct methods
  :::column-end:::
  :::column:::
    Make a device act such as starting or stopping sending messages or rebooting the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twin desired properties
  :::column-end:::
  :::column:::
    Put a device into certain states, such as setting an LED to green or setting the telemetry send interval to 30 minutes.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twin reported properties
  :::column-end:::
  :::column:::
    Get the reported state of a device. For example, the device reports the LED is blinking now.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Twin tags
  :::column-end:::
  :::column:::
    Store device-specific metadata in the cloud. For example, the deployment location of a vending machine.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device twin queries
  :::column-end:::
  :::column:::
    Query all device twins to retrieve those twins with arbitrary conditions, such as identifying the devices that are available for use.
  :::column-end:::
:::row-end:::


> [!NOTE]
> If you don't have the IoT extension installed, the simplest way to install it is to run `az extension add --name azure-iot`

Before you can enter any device management commands, you need to sign in to your Azure account:

```bash
az login

```

## Direct methods

To invoke a direct method on a device, use the following command:

```bash
az iot hub invoke-device-method --device-id <your device id> \
  --hub-name <your hub name> \
  --method-name <the method name> \
  --method-payload <the method payload>

```

## Device twin desired properties

Set a desired property interval = 3000 by running the following command:

```bash
az iot hub device-twin update -n <your hub name> \
  -d <your device id> --set properties.desired.interval = 3000

```

This property can be read from your device.

## Device twin reported properties

Get the reported properties of the device by running the following command:

```bash
az iot hub device-twin show -n <your hub name> -d <your device id>

```

One of the twin reported properties is `$metadata.$lastUpdated`, which shows the last time the device app updated its reported property set.

## Device twin tags

Display the tags and properties of the device by running the following command:

```bash
az iot hub device-twin show --hub-name <your hub name> --device-id <your device id>

```

Add a field role = temperature&amp;humidity to the device by running the following command:

```bash
az iot hub device-twin update \
  --hub-name <your hub name> \
  --device-id <your device id> \
  --set tags = '{"role":"temperature&humidity"}}'

```

## Device twin queries

Query devices with a tag of role = 'temperature&amp;humidity' by running the following command:

```bash
az iot hub query --hub-name <your hub name> \
  --query-command "SELECT * FROM devices WHERE tags.role = 'temperature&humidity'"

```

Query all devices except those with a tag of role = 'temperature&amp;humidity' by running the following command:

```bash
az iot hub query --hub-name <your hub name> \
  --query-command "SELECT * FROM devices WHERE tags.role != 'temperature&humidity'"

```
