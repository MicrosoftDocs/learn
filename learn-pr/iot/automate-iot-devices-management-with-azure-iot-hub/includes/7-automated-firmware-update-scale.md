In this unit you will learn what the challenges and risks are and how to manage large groups of IoT devices.

## Challenges and risks of configuring large groups of devices

Let's get back to our cheese cave environment solution company. Now that we have tested that the firmware update configuration is working on one device in the lab, we need to start deploying the new features and security updates to all our customers.
But you want to be careful to not accidentally brick all devices at one customer's location. Lots of things can go wrong when doing a firmware update over the air at scale: firmware not working as expected on different variations and versions of the hardware, connectivity loss during FW update process, power loss, operator interacting with device at the same time a device is being updated.

To limit the risks of disrupting your customers' production and the cost of a large-scale firmware update fail, the best way to implement a firmware update campaign is usually to proceed in batches: you deploy the firmware on a small set of devices, then if successful you start the deployment on the next group of devices.  

## Manage group of devices with Device Twins tags

The first thing that you will need to do when managing groups of devices via Azure IoT Hub is to assign meta data to your devices to group them depending on their location, the hardware version, the customer's name. To store that metadata and make it available to your solution, you can use the Device Twins tags. See [Understand and use device twins in Azure IoT Hub](https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-device-twins) to learn more.

## Putting theory in practice

In the next unit you will:

- Prepare two new firmware update configurations (one for each of the devices group)
- Create and monitor progress of first configuration
- Create two sets of device identities in IoT Hub with two different sets of tags
- Run simulators for each of these devices
- Once first configuration successfully ends, start and monitor the second configuration.
