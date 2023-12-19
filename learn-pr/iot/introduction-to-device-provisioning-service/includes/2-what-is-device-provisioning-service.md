Your team has developed a working proof-of-concept for your IoT solution, but so far in the development and testing phase you've been manually configuring each device with its registration and authentication info as well as the details of which IoT Hub to connect to. This approach won't scale when you move to the manufacturing and production phase. Now, you're evaluating whether Azure IoT Hub Device Provisioning Service is the right solution for this challenge.

Device Provisioning Service (DPS) is a helper service for Azure IoT Hub. It provides zero-touch, just-in-time provisioning of devices to the right IoT hub.

In the context of provisioning IoT devices to their cloud solution, provisioning is a two part process:

* The first part is establishing the initial connection between the device and the IoT solution by registering the device.
* The second part is applying the proper configuration to the device based on the specific requirements of the solution it was registered to.

Once both of those two steps have been completed, we can say that the device has been fully provisioned. The Device Provisioning Service automates both steps to provide a seamless provisioning experience for the device.

## Key terms and features

* Secure attestation support for both X.509 and TPM-based identities.
* Enrollment lists contain the complete record of devices/groups of devices that may at some point register. The enrollment list contains information about the desired configuration of a device once it registers, and it can be updated at any time.
* Allocation policies control how DPS assigns devices to IoT hubs.
* Multi-hub support allows DPS to assign devices to more than one IoT hub, even IoT hubs across multiple Azure regions or subscriptions.
* Encryption for data at rest allows data in DPS to be encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant.

### Device provisioning endpoint

The device provisioning endpoint is the single endpoint that all devices use for provisioning with DPS. The URL is the same for all provisioning service instances, to eliminate the need to reflash devices with new connection information in supply chain scenarios.

When devices connect to the provisioning endpoint, they present the unique ID scope for their provisioning instance, which ensures tenant isolation.

### Linked IoT hubs

The Device Provisioning Service can only provision devices to IoT hubs that are linked to it. Linking an IoT hub to an instance of the Device Provisioning Service gives the service read/write permissions to the IoT hub's device registry; with the link, a Device Provisioning Service can register a device ID and set the initial configuration in the device twin. Linked IoT hubs can be in any Azure region. You also can link hubs in other subscriptions to your provisioning service.

### Allocation policy

The allocation policy is a service-level setting that determines how Device Provisioning Service assigns devices to an IoT hub. There are three supported allocation policies:

* **Evenly weighted distribution**: linked IoT hubs are equally likely to have devices provisioned to them. This policy is the default setting. If you're provisioning devices to only one IoT hub, you can keep this setting.
* **Lowest latency**: devices are provisioned to an IoT hub with the lowest latency to the device. If multiple linked IoT hubs would provide the same lowest latency, the provisioning service hashes devices across those hubs.
* **Static configuration via the enrollment list**: specification of the desired IoT hub in the enrollment list takes priority over the service-level allocation policy.
* **Custom (Use Azure Functions)**: A custom allocation policy gives you more control over how devices are assigned to an IoT hub. This is accomplished by using custom code in an Azure Function to assign devices to an IoT hub. The Device Provisioning Service calls your Azure Function code, providing all relevant information about the device and the enrollment to your code. Your function code is executed and returns the IoT hub information used to provisioning the device.

### Enrollment

An enrollment is a record of devices that may register through autoprovisioning. The two types of enrollments supported by Device Provisioning Service are *group enrollment* and *individual enrollment*.

The enrollment record contains information about the device or group of devices, including:

* The attestation mechanism used by the device
* The optional initial desired configuration
* Desired IoT hub
* The desired device ID

### Registration

A registration is the record of a device successfully registered to an IoT hub via the Device Provisioning Service. Registration records are created automatically; they can be deleted, but they can't be updated.

### Operations

Operations are the billing unit of the Device Provisioning Service. One operation is the successful completion of one instruction to the service. Operations include device registrations and re-registrations; operations also include service-side changes such as adding enrollment list entries, and updating enrollment list entries.
