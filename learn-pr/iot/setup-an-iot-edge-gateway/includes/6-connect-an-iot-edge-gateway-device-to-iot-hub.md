In this module , you will connect the IoT Edge Device to Azure IoT Hub.

## Connect an IoT Edge Device to IoT Hub

1. If necessary, log in to your Azure portal using your Azure account credentials.
    
    If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. Navigate to the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** IoT Edge virtual machine within the Azure Portal.

1. On the **Overview** pane of the **Virtual machine** blade, click the **Connect** button at the top.

1. Within the **Connect to virtual machine** pane, select the **SSH** option, then copy the **Login using VM local account** value.

    This is a sample SSH command that will be used to connect to the virtual machine that contains the IP Address for the VM and the Administrator username. The command is formatted similar to ssh `demouser@52.170.205.79`.
    
1. At the top of the Azure Portal click on the **Cloud Shell** icon to open up the **Azure Cloud Shell** within the Azure Portal. When the pane opens, choose the option for the **Bash** terminal within the Cloud Shell.

1. Within the Cloud Shell, paste in the `ssh` command that was copied, and press **Enter**.

1. When prompted with **Are you sure you want to continue connecting?**, type `yes` and press Enter. This prompt is a security confirmation since the certificate used to secure the connection to the VM is self-signed. The answer to this prompt will be remembered for subsequent connections, and is only prompted on the first connection.

1. When prompted to enter the password, enter the Administrator password that was entered when the VM was provisioned.

1. Once connected, the terminal will change to show the name of the Linux VM, similar to the following. This tells you which VM you are connected to.

    ```bash
     demouser@AZ-220-VM-EDGEGW-{YOUR-ID}:~$
    ```

1. You will need to run the command to configure the Edge device to connect to IoT Hub as Administrator. Run the following `sudo` command to elevate the terminal to run as Administrator:

    ```bash
     sudo su -
    ```

1. The `/etc/iotedge/configedge.sh` script is used to configure the Edge device with the Connection String necessary to connect it to Azure IoT Hub. This script is installed as part of the Azure IoT Edge Runtime.

1. To configure the Edge device with the Connection String for Azure IoT Hub, run the following command:

    ```bash
     /etc/iotedge/configedge.sh "{iot-edge-device-connection-string}"
    ```

    Be sure to replace the `{iot-edge-device-connection-string}` placeholder with the Connection String you copied previously for your IoT Edge Device.

1. Once this command completes, the IoT Edge Device will be configured to connect to Azure IoT Hub using the Connection String that was entered.

1. After a moment, run the following command that will list out all the **IoT Edge Modules** currently running on the IoT Edge Device.

    ```bash
     iotedge list
    ```

After a moment, this command will show the `edgeAgent` and `edgeHub` modules are running. The output will look similar to the following:

    ```bash
     root@AZ-220-VM-EDGEGW:~# iotedge list
     NAME             STATUS           DESCRIPTION      CONFIG
     edgeHub          running          Up 15 seconds    mcr.microsoft.com/azureiotedge-hub:1.0
     edgeAgent        running          Up 18 seconds    mcr.microsoft.com/azureiotedge-agent:1.0
    ```
If an error is reported, then you’ll need to double check the configurations are set correctly. For troubleshooting, the `iotedge check --verbose` command can be run to see if there are any errors.

Congratulations, that's the end of the module! In the next module, we will open IoT Edge Gateway Device Ports for Communication with Downstream Devices.