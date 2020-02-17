In this exercise, you will configure the Azure IoT Edge on Ubuntu virtual machine that was created previously to be an IoT Edge Transparent Gateway device. The configuration will be handled by a helper script that is part of this unit to make the process quicker.

## Configuring an IoT Edge Device as Gateway

In this exercise, you will configure the Azure IoT Edge on Ubuntu virtual machine that was created previously to be an IoT Edge Transparent Gateway device. The configuration will be handled by a helper script that is part of this unit to make the process quicker.

1. Locate the lab files for this lab, and open the setup-iot-edge-gateway.sh helper script within **Visual Studio Code**.

1. Edit the setup-iot-edge-gateway.sh script replacing the following variable placeholders with the new values so the **IoT Edge on Ubuntu VM** can be configured as an **IoT Edge Transparent Gateway:**

   | Placeholder |	Value to replace with |
   |-------------|-----------------------|
   | {iot-edge-device-connection-string}	| Paste in the **Connection String** for the IoTEdgeGateway device that was created within Azure IoT Hub. |
   | {iot-edge-device-hostname} |	Paste in the **Public IP Address** of the **IoT Edge on Ubuntu VM** as this is the DNS Hostname that the Client IoT Device will use to connect to the IoT Edge Transparent Gateway. |

   The associated variables are located at the top of the setup-iot-edg-gateway.sh script, and are similar to the following before the placeholders are replaced:

   ```bash
    connectionstring="{iot-edge-device-connection-string}"
    hostname="{iot-edge-device-hostname}"
   ```

1. Save the file.

1. Locate the lab files for this lab, and open the setup-remote-iot-edge-gateway.sh helper script within **Visual Studio Code**.

1. Edit the setup-remote-iot-edge-gateway.sh script to replace the following variable placeholders with the necessary values so the **IoT Edge on Ubuntu VM** can be configured as an **IoT Edge Transparent Gateway:**

   | Placeholder	| Value to replace with |
   |--------------|-----------------------|
   | {iot-edge-username} | Enter the admin **username** to connect to the **IoT Edge on Ubuntu VM**. This profile is used to connect to the VM via SSH. |
   | {iot-edge-ipaddress} | Enter the **Public IP Address** for the **IoT Edge on Ubuntu VM**. This is used to connect to the VM via SSH. |

   The variables these placeholders are associated with are located at the top of the setup-remote-iot-edg-gateway.sh script, and are similar to the placeholders that are replaced:

   ```bash
     username="{iot-edge-username}"
     ipaddress="{iot-edge-ipaddress}"
   ```

1. Save the file.

1. If necessary, log in to your Azure portal using your Azure account credentials.

1. If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. Open the Azure Cloud Shell by clicking the **Terminal** icon within the top header bar of the Azure portal, and select the **Bash** shell option.

1. To upload the setup scripts, in the Azure Cloud Shell toolbar, click **Upload/Download** files (fourth button from the right).

1. In the dropdown, select **Upload** and in the file selection dialog, navigate to the directory for this lab. Select the following bash scripts and click **Open** to upload them.

   -- setup-iot-edge-gateway.sh
   -- setup-remote-iot-edge-gateway.sh
   -- A notification will appear when the file upload has completed.

   **Note:** These two scripts are helper scripts that will assist in setting up the Azure IoT Edge on Ubuntu VM to be a Transparent Gateway device. These scripts are meant to be used for development purposes in this lab, and are not meant for production use.

1. You can verify that the files have been uploaded by listing the content of the current directory by entering the ls command.

   **Make sure both scripts have been uploaded to Azure Cloud Shell before continuing.**

1. Run the following command within the **Azure Cloud Shell** to make sure the setup-remote-iot-edge-gateway.sh script is executable:

   ```Bash
    chmod 700 setup-remote-iot-edge-gateway.sh
   ```

1. To set up the IoT Edge on Ubuntu VM as an IoT Edge Transparent Gateway, run the setup-remote-iot-edge-gateway.sh script using the following command within the Azure Cloud Shell:

    ```Bash
      ./setup-remote-iot-edge-gateway.sh
    ```

   Enter the **password** for the **IoT Edge on Ubuntu VM** when prompted. There will be a total of three prompts to enter the password. These prompts are due to the ssh and scp commands used to upload the setup-iot-edge-gateway.sh helper script to the VM, run the script, and then download the x.509 certificate that will be used later to authenticate the Child IoT Device to the IoT Edge Transparent Gateway.

1. Once the helper script has finished configuring the IoT Edge on Ubuntu VM to be an IoT Edge Transparent Gateway, the **Azure Cloud Shell** will download the azure-iot-test-only.root.ca.cert.pem x.509 certificate.

   If the x.509 certificate isn’t downloaded automatically within the web browser, then run the following command within the **Azure Cloud Shell** to manually download the file:

   ```Bash
    download azure-iot-test-only.root.ca.cert.pem
   ```

1. Save the x.509 certificate that was downloaded to the downloads folder for your web browser. This will be used to configure the Child IoT Device authentication.

This unit used the helper scripts to set up and configure the IoT Edge on Ubuntu VM as an IoT Edge Transparent Gateway Device. This is done to keep the labs focus on the Restricted Network and Offline capabilities of Azure IoT Edge.

Reference the **Setup an IoT Edge Gateway** lab for the specific steps and instruction on setting up an **IoT Edge Gateway Device**.
