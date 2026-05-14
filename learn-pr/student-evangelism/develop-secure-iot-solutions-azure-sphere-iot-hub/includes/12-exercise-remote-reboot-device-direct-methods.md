## Step 1: Build and deploy your application

1. Start Visual Studio Code to open your project.

2. From the menu, click **File**, then **Open Folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_4_Direct_Methods** folder.

5. Click **Select Folder** or the **OK** button to open the project.

## Step 2: Set your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. You need to set the configuration that matches your developer board.

The default developer board configuration is for the Avnet Azure Sphere Starter Kit Revision 1. If you have this board, there's no additional configuration required.

1. Open the **CMakeLists.txt** file.

2. Ensure exactly one `set(<BOARD> TRUE ...)` line is active.

   - If your hardware is the **Avnet Azure Sphere Starter Kit Revision 1**, leave `set(AVNET TRUE ...)` uncommented and ensure all other board `set` lines are commented out.
   - If your hardware is a **different supported board**, comment out the Avnet line and uncomment the `set` command that corresponds to your Azure Sphere device developer board.

   ```text
   set(AVNET TRUE "AVNET Azure Sphere Starter Kit Revision 1 ")
   # set(AVNET_REV_2 TRUE "AVNET Azure Sphere Starter Kit Revision 2 ")
   # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
   # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
   ```

3. Save the file. This will autogenerate the CMake cache.

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.

2. Reuse the Azure IoT connection values from the previous exercise: the DPS ID scope in **CmdArgs**, the **AllowedConnections** list, and the **DeviceAuthentication** GUID.

3. Update only those connection values in this lab's **app_manifest.json**. Preserve this lab's existing **ComponentId**, hardware capabilities, and other lab-specific settings.

4. Add the **PowerControls** capability to the **Capabilities** object so the application can call **PowerManagement_ForceSystemReboot**. Your **Capabilities** block should now include the following property as a sibling of the other capabilities. Ensure the surrounding JSON commas remain valid.

    ```json
    "PowerControls": [ "ForceReboot" ]
    ```

    If **PowerControls** is missing, **PowerManagement_ForceSystemReboot** returns `-1` and sets `errno` (typically `EPERM` for an undeclared capability).

5. Save the updated **app_manifest.json** file.

## Step 4: Start the app build deploy process

1. Open **main.c**.
1. Ensure that your Azure Sphere device is connected by USB and is still enabled for development and sideloading. If you moved the device to a cloud-test or production-style device group after the previous lab, enable development again before pressing F5.
1. Confirm that CMake is configured for the project. If the Visual Studio Code status bar shows **CMake: [Debug]: Ready**, select it only if you need to change the build preset.
1. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

## Expected device behavior

### Azure Sphere MT3620 Starter Kit Revision 1 and 2

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

- The network-connected LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).
- Telemetry is sent approximately every 6 seconds.

- When you initiate the device restart direct method, you will observe the device restarting.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

- The network-connected LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).
- Telemetry is sent approximately every 6 seconds.

- When you initiate the device restart direct method, you will observe the device restarting.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

- The User LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).
- Telemetry is sent approximately every 6 seconds.

- When you initiate the device restart direct method, you will observe the device restarting.

## Testing Azure IoT Hub direct method commands

1. Start **Azure IoT Explorer** and connect to your IoT hub.

1. If Azure IoT Explorer opens on the home page, click **View devices in this hub**. Otherwise, open the **Devices** list for the connected hub.

1. Click your **device** in the **Device ID** column.

1. Click **IoT Plug and Play components** from the side menu.

1. Click **Default component**.

1. Select **Commands** from the menu.

1. Set the **Restart Delay** value to an integer from `3` through `9`. The application rejects values outside this range.

1. Keep the application running and connected to IoT Hub, then click **Send command**, **Submit**, or the equivalent button shown by your Azure IoT Explorer version. Azure IoT Explorer should show the direct method response before the device restarts. Direct methods are synchronous request-response calls; if the device is offline or doesn't respond before the timeout, the call fails instead of being queued for later delivery.

## Close Visual Studio Code

Now close Visual Studio Code.
