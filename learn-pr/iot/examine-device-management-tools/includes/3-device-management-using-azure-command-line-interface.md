The IoT extension for Azure CLI gives developers multi-platform (Windows, macOS and Linux) command-line access to IoT Hub, IoT Edge, IoT Device Provisioning, IoT Central, Digital Twins, and Device Update for IoT Hub capabilities. The interface is run outside of the Azure portal.

An organization may decide to use Azure CLI for IoT device management in situations where scripting is required for repeatable or scriptable tasks such as with periodic device updates that a run on a timer. CLI scripting retains the flexibility and power of a coding environment vs. using the Azure IoT Hub portal interface or Visual Studio Code and Azure IoT Hub extension menu-based interface.

Imagine you work for a large product distribution company. Your company needs to update 1000s of warehouse IoT devices on a regular basis. You write a script that runs within the IoT extension for Azure CLI that updates IoT device configuration and firmware information as required through a wireless network. The script runs monthly using a software timer.

Here, you will learn about Azure CLI scripting capabilities that you can use to manage IoT devices.

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
:::row:::
  :::column:::
    Device identity updates
  :::column-end:::
  :::column:::
    Modify device identity information in the IoT Hub identity registry.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device Update for IoT Hub
  :::column-end:::
  :::column:::
    Publish, distribute, and manage over-the-air updates (OTA) to IoT devices. For example, update firmware on a group of devices.
  :::column-end:::
:::row-end:::

> [!NOTE]
> If you don't have the IoT extension for Azure CLI installed, the simplest way to install it is to run `az extension add --name azure-iot` in the Azure CLI.

Before you can enter any device management commands, you need to sign in to your Azure account:

```bash
az login
```

> [!NOTE]
> The commands listed as follows are an introductory sampling and not meant to be a complete reference.

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
az iot hub device-twin update --hub-name <your hub name> \
  --device-id <your device id> --set properties.desired.interval = 3000

```

This property can be read from your device.

## Device twin reported properties

Get the reported properties of the device by running the following command:

```bash
az iot hub device-twin show --hub-name <your hub name> --device-id <your device id>

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
  --tags '{"role":"temperature&humidity"}'

```

## Device twin queries

Query devices with a tag of role = 'temperature&amp;humidity' by running the following JMESPath query language command:

```bash
az iot hub query --hub-name <your hub name> \
  --query-command "SELECT * FROM devices WHERE tags.role = 'temperature&humidity'"

```

Query all devices except those with a tag of role = 'temperature&amp;humidity' by running the following command:

```bash
az iot hub query --hub-name <your hub name> \
  --query-command "SELECT * FROM devices WHERE tags.role != 'temperature&humidity'"

```

## Device identity

Create an edge enabled IoT device with default authorization (shared private key).

```bash
az iot hub device-identity create -n <your hub name> -d <your device name> --ee
```

## Device Update for IoT Hub

Initialize a minimum content import manifest.

```bash
az iot du update init v5 --update-provider Microsoft --update-name myAptUpdate --update-version 1.0.0 --description "My minimum update" --compat manufacturer=Contoso model=Vacuum --step handler=microsoft/apt:1 properties="@/path/to/file" --file path=/my/apt/manifest/file
```
