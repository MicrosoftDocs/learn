In this exercise, you will monitor events from the **ChildIoTDevice** are being sent to Azure IoT Hub through the **IoTEdgeGateway** IoT Edge Transparent Gateway. You will then interrupt connectivity between the IoTEdgeGateway and Azure IoT Hub to see that telemetry is still sent from the child IoT Device to the **IoT Edge Gateway**. After this, you will resume connectivity with Azure IoT Hub and monitor that the IoT Edge Gateway resumes sending telemetry to Azure IoT Hub.

## Testing Device Connectivity and Offline Support

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. Open the Azure Cloud Shell by clicking the **Terminal** icon within the top header bar of the Azure portal, and select the **Bash** shell option.

1. Run the following command within the **Azure Cloud Shell** to start monitoring the Events being received by the Azure IoT Hub:

    ```CLI
        az iot hub monitor-events --hub-name AZ-220-HUB-_{YOUR-ID}_
    ```

    Be sure to replace the {Your-ID} placeholder with your unique suffix for our Azure IoT Hub instance.

1. The az iot hub monitor-events command will start outputting the telemetry from the ChildDevice1 that is getting sent to Azure IoT Hub.

    Keep in mind that the ChildDevice1 simulated device application is configured to send telemetry to the IoTEdgeGateway IoT Edge Transparent Gateway virtual machine, which then is sending the telemetry on to Azure IoT Hub.

    ```JSON
        Starting event monitor, use ctrl-c to stop...
        {
            "event": {
                "origin": "ChildDevice1",
                "payload": "{\"temperature\":20.30307372114764,\"humidity\":72.6844747889249}"
            }
        }
        {
            "event": {
                "origin": "ChildDevice1",
                "payload": "{\"temperature\":31.73955729079412,\"humidity\":78.56052768349673}"
            }
        }
    ```

1. The next step to test the **Offline** capabilities is to make the **IoTEdgeGateway** device go offline. Since this is a Virtual Machine running in Azure, this can be simulated by adding an **Outbound rule** to the **Network security group** for the VM.

1. Within the **Azure portal**, navigate to the **AZ-220-IoTEdgeResources** resource group.

1. In the list of resources, to open the **Network Security Group** for the **AZ220EdgeVM{YOUR-ID}** virtual machine, click **AZ220EdgeVM{YOUR-ID}NSG**.

1. On the **Network security group** blade, click on the **Outbound security rules** link under the **Settings** section.

1. Click the **+Add** button at the top.

1. On the **Add outbound security rule** pane, set the following field values:

    -- Destination port ranges: *
    -- Action: **Deny**
    -- Name: **DenyAll**
    
    A **Destination port range** of “*” will apply the rule to all ports.

1. Click **Add**.

1. Go back to the **Azure Cloud Shell**. If the **az iot hub monitor-events`** command is still running, end it by pressing **Ctrl + C**.

1. Within the **Azure Cloud Shell** connect to the **IoTEdgeGateway** VM using ssh with the following command:

        ```Bash
            ssh <username>@<ip-address>
        ```

    Be sure to replace the placeholders with the required values for the ssh command:

    | Placeholder | Value to replace |
    |-------------|------------------|
    | username | The admin Username for the IoTEdgeGateaway virtual machine. |
    | ipaddress | The Public IP Address for the IoTEdgeGateway virtual machine. |

    Enter the **Password** for the **IoTEdgeGateway** username when prompted.

1. Once connected to the **IoTEdgeGateway** VM via ssh, run the following command to reset the IoT Edge Runtime.

        ```Bash
            sudo systemctl restart iotedge
        ```

    This will force the IoT Edge Runtime to disconnect from the Azure IoT Hub service, and then attempt to reconnect.

1. Within the **IoTEdgeGateway**, run the exit command to end the ssh session.

1. Run the az iot hub monitor-events command again within the **Azure Cloud Shell** to start monitoring the Events being received by the Azure IoT Hub:

        ```Bash
            az iot hub monitor-events --hub-name AZ-220-HUB-_{YOUR-ID}_
        ```

    Be sure to replace the {Your-ID} placeholder with your unique suffix for our Azure IoT Hub instance.

1. Notice there are no longer any events being received by the **Azure IoT Hub**.

1. Go look at the **Terminal** where the **ChildIoTDevice** simulated device application is running, and notice that it’s still sending device telemetry to the **IoTEdgeGateway**.

1. At this point the **IoTEdgeGateway** is disconnected from the Azure IoT Hub. It will continue to authenticate connections by the **ChildIoTDevice**, and receiving device telemetry from child device(s). During this time, the IoT Edge Gateway will be storing the event telemetry from the child devices on the IoT Edge Gateway device storage as configured.

1. In the **Azure portal**, navigate back to the **Network security group** blade for the **IoTEdgeGateway**, and click on **Outbound security rules** under the **Settings section**.

1. On the **Outbound security rules** pane, click on the **DenyAll** rule at the top of the list.

1. On the **DenyAll** rule pane, click the **Delete** button to remove this deny rule from the NSG.

1. On the **Delete security rule** prompt, click **Yes**.

1. Once the **IoTEdgeGateway** IoT Edge Transparent Gateway is able to resume connectivity with Azure IoT Hub, it will sync the event telemetry from all connected child devices. This includes the saved telemetry that couldn’t be sent while disconnected, and all telemetry still being sent to the gateway.

    **Note:** The IoT Edge Gateway device will take a couple minutes to reconnect to Azure IoT Hub and resume sending telemetry. After waiting a couple minutes, you will see events showing up in the az iot hub monitor-events command output again.
