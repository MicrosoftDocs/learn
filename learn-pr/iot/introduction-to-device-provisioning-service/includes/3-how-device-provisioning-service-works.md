Azure IoT Hub Device Provisioning Service (DPS) automates many of the manual steps that are traditionally involved in provisioning devices. This reduces the time to deploy IoT devices and lowers the risk of manual error.

## Phases of provisioning

Provisioning with DPS can be broken into the following phases:

* **Service configuration** - manual - Configure the Azure IoT Hub Device Provisioning Service, creating the service instance and linking it to one or more IoT hubs. This phase is commonly completed by a *cloud administrator*.

* **Device enrollment** - manual - Manage the lists of devices that might attempt to register with the service instance. The steps for managing enrollment lists depend on which attestation method you choose. For example, if your devices use Trusted Platform Module (TPM) attestation, then you would create an individual enrollment for each device using its unique registration ID and endorsement key. Or, if your devices use X.509 certificates, you can create a group enrollment using a signing certificate, and any device that presents a valid downstream certificate is recognized as part of that group. This phase is commonly completed by a *cloud administrator*.

* **Device preconfiguration** - manual - Develop the registration software, which is built using a Device Provisioning Service client SDK appropriate for the device and attestation mechanism. The registration software includes a device provisioning agent and service details about how to make the initial connection with DPS. This phase is commonly completed by a *provisioning agent developer*, and then a *system integrator* is responsible for integrating the registration software onto the devices.

* **Device registration and configuration** - automated - Once the previous phases are completed, the device is ready to be provisioned on first boot up. In production environments, this phase can occur weeks or months after the previous phases.

The roles listed in this section are functional roles that can be performed by the same person or by a combination of people or companies that are involved in your device manufacturing, development, and distribution chain.

## Device registration details

This section describes what goes on behind the scenes when a device is provisioned with DPS.

Device registration is initiated upon boot up by registration software. The software establishes a connection to the provisioning service for authentication of the device, and subsequent registration in the IoT Hub. Upon successful registration, the device is provided with its IoT Hub unique device ID and connection information, allowing it to pull its initial configuration and begin the telemetry process.

:::image type="content" source="../media/device-provisioning-flow.png" alt-text="Diagram that shows what goes on behind the scenes to get a device provisioned.":::

In this diagram, all the manual preconfiguration steps are complete. The DPS instance is configured with enrollment lists, and the device has its registration software installed. Now, the device is waiting to be turned on the first time, and the following steps begin automatically upon initial boot up:

1. The device powers on, connects to the DPS endpoint, and presents its authentication credentials.
1. The DPS instance checks the identity of the device against its enrollment list. Once the device identity is verified, DPS assigns the device to an IoT hub and registers it in the hub. DPS also passes the device's initial desired twin state to the IoT hub if that was configured in the enrollment lists.
1. The DPS instance receives the device ID and registration information from the assigned hub and passes that information back to the device.
1. The device uses its registration information to connect directly to its assigned IoT hub and authenticate.
1. Once authenticated, the device and IoT hub begin communicating directly. The DPS instance has no further role as an intermediary unless the device needs to reprovision.
