## Step 1: Open the project

1. Start Visual Studio Code
2. Click **Open folder**.
3. Open the Azure-Sphere lab folder.
4. Open the **Lab_3_Device_Twins** folder.
5. Click **Select Folder** button to open the project.

## Step 2: Set your developer board configuration

These labs support developer boards from AVNET and Seeed Studio. You need to set the configuration that matches your developer board.

The default developer board configuration is for the AVNET Azure Sphere Starter Kit. If you have this board, there's no additional configuration required.

1. Open CMakeList.txt.

2. Add a # at the beginning of the set AVNET line to disable it.

3. Uncomment the **set** command that corresponds to your Azure Sphere developer board.

   ```
   set(AVNET TRUE "AVNET Azure Sphere Starter Kit")                
   # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
   # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
   ```

4. Save the file. This will autogenerate the CMake cache.

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.
2. You'll need to redo the settings for the **app_manifest.json** file. Either copy from **Notepad** if you still have it open or copy from the **app_manifest.json** file you created in the previous exercise.
3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

## Step 4: Start the app build deploy process

1. Ensure main.c is open.

2. Select **CMake: [Debug]: Ready** from the Visual Studio Code Status Bar.

3. From Visual Studio Code, press F5 to build, deploy, start, and attached the remote debugger to the application now running the Azure Sphere device.

## Step 5: Expected Device Behavior

### Avnet Azure Sphere MT3620 Starter Kit

