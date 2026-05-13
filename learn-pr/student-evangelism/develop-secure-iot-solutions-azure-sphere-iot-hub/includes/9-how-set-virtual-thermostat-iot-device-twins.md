In this unit, you will learn how to control an Azure Sphere connected heating, ventilation, and air conditioning unit (HVAC) from Azure IoT Hub.

## Understanding IoT Hub device twins

Azure IoT Hub uses device twins to store device state information such as metadata, configurations, and conditions. Back-end applications can set desired properties on a device twin, for example, the desired room temperature. A device application can read desired properties and update reported properties, for example, to report whether an HVAC (Heating, Ventilation, and Air Conditioning) unit is heating, cooling, or turned off.

Device twins are JSON documents that Azure IoT Hub keeps in the cloud for all devices. Device twins are often used to synchronize long-running configuration workflows between a back-end application and a device, and to retain the last known configuration or state across device reconnects and restarts. For example, setting the desired room temperature is better modeled as a desired property than as a one-time command.

Properties can be used in the following ways:

- Cloud-to-device updates
- Device-to-cloud updates
- Querying reported properties

## Controlling the heating, ventilation, and air conditioning unit (HVAC) using Azure IoT Hub device twins

From Azure IoT Explorer, you can update the `DesiredTemperature` writable property. IoT Hub stores the new desired property and notifies the connected device. The device applies the requested value, then sends a reported property update that acknowledges the desired property. Azure IoT Explorer reads the reported value and acknowledgment status from the device twin.

![The illustration shows a cloud to device device twin configuration pattern.](../media/azure-device-twins-c2d-pattern.png)

### Steps to controlling the HVAC unit from IoT Explorer

The following steps outline how Azure IoT Explorer uses device twins to set properties on a device:

1. You set the desired room temperature from Azure IoT Explorer.
1. Azure IoT Hub updates the device twin desired property and, if the device is connected, sends a desired property update notification to the device. If the device is offline, it retrieves the latest desired properties when it reconnects.
1. The corresponding device twin handler function is called.
1. The device implements the desired property; in this case, turn on the heater or cooler to bring the room to the desired temperature.
1. The device acknowledges the updated configuration by sending a reported property update to Azure IoT Hub.
1. IoT Explorer queries and displays the device twin reported property data.

## Getting started with device twin bindings

A device twin binding maps a device twin property name with a handler function that will be called to implement the action.

The following example declares a Device Twin Binding to set the desired room temperature. This declaration maps the Azure IoT Hub `DesiredTemperature` device twin with a handler function named `DeviceTwinSetTemperatureHandler`.

```c
static LP_DEVICE_TWIN_BINDING dt_desiredTemperature = {
    .twinProperty = "DesiredTemperature",
    .twinType = LP_TYPE_FLOAT,
    .handler = DeviceTwinSetTemperatureHandler };
```

### Setting the desired temperature

The following is the implementation of the handler function `DeviceTwinSetTemperatureHandler`. The handler function is called when the device receives a `DesiredTemperature` desired property message from Azure IoT Hub.

> [!NOTE]
> As part of the [IoT Plug and Play conventions](/azure/iot/concepts-convention?azure-portal=true), the device should acknowledge the device twin update with a reported property. The acknowledgment includes the applied `value`, an acknowledgment code (`ac`), the desired-property version (`av`), and optionally a description (`ad`). The **lp_deviceTwinAckDesiredState** helper sends this acknowledgment for the default component.

```c
/// <summary>
/// Device Twin Handler to set the desired temperature value
/// </summary>
static void DeviceTwinSetTemperatureHandler(LP_DEVICE_TWIN_BINDING* deviceTwinBinding)
{
    // validate data is sensible range before applying
    if (deviceTwinBinding->twinType == LP_TYPE_FLOAT && *(float*)deviceTwinBinding->twinState >= -20.0f && *(float*)deviceTwinBinding->twinState <= 80.0f)
    {
        lp_deviceTwinAckDesiredState(deviceTwinBinding, deviceTwinBinding->twinState, LP_DEVICE_TWIN_COMPLETED);
        SetHvacStatusColour((int)previous_temperature);
    }
    else {
        lp_deviceTwinAckDesiredState(deviceTwinBinding, deviceTwinBinding->twinState, LP_DEVICE_TWIN_ERROR);
    }
}
```

## Reporting the current HVAC operating mode

The HVAC operating mode depends on the room temperature; it can be heating, cooling, or turned off. We can use a device-to-cloud reported property update to report the current operating mode of the HVAC unit.

### Device-to-cloud updates

![The illustration shows a device to cloud device twin configuration pattern.](../media/azure-device-twins-d2c-pattern.png)

1. The Azure Sphere detects the HVAC operating mode has changed.
1. The Azure Sphere sends a reported property update to report the new operating mode of the HVAC to Azure IoT Hub.
1. IoT Explorer queries and displays the updated operating mode of the HVAC unit.

The following example declares a **ReportedHvacState** device twin property of type **string**. A handler function is not required as this is a one-way device-to-cloud binding.

```c
static LP_DEVICE_TWIN_BINDING dt_reportedHvacState = {
    .twinProperty = "ReportedHvacState",
    .twinType = LP_TYPE_STRING };
```

The device updates the **ReportedHvacState** property by calling the **lp_deviceTwinReportState** function. You must pass a property of the correct type.

```c
lp_deviceTwinReportState(&dt_reportedHvacState, (void*)hvacState[(int)current_led]);
```

## How desired property updates are mapped to handlers

All declared device twin bindings must be added by reference to the deviceTwinBindingSet array. When a desired property update is received by the device, it is checked for a matching *twinProperty* name in the deviceTwinBindingSet array. When a match is found, the corresponding handler function is called.

```c
LP_DEVICE_TWIN_BINDING* deviceTwinBindingSet[] = {
    &dt_desiredTemperature,
    &dt_reportedTemperature,
    &dt_reportedHvacState,
    &dt_reportedDeviceStartTime
};
```

### Opening the device twin binding set

The device twin binding set is initialized in the **InitPeripheralAndHandlers** function in **main.c**.

```c
lp_deviceTwinSetOpen(deviceTwinBindingSet, NELEMS(deviceTwinBindingSet));
```

### Closing the device twin binding set

The device twin bindings set is closed in the **ClosePeripheralAndHandlers** function in **main.c**.

```c
lp_deviceTwinSetClose();
```
