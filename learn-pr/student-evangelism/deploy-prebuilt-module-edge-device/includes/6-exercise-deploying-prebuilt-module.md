Deploy the "Simulated Temperature Sensor" module from the Microsoft Artifact Registry using these steps:

1. Find the **Simulated Temperature Sensor** module in the [Microsoft Artifact Registry](https://mcr.microsoft.com/catalog?cat=IoT%20Edge%20Modules&alphaSort=asc&alphaSortKey=Name) filtered by *IoT Edge Modules*.

1. Select the latest image version of the **Simulated Temperature Sensor** module.

1. Copy the URI for the **Simulated Temperature Sensor** module. Only copy the URI, not the *docker pull* command. For example, `mcr.microsoft.com/azureiotedge-simulated-temperature-sensor:latest`.

1. In the Azure portal, go to your IoT Hub and select the device to add the **Simulated Temperature Sensor** module.

1. On the IoT Edge device details page, select **Set modules**.

1. In the **IoT Edge modules** section, select **Add** then choose **IoT Edge Module**.

1. Update the following module settings:

    | Setting            | Value                                                                |
    |--------------------|----------------------------------------------------------------------|
    | IoT Module name    | `SimulatedTemperatureSensor`                                         |
    | Image URI          | `mcr.microsoft.com/azureiotedge-simulated-temperature-sensor:latest` |
    | Restart policy     | always                                                               |
    | Desired status     | running                                                              |

1. Select **Routes** to define how messages are passed between modules and to IoT Hub.

1. Add a route to send all messages from the simulated temperature module to IoT Hub.

    | Setting                          | Value                                      |
    |----------------------------------|--------------------------------------------|
    | Name                             | `SimulatedTemperatureSensorToIoTHub`       |
    | Value                            | `FROM /messages/modules/SimulatedTemperatureSensor/* INTO $upstream` |

1. Select **Review + create** to preview the deployment manifest JSON file that defines all the modules deployed to your IoT Edge device. Ensure it includes the *Simulated Temperature Sensor* module.

1. On the device details page, find the *Modules* section. Three modules should be listed: `$edgeAgent`, `$edgeHub`, and `SimulatedTemperatureSensor`. The list should look similar to the following screenshot.

    > [!IMPORTANT]
    > If a **module is listed as "in deployment"** but not reported by the device, your IoT Edge device is still starting it. **Wait a few moments and click "Refresh"** at the top of the page.

    ![Deployed modules at the edge.](../media/deployed-modules.png)

1. Open the command prompt on your IoT Edge device, or use the SSH connection from Azure CLI.
1. Use the `sudo iotedge list` command to confirm that the module deployed from the cloud is running on your IoT Edge device.
1. View the messages being sent from the temperature sensor module using the command `sudo iotedge logs SimulatedTemperatureSensor -f`.

    > [!IMPORTANT]
    > IoT Edge commands are case-sensitive when referring to module names.

1. Clean up resources
