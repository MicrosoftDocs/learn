## Step 1: Build and deploy your application

1. Start Visual Studio Code to open your project.

2. From the menu, click **File**, then **Open Folder**.

3. Open the **Azure-Sphere lab** folder.

4. Open the **Lab_4_Direct_Methods** folder.

5. Click **Select Folder** or the **OK** button to open the project.

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

4. Save the file. This will autogenerate the CMake cache.

## Step 3: Configure the Azure IoT connection information

1. Open the **app_manifest.json** file.

2. You'll need to redo the settings for the **app_manifest.json** file. Either copy the settings from Notepad if you still have it open. Alternatively,  copy the **app_manifest.json** settings created in the previous exercise.

3. Replace the existing configuration by pasting the contents of the clipboard into **app_manifest.json**.

4. Save the updated **app_manifest.json** file.

## Step 4: Start the app build deploy process

1. Open **main.c**.
1. Select **CMake: [Debug]: Ready** from the Visual Studio Code status bar.
1. From Visual Studio Code, press F5 to build, deploy, start, and attach the remote debugger to the application now running the Azure Sphere device.

## Expected device behavior

### Azure Sphere MT3620 Starter Kit Revision 1 and 2

![The illustration shows the Avnet Azure Sphere kit.](../media/avnet-azure-sphere.jpg)

- The WLAN LED will blink every 5 seconds when connected to Azure.

- When you initiate the device restart direct method, you will observe the device restarting.

### Seeed Studio Azure Sphere MT3620 Development Kit

![The illustration shows the Seeed Studio Azure Sphere kit.](../media/seeed-studio-azure-sphere-rdb.jpg)

- The WLAN LED will blink every 5 seconds when connected to Azure.

- When you initiate the device restart direct method, you will observe the device restarting.

### Seeed Studio MT3620 Mini Dev Board

![The illustration shows the Seeed Studio Mini Azure Sphere kit.](../media/seeed-studio-azure-sphere-mini.png)

- The User LED will blink every 5 seconds when connected to Azure.

- When you initiate the device restart direct method, you will observe the device restarting.

## Testing Azure IoT Hub direct method commands

1. Start **Azure IoT Explorer**.

1. Click **View devices in this hub**.

1. Click your on your **device**.

1. Click **IoT Plug and Play components** from the side menu.

1. Click **Default component**.

1. Select **Commands** from the menu.

1. Set the **Restart Delay** value to be greater than 2 and less than 10.

1. Click the **Send command** button.

## Close Visual Studio

Now close Visual Studio.
