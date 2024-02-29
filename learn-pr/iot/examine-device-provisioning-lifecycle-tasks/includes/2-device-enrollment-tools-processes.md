A device enrollment creates a record of a single device or a group of devices that may at some point register with the Azure IoT Hub Device Provisioning Service (DPS).

The enrollment record contains the initial configuration for the device(s) as part of that enrollment. Included in the configuration is either the Azure IoT hub to which a device is assigned, or an allocation policy that configures the Azure IoT hub from a set of Azure IoT hubs.

The Device Provisioning Service supports two types of enrollments:

* **Enrollment groups**: Used to enroll multiple related devices.
* **Individual enrollments**: Used to enroll a single device.

## Device enrollment tools

There are four tools that you can use to perform DPS device enrollment tasks:

* [Azure portal](/azure/iot-dps/how-to-manage-enrollments)
* [DPS CLI commands](/cli/azure/iot/dps)
* [DPS PowerShell commands](/powershell/module/az.deviceprovisioningservices/)
* [DPS SDKs](/azure/iot-dps/libraries-sdks)

## Device enrollment tasks

There are several DPS enrollment processes that you may need to perform on a semi-regular basis:

* **Create an enrollment group**: An enrollment group is an entry for a group of devices that share a common attestation mechanism. Use an enrollment group for a large number of devices that share an initial configuration, or for devices that go to the same tenant. Enrollment groups support devices that use either symmetric key or X.509 certificates attestation.
* **Create an individual enrollment**: An individual enrollment is an entry for a single device that may be assigned to an Azure IoT hub. Devices using symmetric key, X.509 certificates, and TPM attestation are supported.
* **Update an enrollment entry**: Update an existing group or individual enrollment entry. On the enrollment entry details page, you can update all items, except the security type and credentials.
* **Remove a device enrollment**: Remove an existing group or individual enrollment.
