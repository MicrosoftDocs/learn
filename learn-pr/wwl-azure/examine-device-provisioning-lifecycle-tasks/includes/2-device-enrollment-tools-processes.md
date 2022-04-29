A device enrollment creates a record of a single device or a group of devices that may at some point register with the Azure IoT Hub Device Provisioning Service. The enrollment record contains the initial configuration for the device(s) as part of that enrollment.

The tool that you choose for a particular device enrollment scenario, and the corresponding implementation steps, will vary based on situational requirements, but the processes are discrete and defined.

## Device enrollment processes

There are three enrollment processes that you will need to perform on a semi-regular basis:

 -  Create: Create an enrollment when you need to prepare a device that you want to have ready to register with the Azure IoT Hub Device Provisioning Service. The enrollment record will contain the initial desired configuration for the device.
 -  Update: Update a device enrollment if you want to change the IoT Hub that the device should be linked to, the device ID, or the initial device twin state for the device.
 -  Remove: Remove enrollments when an enrolled device will not be provisioned to an IoT Hub.

## Device enrollment tools

There are two primary approaches for performing device enrollments that you should be familiar with:

 -  Azure portal: Use the Device Provisioning Service in the portal.
 -  Programmatic tools: Azure CLI and the Service SDKs.
