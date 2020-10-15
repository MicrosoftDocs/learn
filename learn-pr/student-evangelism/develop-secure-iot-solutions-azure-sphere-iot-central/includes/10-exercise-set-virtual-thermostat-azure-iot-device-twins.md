## Step 1: Build and deploy your application

1. Start Visual Studio Code to open your project.

2. Click **Open folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_3_Device_Twins** folder.

5. Click **Select Folder** or the **OK** button to open the project.

6. Set your developer board configuration:

   1. Open **CMakeList.txt**.
   2. Uncomment the **set** command that corresponds to your Azure Sphere developer board.
   3. Save the file. This will autogenerate the CMake cache.

7. Configure the Azure IoT Central connection information:

   1. Open the **app_manifest.json** file.
   2. You'll need to redo the settings for the **app_manifest.json** file. Either copy the settings from Notepad if you still have it open, or copy them from the **app_manifest.json** file you created in the previous exercise.
   3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

8. Ensure **main.c** is open.

9. Select **CMake: [Debug]: Ready** from the Visual Studio Code status bar.

10. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

## Step 2: Expected device behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. The RGB LED5 will start to blink. In the next section, you'll be setting the desired temperature, which will determine the RGB LED color.
2. LED4 will turn yellow when connected to Azure.
3. LED3 will blink when telemetry is sent to Azure IoT Central.
4. Press **Button A** or **Button B** on the device to change the blink rate of LED5 and to update the **Actual Temperature** device twin property in Azure IoT Central.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The RGB LED 1 will start to blink. In the next section, you'll be setting the desired temperature, which will determine the RGB LED color.
2. The network LED will turn red when connected to Azure.
3. LED 4 will blink blue when telemetry is sent to Azure IoT Central.
4. Press **Button A** or **Button B** on the device to change the blink rate of RGB LED 1 and to update the **Actual Temperature** device twin property in Azure IoT Central.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The green LED closest to the USB connector will start to blink.
2. Given this device has no built-in buttons, virtual **Button A** and **Button B** presses will be generated every 10 seconds. The blink rate will change and the **Actual Temperature** device twin property in Azure IoT Central will be updated.

## Step 3: Display the actual temperature property

1. Switch to Azure IoT Central in your browser.

2. Select **Devices**, then the **Azure Sphere** template, then your device.

3. Select the **Form** tab.

4. For Azure Sphere devices with built-in buttons, press **Button A** or **Button B** to update the **Actual Temperature** property in Azure IoT Central.

    > [!NOTE]
    > Azure IoT Central does not update immediately. It might take a minute or two for the **Actual Temperature** property to change.

   Virtual button-press events are generated for Azure Sphere devices that do not have built-in buttons.

![The illustration shows how to display telemetry.](../media/iot-central-display-telemetry.png)

## Step 4: Set the desired temperature

Setting the desired temperature is like setting a thermostat in a room. A device twin property message for desired temperature is sent to Azure Sphere, where it will be acted upon.

When the temperature sensor is read on Azure Sphere, it is compared to the desired temperature.

- If the temperature is greater than the desired temperature, the blinking LED will turn blue to indicate the cooler needs be turned on.
- If the temperature is less than the desired temperature, the blinking LED will turn red to indicate the heater needs to be turned on.
- If the temperature is the same as the desired temperature, the blinking LED will turn green to indicate no action required.

> The Avnet Azure Sphere Starter Kit has a built-in temperature sensor. For other boards, a random temperature of 25 +/- 5 degrees Celsius is generated.

To set the desired temperature:

1. Update the **Desired Temperature** value.
2. Save the property. This will send the desired temperature property to Azure Sphere. The blinking LED color may change depending on the desired temperature chosen.

![The illustration shows display settings.](../media/iot-central-display-settings.png)

## Close Visual Studio

Now close Visual Studio.
