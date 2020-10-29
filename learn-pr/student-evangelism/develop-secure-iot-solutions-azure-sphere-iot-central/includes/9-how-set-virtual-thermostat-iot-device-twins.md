In this unit, you'll learn how to control an Azure Sphere application by using Azure IoT Central properties to set the desired temperature from the Azure IoT Central dashboard. As a result, it will act upon the Azure Sphere device as a thermostat in a room.

## Azure IoT cloud-to-device communications

The various forms of communications we will cover are:

- **Direct methods** for communications that require immediate confirmation of the result. Direct methods are often used for interactive control of devices, such as turning on a fan.
- **Device twins** are for long-running commands intended to put the device into a certain desired state. For example, set the sample rate for a sensor to every 30 minutes.
- **Cloud-to-device** messages are for one-way notifications to the device app.

This unit will cover Azure IoT device twins and explain **DeviceTwinBindings** to simplify the implementation of Azure IoT.

## Azure IoT device twins

Device twins are JSON documents that store device information, including metadata, configurations, and conditions. Azure IoT Hub keeps a device twin for each device that you connect to IoT Hub. Azure IoT Central is an application built on Azure IoT Hub, and it uses device twins to manage properties.

Device twins can be used for communication in the following ways:

- Cloud-to-device updates
- Device-to-cloud updates
- Querying reported properties

### Cloud-to-device updates

A user sets an Azure IoT Central device property such as setting the temperature of the room where Azure IoT Central sends a device twin message for a desired property to the device. The device implements the desired property, and then the device responds with a device twin message for the reported property. Azure IoT Hub stores the reported property.

### Device-to-cloud updates

A device can send a device twin message for a reported property to Azure, such as reporting its firmware level on startup. Azure IoT Hub stores the reported property.

### Querying reported properties

With the reported state of device twins stored in Azure, it is possible to query the stored device twin properties on the cloud side. For example, list all devices with a firmware version less than 2.0, as these devices require an update. Or, list all rooms with a temperature setting higher than 25 degrees Celsius.

## Setting device twins on device properties

![The illustration shows a device twin configuration pattern.](../media/device-twin-configuration-pattern.png)

### Steps to set device twins on device properties

The following steps outline how Azure IoT Central uses device twins to set properties on a device:

1. A user sets the value of a property in Azure IoT Central. For example, set the desired room temperature.
1. Azure IoT Hub sends a desired property message to the device.
1. The device implements the desired property; in this case, turn on the heater or cooler to bring the room to the desired temperature.
1. The device sends a reported property message back to Azure IoT. In this example, the device would report the new desired temperate.
1. Azure IoT Central queries and displays the device's reported property data.

## Device twin bindings

Azure IoT Central properties are implemented on Azure IoT Hub device twins. Device twin bindings map a device twin with a device property and a handler function that implements the action.

### Cloud-to-device updates

The following example declares a variable named **desiredTemperature** of type **LP_DEVICE_TWIN_BINDING**. This variable maps the Azure IoT Central **DesiredTemperature** property with a handler function named **DeviceTwinSetTemperatureHandler**.

```
static LP_DEVICE_TWIN_BINDING desiredTemperature = { 
	.twinProperty = "DesiredTemperature", 
	.twinType = LP_TYPE_FLOAT, 
	.handler = DeviceTwinSetTemperatureHandler 
};
```

The following is the implementation of the **DeviceTwinSetTemperatureHandler** function. Note, as part of the [IoT Plug and Play](https://docs.microsoft.com/en-us/azure/iot-pnp/concepts-convention) conventions, the device should acknowledge the device twin update with a call to **lp_deviceTwinAckDesiredState**.

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

The following example declares an **actualTemperature** device twin property of type **float**. There is no handler function registered, as this is a one-way device-to-cloud binding.

```
static LP_DEVICE_TWIN_BINDING actualTemperature = {
		.twinProperty = "ActualTemperature",
		.twinType = LP_TYPE_FLOAT
};
```

### Reporting the temperature state

The **ActualTemperature** reported property message is sent to Azure IoT Central by calling the **DeviceTwinReportState** function. You must pass a property of the correct type.

```
lp_deviceTwinReportState(&actualTemperature, &last_temperature); // TwinType = LP_TYPE_FLOAT
```

## Azure IoT Central device properties

Azure IoT Central device properties are defined in device templates.

[![The illustration shows device properties.](../media/iot-central-device-template-interface-led1.png)](../media/iot-central-device-template-interface-led1.png)

### Steps to define properties

Perform the following in Azure IoT Central:

- From Azure IoT Central, navigate to **Device templates**, and select the **Azure Sphere** template.
- Click on **Interface** to list the interface capabilities.
- Scroll down and expand the **Actual Temperature** capability.
- Review the definition of **Actual Temperature**. The capability type is **Property**, the schema type is **Float**, and the property is **Writeable**. Writeable means this property is enabled for cloud-to-device updates.

## Working with device twins

When a device twin message is received from Azure, this set is checked for a matching *twinProperty* name and when a match is found, the corresponding handler function is called. Device twin bindings must be added to **deviceTwinBindingSet**.

```
LP_DEVICE_TWIN_BINDING* deviceTwinBindingSet[] = { &desiredTemperature, &actualTemperature, &actualHvacState };
```

### Opening

Sets are initialized in the **InitPeripheralsAndHandlers** function found in **main.c**.

```
lp_deviceTwinSetOpen(deviceTwinBindingSet, NELEMS(deviceTwinBindingSet));
```

### Dispatching

When a device twin message is received, **deviceTwinBindingSet** is checked for a matching **twinProperty** name and when a match is found, the corresponding handler function is called.

### Closing

Sets are closed in the **ClosePeripheralsAndHandlers** function found in **main.c**.

```
lp_deviceTwinSetClose();
```
