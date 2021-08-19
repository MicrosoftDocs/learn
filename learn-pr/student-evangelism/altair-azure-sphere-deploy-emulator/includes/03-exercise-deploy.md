In the following exercise, you'll deploy a high-level application to your Azure Sphere.

1. Start Visual Studio Code.

2. Select **Open folder**.

3. Open the **azure-sphere-altair** folder you cloned or downloaded.

4. Open the **AltairHL_emulator** folder.

5. Select **Select Folder** or the **OK** button to open the project.

## Step 2: Configure the Azure Sphere application

1. From Visual Studio Code, open the **app_manifest.json** file. The resources this application requires must be declared in the **Capabilities** section.

1. Update the connection properties for the Azure IoT Central application.

    * Update **CmdArgs** with your Azure IoT Central ID scope.
    * Update **DeviceAuthentication** with your Azure Sphere Tenant ID. Remember, the Tenant ID was the numeric value returned from running the **azsphere tenant show-selected** command.

1. Update the **AllowedConnections** with the Azure IoT Central application endpoints you copied to Notepad.

1. You **MUST** include network endpoint for *test.mosquitto.org* in the **AllowedAllowedConnections** list.

1. You can format the app_manifest.json document by right mouse clicking on the document and selecting **Format Document** from the context menu.

1. Review your updated **app_manifest.json** file. It should look similar to the following.

    ```json
    {
      "SchemaVersion": 1,
      "Name": "AltairHL_emulator",
      "ComponentId": "ac8d863a-4424-11eb-b378-0242ac130002",
      "EntryPoint": "/bin/app",
      "CmdArgs": [ "--ConnectionType", "DPS", "--ScopeID", "0ne0099999D" ],
      "Capabilities": {
        "MutableStorage": { "SizeKB": 8 },
        "Gpio": [
            "$MQTT_CONNECTED_LED",
            "$AZURE_CONNECTED_LED",
            "$SWITCHES_LOAD",
            "$SWITCHES_CHIP_SELECT",
            "$LED_MASTER_RESET",
            "$LED_STORE",
            "$LED_OUTPUT_ENABLE",
            "$BUTTON_A",
            "$BUTTON_B"
        ],
        "Uart": [ "$MT3620_ISU3_UART" ],
        "SpiMaster": [ "$MT3620_ISU1_SPI" ],
        "PowerControls": [ "ForceReboot" ],
        "AllowedConnections": [
            "test.mosquitto.org",
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
            "iotc-f9199991-ceb1-4f38-9f1c-13199992570e.azure-devices.net",
            "api.timezonedb.com",
            "api.openweathermap.org",
            "get.geojs.io"
        ],
        "DeviceAuthentication": "9d799999-9999-43ce-9999-fa8888888894"
        "AllowedApplicationConnections": [
            "2e319eae-7be5-4a0c-ba47-9353aa6ca96a",
            "9b684af8-21b9-42aa-91e4-621d5428e497"
        ]
      },
      "ApplicationType": "Default"
    }
    ```

1. Save the updated app_manifest.json file.

1. **IMPORTANT**. Copy the contents of your **app_manifest.json** file to Notepad or your text editor of choice, as you'll need this configuration information for the next labs.

## Step 3: Select your developer board configuration

The Altair project works on Azure Sphere developer boards from Avnet and Seeed Studio. The default developer board configuration is the Avnet Azure Sphere Starter Kit Revision 1 with **no** front panel. You can skip this step if this is your configuration.

1. Open **CMakeLists.txt**.

2. Add **#** at the beginning of the **set AVNET** line to disable it.

3. Uncomment the **set** command that corresponds to your Azure Sphere developer board. Ensure only one developer board is enabled.

    ```text
    set(AVNET TRUE "AVNET Azure Sphere Starter Kit Revision 1 ")
    # set(AVNET_REV_2 TRUE "AVNET Azure Sphere Starter Kit Revision 2 ")
    # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
    ```

4. Select your front panel configuration. Uncomment the **set** command that corresponds to your front panel configuration.  Ensure only one front panel configuration is enabled.

    ```text
    set(ALTAIR_FRONT_PANEL_NONE TRUE "Altair on Azure Sphere with no panel.")
    # set(ALTAIR_FRONT_PANEL_KIT TRUE "Altair front panel board")
    # set(ALTAIR_FRONT_PANEL_CLICK TRUE "Avnet with the 4x4 keypad Click and  8x8 LED Click")
    # set(ALTAIR_FRONT_PANEL_RETRO_CLICK TRUE "Avnet with Altair 8800 Retro Click")
    ```

5. Save the **CMakeLists.txt** file. Saving the file will autogenerate the CMake cache.

## Step 4: Deploy the application to Azure Sphere

### Start the app build and deployment process

1. Open **main.c**.

1. Select **CMake: [Release]: Ready** from the Visual Studio Code status bar.

  :::image type="content" source="../media/visual-studio-code-start-application.png" alt-text="The illustration shows CMake status.":::

1. From Visual Studio Code, press <kbd>ctrl+F5</kbd> to build, deploy, and start the application on  the Azure Sphere device.

### View debugger output

1. Select the Visual Studio Code **Output** tab to view the output from **Log_Debug** statements in the code. You'll see the device negotiating security with IoT Central.

   > [!TIP]
   > You can open the output tab by using the Visual Studio Code **Ctrl+Shift+U** shortcut or clicking the **Output** tab.

## Step 5: Expected device behavior

Observe the WLAN status LED on your developer board while the device establishes a secure connection to IoT Central and the MQTT Broker

1. While establishing a WiFi connection the WLAN LED will blink on for 700 ms, then off for 700 ms.
1. While establishing a connection to IoT Central and the MQTT Broker the WLAN LED will blink on for 100 ms, then off for 1300 ms.
1. When the connection has been established with IoT Central the WLAN LED will blink on for 1300 ms, then off for 100 ms.
