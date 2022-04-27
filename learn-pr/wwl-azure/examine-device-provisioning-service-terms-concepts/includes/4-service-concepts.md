Device provisioning with the Device Provisioning Service is a two part process. The first part is establishing the initial connection between the device and the IoT solution by registering the device. The second part is applying the proper configuration to the device based on the specific requirements of the solution. Once both steps have been completed, the device has been fully provisioned. Device Provisioning Service automates both steps to provide a seamless provisioning experience for the device.

## Service operations endpoint

The service operations endpoint is the endpoint for managing the service settings and maintaining the enrollment list. This endpoint is only used by the service administrator; it is not used by devices.

## Device provisioning endpoint

The device provisioning endpoint is the single endpoint all devices use for autoprovisioning. The URL is the same for all provisioning service instances, to eliminate the need to reflash devices with new connection information in supply chain scenarios. The ID scope ensures tenant isolation.

## Linked IoT hubs

The Device Provisioning Service can only provision devices to IoT hubs that have been linked to it. Linking an IoT hub to an instance of the Device Provisioning Service gives the service read/write permissions to the IoT hub's device registry; with the link, a Device Provisioning Service can register a device ID and set the initial configuration in the device twin. Linked IoT hubs may be in any Azure region. You may link hubs in other subscriptions to your provisioning service.

## Allocation policy

The service-level setting that determines how Device Provisioning Service assigns devices to an IoT hub. There are three supported allocation policies:

 -  Evenly weighted distribution: linked IoT hubs are equally likely to have devices provisioned to them. The default setting. If you are provisioning devices to only one IoT hub, you can keep this setting.
 -  Lowest latency: devices are provisioned to an IoT hub with the lowest latency to the device. If multiple linked IoT hubs would provide the same lowest latency, the provisioning service hashes devices across those hubs.
 -  Static configuration via the enrollment list: specification of the desired IoT hub in the enrollment list takes priority over the service-level allocation policy.
 -  Custom (Use Azure Function): A custom allocation policy gives you more control over how devices are assigned to an IoT hub. This is accomplished by using custom code in an Azure Function to assign devices to an IoT hub. The device provisioning service calls your Azure Function code providing all relevant information about the device and the enrollment to your code. Your function code is executed and returns the IoT hub information used to provisioning the device.

## Enrollment

An enrollment is the record of devices that may register through autoprovisioning. The two types of enrollments supported by Device Provisioning Service are *group enrollment* and *individual enrollment*.

 -  Group enrollment: An enrollment group is recommended for a large number of devices that share a desired initial configuration, or for devices all going to the same tenant.
 -  Individual enrollment: Individual enrollments are recommended for devices that require unique initial configurations, or for devices that can only authenticate using SAS tokens via TPM attestation.

The enrollment record contains information about the device or group of devices, including:

 -  The attestation mechanism used by the device
 -  The optional initial desired configuration
 -  Desired IoT hub
 -  The desired device ID

## Registration

A registration is the record of a device successfully registering/provisioning to an IoT Hub via the Device Provisioning Service. Registration records are created automatically; they can be deleted, but they cannot be updated.

## Operations

Operations are the billing unit of the Device Provisioning Service. One operation is the successful completion of one instruction to the service. Operations include device registrations and re-registrations; operations also include service-side changes such as adding enrollment list entries, and updating enrollment list entries.
