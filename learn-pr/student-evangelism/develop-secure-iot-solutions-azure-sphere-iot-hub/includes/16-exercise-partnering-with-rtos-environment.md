In this exercise, we'll partner a high-level application to send Azure RTOS real-time room environment sensor data to IoT Hub.

## Step 1: Open the project

1. Start Visual Studio Code to open your project.

2. From the menu, click **File**, then **Open Folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_7_Partnering_with_RTOS_environment** folder.

5. Click **Select Folder** or the **OK** button to open the project.

If you installed the Visual Studio Code Peacock extension then Visual Studio Code will turn blue. The blue colored instance is connected to the high-level application running on the Cortex-A7 core.

## Step 2: Set your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. You need to set the configuration that matches your developer board.

The default developer board configuration is for the Avnet Azure Sphere Starter Kit Revision 1. If you have this board, there's no additional configuration required.

1. Open the **CMakeList.txt** file.

2. Add a `#` at the beginning of the set Avnet line to disable it.

3. Uncomment the `set` command that corresponds to your Azure Sphere device developer board.

    ```text
    set(AVNET TRUE "AVNET Azure Sphere Starter Kit Revision 1 ")
    # set(AVNET_REV_2 TRUE "AVNET Azure Sphere Starter Kit Revision 2 ")
    # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
    # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
    ```

4. Save the file. This will auto-generate the CMake cache.

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.

1. **DO NOT** copy the app_manifest.json that you saved to notepad as there are new properties in this application manifest.

1. Update the connection properties for the Azure IoT Hub.

    - Update **CmdArgs** with your Azure IoT DPS ID scope.
    - Update **DeviceAuthentication** with your Azure Sphere Tenant ID. Remember, this was the numeric value returned from running the **azsphere tenant show-selected** command.

1. Update the **AllowedConnections** with the **global device provisioning service endpoint**, your **DPS endpoint**, and your **Azure IoT Hub endpoint**. See the example below to understand the correct format for these endpoints.

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
            "PowerControls": [
            "ForceReboot"
            ],
            "AllowedConnections": [
                "global.azure-devices-provisioning.net",
                "<Your device provisioning service endpoint>",
                "<Your Azure IoT hub endpoint>"
            ],
            "DeviceAuthentication": "9d7e79eb-9999-43ce-9999-fa8888888894"
            "AllowedApplicationConnections": [ "6583cf17-d321-4d72-8283-0b7c5b56442b" ]
        },
        "ApplicationType": "Default"
    }
    ```

## Step 4: Set a breakpoint in the InterCoreHandler callback function

1. Open **main.c**.

1. Scroll down to the function named **InterCoreHandler**.
    > [!NOTE]
    > Use **Go to Symbol in Editor** in Visual Studio Code. Use the keyboard shortcut Ctrl+Shift+O and start typing *InterCoreHandler*. You'll often see a function name listed twice in the drop-down. The first is the function prototype or forward signature declaration, and the second is the implementation of the function.

1. Set a breakpoint in the *InterCoreHandler* function on the line that reads **switch (ic_message_block->cmd)**
    > [!NOTE]
    > You can learn how to set breakpoints from this [Visual Studio Code Debugging](https://code.visualstudio.com/docs/editor/debugging#_debug-actions?azure-portal=true) article.

    :::image type="content" source="../media/visual-studio-debug-intercore-callback.png" alt-text="The illustration shows how to set a breakpoint in the InterCoreHandler callback function." lightbox="../media/visual-studio-debug-intercore-callback.png":::

## Step 5: Start the app build deploy process

1. Select **CMake: [Debug]: Ready** from the Visual Studio Code Status Bar.

2. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application that's now running the Azure Sphere device.

## Step 6: Debugging high-level and real-time core applications

1. When the high-level application has started it will request environment data from the real-time core application.

2. Without closing or stopping the high-level application, switch to the instance of Visual Studio code that you left connected to the real-time core.

3. In a moment or two the code execution will stop at the breakpoint set in the real-time code.

4. Step through the code on the real-time code and then press **F5** to continue execution.

5. Switch back to the instance of Visual Studio Code connected to the high-level application. The code execution should have stopped at the breakpoint you set in the InterCoreHandler function.

6. Repeat this process a few times and then remove the breakpoints so code continues to execute

## Step 7: Expected device behavior

The Avnet Azure Sphere Starter Kit, revisions 1 and 2, have a built-in temperature sensor. For other boards, a random temperature of 25 +/- 5 degrees Celsius is generated.

### Azure Sphere MT3620 Starter Kit Revision 1 and 2

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

- The WLAN LED will blink every 5 seconds when connected to Azure.

- The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

- The WLAN LED will blink every 5 seconds when connected to Azure.

- The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

- The User LED will blink every 5 seconds when connected to Azure.

## Step 8: Set the desired temperature

Setting the desired temperature is like setting a thermostat in a room. A device twin property message for desired temperature is sent to Azure Sphere, where it will be acted upon.

When the temperature sensor is read on the Azure Sphere, it is compared to the desired temperature.

1. From **Azure IoT Explorer**.

1. Click **View devices in this hub**.

1. Click your on your **device**.

1. Click **IoT Plug and Play components** from the side menu.

1. Click **Default component**.

1. Select **Properties (writable)** from the menu.

1. Set the **Desired Temperature** property.

1. Click the **Update desired value** button.

## Close Visual Studio

Now close Visual Studio.
