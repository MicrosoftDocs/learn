Before getting started with your first firmware update on an IoT device, let's describe what it actually means to implement such an operation, and how Azure IoT Hub helps making the process simpler and more scalable.

## What does updating an IoT device's firmware imply?

IoT devices most often are powered by optimized operating systems, or even sometimes running code directly on the silicon (without the need for an actual operating system). To update the software running on these kind of devices, the most common method is to flash a new version of the entire software package, including the OS and the apps running on it (called firmware).

Because each device has a specific purpose, its firmware is also specific and optimized for the purpose of the device, as well as the constrained resources available.

The process for updating a device's firmware is also something that can be specific to the hardware itself and to the way the hardware manufacturer does things. You will need to work with your device manufacturer to get the details of the firmware update process (unless you are developing your own hardware, which means you probably know what the firmware update process is).

While firmware updates can be (and used to be) applied manually on devices, that option is no longer viable considering the rapid growth in scale of IoT solutions. Firmware updates are now more commonly done over-the-air (OTA) with deployments of new firmware managed remotely from the cloud.

There is a set of common denominators to all OTA firmware updates for IoT devices:

- Firmware versions are uniquely identified.
- Firmware comes in a binary file format that the device will need to acquire from an online source.
- Firmware is locally stored in some form of physical storage (ROM memory, hard drive, and so on).
- Device manufacturer provides instructions for implementing the sequence of operations required to update the firmware.

## Azure IoT Hub Automatic Device Management

Azure IoT Hub offers advanced support for implementing device management operations on a single and on collections of devices. The [Automatic Device Management](/azure/iot-hub/iot-hub-auto-device-config) feature simplifies the configuration of a set of operations, trigger them, and then monitor their execution.

In the following exercise, you'll create a device simulator that will manage the device twin desired properties changes, and will trigger a local process simulating a firmware update. The overall process would be exactly the same for a real device with the exception of the actual steps for the local firmware update. You'll then use the Azure portal to configure and execute a firmware update for a single device. IoT Hub will use the device twin properties to transfer the configuration change request to the device and monitor the progress as shown in the following diagram:

:::image type="content" source="../media/firmware-update-diagram.png" alt-text="Firmware Update Configuration.":::

Ready to get started? Let's start with some coding.