Microsoft Azure provides a rich set of integrated public cloud services for all your IoT solution needs. The IoT Hub Device Provisioning Service is a helper service for IoT Hub that enables zero-touch, just-in-time provisioning to the right IoT hub without requiring human intervention, enabling customers to provision millions of devices in a secure and scalable manner.

## Features of the Device Provisioning Service

 -  Secure attestation support for both X.509 and TPM-based identities.
 -  Enrollment list containing the complete record of devices/groups of devices that may at some point register. The enrollment list contains information about the desired configuration of the device once it registers, and it can be updated at any time.
 -  Multiple allocation policies to control how the Device Provisioning Service assigns devices to IoT hubs in support of your scenarios.
 -  Monitoring and diagnostics logging to make sure everything is working properly.
 -  Multi-hub support allows the Device Provisioning Service to assign devices to more than one IoT hub. The Device Provisioning Service can talk to hubs across multiple Azure subscriptions.
 -  Cross-region support allows the Device Provisioning Service to assign devices to IoT hubs in other regions.
 -  Encryption for data at rest allows data in DPS to be encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant.

## Cross-platform support

The Device Provisioning Service, like all Azure IoT services, works cross-platform with several operating systems. Azure offers open-source SDKs in various programming languages to facilitate connecting devices and managing the service. The Device Provisioning Service supports the following protocols for connecting devices:

 -  HTTPS
 -  AMQP
 -  AMQP over web sockets
 -  MQTT
 -  MQTT over web sockets

The Device Provisioning Service only supports HTTPS connections for service operations.

## When to use Device Provisioning Service

There are many provisioning scenarios in which the Device Provisioning Service is an excellent choice for getting devices connected and configured to IoT Hub, such as:

 -  Zero-touch provisioning to a single IoT solution without hardcoding IoT Hub connection information at the factory (initial setup)
 -  Load-balancing devices across multiple hubs
 -  Connecting devices to their owner’s IoT solution based on sales transaction data (multitenancy)
 -  Connecting devices to a particular IoT solution depending on use-case (solution isolation)
 -  Connecting a device to the IoT hub with the lowest latency (geo-sharding)
 -  Reprovisioning based on a change in the device
 -  Rolling the keys used by the device to connect to IoT Hub (when not using X.509 certificates to connect)
