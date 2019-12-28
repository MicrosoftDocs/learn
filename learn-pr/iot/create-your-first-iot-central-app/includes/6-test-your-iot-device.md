Working through this unit is an exciting time in IoT Central development! Finally, you get to check whether all the moving parts you've created work together.

  > [!TIP]
  > It can be helpful to have multiple monitors available, to display all the browser windows and console screens that are active at the same time.

## Test the device app and IoT Central app together

To fully test the refrigerated truck device, it helps to break down the testing into a number of discreet checks:

1. The device app connects to Azure IoT Central.
1. The telemetry functions send data on the specified interval.
1. The data is picked up correctly by IoT Central.
1. The command to send the truck to a specified customer works as expected.
1. The command to recall the truck works as expected.
1. Check customer and conflict events are transmitted correctly.
1. Check the truck properties, and change the optimal temperature.

In addition to this list, there are edge-cases you could also investigate. One such case is what happens when the truck's contents start to melt? This state is left up to chance in our simulation, with the use of random numbers in our code in the previous unit.

To begin the testing, with your [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) app open in a browser, run the device app.

::: zone pivot="vs-csharp,vs-node"

1. In Visual Studio, select **Debug/Start without Debugging**.

::: zone-end
::: zone pivot="vscode-node"

1. In the terminal, enter `node app.js`.

::: zone-end
::: zone pivot="vscode-csharp"

1. In the terminal, enter `dotnet run`.

::: zone-end

A console screen should open, with the text: **Starting Truck number 1**.

### 1. Confirm the device app connects to Azure IoT Central

1. If one of the next lines on the console is **Device successfully connected to Azure IoT Central** you've made the connection. If you do not get this message, it usually means either the IoT Central app isn't running, or the connection key strings aren't correct.

1. The "connected" line should be followed by some text verifying the settings and properties were sent successfully.

    [![Screenshot showing the connection to IoT Central from the device app was made correctly](../media/refrigerated-trucks-connected.png)](../media/refrigerated-trucks-connected.png#lightbox)

If all goes well, go straight into the second test.

### 2. Confirm the telemetry functions send data on the specified interval

1. A console message should appear every five seconds, with the contents temperature.

1. Watch the telemetry for a short while, and mentally prepare for the main test of this module!

### 3. Confirm the data is picked up correctly by IoT Central

1. To verify the data is being received at IoT Central, make sure your IoT Central pp is open, and the device selected. If not, select the **Devices** entry in the left-hand menu. Double-click the real device (**RefrigeratedTruck - 1**), in the list of devices.

1. Locate the **Contents temperature** tile, and verify approximately that the temperatures being sent by the device app, in the console window, match the data being shown in the telemetry view of the IoT Central app.

    | IoT Central | Device app |
    | --- | --- |
    | [![Screenshot showing the chart view in IoT Central, receiving the truck temperatures](../media/refrigerated-trucks-central.png)](../media/refrigerated-trucks-central.png#lightbox) | [![Screenshot showing the console output from the device app, showing the truck contents temperatures](../media/refrigerated-trucks-console.png)](../media/refrigerated-trucks-console.png#lightbox) |

    > [!NOTE]
    > The screenshots in this module are taken from the C# version of the app. The Node.js app screens will be similar, but not identical.

1. Check the state tiles: **Truck state**, **Cooling system state**, and **Contents state** in the IoT Central app, to verify the truck and its contents are in the expected state.

1. Check the **Location** map view for the device. A blue circle near Seattle, USA shows our truck ready to go. You may have to zoom out a bit.

    [![Screenshot showing the map view of the truck at its base in Seattle](../media/refrigerated-trucks-seattle.png)](../media/refrigerated-trucks-seattle.png#lightbox)

If all is well, this is great progress. The truck is at its base, in the correct state, and waiting for a command.

## Next steps

Before you move on to the next steps of the testing, there's a short knowledge check to help establish what you've learned in the past few units.
