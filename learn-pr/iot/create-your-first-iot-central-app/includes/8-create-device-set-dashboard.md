All the required units for this module have been completed. In this unit, we consider what steps would be necessary to add multiple trucks to our system. Feel free to skip this unit, completing it is optional!

## Add multiple devices to the IoT Central app

1. To add multiple devices, start in the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) app, clicking **Devices** in the left-hand menu.

1. Click **RefrigeratedTruck** in the **Devices** menu, to ensure the device we create uses this device template. The device template you select will be shown in bold text.

1. Click **+ New**. Verify in the dialog that the device name includes the **RefrigeratedTruck** text. If it doesn't, you've not selected the right device template.

1. Change the **Device ID** to a friendlier name, say "RefrigeratedTruck2".

1. Change the **Device name** to a friendlier name, say "RefrigeratedTruck - 2".

1. Leave the **Simulated** setting at **Off**.

1. Click **Create**.

Repeat this process to create as many devices as you need.

## Provision the new devices

1. Double-click on **RefrigeratedTruck - 2**, and then click **Connect** (top right of your IoT Central screen).

1. In the **Device Connection** screen, copy the **Device ID** and the **Primary Key** to your text file, noting that they are for the second truck. There is no need to copy the **Scope ID**, as this value is identical to the value for the first truck (it identifies your app, not an individual device).

1. Click **Close**.

1. Back on the **Devices** page, repeat the process for any other devices you created, copying their **Device ID** and **Primary Key** to your text file.

1. When you have completed connecting all new trucks, notice that the **Provisioning Status** is still **Registered**. Not until you make the connection will this change.

::: zone pivot="vs-node,vscode-node"

## Create connection strings for the new devices

1. In your text file, create strings that match the following outline, replacing `{scope_id}` with the value for the first truck, and the appropriate device values for each `{device_id#}` and `{primary_key#}` placeholder. Also add the truck number to the name of the text file.

    ```bash
    ./dps_cstr {scope_id} {device_id2} {primary_key2} > connection2.txt
    ```
1. Navigate to the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true).

1. In the Cloud Shell session, navigate to the `refrigerated-truck` folder.

1. Copy across one at a time, from your text file, each of the strings (starting with **./dps_cstr...**) and press Enter after each is pasted into Azure Cloud Shell. Each will take a few seconds to run.

1. Select the **{ }** icon to open up the file structure, open the **refrigerated-truck** folder.

1. Open up each one of the connection.txt files in turn, and copy across the connection string (from "HostName=" to the end of the file) to your text file.

1. Close Azure Cloud Shell.

1. Verify that each connection string ends with an exact copy of the **Primary Key**, just in case there is spurious text at the end of any of the **connection#.txt** files.

## Update the device app to handle multiple devices

1. Open up your device app in the development environment you are using.

1. Locate the `connectionString` statement at the top of the file, and replace it with code similar to the following:

    ```js
    var connectionString;

    switch (truckNum) {
        case 1:
            connectionString = "<your first truck connection string>";
            break;

        case 2:
            connectionString = "<your second truck connection string>";
            break;

        case 3:
            connectionString = "<your third truck connection string>";
            break;

        case 4:
            connectionString = "<your fourth truck connection string>";
            break;

        case 5:
            connectionString = "<your fifth truck connection string>";
            break;
    }
    ```

1. Carefully copy the connection strings from your text file, to the correct location in this switch statement.

1. Take a moment to verify you have copied all strings exactly, each connection string should be of identical length.

1. For as many devices as you have set up, change the `truckNum` variable, and set all device apps running.

::: zone-end
::: zone pivot="vs-csharp,vscode-csharp"

## Create new apps for each new device

Each truck is simulated by one running copy of the device app. So, you need multiple versions of this app running simultaneously.

1. Create multiple projects by repeating the steps in the **Create a programming project for a real device** for each new device. Copy and paste the entire app from your current working project, replacing the **Device ID** and **Primary Key** with new values. No need to change the **Scope ID** or the **Azure Maps subscription Key**, as these are identical for all devices.

1. Remember to add the necessary libraries to each new project.

1. Change the `truckNum` in each project to a different value.

1. Set each project app running.

::: zone-end

## Verify the telemetry from all the devices

1. Verify that the one dashboard you created works for all trucks.

1. Using the dashboard for each truck, try ordering the trucks to different customers. Using the **Location** map on each dashboard, verify the trucks are heading in the right direction!

## Next steps

To finish the module, pass the following knowledge check.
