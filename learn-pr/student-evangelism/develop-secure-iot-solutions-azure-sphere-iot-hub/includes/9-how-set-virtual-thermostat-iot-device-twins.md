You'll make the changes to set the desired temperature from Azure Cloud Shell and to act upon the Azure Sphere device as a thermostat in a room. By doing this, you'll learn how to control an Azure Sphere application using Azure IoT Hub Device Twins.

## Azure IoT cloud to device communications

The multiple communication times between the cloud and device are:

- **Direct Methods** for communications that require immediate confirmation of the result. Direct methods are often used for interactive control of devices, such as turning on a fan.
- **Device Twins** are for long-running commands intended to put the device into a certain desired state. For example, set the sample rate for a sensor to every 30 minutes.
- **Cloud-to-device** messages are for one-way notifications to the device app.

This unit will cover **Azure IoT Device Twins** and explain **DeviceTwinBindings** to simplify the implementation of Azure IoT.

## Azure IoT Device Twins

Device twins are JSON documents that store device information, including metadata, configurations, and conditions. Azure IoT Hub keeps a device twin for each device that you connect to IoT Hub.

### Using Device twins

You can use device twins as follows:

- Cloud to device updates.

   Typically an IoT Hub application would set the value of a device twin. For example, to set the temperature of the room. IoT Hub sends a desired property device twin message to the device. The device actions the desired property, and then the device responds with a reported property device twin message. Azure IoT Hub stores the reported property.

- Device to cloud updates.

   A device can send a reported property device twin message to Azure. For example, a device could report its firmware level on startup. Azure IoT Hub stores the reported property.

- Querying reported properties.

   With device twins reported state stored in Azure, it is possible to query the stored device twin properties cloud side. For example, list all devices with a firmware version less than 2.0, as these devices require an update. Or, list all rooms with a temperature setting higher than 25 degrees Celsius.

## Setting properties on a device

Examine how Azure IoT Hub device twins work

![The illustration shows how Azure IoT Hub device twins work.](../media/device-twin-configuration-pattern.png)

## Steps to set device properties

The following outlines how Azure IoT Hub uses Device Twins to set properties on a device:

1. Typically an Azure IoT Hub application sets the value of a device twin. For example, set the desired room temperature.
2. Azure IoT Hub sends a desired property message to the device.
3. The device implements the desired property; in this case, turn on the heater or cooler to bring the room to the desired temperature.
4. The device sends a reported property message back to Azure IoT. In this example, the device would report the new desired temperate.
5. Your application can then query the device twin report property cloud side.

## Device Twin Bindings

A Device Twin Bindings maps a device twin with a device property and a handler function that implements the action.

### Cloud to Device Updates

#### Defining the Desired Tempurature binding

The following example declares a variable named **desiredTemperature** of type **LP_DEVICE_TWIN_BINDING**. This variable maps the Azure IoT Hub device twin **DesiredTemperature** with a handler function named **DeviceTwinSetTemperatureHandler**.

```
static LP_DEVICE_TWIN_BINDING desiredTemperature = { 
	.twinProperty = "DesiredTemperature", 
	.twinType = LP_TYPE_FLOAT, 
	.handler = DeviceTwinSetTemperatureHandler 
};
```

#### Setting the Desired Tempurature

The following is the implementation of the handler function **DeviceTwinSetTemperatureHandler**. The handler function is called when the device receives a **DesiredTemperature** desired property message from Azure IoT Hub.

```
/// <summary>
/// Device Twin Handler to set the desired temperature value
/// </summary>
static void DeviceTwinSetTemperatureHandler(LP_DEVICE_TWIN_BINDING* deviceTwinBinding)
{
	if (deviceTwinBinding->twinType == LP_TYPE_FLOAT)
	{
		desired_temperature = *(float*)deviceTwinBinding->twinState;
		SetTemperatureStatusColour(last_temperature);
	}
}
```

### Device to Cloud Updates

The following example declares an **actualTemperature** device twin property of type float. There is no handler function registered as this is a one-way device to cloud binding.

```
static LP_DEVICE_TWIN_BINDING actualTemperature = {
		.twinProperty = "ActualTemperature",
		.twinType = LP_TYPE_FLOAT 
};
```

#### Reporting the State of the Tempurature

The ActualTemperature reported property message is sent to IoT Hub by calling the DeviceTwinReportState function. You must pass a property of the correct type.

```
lp_deviceTwinReportState(&actualTemperature, &last_temperature); // TwinType = LP_TYPE_FLOAT
```

------

## Working with Device Twins

Device twin bindings must be added to the **deviceTwinBindingSet**. When a device twin message is received from Azure, this set is checked for a matching *twinProperty* name. When a match is found, the corresponding handler function is called.

```
LP_DEVICE_TWIN_BINDING* deviceTwinBindingSet[] = { &desiredTemperature, &actualTemperature };
```

### Opening

Sets are initialized in the **InitPeripheralsAndHandlers** function found in **main.c**.

```
lp_openDeviceTwinSet(deviceTwinBindingSet, NELEMS(deviceTwinBindingSet));
```

### Dispatching

When a Device Twin message is received, the deviceTwinBindingSet is checked for a matching **twinProperty** name. When a match is found, the corresponding handler function is called.

### Closing

Sets are closed in the **ClosePeripheralsAndHandlers** function found in **main.c**.

```
lp_closeDeviceTwinSet();
```
