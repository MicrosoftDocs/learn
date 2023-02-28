The device developer must make sure that the device implements the behaviors defined in the device model so that Azure IoT Central can monitor and manage the device.

In the IoT enabled coffee machines example you'll simulate a device to validate your scenario before connecting a physical device.

Here, you'll see how a device developer uses the device model defined in the *CoffeeMaker.json*, to write a Node.js application that will simulate a coffee machine.

## IoT Plug and Play conventions

Devices that connect to IoT Central should follow the [IoT Plug and Play](/azure/iot-develop/overview-iot-plug-and-play) set of [conventions](/azure/iot-develop/concepts-convention). One of these conventions is that a device should send the [Digital Twin Model Identifier (DTMI)](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/DTDL.v2.md#digital-twin-model-identifier) when it connects. The DTMI enables the IoT Central application to assign the device to the correct device template.

The [Azure IoT device SDKs](/azure/iot-hub/iot-hub-devguide-sdks) include support for the IoT Plug and Play conventions.

## Review the code

<!-- TODO: Add file to githubrepo https://github.com/Azure-Samples/iot-central-docs-samples -->
You can open the *CoffeeMaker.js* file in a text editor to see the entire code.

The `provisioningClient` object:

- Sets the `dtmi:com:example:ConnectedCoffeeMaker;1` model ID before it registers the device.
- Opens the connection in the `centralClient` object.

:::code language="js" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.js" id="ProvisioningClient":::

The `connectCallback` method:

- Starts a loop to send temperature and humidity telemetry, whether it's currently brewing and when a cup is detected every 1 second.
- Creates command handlers for two commands: `SetMaintenanceMode` and `StartBrewing`.
- Sends device properties via the device twin `DeviceWarrantyExpired` *read-only* property.
- Creates a *writable* property handler - `handleSettings`,  to set the optimal water temperature that comes from IoT Central via the device twin.

:::code language="js" source="../resources/CoffeeMaker.js" id="ConnectCallback":::

### Telemetry

The function `sendTelemetry` sends telemetry in the format that the device model specifies.

:::code language="js" source="../resources/CoffeeMaker.js" id="Telemetry":::

### Properties

The model specifies the property names and data types to synchronize property values between the device and IoT Central via the device twin. The function `sendDeviceProperties` sends the `warrantyState` of the device and the function `handleSettings` handles `OptimalTemperature` changes that come from IoT Central.

:::code language="js" source="../resources/CoffeeMaker.js" id="Properties":::

### Commands

The model specifies the command names and parameters that the device should use. The functions `onCommandMaintenance` and `onCommandStartBrewing` handle the commands sent from IoT Central.

:::code language="js" source="../resources/CoffeeMaker.js" id="Commands":::

### Cloud properties and Views

Cloud properties and Views don't affect the code that a device developer writes to implement the device model.