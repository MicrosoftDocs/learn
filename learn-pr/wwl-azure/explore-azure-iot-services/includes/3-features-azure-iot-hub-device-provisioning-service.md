## Registration and provisioning

Provisioning means various things depending on the industry in which the term is used. In the context of provisioning IoT devices to their cloud solution, provisioning is a two part process:

 -  The first part is establishing the initial connection between the device and the IoT solution by registering the device.
 -  The second part is applying the proper configuration to the device based on the specific requirements of the solution it was registered to.

Once both of those two steps have been completed, we can say that the device has been fully provisioned. Some cloud services only provide the first step of the provisioning process, registering devices to the IoT solution endpoint, but do not provide the initial configuration. The Device Provisioning Service automates both steps to provide a seamless provisioning experience for the device.

## When to use Device Provisioning Service

There are many provisioning scenarios in which the Device Provisioning Service is an excellent choice for getting devices connected and configured to IoT Hub, such as:

 -  Zero-touch provisioning to a single IoT solution without hardcoding IoT Hub connection information at the factory (initial setup).
 -  Load-balancing devices across multiple hubs.
 -  Connecting devices to their owner’s IoT solution based on sales transaction data (multitenancy).
 -  Connecting devices to a particular IoT solution depending on use-case (solution isolation).
 -  Connecting a device to the IoT hub with the lowest latency (geo-sharding).
 -  Reprovisioning based on a change in the device.
 -  Rolling the keys used by the device to connect to IoT Hub (when not using X.509 certificates to connect).

Many of the manual steps traditionally involved in provisioning are automated with the Device Provisioning Service to reduce the time to deploy IoT devices and lower the risk of manual error.

## Features of the Device Provisioning Service

The Device Provisioning Service has many features, making it ideal for provisioning devices.

 -  Secure attestation support for both X.509 and TPM-based identities.
 -  Enrollment list containing the complete record of devices/groups of devices that may at some point register. The enrollment list contains information about the desired configuration of the device once it registers, and it can be updated at any time.
 -  Multiple allocation policies to control how the Device Provisioning Service assigns devices to IoT hubs in support of your scenarios.
 -  Monitoring and diagnostics logging to make sure everything is working properly.
 -  Multi-hub support allows the Device Provisioning Service to assign devices to more than one IoT hub. The Device Provisioning Service can talk to hubs across multiple Azure subscriptions.
 -  Cross-region support allows the Device Provisioning Service to assign devices to IoT hubs in other regions.
