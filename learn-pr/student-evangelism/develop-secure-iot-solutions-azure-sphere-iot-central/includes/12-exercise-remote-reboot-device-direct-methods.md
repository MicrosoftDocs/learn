## Step 1: Build and deploy your application

1. Start Visual Studio Code to open your project.

2. Click **Open folder**.

3. Open the Azure-Sphere lab folder.

4. Open the **Lab_4_Direct_Methods** folder.

5. Click **Select Folder** or the **OK** button to open the project.

6. Set your developer board configuration

   1. Open CMakeList.txt
   2. Uncomment the **set** command that corresponds to your Azure Sphere developer board.
   3. Save the file. This will autogenerate the CMake cache.

7. Configure the Azure IoT Central connection information

   1. Open the **app_manifest.json** file.
   2. You'll need to redo the settings for the **app_manifest.json** file. Either copy from **Notepad** if you still have it open or copy from the **app_manifest.json** file you created in the previous exercise.
   3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

8. Ensure main.c is open.

9. Select **CMake: [Debug]: Ready** from the Visual Studio Code Status Bar.

10. From Visual Studio Code, press F5 to build, deploy, start, and attached the remote debugger to the application now running the Azure Sphere device.

## Expected device behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

LED3 will turn yellow when connected to Azure.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

The network LED will turn red when connected to Azure.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

The green LED closest to the USB connector will turn on when connected to Azure.

## Testing Azure IoT Central Commands

1. From Visual Studio, ensure the Azure Sphere is running the application and set a breakpoint in the **ResetDirectMethod** handler function.

2. Switch to Azure IoT Central in your web browser.

3. Select the Azure IoT Central **Commands** tab.

4. Set the **Reset Azure Sphere** time in seconds, then click **Run**.

5. Observer the device rebooting. The LEDs will turn off for a few seconds.

   ![The illustration shows how to control the device with Command.](../media/iot-central-device-command-run.png)

6. Switch back to Visual Studio. The application execution should have stopped where you set the breakpoint. Step over code F10, step into code F11, and continue code execution F5.

7. Switch back to Azure IoT Central, and click the Command History button to view the result of the command.

    > [!NOTE]
    > You may see a timed out message in the history depending on how long it took you to step through the code in Visual Studio.

## Close Visual Studio

Now close Close Visual Studio.
