All the required units for this module have been completed. In this unit, we consider what steps would be necessary to add multiple trucks to our system. 

Feel free to skip this unit, completing it is optional!

## Add multiple devices to the IoT Central app

1. To add multiple devices, start in the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) app, selecting **Devices** in the left-hand menu.

1. Select **RefrigeratedTruck** in the **Devices** menu, to ensure the device we create uses this device template. The device template you select will be shown in bold text.

1. Select **New**. Verify in the dialog that the device name includes the **RefrigeratedTruck** text. If it doesn't, you've not selected the right device template.

1. Change the **Device ID** to a friendlier name, say "RefrigeratedTruck2".

1. Change the **Device name** to a friendlier name, say "RefrigeratedTruck - 2".

1. Leave the **Simulated** setting at **Off**.

1. Select **Create**.

Repeat this process to create as many devices as you want.

## Provision the new devices

1. Double-select on **RefrigeratedTruck - 2**, and then select **Connect** (top right of your IoT Central screen).

1. In the **Device Connection** screen, copy the **Device ID** and the **Primary Key** to your text file, noting that they are for the second truck. There's no need to copy the **ID Scope**, as this value is identical to the value for the first truck (this ID identifies your app, not an individual device).

1. Select **Close**.

1. Back on the **Devices** page, repeat the process for any other devices you created, copying their **Device ID** and **Primary Key** to your text file.

1. When you have completed connecting all the new trucks, notice that the **Provisioning Status** is still **Registered**. Not until you make the connection will this change.

## Create new apps for each new device

Each truck is simulated by one running copy of the device app. So, you need multiple versions of this app running simultaneously.

1. Create multiple projects by repeating the steps in the **Create a programming project for a real device** for each new device. Copy and paste the entire app from your current working project, replacing the `DeviceID` and device `PrimaryKey` with new values. No need to change the `ScopeID` or the `AzureMapsKey`, as these values are identical for all devices.

1. Remember to add the necessary libraries to each new project.

1. Change the truck identification number in each project to a different value.

1. Set each project app running.

## Verify the telemetry from all the devices

1. Verify that the views you created work for all trucks.

1. Using the dashboard for each truck, try ordering the trucks to different customers. Using the **Location** map on each dashboard, verify the trucks are heading in the right direction!

## Next steps

To finish the module, pass the following knowledge check.
