A device model defines how a device interacts with your IoT Central application. The device developer must make sure that the device implements the behaviors defined in the device model so that IoT Central can monitor and manage the device. A device model is made up of one or more interfaces, and each interface can define a collection of telemetry types, device properties, and commands. A solution developer can import a JSON file that defines the device model into a device template, or use the web UI in IoT Central to create or edit a device model.

A solution developer can also export a JSON file that contains the device model. A device developer can use this JSON document to understand how the device should communicate with the IoT Central application.

The JSON file that defines the device model uses the Digital Twin Definition Language (DTDL) V2. IoT Central expects the JSON file to contain the device model with the interfaces defined inline, rather than in separate files. To learn more, see the IoT Plug and Play modeling guide: [IoT Plug and Play modeling guide](/azure/iot-develop/concepts-modeling-guide)

A typical IoT device is made up of:

- Custom parts, which are the things that make your device unique.
- Standard parts, which are things that are common to all devices.

These parts are called interfaces in a device model. Interfaces define the details of each part your device implements. Interfaces are reusable across device models. In DTDL, a component refers to another interface, which may be defined in a separate DTDL file or in a separate section of the file.

## Approaches for creating a device model

To create a device model, you can:

- Use IoT Central to create a custom model from scratch.
- Import a model from a JSON file. A device builder might have used Visual Studio Code to author a device capability model for your application.
- Select one of the devices from the **Device Catalog**. This option imports the device capability model that the manufacturer has published for this device. A device capability model imported like this is automatically published.

## Manage a device model

After you create a device model, you can:

- Add capabilities and inherited interfaces to the model. A model must have at least one interface.
- Edit model metadata, such as its ID, namespace, and name.
- Delete the model.

## Interfaces and components

To view and manage the interfaces in your device model:

1. Go to **Device templates** page and select the device template you created. The interfaces are listed in the **Model** section of the device template.
1. Select the ellipsis to add an inherited interface or component to the root interface.
1. To export a model or interface select **Export**.
1. To view or edit the DTDL for an interface or a capability, select **Edit DTDL**.

:::image type="content" source="../media/interfaces-components.png" alt-text="Screenshot that shows the interfaces and components in a device template.":::

### Capabilities

Select **+ Add capability** to add capability to an interface or component. For example, you can add *Target Temperature* capability to a *SensorTemp* component.

### Telemetry

Telemetry is a stream of values sent from the device, typically from a sensor. For example, a sensor might report the ambient temperature.

The following table shows the configuration settings for a telemetry capability:

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display name
  :::column-end:::
  :::column:::
    The display name for the telemetry value used on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The name of the field in the telemetry message. IoT Central generates a value for this field from the display name, but you can choose your own value if necessary.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Capability type
  :::column-end:::
  :::column:::
    Telemetry
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Semantic type
  :::column-end:::
  :::column:::
    The semantic type of the telemetry, such as temperature, state, or event. The choice of semantic type determines which of the following fields are available.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schema
  :::column-end:::
  :::column:::
    The telemetry data type such as double, string, or vector. The available choices are determined by the semantic type. Schema isn't available for the event and state semantic types.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Severity
  :::column-end:::
  :::column:::
    Only available for the event semantic type. The severities are **Error**, **Information**, or **Warning**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    State values
  :::column-end:::
  :::column:::
    Only available for the state semantic type. Define the possible state values, each of which has display name, name, enumeration type, and value.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Unit
  :::column-end:::
  :::column:::
    A unit for the telemetry value, such as **mph**, **%**, or **°C**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display unit
  :::column-end:::
  :::column:::
    A display unit for use on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Comment
  :::column-end:::
  :::column:::
    Any comments about the telemetry capability.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Description
  :::column-end:::
  :::column:::
    A description of the telemetry capability.
  :::column-end:::
:::row-end:::

Additional customizations are available depending on the schema value. For example, if the schema is **String**, you can specify the minimum and maximum length of the string.

### Properties

Properties represent point-in-time values. You can set writable properties from IoT Central. For example, a device can use a writable property to let an operator set the target temperature.

The following table shows the configuration settings for a property capability:

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display name
  :::column-end:::
  :::column:::
    The display name for the property value used on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The name of the property. IoT Central generates a value for this field from the display name, but you can choose your own value if necessary.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Capability type
  :::column-end:::
  :::column:::
    Property.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Semantic type
  :::column-end:::
  :::column:::
    The semantic type of the property, such as temperature, state, or event. The choice of semantic type determines which of the following fields are available.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schema
  :::column-end:::
  :::column:::
    The property data type, such as double, string, or vector. The available choices are determined by the semantic type. Schema isn't available for the event and state semantic types.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    writable
  :::column-end:::
  :::column:::
    If the property isn't writable, the device can report property values to IoT Central. If the property is writable, the device can report property values to IoT Central and IoT Central can send property updates to the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Severity
  :::column-end:::
  :::column:::
    Only available for the event semantic type. The severities are **Error**, **Information**, or **Warning**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    State values
  :::column-end:::
  :::column:::
    Only available for the state semantic type. Define the possible state values, each of which has display name, name, enumeration type, and value.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Unit
  :::column-end:::
  :::column:::
    A unit for the property value, such as **mph**, **%**, or **°C**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display unit
  :::column-end:::
  :::column:::
    A display unit for use on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Comment
  :::column-end:::
  :::column:::
    Any comments about the property capability.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Description
  :::column-end:::
  :::column:::
    A description of the property capability.
  :::column-end:::
:::row-end:::

### Commands

You can call device commands from IoT Central. Commands optionally pass parameters to the device and receive a response from the device. For example, you can call a command to reboot a device in 10 seconds.

The following table shows the configuration settings for a command capability:

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display name
  :::column-end:::
  :::column:::
    The display name for the command used on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The name of the command. IoT Central generates a value for this field from the display name, but you can choose your own value if necessary.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Capability type
  :::column-end:::
  :::column:::
    Command.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queue if offline
  :::column-end:::
  :::column:::
    If enabled, you can call the command even if the device is offline. If not enabled, you can only call the command when the device is online.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Comment
  :::column-end:::
  :::column:::
    Any comments about the command capability.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Description
  :::column-end:::
  :::column:::
    A description of the command capability.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Request
  :::column-end:::
  :::column:::
    If enabled, a definition of the request parameter, including: name, display name, schema, unit, and display unit.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Response
  :::column-end:::
  :::column:::
    If enabled, a definition of the command response, including: name, display name, schema, unit, and display unit.
  :::column-end:::
:::row-end:::
