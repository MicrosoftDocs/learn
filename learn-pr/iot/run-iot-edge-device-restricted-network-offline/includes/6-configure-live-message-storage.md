In this exercise, you will configure the message Time-to-Live (TTL) of the Edge Hub module on the Azure IoT Edge Gateway device to be longer than the default. You will also configure the storage location on the IoT Edge Device where the messages are to be stored.

The default value of 7200 (2 hours) is not long enough for a device or solution that may need to function in Offline mode for extended periods of time. For the device and solution to operate for more extended periods of being disconnected, you will configure the Time-to-Live (TTL) property of the IoT Edge Hub module to the value of 1,209,600 seconds, for a two-week TTL period.

The Module Twin for the IoT Edge Hub is called $edgeHub and is used to coordinate communications between the IoT Edge Hub running on the device and the Azure IoT Hub service. Within the Desired Properties for the Module Twin, the storeAndForwardConfiguration.timeToLiveSecs property specifies the time in seconds that IoT Edge Hub keeps messages when in a state disconnected from routing endpoints, like Azure IoT Hub.

The timeToLiveSecs property for the Edge Hub can be specified in the Deployment Manifest on a specific device as part of a single-device or at-scale deployment. In this unit, you will use the Azure portal user interface for Azure IoT Hub to modify the timeToLiveSecs property for the Edge Hub ($edgeHub) module on the single IoT Edge Gateway device.

### Task 1: Configure the module twin

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. On your Resource group tile, click **AZ-220-HUB-_{YOUR-ID}_** to navigate to the Azure IoT Hub.

1. On the IoT Hub summary blade, click **IoT Edge** under the Automatic Device Management section. This section of the IoT Hub blade allows you to manage the IoT Edge devices connected to the IoT Hub.

1. In the list of **Device IDs**, click on the **IoTEdgeGateway** device.

1. In the list of **Modules**, click on the **$edgeHub** module. This Module Twin is for the **Edge Hub** module configured for the **IoT Edge Device**.

1. On the **IoT Edge Module Details** pane, click the **Module Identity Twin** to view the Module Twin JSON.

You will note that the "desired" properties are empty for this new device.

1. Close the **Module Identity** Twin pane.

1. Go back to the **IoT Edge Device** pane displaying the **IoTEdgeGateway** IoT Edge device.

1. Click the **Set Modules** button at the top. An interface now opens allowing you to set and configure the IoT Edge Modules deployed to this IoT Edge Device.

1. On the **Set modules** pane, click the Runtime Settings button under the IoT Edge Modules section.

1. On the **Runtime Settings** pane, locate the **Store and forward configuration - time to live (seconds)** field for the **Edge Hub** module, then change the value to 1209600, which specifies a message time to live of two weeks on the IoT Edge Device.

    >[!NOTE]
    >There are several considerations to make when configuring the Message Time-to-Live (TTL) for the Edge Hub ($edgeHub) module. When the IoT Edge Device is disconnected, the messages are stored on the local device. You need to calculate how much data will be stored during the TTL period, and make sure there is enough storage on the device for that much data. The amount of storage and TTL configured will need to meet the solutions requirements so that important data is not lost; if possible.

    >[!NOTE]
    >If the device does not have enough storage, then you need to configure a shorter TTL. Once the age of a message reaches the TTL time limit, it will be deleted if it has not yet been sent to Azure IoT Hub.

1. The IoT Edge Device will automatically be able to store messages when in a disconnected / offline state. However, this location can be overridden by configuring a HostConfig.Binds setting.

1. On the Runtime Settings pane, beneath Edge Hub, within the Create Options box, add the following Binds property to the HostConfig object in the JSON.

    ```JSON
        "Binds": [
        "/etc/iotedge/storage/:/iotedge/storage/"
        ]
    ```

    This Binds value configures the /iotedge/storage/ directory in the Docker container for the Edge Hub Module to be mapped to the /etc/iotedge/storage/ host system directory on the physical IoT Edge Device.

    The value is in the format of \<HostStoragePath\>:\<ModuleStoragePath\>. The \<HostStoragePath\> value is the host directory location on the IoT Edge Device. The \<ModuleStoragePath\> is the module storage path made available within the container. Both of these values must be an absolute path.

