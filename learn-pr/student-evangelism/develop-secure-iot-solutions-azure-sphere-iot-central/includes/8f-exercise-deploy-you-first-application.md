## Step 1: Open the lab project

1. Start Visual Studio Code.
2. Click **Open folder**.
3. Open the **Azure-Sphere lab** folder.
4. Open the **Lab_2_Send_Telemetry_to_Azure_IoT_Central** folder.
5. Click **Select Folder** or the **OK** button to open the project.

------

From Visual Studio Code, open the **app_manifest.json** file. The resources this application requires must be declared in the **Capabilities** section.

## Step 2: Configure the Azure Sphere application

1. Update the connection properties for the Azure IoT Central application.

   - Update **CmdArgs** with your Azure IoT Central ID scope.
   - Update **DeviceAuthentication** with your Azure Sphere Tenant ID. Remember, this was the numeric value returned from running the **azsphere tenant show-selected** command.

2. Update the **AllowedConnections** with the Azure IoT Central application endpoints you copied to Notepad.

3. You can format the app_manifest.json document by pressing **Shift+Alt+F**.

4. Review your updated **app_manifest.json** file. It should look similar to the following.

    ```json
    {
        "SchemaVersion": 1,
        "Name": "AzureSphereIoTCentral",
        "ComponentId": "25025d2c-66da-4448-bae1-ac26fcdd3627",
        "EntryPoint": "/bin/app",
        "CmdArgs": [ "--ConnectionType", "DPS", "--ScopeID", "0ne0099999D" ],
        "Capabilities": {
            "Gpio": [
                "$BUTTON_A",
                "$NETWORK_CONNECTED_LED",
                "$ALERT_LED"
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

5. **IMPORTANT**. Copy the contents of your **app_manifest.json** file to Notepad, as you'll need this configuration information for the next labs.

------

## Step 3: Select your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. You need to set the configuration that matches your developer board. The default developer board configuration is for the Avnet Azure Sphere Starter Kit. If you have this board, there is no additional configuration required.

1. Open **CMakeList.txt**.

2. Add **#** at the beginning of the **set AVNET** line to disable it.

3. Uncomment the **set** command that corresponds to your Azure Sphere developer board.

   ```text
   set(AVNET TRUE "AVNET Azure Sphere Starter Kit")
   # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
   # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
   ```

4. Save the file. This will autogenerate the CMake cache.

------

## Step 4: Understand the Azure Sphere application

Open **main.c** and scroll down to where **measureSensorTimer** is declared. When initialized, this timer will fire every 6 seconds calling the **MeasureSensorHandler** handler function.

```c
static LP_TIMER measureSensorTimer = {
    .period = { 6, 0 },
    .name = "measureSensorTimer",
    .handler = MeasureSensorHandler };
```

Scroll down to the implementation of the **MeasureSensorHandler** function. This is the function that will be called by the **measureSensorTimer** timer.

> [!NOTE]
> Use **Go to Symbol in Editor** in Visual Studio Code. Use the keyboard shortcut Ctrl+Shift+O and start typing *measure*. You'll often see a function name listed twice in the drop-down. The first is the function prototype or forward signature declaration, and the second is the implementation of the function.

The MeasureSensorHandler function will read the environment sensor, format the data into a JSON string, display the JSON data on the **Output** tab, and then send the telemetry to Azure IoT Central.

```c
/// <summary>
/// Read sensor and send to Azure IoT
/// </summary>
static void MeasureSensorHandler(EventLoopTimer* eventLoopTimer)
{
    static int msgId = 0;
    static LP_ENVIRONMENT environment;

    if (ConsumeEventLoopTimerEvent(eventLoopTimer) != 0)
    {
        lp_terminate(ExitCode_ConsumeEventLoopTimeEvent);
    }
    else {
        if (lp_readTelemetry(&environment) &&
            snprintf(msgBuffer, JSON_MESSAGE_BYTES, msgTemplate,
                environment.temperature, environment.humidity, environment.pressure, msgId++) > 0)
        {
            Log_Debug(msgBuffer);
            lp_azureMsgSendWithProperties(msgBuffer, telemetryMessageProperties, NELEMS(telemetryMessageProperties));
        }
    }
}
```

------

## Step 5: Deploy the application to Azure Sphere

### Start the app build and deployment process

1. Ensure **main.c** is open.

2. Select **CMake: [Debug]: Ready** from the Visual Studio Code status bar.

   ![The illustration shows CMake status.](../media/visual-studio-code-start-application.png)

3. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

### View debugger output

1. Select the Visual Studio Code **Output** tab to view the output from **Log_Debug** statements in the code.

   > [!TIP]
   > You can open the output tab by using the Visual Studio Code **Ctrl+Shift+U** shortcut or clicking the **Output** tab.

2. You'll see the device negotiating security, and then it will start sending telemetry to Azure IoT Central.

    > [!NOTE]
    > You may see a couple of *ERROR: failure to create IoTHub Handle* messages displayed. These messages occur while the connection to Azure IoT Central is being negotiated.

------

## Step 6: Expected device behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The User LED will blink every 5 seconds when connected to Azure.

## Step 7: Display the Azure Sphere device telemetry

1. Click **Devices** on the sidebar.
2. Select the **Azure Sphere** template.
3. Click on the migrated device.
4. Select the **Telemetry** tab to view the device telemetry.
5. Rename your device. Click the **Rename** button and give your device a friendly name.

Azure IoT Central does not update immediately. It may take a minute or two for the temperature, humidity, and pressure telemetry to be displayed.

![The illustration shows how to display measurements.](../media/iot-central-display-measurements.png)

------

## Close Visual Studio Code

Now close Visual Studio Code.
