IoT devices can be managed using the following Azure IoT Hub device management tools.

| Tool | Description |
| ------- | ----------- |
| Azure portal | A web-based user interface. |
| Azure CLI with the Azure IoT extension | A cross-platform text-based CLI that runs from a command shell. |
| Visual Studio Code using the Azure IoT Hub extension | A menu-based IoT device configuration and control user interface that runs within Visual Studio Code. |

Recall that as an electrical power system operator, you detected a faulty power monitoring device. You use the Azure portal to send a direct method to the malfunctioning device, instructing it to go offline and stop sending messages. You receive confirmation that the device has executed the command successfully. You then update the device twin of the malfunctioning device, setting the status property to `offline` and add a reported property reason with the value `malfunction`. You then dispatch a technician to maintenance the malfunctioning device.

Here, you learn about the features of the three device management tools for Azure IoT.

The following feature comparison table lists a summary of the capabilities of each device maintenance tool.

| Feature | Azure portal | Azure CLI using the Azure IoT extension | Visual Studio Code using the Azure IoT Hub extension |
| --- | --- | --- | --- |
| Invoke a direct method on a device | Yes | Yes | Yes |
| Read device twin properties for a device | Yes | Yes | Yes |
| Update desired device twin properties for a device | Yes | Yes | Yes |
| Update device twin tags for a device | Yes | Yes | Yes |
| Perform device twin queries | Yes | Yes | No |
| List existing devices in an IoT hub | Yes | Yes | Yes |
| Create and delete device identities | Yes | Yes | Yes |
| Implement automatic device management | Yes | Yes | No |
| Update a device using the Device Update for IoT Hub service | Yes | Yes | No |
