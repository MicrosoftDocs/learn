You'll make the changes to set the desired temperature from Azure Cloud Shell and to act upon the Azure Sphere device as a thermostat in a room. By doing this, you'll learn how to control an Azure Sphere application by using Azure IoT Hub device twins.

------

## Azure IoT cloud-to-device communications

The multiple communications between the cloud and the device are:

- **Direct method** for communications that require immediate confirmation of the result. You often use direct method for interactive control of devices, such as turning on a fan.
- **Device twins** are for long-running commands intended to put the device into a certain desired state. For example, you might want to set the sample rate for a sensor to every 30 minutes.
- **Cloud-to-device** messages are for one-way notifications to the device app.

This unit covers Azure IoT device twins, and explains device twin bindings to simplify the implementation of Azure IoT.

------

## Azure IoT device twins

Device twins are JSON documents that store device information, including metadata, configurations, and conditions. Azure IoT Hub keeps a device twin for each device that you connect to IoT Hub.

Device twins can be used for communication in the following ways:

- Cloud-to-device updates
- Device-to-cloud updates
- Querying reported properties

### Using device twins

You can use device twins as follows:

- Cloud-to-device updates.

   Typically, an IoT hub application sets the value of a device twin. For example, the application might set the temperature of the room. IoT Hub sends a desired property device twin message to the device. The device takes action on the desired property, and then the device responds with a reported property device twin message. Azure IoT Hub stores the reported property.

- Device-to-cloud updates.

   A device can send a reported property device twin message to Azure. For example, a device can report its firmware level on startup. Azure IoT Hub stores the reported property.

- Querying reported properties.

   With device twins reported state stored in Azure, it's possible to query the stored device twin properties. For example, list all devices with a firmware version less than 2.0, as these devices require an update. Or, list all rooms with a temperature setting higher than 25 degrees Celsius.

------

## Setting properties on a device

The following diagram shows how Azure IoT Hub device twins work.

![Diagram showing how Azure IoT Hub device twins work.](../media/device-twin-configuration-pattern.png)

## Steps to set device properties

The following outlines how Azure IoT Hub uses device twins to set properties on a device:

1. Typically an Azure IoT Hub application sets the value of a device twin. For example, set the desired room temperature.
2. Azure IoT Hub sends a desired property message to the device.
3. The device implements the desired property (in this case, to turn on the heater or cooler to bring the room to the desired temperature).
4. The device sends a reported property message back to Azure IoT. In this example, the device reports the new desired temperature.
5. Your application can then query the device twin report property.

------

## Device twin bindings

Device twin bindings map a device twin with a device property and a handler function that implements the action.

### Cloud-to-device updates

The following example declares a variable named `dt_desiredTemperature` of type `LP_DEVICE_TWIN_BINDING`. This variable maps the Azure IoT hub device twin `DesiredTemperature` with a handler function named `DeviceTwinSetTemperatureHandler`.

```
static LP_DEVICE_TWIN_BINDING dt_desiredTemperature = {
	.twinProperty = "DesiredTemperature",
	.twinType = LP_TYPE_FLOAT,
	.handler = DeviceTwinSetTemperatureHandler };
```

#### Set the desired temperature

The following is the implementation of the handler function `DeviceTwinSetTemperatureHandler`. The handler function is called when the device receives a `DesiredTemperature` desired property message from Azure IoT Hub.

> [!NOTE]
> As part of the [IoT Plug and Play](https://docs.microsoft.com/en-us/azure/iot-pnp/concepts-convention) conventions, the device should acknowledge the device twin update with a call to **lp_deviceTwinAckDesiredState**.

```
/// <summary>
/// Device Twin Handler to set the desired temperature value
/// </summary>
static void DeviceTwinSetTemperatureHandler(LP_DEVICE_TWIN_BINDING* deviceTwinBinding)
{
    if (deviceTwinBinding->twinType == LP_TYPE_FLOAT)
    {
        lp_deviceTwinAckDesiredState(deviceTwinBinding, deviceTwinBinding->twinState, LP_DEVICE_TWIN_COMPLETED);
        SetTemperatureStatusColour(last_temperature);
    }
}
```

### Device-to-cloud updates

The following example declares an `ReportedTemperature` device twin property of type `float`. There is no handler function registered because this is a one-way, device-to-cloud binding.

```
static LP_DEVICE_TWIN_BINDING dt_reportedTemperature = {
	.twinProperty = "ReportedTemperature",
	.twinType = LP_TYPE_FLOAT };
```

The **ReportedTemperature** reported property message is sent to IoT Central by calling the **lp_deviceTwinReportState** function. You must pass a property of the correct type.

```
lp_deviceTwinReportState(&dt_reportedTemperature, &actual_temperature);
```

------

## Work with device twins

Device twin bindings must be added to the `deviceTwinBindingSet`. When a device twin message is received from Azure, this set is checked for a matching `twinProperty` name. When a match is found, the corresponding handler function is called.

```
LP_DEVICE_TWIN_BINDING* deviceTwinBindingSet[] = { &dt_desiredTemperature, &dt_reportedTemperature, &dt_reportedHvacState };
```

### Opening

Sets are initialized in the `InitPeripheralsAndHandlers` function found in **main.c**.

```
lp_deviceTwinSetOpen(deviceTwinBindingSet, NELEMS(deviceTwinBindingSet));
```

### Dispatching

When a device twin message is received, the `deviceTwinBindingSet` is checked for a matching `twinProperty` name. When a match is found, the corresponding handler function is called.

### Closing

Sets are closed in the `ClosePeripheralsAndHandlers` function found in **main.c**.

```
lp_deviceTwinSetClose();
```
