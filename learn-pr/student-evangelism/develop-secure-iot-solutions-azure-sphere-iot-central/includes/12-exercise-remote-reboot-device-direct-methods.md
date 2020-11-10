## Step 1: Build and deploy your application

1. Start Visual Studio Code to open your project.

2. Click **Open folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_4_Direct_Methods** folder.

5. Click **Select Folder** or the **OK** button to open the project.

6. Set your developer board configuration:

   1. Open **CMakeList.txt**.
   2. Uncomment the **set** command that corresponds to your Azure Sphere developer board.
   3. Save the file. This will autogenerate the CMake cache.

7. Configure the Azure IoT Central connection information:

   1. Open the **app_manifest.json** file.
   2. Redo the settings for the file. Either copy the settings from Notepad if you still have it open, or copy them from the **app_manifest.json** file you created in the previous exercise.
   3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

8. Ensure **main.c** is open.

9. Select **CMake: [Debug]: Ready** from the Visual Studio Code status bar.

10. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

## Expected device behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.
1. When you initiate the device restart direct method you will observe the device restarting.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.
1. When you initiate the device restart direct method you will observe the device restarting.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The User LED will blink every 5 seconds when connected to Azure.
1. When you initiate the device restart direct method you will observe the device restarting.

## Testing Azure IoT Central commands

1. From Visual Studio, ensure that Azure Sphere is running the application and set a breakpoint in the **RestartDeviceDirectMethodHandler** handler function.

2. Switch to Azure IoT Central in your web browser.

3. Select the Azure IoT Central **Commands** tab.

4. Set the **Restart Device** time in seconds, and then click **Run**.

5. Observer the device rebooting. The LEDs will turn off for a few seconds.

   ![The illustration shows how to control the device with a command.](../media/iot-central-device-command-run.png)

6. Switch back to Visual Studio. The application execution should have stopped where you set the breakpoint. Using the debugger, step over code (F10), step into code (F11), and continue code execution (F5) to understand the code path in more detail.

7. Switch back to Azure IoT Central and click the **Command History** button to view the result of the command.

    > [!NOTE]
    > You may see a timed-out message in the history, depending on how long it took you to step through the code in Visual Studio.

## Close Visual Studio

Now close Visual Studio.
