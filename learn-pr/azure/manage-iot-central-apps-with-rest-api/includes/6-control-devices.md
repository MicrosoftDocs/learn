The REST API lets you programmatically control the devices connected to your IoT Central application.

To simplify the job of a fleet manager, you've been asked to integrate IoT Central device control capabilities into the existing fleet management application. Fleet managers want to use the existing fleet management application to control the devices connected your IoT Central application.

Here, you'll learn how to use the REST API to retrieve telemetry values, read and set device properties, and send commands to the devices.

## Telemetry

The telemetry a device sends is defined in the device template. Each telemetry definition includes a name and a type. Telemetry types can be simple types such as integers and strings, or complex types such as enumerations or objects.

The IoT Central REST API lets you retrieve the last known value of any telemetry type for a connected device or run queries to retrieve device telemetry.

## Device properties

The properties that a device supports are defined in the device template. IoT Central uses two types of property to store information about devices. *Device properties* are stored on a real or simulated device. *Cloud properties* are stored in the IoT Central application and are associated with specific devices.

For example, a device property could enable a device to report the current firmware version of the device. Device property values are only reported to IoT Central when the device starts up or when the property value changes.

A device property can, optionally, be writeable. An operator can use an IoT Central application to set a value for a writeable property on a device. For example, an application could use a writeable property to set the target temperature for a thermostat on a device.

An example of a cloud property is the date the device was last serviced. The device doesn't need this information to function, but it's useful data to track in the fleet management application.

The IoT Central REST API lets you:

- Run queries to retrieve device property values
- Get the device properties for a device
- Update the writeable device properties for a device
- Get the cloud properties associated with a device
- Update the cloud properties associated with a device

## Device commands

The commands that a device supports are defined in the device template. IoT Central sends commands to devices to control the device behavior. Commands can take parameters and return values.

For example, a device could respond to a command that asks it to reboot or that asks it to change the frequency at which it sends telemetry values.

The IoT Central REST API lets you:

- Execute a command on a device
- View the history of sending a command to a device

## Components and modules

A device template may group telemetry, properties, and commands into reusable components. The IoT Central devices REST API lets you:

- Retrieve the last known value of any telemetry type from a component on a device
- Get the device properties from a component on a device
- Update the writeable device properties on a component on a device
- Execute a command on a component on a device
- View the history of sending a command to a component on a device

A device template can also describe the capabilities of an IoT Edge device that's connecting to your application. The capabilities of an IoT Edge device are implemented in IoT Edge modules. An IoT Edge device can have one of more modules. The IoT Central devices REST API lets you:

- Retrieve the last known value of any telemetry type from a module on a device
- Get the device properties from a module on an IoT Edge device
- Update the writeable device properties on a module on an IoT Edge device
- Execute a command on a module on an IoT Edge device
- View the history of sending a command to a module on an IoT Edge device

An IoT Edge module can also use components to group its capabilities. The IoT Central REST API lets you work with telemetry, properties, and commands defined on component, in a module, on an IoT Edge device.