1. The resulting JSON in the Create Options box should look similar to the following script:

    ```JSON
            {
        "HostConfig": {
            "PortBindings": {
            "443/tcp": [
                {
                "HostPort": "443"
                }
            ],
            "5671/tcp": [
                {
                "HostPort": "5671"
                }
            ],
            "8883/tcp": [
                {
                "HostPort": "8883"
                }
            ]
            },
            "Binds": [
            "/etc/iotedge/storage/:/iotedge/storage/"
            ]
        }
        }
    ```

1. To finish the update for the change in message storage location, add a new environment variable named **storageFolder** with the value of /iotedge/storage/ within the **Environment Variables** section.

1. Click **Save**.

1. On the **Set modules** pane, click **Review + create**.

1. On the **Review + create** step, notice changes made are reflected within the JSON displayed, then click **Create**.

1. Once this change is saved, the **IoT Edge Device** will be notified of the change to the Module configuration and the new settings will be reconfigured on the device accordingly.

Once the changes have been passed to the Azure IoT Edge device, it will restart the edgeHub module with the new configuration.

### Task 2: Update directory permissions

Before continuing, it is essential to ensure that the user profile for the IoT Edge Hub module has the required read, write, and execute permissions to the **/etc/iotedge/storage/ directory**.

1. Navigate to the **AZ220EdgeVM{YOUR-ID}** IoT Edge virtual machine within the Azure portal.

1. On the **Overview pane** of the **Virtual machine** blade, click the **Connect** button at the top.

1. Within the **Connect to virtual machine** pane, select the **SSH option**, then copy the **Login using VM local account** value.

    This sample SSH command will be used to connect to the virtual machine that contains the IP Address for the VM and the Administrator username. The command is formatted similar to ssh username@52.170.205.79.

1. At the top of the Azure portal, click on the **Cloud Shell** icon to open up the **Azure Cloud Shell** within the Azure portal. When the pane opens, choose the option for the **Bash** terminal within the Cloud Shell.

1. Within the Cloud Shell, paste in the ssh command that was copied, and press **Enter**.

1. When prompted with "Are you sure you want to continue connecting?", type yes and press Enter. 

    >[!NOTE]
    >This prompt is a security confirmation since the certificate used to secure the connection to the VM is self-signed. The answer to this prompt will be remembered for subsequent connections, and is only prompted on the first connection.

1. Enter the Administrator password, when prompted to enter the password, that was entered when the VM was provisioned.

1. Once connected, the terminal will change to show the name of the Linux VM, similar to the following and reports which VM you are connected to.

    ```bash
        username@AZ220EdgeVM{YOUR-ID}:~$
    ```

1. To view the running IoT Edge modules, enter the following command:
    ```bash
        iotedge list
    ```

    Notice that the edgeHub has failed to start:

    ```Bash
         NAME             STATUS           DESCRIPTION                 CONFIG
        edgeAgent        running          Up 4 seconds                mcr.microsoft.com/azureiotedge-agent:1.0
        edgeHub          failed           Failed (139) 0 seconds ago  mcr.microsoft.com/azureiotedge-hub:1.0
    ```

    This event occurs because the edgeHub process does not have permission to write to the /etc/iotedge/storage/ directory.

1. To confirm the issue with the directory permission, enter the following command:

    ```bash
        iotedge logs edgeHub
    ```

    The terminal will output the current log - if you scroll through the log you will see the relevant entry:

    ```bash
         Unhandled Exception: System.AggregateException: One or more errors occurred. (Access to the path '/iotedge/storage/edgeHub' is denied.) ---> System.UnauthorizedAccessException: Access to the path '/iotedge/storage/edgeHub' is denied. ---> System.IO.IOException: Permission denied
    ```

1. To update the directory permissions, enter the following commands:

    ```bash
        sudo chown $( whoami ):iotedge /etc/iotedge/storage/
        sudo chmod 775 /etc/iotedge/storage/
    ```

    The first command sets the owner of the directory to the current user and the owning user group to iotedge. The second command enables full access to both the current user and members of the iotedge group. These commands will ensure that the edgeHub module is able to create directories and files within the /etc/iotedge/storage/ directory.

1. To restart the edgeHub module and verify it started, enter the following commands:

    ```bash
        iotedge restart edgeHub
        iotedge list
    ```

    You should see that the edgeHub module is now running:

    ```
        NAME             STATUS           DESCRIPTION      CONFIG
        edgeAgent        running          Up 13 minutes    mcr.microsoft.com/azureiotedge-agent:1.0
        edgeHub          running          Up 6 seconds     mcr.microsoft.com/azureiotedge-hub:1.0
    ```

We are now ready to connect a device to this IoT Edge Gateway device.
