Perform the following steps in the Azure Cloud Shell environment.

## Install the Vision on Edge Solution Accelerator

1. Run the following command to download installer (acs.zip) from GitHub.

   ```
   wget -O acs.zip https://github.com/Azure-Samples/azure-intelligent-edge-patterns/raw/master/factory-ai-vision/Installer/acs.zip
   ```

   [![The illustration shows how to install installer.](../media/download-installer.png)](../media/download-installer.png)

2. Unzip it.

   ```
   unzip -o acs.zip
   ```

   [![The illustration shows how to uzip installer.](../media/unzip-installer.png)](../media/unzip-installer.png)

3. Execute the installer. It will check the az command and check if it requires any installing/updating the IoT extension.

   ```
   bash factory-ai-vision-install.sh
   ```

   [![The illustration shows how to execute installer.](../media/execute-installer.png)](../media/execute-installer.png)

4. You would be asked if you would like to use an existing Custom Vision Service. Choose **no** and go ahead to create a new one with the instruction.

   [![The illustration shows how to create custom vision service.](../media/create-custom-vision-service.png)](../media/create-custom-vision-service.png)

5. Once you create custom vision service information, make a note of **API key** and **Endpoint**.

   [![The illustration shows the API key and endpoint.](../media/copy-api-key-endpoint.png)](../media/copy-api-key-endpoint.png)

6. Next you will be asked if you want to use Azure Live Video Analytics. Choose **yes** and it will create Azure Media Service.

   [![The illustration shows how to create Azure Media Service.](../media/create-media-service.png)](../media/create-media-service.png)

7. Copy the "SERVICE-PRINCIPLE-SECRET" information. You will need the secret information for later use.         

   [![The illustration shows service principle secret.](../media/service-principal-secret.png)](../media/service-principal-secret.png)

8. There will be a list of IoT hubs, choose the IoT Hub that you created in this module.  

   [![The illustration shows a list of IoT hubs.](../media/list-iot-hubs.png)](../media/list-iot-hubs.png)

9. It will show a list of devices in your account, and choose the device to install VisionEdge. 

   [![The illustration shows a list of edge devices.](../media/device-list.png)](../media/device-list.png)

10. Choose the platform you are going to deploy.

    [![The illustration shows the platform.](../media/choose-platform.png)](../media/choose-platform.png)

11. You will be asked if your device has a GPU or not. Choose CPU as your Edge device doesn't have it.

    [![The illustration shows devices.](../media/choose-device.png)](../media/choose-device.png)

12. The installation will be started after. You'll wait for couple minutes to complete the installation. You can check the deployment status on the [Azure portal](https://portal.azure.com/#home)

    [![The illustration shows deployment.](../media/create-deployment.png)](../media/create-deployment.png)

13. Open your browser, connect to **http://YOUR_IP:8181**. You'll connect to the VisiononEdge solution.