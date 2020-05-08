The REST API lets you programmatically control the devices connected to your IoT Central application.

To simplify the job of a store manager, you've been asked to integrate IoT Central device control capabilities into the existing store management application. Store managers want to use the existing store management application to control the devices connected your IoT Central application.

Here, you'll learn how to use the REST API to set device properties and send commands to the devices.

## Device properties

The properties that a device supports are defined on interfaces in the device template. IoT Central uses two types of property to store information about devices. *Device properties* are stored on a real or simulated device. *Cloud properties* are stored in the IoT Central application and are associated with specific devices.

For example, a device property could enable a device to report the current firmware version of the device. Device property values are only reported to IoT Central when the device starts up or when the property value changes.

A device property can, optionally, be writeable. An operator can use an IoT Central application to set a value for a writeable property on a device. For example, an application could use a writeable property to set the target temperature for a thermostat on a device.

An example of a cloud property is the date the device was last serviced. The device doesn't need this information to function, but it's useful data to track in the store management application.

## Use the REST API to work with device properties

The IoT Central REST API lets you:

- Get the device properties for a device
- Update the writeable device properties for a device
- Get the device properties for a specific interface on a device
- Update the writeable device properties for a specific interface on a device
- Get the cloud properties associated with a device
- Update the cloud properties associated with a device

## Device commands

The commands that a device supports are defined on interfaces in the device template. IoT Central sends commands to devices to control the device behavior. Commands can take parameters and return values.

For example, a device could respond to a command that asks it to reboot or that asks it to change the frequency at which it sends telemetry values.

## Use the REST API to control devices

The [IoT Central REST API for devices](https://docs.microsoft.com/rest/api/iotcentral/devices) lets you:

- Execute a command on a device
- View the history of sending a command to a device
- Get, set, and update properties
