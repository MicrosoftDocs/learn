In this unit, you'll learn how to control an Azure Sphere application using Azure IoT Central Properties. You will set the desired temperature from IoT Central Dashboard and it will act upon the Azure Sphere device as a thermostat in a room.

This unit will cover **Azure IoT Device Twins** and explain **DeviceTwinBindings** to simplify the implementation of Azure IoT.

## Azure IoT cloud to device communications

1. [Direct Methods](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-direct-methods?WT.mc_id=github-blog-dglover) for communications that require immediate confirmation of the result. Direct methods are often used for interactive control of devices, such as turning on a fan.
2. [Device Twins](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-device-twins?WT.mc_id=github-blog-dglover) are for long-running commands intended to put the device into a certain desired state. For example, set the sample rate for a sensor to every 30 minutes.
3. [Cloud-to-device](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-messages-c2d?WT.mc_id=github-blog-dglover) messages are for one-way notifications to the device app.

This unit will cover **Azure IoT Device Twins** and explain **DeviceTwinBindings** to simplify the implementation of Azure IoT.

## Azure IoT Device Twins

Device twins are JSON documents that store device information, including metadata, configurations, and conditions. Azure IoT Hub keeps a device twin for each device that you connect to IoT Hub. Azure IoT Central is an application built on Azure IoT Hub, and it uses device twins to manage properties.

You can use device twins as follows:

1. Cloud to device updates.

   A user sets an Azure IoT Central device property. For example, to set the temperature of the room. IoT Central sends a desired property device twin message to the device. The device implements the desired property, and then the device responds with a reported property device twin message. Azure IoT Hub stores the reported property.

2. Device to cloud updates.

   A device can send a reported property device twin message to Azure. For example, a device could report its firmware level on startup. Azure IoT Hub stores the reported property.

3. Querying reported properties.

   With device twins reported state stored in Azure, it is possible to query the stored device twin properties cloud side. For example, list all devices with a firmware version less than 2.0, as these devices require an update. Or, list all rooms with a temperature setting higher than 25 degrees Celsius.

The following outlines how Azure IoT Central uses Device Twins to set properties on a device:

1. A user sets the value of a property in Azure IoT Central. For example, set the desired room temperature.
2. Azure IoT Hub sends a desired property message to the device.
3. The device implements the desired property; in this case, turn on the heater or cooler to bring the room to the desired temperature.
4. The device sends a reported property message back to Azure IoT. In this example, the device would report the new desired temperate.
5. Azure IoT Central queries and displays the devices reported property data.

[![img](https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path/raw/master/zdocs_vs_code_iot_central/Lab_3_Control_Device_with_Device_Twins/resources/device-twin-configuration-pattern.png)](https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path/blob/master/zdocs_vs_code_iot_central/Lab_3_Control_Device_with_Device_Twins/resources/device-twin-configuration-pattern.png)

For more information, refer to the [Understand and use device twins in IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-device-twins?WT.mc_id=github-blog-dglover) article.

------

## Device Twin Bindings

Azure IoT Central properties are implemented on Azure IoT Hub device twins. Device Twin Bindings map a device twin with a device property and a handler function that implements the action.

### Cloud to Device Updates

The following example declares a variable named **desiredTemperature** of type **LP_DEVICE_TWIN_BINDING**. This variable maps the Azure IoT Central **DesiredTemperature** property with a handler function named **DeviceTwinSetTemperatureHandler**.

```
static LP_DEVICE_TWIN_BINDING desiredTemperature = { 
	.twinProperty = "DesiredTemperature", 
	.twinType = LP_TYPE_FLOAT, 
	.handler = DeviceTwinSetTemperatureHandler 
};
```

The following example declares a variable named **desiredTemperature** of type **LP_DEVICE_TWIN_BINDING**. This variable maps the Azure IoT Central *DesiredTemperature* property with a handler function named **DeviceTwinSetTemperatureHandler**.

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

The ActualTemperature reported property message is sent to IoT Central by calling the DeviceTwinReportState function. You must pass a property of the correct type.

```
lp_deviceTwinReportState(&actualTemperature, &last_temperature); // TwinType = LP_TYPE_FLOAT
```

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
