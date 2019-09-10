The heavy-lifting of this module has been completed, the process of extending our process to multiple trucks is relatively easy.

## Add mutliple devices to the IoT Central app
1. To add multiple devices, start in the IoT Central app, clicking **Devices** in the left-hand menu.
2. Click the **+** then **Real** to add a second truck, change the **Device Name** to "RefrigeratedTruck - 2". This will take you to the **Device** page, so go back to the **Devices** page.
3. Repeat the process so that you have five trucks. Note that there is a limit in the Trial plan to the number of devices you can create. Feel free to delete the **(Simulated)** device if you run into this limit.

> [!NOTE]
> To delete any device, click the check box next to it, then select the garbage can icon top right. You will be prompted to confirm you want to delete the device.

4. Verify you now have five devices, all created with the same template, but with only the first with **Provisioned** status, the additions are just **Registered**.

![Just cresated all five devices](../media/refrigerated-trucks-five.png)

## Provision the new devices

1. Double-click on **RefrigeratedTruck - 2**, and then click **Connect** (top right of your IoT Central screen).
2. In the **Device Connection** screen, copy the **Device ID** and the **Primary Key** to your text file, noting that they are for the second truck. There is no need to copy the **Scope ID**, as this value is identical to the value for the first truck (it identifies your app, not an individual device).
3. Click **Close**.
4. Back on the **Devices** page, repeat the process for trucks 3 through 5, copying their **Device ID** and **Primary Key** to your text file.
5. When you have completed connecting all four new trucks, notice that the **Provisioning Status** is still **Registered**. Not until we actually make the connection will this change.

## Create connection strings for the new devices

1. In your text file, create four strings that match the following outline, replacing **scope_id** with the same value as that for the first truck, but with the unique **Device ID** and **Primary Key** for each individual device. Note too, that the name of the output text file is changed to match the truck number (this is to avoid mistakes).

```
    ./dps_cstr scope_id device_id2 primary_key2 > connection2.txt
    ./dps_cstr scope_id device_id3 primary_key3 > connection3.txt
    ./dps_cstr scope_id device_id4 primary_key4 > connection4.txt
    ./dps_cstr scope_id device_id5 primary_key5 > connection5.txt
```

 > [!NOTE]
 > Preparing strings manually this way does require patience and time. This would be onerous if there was a large number of devices. Automated device provisioning, using Azure DPS, is a subject you can investigate further, if needed for the scenarios you might be addressing in future.

2. Open up Azure Cloud Shell, and navigate to the right folder by entering ```cd refrigerated-truck```.
3. Copy across one at a time, from your text file, each of the four strings (starting with **./dps_cstr...**) and press Enter after each is pasted into Azure Cloud Shell. Each will take a few seconds to run.
4. Select the **{ }** icon to open up the file structure, open the **refrigerated-truck** folder, and verify you have files named connection2.txt through to connection5.txt.
5. Open up each one of these files in turn, and copy across the connection string (from "HostName=" to the end of the file) to your text file.
6. Close Azure Cloud Shell.
7. Remember to verify that each connection string ends with an exact copy of the **Primary Key**. There can be spurious text at the end of the connection.txt file.

## Update the Node.JS app to handle multiple devices

1. Open up your Node.JS app in the development environment you are using (Visual Studio Code, Visual Studio).

2. Locate the switch statement at the top of the file, and add four entries:

```js
switch (truckNum) {
    case 1:
        // Leave this entry as is.
        break;
            
    case 2:
        connectionString = "xxxxx";
        break;

    case 3:
        connectionString = "xxxxx";
        break;

    case 4:
        connectionString = "xxxxx";
        break;

    case 5:
        connectionString = "xxxxx";
        break;
}
```

3. Carefully copy the four connection strings from your text file, to the correct location in this switch statement.
4. Take a moment to verify you have copied all four exactly, each connection string should be of identical length.

## Run five versions of the Node.JS app

Each truck is simulated by one running copy of the Node.JS app. So, we need five versions of this app running simultaneously.

1. With the line  ```const truckNum = 1``` run the app, but _not_ in debugging mode (Debugging mode might not work with five versions running together). Does the app start, connect, and start sending telemetry? If so, good, go on to the next step. If not, go back and check you have altered the code correctly.
2. Change the line to ```const truckNum = 2;```, and run the app again. You should get a second console window, and the correct startup sequence should appear.
3. Repeat this process for trucks 3 through 5, changing the ```const truckNum``` and running the app.
4. Exciting isn't it. You now have five console windows open, with five simulated refrigerated trucks waiting for their commands!

## Monitor and command the trucks from IoT Central

1. In the **Devices** page of your IoT Central app, verify all devices are **Provisioned**.
2. Double-click on each device in turn, then select **Commands**. In the **Go to customer** command, send Truck 1 to customer 1, Truck 2 to customer 2, and so on (to Truck 5 to customer 5).
3. There is now a lot going on! Select each device in turn on the **Devices** page, and in the **Measurements** section, open up the map view. Make sure the eye icon of the **Location** is turned on. Each truck should now be on its way to a unique customer.

![Map view of first delivery of truck three](../media/refrigerated-trucks-three-enroute.png)

4. There is in fact now so much going on it is tough to keep track of it. For each truck open up one of the other views, and check the states and events. Did any of the cooling systems fail? Did any of the contents melt?

Clearly the map view is one of the most useful, at least in terms of giving the operator some confidence that they can see the big picture. It is tough to have this confidence when each truck is shown on a different map. In the next unit, we will look about resolving this by creating a device set, which enables all device locations to appear on a single map.

You can leave all five Node.JS apps running, the trucks will have returned to their base and will be ready for the next unit when needed!