![The illustration shows Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

1. The RGB LED5 will start to blink. In the next section, you'll be setting the desired temperature which will determine the RGB LED color.
2. LED4 will turn yellow when connected to Azure.
3. LED3 will blink when telemetry is sent to IoT Hub
4. Press **Button A** or **Button B** on the device to change the blink rate of LED5 and to update the **Actual Temperature** device twin property in IoT Hub.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The RGB LED 1 will start to blink. In the next section, you'll be setting the desired temperature which will determine the RGB LED color.
2. The network LED will turn red when connected to Azure.
3. LED 4 will blink blue when telemetry is sent to IoT Hub
4. Press **Button A** or **Button B** on the device to change the blink rate of RGB LED 1 and to update the **Actual Temperature** device twin property in IoT Hub.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The green LED closest to the USB connector will start to blink
2. Given this device has no builtin buttons then virtual **Button A** and **Button B** presses will be generated every 10 seconds. The blink rate will change and the **Actual Temperature** device twin property in IoT Hub will be updated.

## Step 6: Display the actual temperature device twin

We're going to use the Azure command-line tool to view and update the IoT Hub device twins. For more information, see [az iot hub device-twin](https://docs.microsoft.com/cli/azure/ext/azure-cli-iot-ext/iot/hub/device-twin?view=azure-cli-latest).

Follow these steps to show the actual temperature recorded by the device:

1. For Azure Sphere devices with buttons, press Button A or B. Virtual button presses are generated for devices without buttons

2. You need the name of the Azure IoT Hub you created. You can get the name from the Azure web portal.

3. You need the Azure Sphere device ID. Run the following command from the **Azure Sphere Developer Command Prompt**.

   ```
   azsphere dev show-attached
   ```

4. Open the Azure Cloud Shell by right mouse clicking on the following link and opening in a new tab "[https://shell.azure.com](https://shell.azure.com/)".

5. In the Cloud Shell, run the [az extension add](https://docs.microsoft.com/cli/azure/extension?view=azure-cli-latest#az-extension-add) command to add the Microsoft Azure IoT Extension to your CLI shell. The IoT Extension adds IoT Hub, IoT Edge, and IoT Device Provisioning Service (DPS) specific commands to Azure CLI.

   ```
   az extension add --name azure-iot
   ```

6. Set a bash variable in the Cloud Shell for your Azure Sphere Device ID. Make sure there are no spaces either side of the **=** character.

   ```
   DEVICE_ID={your Azure Sphere device ID}
   ```

7. Set a bash variable in the Cloud Shell for your IoT Hub name. Make sure there are no spaces either side of the **=** character.

   ```
   HUB_NAME={your hub name}
   ```

8. Show the latest state of the device twin JSON document. Review the **reported** section for the **ActualTemperature** property.

   ```
   az iot hub device-twin show --device-id "${DEVICE_ID,,}" -n $HUB_NAME
   ```

    > [!NOTE]
    > IoT Hub requires Device IDs to be lowercase. The bash command **"${DEVICE_ID,,}"** in the device twin show command converts the device id to lowercase.

9. Review the device twin **reported** section and look for the updated **ActualTemperature** property.

   ```
   {
     "authenticationType": "selfSigned",
     "capabilities": {
       "iotEdge": false
     },
     "cloudToDeviceMessageCount": 0,
     "connectionState": "Connected",
     "deviceEtag": "NjgyOTY2MjU4",
     "deviceId": "3ea5ef99999999999999999999999999999990247a0bc6d37029999999996b8183ce07c1817d02cdd95b0d8b999991a201a8c34137935",
     "etag": "AAAAAAAAAAE=",
     "lastActivityTime": "0001-01-01T00:00:00Z",
     "properties": {
       "desired": {
         "$metadata": {
           "$lastUpdated": "2020-06-22T05:52:42.7416771Z"
         },
         "$version": 1
       },
       "reported": {
         "$metadata": {
           "$lastUpdated": "2020-06-22T05:52:58.8264962Z",
           "ActualTemperature": {
             "$lastUpdated": "2020-06-22T05:52:58.8264962Z"
           }
         },
         "$version": 2,
         "ActualTemperature": 29.0
       }
     },
     "status": "enabled",
     "statusUpdateTime": "0001-01-01T00:00:00Z",
     "version": 3,
     "x509Thumbprint": {
       "primaryThumbprint": "188109118C6F979078C9999999999D9B231DA41BA4706EC",
       "secondaryThumbprint": "1881091180000000000999650AE3250B4313385DD9B231DA41BA4706EC"
     }
   }
   ```

10. Leave the Cloud Shell open for the next section.

------

## Step 7: Set the desired temperature device twin

Setting the desired temperature is like setting a thermostat in a room. A desired temperature device twin property message is sent to the Azure Sphere where it will be acted upon.

When the temperature sensor is read on the Azure Sphere device it is compared to the desired temperature.

- If the temperature is greater than the desired temperature the blinking LED will turn blue to indicate the cooler needs be turned on.
- If the temperature is less than the desired temperature then the blinking LED will turn red to indicate the heater needs to be turned on.
- If the temperature is the same as the desired temperature then the blinking LED turns green to indicate no action required.

> The AVNET Azure Sphere Starter Kit has a built-in temperature sensor. For other boards, a random temperature 25 +/- 5 degrees celsius is generated.

To set the desired temperature:

1. The **DEVICE_ID** and **HUB_NAME** bash variables were set the previous section.

2. Run the iot hub device twin update.

   ```
   az iot hub device-twin update --device-id "${DEVICE_ID,,}" -n $HUB_NAME --set properties.desired='{"DesiredTemperature":{"value":25}}'
   ```

    > [!NOTE]
    > IoT Hub requires Device IDs to be lowercase. The bash command **"${DEVICE_ID,,}"** in the device twin show command converts the device id to lowercase.

3. Observe the blinking LED on the Azure Sphere may change color depending on the desired temperature you set.

4. Show the latest state of the device twin. Review the **desired** and **reported** sections for the **DesiredTemperature** property.

   ```
   az iot hub device-twin show --device-id "${DEVICE_ID,,}" -n $HUB_NAME
   ```

5. Try setting more extreme desired temperatures. For example, try 0 or 100. Again, observe the blinking LED will change color.

6. Close the Cloud Shell by typing `exit`.

## Close Visual Studio

Now close **Close Visual Studio**.
