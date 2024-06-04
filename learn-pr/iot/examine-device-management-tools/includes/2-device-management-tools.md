IoT devices can be managed using the following Azure IoT Hub device management tools.

| Tool | Description |
| ------- | ----------- |
| Azure portal | A web-based user interface. |
| Azure CLI with the Azure IoT extension | A cross-platform text-based CLI that runs from a command shell. |
| Visual Studio Code using the Azure IoT Hub extension | A menu-based IoT device configuration and control user interface that runs within Visual Studio Code. |

Recall that as an electrical power system operator, you detected a faulty power monitoring device. You use the Azure portal to send a direct method to the malfunctioning device, instructing it to go offline and stop sending messages. You receive confirmation that the device has executed the command successfully. You then update the device twin of the malfunctioning device, setting the status property to `offline`. You then dispatch a technician to maintenance the malfunctioning device.

Here, you learn about the features of the three device management tools for Azure IoT.

The following feature comparison table lists a summary of the capabilities of each device maintenance tool.

| Feature | Azure portal | Azure CLI using the Azure IoT extension | Visual Studio Code using the Azure IoT Hub extension |
| --- | --- | --- | --- |
| Invoke a direct method on a device | X | X | X |
| Read device twin properties for a device | X | X | X |
| Update desired device twin properties for a device | X | X | X |
| Update device twin tags for a device | X | X | X |
| Perform device twin queries | X | X |  |
| List existing devices in an IoT hub | X | X | X |
| Create and delete device identities | X | X | X |
| Implement automatic device management | X | X |  |
| Update a device using the Device Update for IoT Hub service | X | X |  |
