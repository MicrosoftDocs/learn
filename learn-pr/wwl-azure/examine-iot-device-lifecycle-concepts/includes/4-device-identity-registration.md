Every IoT hub has an identity registry that stores information about the devices permitted to connect to the IoT hub. Before a device can connect to an IoT hub, there must be an entry for that device in the IoT hub's identity registry. A device must also authenticate with the IoT hub based on credentials stored in the identity registry.

The device ID stored in the identity registry is case-sensitive.

At a high level, the identity registry is a REST-capable collection of device identity resources. When you add an entry in the identity registry, IoT Hub creates a set of per-device resources such as the queue that contains in-flight cloud-to-device messages.

Use the identity registry when you need to:

 -  Provision devices that connect to your IoT hub.
 -  Control per-device access to your hub's device-facing endpoints.

## Module identity

For more sophisticated device implementations, IoT Hub enables you to configure subcomponents of the device by creating "module identities" under a device identity. Each module identity can be configured with an independent connection to IoT Hub, which means you can configure separate access control permissions. For example, you could separate access to diagnostic controls form general operator controls of a device. You can create up to 20 module identities under a device identity.

## Identity registry operations

The IoT Hub identity registry exposes the following operations:

 -  Create device or module identity.
 -  Update device or module identity.
 -  Retrieve device or module identity by ID.
 -  Delete device or module identity.
 -  List up to 1000 identities.
 -  Export device identities to Azure blob storage.
 -  Import device identities from Azure blob storage.

## Create an IoT device using the Azure portal

When you create a new IoT device using the Azure portal, you will specify a device ID and a method for device authentication. IoT hub uses an identity registry to store information about the individual devices that are permitted to connect to it.

 -  Device ID: The device identity is a unique identifier that is assigned to a device.
 -  Authentication Type: Device authentication can be accomplished using either a Symmetric key pair or X.509 Certificate. The certificate can either be self-signed or come from a certificate authority.
