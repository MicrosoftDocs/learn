Back-end apps can use Azure IoT Hub primitives, such as device twins and direct methods, to remotely start and monitor device management actions on devices.

## Patterns

IoT Hub enables the following set of device management patterns.

**Reboot**: The back-end app informs the device through a direct method that it has initiated a reboot. The device uses the reported properties to update the reboot status of the device.

:::image type="content" source="../media/m08-l01-device-management-reboot-pattern-67a697c2.png" alt-text="Diagram that shows the Reboot device management pattern.":::


**Factory reset**: The back-end app informs the device through a direct method that it has initiated a factory reset. The device uses the reported properties to update the factory reset status of the device.

:::image type="content" source="../media/m08-l01-device-management-factory-reset-pattern-ae2bcf97.png" alt-text="Diagram that shows the Factory reset device management pattern.":::


**Configuration**: The back-end app uses the desired properties to configure software running on the device. The device uses the reported properties to update configuration status of the device.

:::image type="content" source="../media/m08-l01-device-management-configuration-pattern-b0be34d8.png" alt-text="Diagram that shows the Configuration device management pattern.":::


**Firmware update**: The back-end app uses an automatic device management configuration to select the devices to receive the update, to tell the devices where to find the update, and to monitor the update process. The device initiates a multistep process to download, verify, and apply the firmware image, and then reboot the device before reconnecting to the IoT Hub service. Throughout the multistep process, the device uses the reported properties to update the progress and status of the device.

:::image type="content" source="../media/m08-l01-device-management-firmware-update-pattern-3deee818.png" alt-text="Diagram that shows the Firmware update device management pattern.":::


**Reporting progress and status**: The solution back end runs device twin queries, across a set of devices, to report on the status and progress of actions running on the devices.

:::image type="content" source="../media/m08-l01-device-management-reporting-progress-status-pattern-970ff9d5.png" alt-text="Diagram that shows the Reporting progress and status device management pattern.":::


## Approaches

You can use a direct method to initiate device management actions (such as reboot, factory reset, and firmware update) from a back-end app in the cloud. The device is responsible for:

 -  Handling the method request sent from IoT Hub.
 -  Initiating the corresponding device-specific action on the device.
 -  Providing status updates through reported properties to IoT Hub.

You can use a back-end app in the cloud to run device twin queries to set a device twin desired property or to report on the progress of your device management actions. The device is responsible for:

 -  Handling the property changed event and updating the local variables that correspond to the device twin desired property.
 -  Communicating the device twin reported property setting to IoT hub after the updated desired property has been implemented successfully.
