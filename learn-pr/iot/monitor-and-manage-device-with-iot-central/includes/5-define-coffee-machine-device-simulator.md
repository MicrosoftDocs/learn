The device developer must make sure that the device implements the behaviors defined in the device model so that Azure IoT Central can monitor and manage the device.

In the IoT enabled coffee machines example you'll simulate a device to validate your scenario before connecting a physical device.

Here, you'll see how a device developer uses the device model defined in the *CoffeeMaker.json*, to write a C# application that will simulate a coffee machine.

## IoT Plug and Play conventions

Devices that connect to IoT Central should follow the [IoT Plug and Play](/azure/iot-develop/overview-iot-plug-and-play) set of [conventions](/azure/iot-develop/concepts-convention). One of these conventions is that a device should send the [Digital Twin Model Identifier (DTMI)](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/DTDL.v2.md#digital-twin-model-identifier) when it connects. The DTMI enables the IoT Central application to assign the device to the correct device template.

The [Azure IoT device SDKs](/azure/iot-hub/iot-hub-devguide-sdks) include support for the IoT Plug and Play conventions.

## Review the code

The [Sample code for Azure IoT Central Documentation](https://github.com/Azure-Samples/iot-central-docs-samples) GitHub repository contains the sample code. You can open the [CoffeeMaker.cs](https://github.com/Azure-Samples/iot-central-docs-samples/blob/main/monitor-manage-device-with-iotcentral/CoffeeMaker.cs), [Program.cs](https://github.com/Azure-Samples/iot-central-docs-samples/blob/main/monitor-manage-device-with-iotcentral/Program.cs) and [Parameters.cs](https://github.com/Azure-Samples/iot-central-docs-samples/blob/main/monitor-manage-device-with-iotcentral/Parameters.cs) files to see the entire code.

In *Program.cs*, the `Main` method calls *SetupDeviceClientAsync* to:

- Provision the device and send the `dtmi:com:example:ConnectedCoffeeMaker;1` model ID as payload.
- Create a device client instance to connect to IoT Central.

:::code language="csharp" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/Program.cs" id="Provisioning":::

The main method then creates a **CoffeeMaker** instance and calls the `PerformOperationsAsync` method to handle the interactions with IoT Central.

In *CoffeeMaker.cs*, the `PerformOperationsAsync` method:

- Sets handlers to receive `SetMaintenanceMode` and `StartBrewing` command callbacks.
- Sets handler to handle `OptimalTemperature` desired property changes on device twin.
- Updates `DeviceWarrantyExpired` device twin reported property on the initial startup.
- Starts a loop to send temperature and humidity telemetry, whether it's currently brewing and when a cup is detected every 1 second.

:::code language="csharp" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.cs" id="Workflow":::

### Telemetry

The `SendTelemetryAsync` method sends telemetry in the format that the device model specifies.

:::code language="csharp" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.cs" id="Telemetry":::

### Properties

The model specifies the property names and data types to synchronize property values between the device and IoT Central via the device twin. The method `UpdateDeviceWarranty` sends the `DeviceWarrantyExpired` state of the device and the method `OptimalTemperatureUpdateCallbackAsync` handles `OptimalTemperature` changes that come from IoT Central.

:::code language="csharp" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.cs" id="Properties":::

### Commands

The model specifies the command names and parameters that the device should use. The methods `HandleMaintenanceModeCommand` and `HandleStartBrewingCommand` handle the commands sent from IoT Central.

:::code language="csharp" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.cs" id="Commands":::

### Cloud properties and Views

Cloud properties and Views don't affect the code that a device developer writes to implement the device model.