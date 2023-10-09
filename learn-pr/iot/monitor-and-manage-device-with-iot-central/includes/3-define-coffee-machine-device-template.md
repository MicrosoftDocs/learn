A device template in Azure IoT Central is a blueprint that defines the characteristics and behaviors of a type of device that connects to your application. For example, the device template defines the telemetry that a device sends, so that IoT Central can create visualizations that use the correct units and data types.

A device template includes the following sections:
- A *device model*. The data that the coffee machine simulator exchanges with your application is specified in a device model.
    - *Root component*. The root component's interface describes capabilities that are specific to the device model.
    - *Components*. A device model may include components in addition to the root component to describe device capabilities. In this scenario, you'll only use the root component to define the *Connected Coffee Maker* model.
    - *Inherited interfaces*. A device model contains one or more interfaces that extend the capabilities of the root component. In this scenario, you'll define only one interface.
- *Views*. This part of the device template lets you define visualizations to view data from the device, and forms to manage and control the coffee machine.

After you create a device template, you can connect a simulated device. The simulated device generates telemetry so you can test the behavior of your application before connecting a real device.

Here, you'll see how telemetry, properties, and commands definitions are specified in the device model, and the cloud properties and views needed to manage and control the devices in the IoT enabled coffee machines example.

### Telemetry

Telemetry is the data that streams from your device. You can add multiple telemetry types to your device template to match the capabilities of your device. The coffee machine sends air humidity and water temperature values from its sensors. It also sends state information about whether it's currently brewing and when a cup is detected.

### Properties

Use properties to share configuration data between a device and your application.

In this scenario, you use a *writeable* property to set the optimal water temperature and send it to the coffee machine. When the writeable property is updated in IoT Central, it's marked as pending in the UI until the device acknowledges that it has responded to the update.

You can use *read-only* properties to enable a device to send values to your application. Read-only properties can only be changed by the device. In this scenario, you define a read-only device property called `Device Warranty Expired` in the device template. The `Device Warranty Expired` field remains empty until the coffee machine is connected to IoT Central. Once connected, the coffee machine sends the warranty status to the application.

Cloud properties are device metadata that's associated with the device. Use cloud properties to record information about your device in your IoT Central application. In this scenario, you use cloud properties to record the ideal water temperature range of the coffee machine. Cloud properties are stored in the IoT Central application and don't synchronize with the device.

### Commands

Use commands to remotely manage your device from your application. You can directly run commands on the device from the cloud to control the device. In this scenario, you run commands on your coffee machine to set it to maintenance mode or to start brewing.

### Views

You can customize the UI that IoT Central displays for managing and monitoring devices associated with the device template. In this scenario, you create a view to plot the telemetry values sent from the device, and create a form to manage the device properties.

## Connected Coffee Maker model

A device model is the part of the device template that defines the telemetry, properties, and commands that a device supports. You can store a device capability model in a JSON file and import it into IoT Central. The following JSON is the device capability model for the connected coffee machine.

:::code language="json" source="~/../iot-central-docs-samples/monitor-manage-device-with-iotcentral/CoffeeMaker.json":::

- The `@id` field is the [Digital Twin Model Identifier (DTMI)](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/DTDL.v2.md#digital-twin-model-identifier) for the model, in the format `dtmi:<domain>:<unique-model-identifier>;<model-version-number>`.
- The `@type` identifies the kind of information being described. For example, `"@type": "Interface"` is used to indicate the type of the [Digital Twin Definition Language (DTDL)](/azure/digital-twins/concepts-models) entity. In this case, the entity is an `Interface`.
- The `contents` field is an array of attribute definitions. Each attribute must provide a `@type` to identify the sort of interface information it describes. In this case, `Telemetry`, `Property`, and `Command` objects describe the features of the connected coffee maker.
- The `displayName` field is an object that provides a human-readable name for the interface or entity in different languages. In this case, the interface `displayName` is `Connected Coffee Maker` in English.
- The `@context` field is used to specify the DTDL context in which the interface or entity is defined. In this case, it references the `iotcentral` and `dtdl` contexts.
- The `name` field is a unique identifier for the `Telemetry`, `Property`, or `Command`.
- Each telemetry field represent measurements or events, and are often used to describe device sensor readings. For example, `Water Temperature` has a `schema` of `double` and a `unit` of `degreeCelsius`. The `decimalPlaces`, `maxValue`, and `minValue` fields specify more details about the telemetry data.
- Each property field represents the state of an entity. For example, `Device Warranty Expired` is of type boolean and can have its state set by the connected device as true or false.
- The `writable` field specifies whether the property can be set from the IoT Central application. In this case, `Optimal Temperature` can be set from the application UI, while `Device Warranty Expired` can't.
- If a property has `Cloud` in the list of types, then it is a Cloud Property. In this case, `Coffee Maker Min Temperature` and `Coffee Maker Max Temperature` are cloud properties.
- Each command field describes an action that the device can perform. For example, `Start Brewing` is a command that the cloud can send to the device to begin brewing coffee.
- The `commandType` field specifies whether a command is synchronous (waits for a response), or asynchronous (doesn't wait for a response).