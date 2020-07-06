## Build and deploy your application

1. Start Visual Studio Code to open your project.

2. Click **Open folder**.

3. Open the Azure-Sphere lab folder.

4. Open the **Lab_4_Direct_Methods** folder.

5. Click **Select Folder** or the **OK** button to open the project.

6. Set your developer board configuration

   1. Open CMakeList.txt
   2. Uncomment the **set** command that corresponds to your Azure Sphere developer board.
   3. Save the file. This will autogenerate the CMake cache.

7. Configure the Azure IoT connection information

   1. Open the **app_manifest.json** file.
   2. You'll need to redo the settings for the **app_manifest.json** file. Either copy from **Notepad** if you still have it open or copy from the **app_manifest.json** file you created in the previous exercise.
   3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

8. Ensure main.c is open.

9. Select **CMake: [Debug]: Ready** from the Visual Studio Code Status Bar.

10. From Visual Studio Code, press F5 to build, deploy, start, and attached the remote debugger to the application now running the Azure Sphere device.

## Expected Device Behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. LED3 will turn yellow when connected to Azure.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The network LED will turn red when connected to Azure.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The green LED closest to the USB connector will turn on when connected to Azure

## Testing IoT Hub direct methods

We are going to use the Azure command-line tool to invoked the Azure IoT Hub direct method. For more information see [invoke-device-method](https://docs.microsoft.com/cli/azure/ext/azure-cli-iot-ext/iot/hub?view=azure-cli-latest#ext-azure-cli-iot-ext-az-iot-hub-invoke-device-method).

Follow these steps to invoke the **resetDevice** direct method which will restart the device:

1. You need the name of the Azure IoT Hub you created. You can get the name from the Azure web portal.

   ![The illustration shows Azure resources.](../media/azure-iot-resources.png)

2. You need the Azure Sphere device ID. Run the following command from the **Azure Sphere Developer Command Prompt**.

   ```
   azsphere dev show-attached
   ```

3. Open the Azure Cloud shell by right mouse clicking on the following link and opening in a new tab "[https://shell.azure.com](https://shell.azure.com/)".

4. In the Cloud Shell, run the [az extension add](https://docs.microsoft.com/cli/azure/extension?view=azure-cli-latest#az-extension-add) command to add the Microsoft Azure IoT Extension to your CLI shell. The IoT Extension adds IoT Hub, IoT Edge, and IoT Device Provisioning Service (DPS) specific commands to Azure CLI.

   ```
   az extension add --name azure-iot
   ```

5. Set a bash variable in the Cloud Shell for your Azure Sphere Device ID. Make sure there are no spaces either side of the **=** character.

   ```
   DEVICE_ID={your Azure Sphere device ID}
   ```

6. Set a bash variable in the Cloud Shell for your IoT Hub name. Make sure there are no spaces either side of the **=** character.

   ```
   HUB_NAME={your hub name}
   ```

7. Invoke the direct method as follows.

   ```
   az iot hub invoke-device-method --method-name "ResetMethod" --method-payload '{"reset_timer":5}' --device-id "${DEVICE_ID,,}" -n $HUB_NAME
   ```

    > [!NOTE]
    > IoT Hub requires Device IDs to be lowercase. The bash command **"${DEVICE_ID,,}"** in the invoke device method converts the device id to lowercase.

8. The invoke-device-method will display the result of the call as follows.

   ```
   {
   "payload": "ResetMethod called. Reset in 5 seconds",
   "status": 200
   }
   ```

------

## Close Visual Studio

Now you can close **Visual Studio** and clean up your resources in Azure.
