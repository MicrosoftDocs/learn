You've completed all the required units for this module. In this unit, you consider steps to add multiple trucks to the system. Feel free to skip this optional unit.

## Add multiple devices to the IoT Central app

1. To add multiple devices, start in the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) app. In the menu on the left, select **Devices**.

1. In the **Devices** menu, select **RefrigeratedTruck** to ensure the device you create uses this device template. Your selected device template appears in bold text.

1. Select **New**. In the dialog box, verify that the device name includes **RefrigeratedTruck**. If it doesn't, you haven't selected the right device template.

1. Change the **Device ID** to a friendlier name, say _RefrigeratedTruck2_.

1. Change the **Device name** to a friendlier name, say _RefrigeratedTruck - 2_.

1. Leave the **Simulated** setting at **Off**.

1. Select **Create**.

Repeat this process to create as many devices as you want.

## Provision the new devices

1. Double-click **RefrigeratedTruck - 2**. Then in the upper-right corner, select **Connect**.

1. On the **Device Connection** window, copy the second truck's **Device ID** and **Primary key** to your text file. You don't need to copy the **ID scope**. This value is identical to the value for the first truck. The ID scope identifies your app, not an individual device.

1. Select **Close**.

1. Back on the **Devices** page, repeat the process for any other devices you created. Copy their **Device ID** and **Primary key** to your text file.

1. When you finish connecting all the new trucks, notice that the **Provisioning Status** is still **Registered**. This status will change after you make the connection.

## Create new apps for each new device

Each truck is simulated by one running copy of the device app. So multiple versions of this app need to run simultaneously.

1. Create multiple projects by repeating the steps in the [Create a programming project for a real device](../5-create-real-device-nodejs.yml) exercise for each new device. Copy and paste the entire app from your current working project. In the code, replace `DeviceID` and `PrimaryKey` with new values. You don't need to change `ScopeID` or `AzureMapsKey`. These values are identical for all devices.

1. Add the necessary libraries to each new project.

1. In each project, change the truck identification number to a different value.

1. Run each project app.

## Verify the telemetry from all the devices

1. Verify that the views you created work for all trucks.

1. On the dashboard for each truck, try ordering the trucks to different customers. 

1. Use the **Location** map on each dashboard to verify the trucks are heading in the right direction!

## Next steps

To finish the module, complete the following knowledge check.
