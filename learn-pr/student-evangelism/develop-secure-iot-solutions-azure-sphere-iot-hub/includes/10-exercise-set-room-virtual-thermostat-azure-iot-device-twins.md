## Step 1: Open the project

1. Start Visual Studio Code to open your project.
2. Click **Open folder**.
3. Open the **Azure-Sphere lab** folder.
4. Open the **Lab_3_Device_Twins** folder.
5. Click **Select Folder** or the **OK** button to open the project.

------

## Step 2: Set your developer board configuration

These labs support developer boards from Avnet and Seeed Studio. You need to set the configuration that matches your developer board.

The default developer board configuration is for the Avnet Azure Sphere Starter Kit. If you have this board, there's no additional configuration required.

1. Open the **CMakeList.txt** file.
2. Add a `#` at the beginning of the set Avnet line to disable it.
3. Uncomment the `set` command that corresponds to your Azure Sphere device developer board.

   ```
   set(AVNET TRUE "AVNET Azure Sphere Starter Kit")
   # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
   # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
   ```

4. Save the file. This will auto-generate the CMake cache.

------

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.
2. You'll need to redo the settings for this file. Either copy from Notepad, if you still have it open, or copy from the **app_manifest.json** file that you created in the previous exercise.
3. Paste the contents of the clipboard into **app_manifest.json** and save the file.

------

## Step 4: Start the app build deploy process

1. Ensure main.c is open.
2. Select **CMake: [Debug]: Ready** from the Visual Studio Code Status Bar.
3. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application that's now running the Azure Sphere device.

------

## Step 5: Expected device behavior

### Avnet Azure Sphere MT3620 Starter Kit

![Photo of the Avnet Azure Sphere Kit.](../media/avnet-azure-sphere.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.
1. The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio Azure Sphere MT3620 Development Kit

![Photo of the Seeed Studio Azure Sphere Kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

1. The WLAN LED will blink every 5 seconds when connected to Azure.
1. The RGB LED will turn red if the measured temperature is less than the desired temperature, blue if the measured temperature is greater than the desired temperature and green if the measured temperature is the same as the desired temperature.

### Seeed Studio MT3620 Mini Dev Board

![Photo of the Seeed Studio Mini Azure Sphere Kit.](../media/seeed-studio-azure-sphere-mini.png)

1. The User LED will blink every 5 seconds when connected to Azure.

------

## Step 6: Display the actual temperature device twin

We're going to use the Azure command-line tool to view and update the IoT hub device twins. For more information, see [az iot hub device-twin](https://docs.microsoft.com/cli/azure/ext/azure-cli-iot-ext/iot/hub/device-twin?view=azure-cli-latest).

Follow these steps to show the actual temperature recorded by the device:

1. You need the name of the Azure IoT hub you created. You can get the name from the Azure portal.
2. You need the Azure Sphere device ID. Run the following command from the **Azure Sphere Developer Command Prompt**.

   ```
   azsphere dev show-attached
   ```

4. Open Azure Cloud Shell by right-clicking the following link and opening in a new tab: [https://shell.azure.com](https://shell.azure.com/).

5. In Cloud Shell, run the [az extension add](https://docs.microsoft.com/cli/azure/extension?view=azure-cli-latest#az-extension-add) command to add the Microsoft Azure IoT Extension to the Azure CLI shell. The IoT Extension adds IoT Hub, IoT Edge, and IoT device provisioning service specific commands to the Azure CLI.

   ```
   az extension add --name azure-iot
   ```

6. Set a bash variable in Cloud Shell for your Azure Sphere device ID. Make sure there are no spaces on either side of the `=` character.

   ```
   DEVICE_ID={your Azure Sphere device ID}
   ```

7. Set a bash variable in Cloud Shell for your IoT Hub name. Make sure there are no spaces on either side of the `=` character.

   ```
   HUB_NAME={your hub name}
   ```

8. Show the latest state of the device twin JSON document. Review the `reported` section for the `ActualTemperature` property.

   ```
   az iot hub device-twin show --device-id "${DEVICE_ID,,}" -n $HUB_NAME
   ```

    > [!NOTE]
    > IoT Hub requires device IDs to be lowercase. The bash command `"${DEVICE_ID,,}"` in the `device-twin show` command converts the device ID to lowercase.

9. Review the device twin `reported` section and look for the updated `ReportedTemperature` property.

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
           "ReportedTemperature": {
             "$lastUpdated": "2020-06-22T05:52:58.8264962Z"
           }
         },
         "$version": 2,
         "ReportedTemperature": 29.0
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

10. Leave Cloud Shell open for the next section.

------

## Step 7: Set the desired temperature device twin

Setting the desired temperature is like setting a thermostat in a room. A desired temperature device twin property message is sent to the Azure Sphere device where it will be acted upon.

When the temperature sensor is read on the Azure Sphere device, it's compared to the desired temperature.

- If the temperature is greater than the desired temperature, the RGB LED turns blue to indicate the cooler needs be turned on.
- If the temperature is less than the desired temperature, the RGB LED turns red to indicate the heater needs to be turned on.
- If the temperature is the same as the desired temperature, the RGB LED turns green to indicate no action is required.

The Avnet Azure Sphere Starter Kit has a built-in temperature sensor. For other boards, a random temperature 25 +/- 5 degrees celsius is generated.

To set the desired temperature:

1. The `DEVICE_ID` and `HUB_NAME` bash variables were set in the previous section.

2. Run the IoT hub device twin update.

   ```
   az iot hub device-twin update --device-id "${DEVICE_ID,,}" -n $HUB_NAME --set properties.desired='{"DesiredTemperature":25}'
   ```

    > [!NOTE]
    > IoT Hub requires device IDs to be lowercase. The bash command `"${DEVICE_ID,,}"` in the `device-twin show` command converts the device ID to lowercase.

3. The RGB LED on the Azure Sphere device will change color, depending on the desired temperature you set.

4. Show the latest state of the device twin. Review the `desired` and `reported` sections for the `DesiredTemperature` property.

   ```
   az iot hub device-twin show --device-id "${DEVICE_ID,,}" -n $HUB_NAME
   ```

5. Try setting more extreme desired temperatures. For example, try 0 or 100. Again, you can observe that the blinking LED changes color in response.

6. Close Cloud Shell by typing `exit`.

------

## Close Visual Studio

Now close Visual Studio.
