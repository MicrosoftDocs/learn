IoT devices can be managed using the following Azure IoT device management tools.

| Tool | Description |
| ------- | ----------- |
| Azure IoT Hub | A user interface within the Azure portal. |
| Azure Command-Line Interface (CLI) with the Azure IoT extension for Azure CLI | A cross-platform text-based CLI that runs from a command shell. This interface is used outside of the Azure portal. |
| Visual Studio Code using the Azure IoT Hub extension | A menu-based IoT device configuration and control user interface that runs within Visual Studio Code. This interface is used outside of the Azure portal. |

Imagine that you work as an operator in an electrical power monitoring and control room at a large auto manufacturing plant. One day you notice that a field power line voltage measurement IoT device is malfunctioning and is giving erratic readings that could affect the stability of the power grid. You use the Azure portal IoT Hub portal interface to send a direct method to the malfunctioning device, instructing it to go offline and stop sending messages. You receive a confirmation that the device has executed the command successfully. You then update the device twin of the malfunctioning device, setting the  status property to `offline` and add a reported property reason with the value `malfunction`. You then dispatch a technician to maintenance the malfunctioning device.

Here, you'll learn about the capabilities of the three device management tools for Azure IoT.

## IoT Hub (Azure portal) user interface

The Azure portal IoT Hub user interface can be used to implement device management in the following ways:

- Manage configuration information for a device
- Update device twin properties and tags for a device
- Perform device twin queries across devices
- Invoke a direct method on a device
- Manage identity for a device
- Implement automatic device management

## Azure CLI using the Azure IoT extension for Azure CLI

Azure CLI commands using the Azure IoT extension for Azure CLI can be used to implement device management in the following ways:

- Update device twin properties and tags for a device
- Invoke a direct method on a device
- Manage identity for a device
- Perform device twin queries across devices
- Perform device firmware updates
- Implement automatic device management

## Visual Studio Code using the Azure IoT Hub extension

Visual Studio Code using the Azure IoT Hub extension can be used to implement device management in the following ways:

- Create a new IoT Hub device
- Create a new IoT Edge device
- Delete a device from an IoT hub
- List existing devices
- Get information about the selected device as a JSON document
- Edit the device twin for the selected device
- Copy the connection string for the selected device to your clipboard
- Generate an SAS token for the selected device and copy it to your clipboard
- Invoke a direct method for the selected device
- Generate code in a selected programming language to perform a common task, such as sending a device-to-cloud message, for a selected resource
- Send a device-to-cloud (D2C) message to IoT Hub for a selected device
- Send a cloud-to-device (C2D) message to the selected device for a current IoT hub and display the results in the Output panel of VS Code
- Start and stop monitoring C2D messages to the selected device for a current IoT hub and display the results in the Output panel of VS Code
- Update distributed tracing settings for devices
