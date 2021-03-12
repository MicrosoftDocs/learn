In this exercise, we'll deploy a high-level application to your Azure Sphere.

1. Start Visual Studio Code.

2. Click **Open folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_2_Send_Telemetry_to_Azure_IoT** folder.

5. Click **Select Folder** or the **OK** button to open the project.

## Step 2: Configure the Azure Sphere application

1. From Visual Studio Code, open the **app_manifest.json** file. The resources this application requires must be declared in the **Capabilities** section.

1. Update the connection properties for the Azure IoT Central application.

    - Update **CmdArgs** with your Azure IoT Central ID scope.
    - Update **DeviceAuthentication** with your Azure Sphere Tenant ID. Remember, this was the numeric value returned from running the **azsphere tenant show-selected** command.

1. Update the **AllowedConnections** with the Azure IoT Central application endpoints you copied to Notepad.

1. You can format the app_manifest.json document by right mouse clicking on the document and selecting **Format Document** from the context menu.

1. Review your updated **app_manifest.json** file. It should look similar to the following.

    ```json
    {
        "SchemaVersion": 1,
        "Name": "AzureSphereIoTCentral",
        "ComponentId": "25025d2c-66da-4448-bae1-ac26fcdd3627",
        "EntryPoint": "/bin/app",
        "CmdArgs": [ "--ConnectionType", "DPS", "--ScopeID", "0ne0099999D" ],
        "Capabilities": {
            "Gpio": [
                "$NETWORK_CONNECTED_LED",
                "$LED_RED",
                "$LED_GREEN",
                "$LED_BLUE"
            ],
            "I2cMaster": [
                "$I2cMaster2"
            ],
            "PowerControls": [
                "ForceReboot"
            ],
            "AllowedConnections": [
                "global.azure-devices-provisioning.net",
                "iotc-9999bc-3305-99ba-885e-6573fc4cf701.azure-devices.net",
                "iotc-789999fa-8306-4994-b70a-399c46501044.azure-devices.net",
                "iotc-7a099966-a8c1-4f33-b803-bf29998713787.azure-devices.net",
                "iotc-97299997-05ab-4988-8142-e299995acdb7.azure-devices.net",
                "iotc-d099995-7fec-460c-b717-e99999bf4551.azure-devices.net",
                "iotc-789999dd-3bf5-49d7-9e12-f6999991df8c.azure-devices.net",
                "iotc-29999917-7344-49e4-9344-5e0cc9999d9b.azure-devices.net",
                "iotc-99999e59-df2a-41d8-bacd-ebb9999143ab.azure-devices.net",
                "iotc-c0a9999b-d256-4aaf-aa06-e90e999902b3.azure-devices.net",
                "iotc-f9199991-ceb1-4f38-9f1c-13199992570e.azure-devices.net"
            ],
            "DeviceAuthentication": "9d7e79eb-9999-43ce-9999-fa8888888894"
        },
        "ApplicationType": "Default"
    }
    ```

1. Save the updated app_manifest.json file.

1. **IMPORTANT**. Copy the contents of your **app_manifest.json** file to Notepad or your text editor of choice, as you'll need this configuration information for the next labs.

## Step 3: Select your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. You need to set the configuration that matches your developer board. The default developer board configuration is for the Avnet Azure Sphere Starter Kit Revision 1. If you have this board, there is no additional configuration required.

1. Open **CMakeLists.txt**.

2. Add **#** at the beginning of the **set AVNET** line to disable it.

3. Uncomment the **set** command that corresponds to your Azure Sphere developer board.

    ```text
    set(AVNET TRUE "AVNET Azure Sphere Starter Kit Revision 1 ")
    # set(AVNET_REV_2 TRUE "AVNET Azure Sphere Starter Kit Revision 2 ")
    # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
    # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
    ```

4. Save the file. This will autogenerate the CMake cache.

## Step 4: Deploy the application to Azure Sphere

### Start the app build and deployment process

1. Open **main.c**.

1. Select **CMake: [Debug]: Ready** from the Visual Studio Code status bar.

   <!-- ![The illustration shows CMake status.](../media/visual-studio-code-start-application.png) -->

   :::image type="content" source="../media/visual-studio-code-start-application.png" alt-text="The illustration shows CMake status.":::

1. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

1. Try setting a breakpoint in the **MeasureSensorHandler** function. The function will be called every 5 seconds.

    > [!NOTE]
    > You can learn how to set breakpoints from this [Visual Studio Code Debugging](https://code.visualstudio.com/docs/editor/debugging#_debug-actions?azure-portal=true) article.

### View debugger output

1. Select the Visual Studio Code **Output** tab to view the output from **Log_Debug** statements in the code.

   > [!TIP]
   > You can open the output tab by using the Visual Studio Code **Ctrl+Shift+U** shortcut or clicking the **Output** tab.

2. You'll see the device negotiating security, and then it will start sending telemetry to Azure IoT Central.

    > [!NOTE]
    > You may see a couple of *ERROR: failure to create IoTHub Handle* messages displayed. These messages occur while the connection to Azure IoT Central is being negotiated.

## Step 5: Expected device behavior

### Azure Sphere MT3620 Starter Kit Revision 1 and 2

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The User LED will blink every 5 seconds when connected to Azure.

## Step 6: Display the device telemetry in IoT Central

1. Switch back to the **IoT Central** web portal.

1. From the sidebar menu, select **Devices**, then the **Learning Path Lab Monitor** template, then your **device**.

    The device name is your Azure Sphere Device ID. You can display your Device ID by running the following command from the Windows **PowerShell command line** or Linux **Terminal**.

   ```
   azsphere device show-attached
   ```

1. Select the **Overview** tab to view the device telemetry.

1. Optional. You can also rename your device. Click the **Rename** button and give your device a friendly name.

    > [!NOTE]
    > Azure IoT Central does not update immediately. It may take a minute or two for the temperature, humidity, and pressure telemetry to be displayed. You can check that data is flowing into IoT Central by checking the **Raw data** tab.

:::image type="content" source="../media/iot-central-display-measurements.png" alt-text="The illustration shows how to display measurements.":::

## Close Visual Studio Code

Now close Visual Studio Code.
