## Step 1: Open the project

1. Start Visual Studio Code to open your project.

2. From the menu, click **File**, then **Open Folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_3_Device_Twins** folder.

5. Click **Select Folder** or the **OK** button to open the project.

## Step 2: Set your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. Set the configuration that matches your developer board.

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

3. Save the file. The CMake cache will be regenerated automatically.

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.

2. Reuse the Azure IoT connection values from the previous exercise: the DPS ID scope in **CmdArgs**, the **AllowedConnections** list, and the **DeviceAuthentication** GUID.

3. Update only those connection values in this lab's **app_manifest.json**. Preserve this lab's existing **ComponentId**, hardware capabilities, and other lab-specific settings.

4. Save the updated **app_manifest.json** file.

## Step 4: Start the app build deploy process

1. Open **main.c**.

1. Ensure that your Azure Sphere device is connected by USB and is still enabled for development and sideloading. If you moved the device to a cloud-test or production-style device group after the previous lab, enable development again before pressing F5.

1. Confirm that CMake is configured for the project. If the Visual Studio Code status bar shows **CMake: [Debug]: Ready**, select it only if you need to change the build preset.

1. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application.

## Step 5: Set the desired temperature

1. Start **Azure IoT Explorer** and connect to your IoT hub.

1. If Azure IoT Explorer opens on the home page, click **View devices in this hub**. Otherwise, open the **Devices** list for the connected hub.

1. Click your **device** in the **Device ID** column.

1. Click **IoT Plug and Play components** from the side menu.

1. Click **Default component**.

1. Select **Properties (writable)** from the menu.

1. Set the **Desired Temperature** property to a numeric Celsius value in the range accepted by the application (for example, `22`). The sample application rejects values outside its configured range.

1. Click **Update desired value**, **Submit**, or the equivalent button shown by your Azure IoT Explorer version.

1. Wait for the property status to complete. If needed, click **Refresh** to display the latest reported values. If the property remains in a syncing state, verify that the device is still connected to IoT Hub; desired properties are stored in the device twin and are processed when the device reconnects and reads the latest desired state.

    The device acknowledges the property update by setting the reported value along with an acknowledgment code and version. This behavior is defined as part of the [IoT Plug and Play conventions](/azure/iot/concepts-convention?azure-portal=true).

## Step 6: Expected device behavior

The Avnet Azure Sphere Starter Kit, revisions 1 and 2, have a built-in temperature sensor. For other boards, a random temperature of 25 +/- 5 degrees Celsius is generated.

### Azure Sphere MT3620 Starter Kit Revision 1 and 2

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

- The network-connected LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).

- Telemetry is sent approximately every 6 seconds.

- The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

- The network-connected LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).

- Telemetry is sent approximately every 6 seconds.

- The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

- The User LED toggles approximately every 5 seconds while connected to Azure IoT Hub (driven by the connection-status timer).

- Telemetry is sent approximately every 6 seconds.

## Close Visual Studio Code

Now close Visual Studio Code.
