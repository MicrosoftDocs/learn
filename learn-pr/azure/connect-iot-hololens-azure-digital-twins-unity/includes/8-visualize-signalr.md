> [!IMPORTANT]
> Be aware that this simulation generates a significant amount of data that simulates real world operations. Azure consumption occurs. Remember to stop the simulator whenever it isn't needed to avoid unnecessary charges on your Azure account.

Use the Visual Studio **s** solution to simulate an operating wind farm. Send telemetry data to Azure Digital Twins, where your newly configured digital twin in Unity receives input and displays wind farm operating conditions.

## Begin the wind farm device simulation

1. In Visual Studio, open *DeviceSimulator.sln*.
1. Run the device simulator by selecting the **Play** button or **F5**.
1. A console window opens that displays turbine IDs and messages indicating connectivity and device retrieval and creation.

   :::image type="content" source="../media/device-simulator.png" alt-text="Screenshot of the command window open and running the device simulator solution with turbine IDs and connectivity messages displayed.":::

1. Press any key to begin the simulation. If configured properly and connected to the correct Azure services, there are a series of streaming console messages *Message Received*, which indicate that the Azure Digital Twins service has acknowledged the receipt of the simulated IoT data.

   :::image type="content" source="../media/device-simulator-2.png" alt-text="Screenshot of the command window open and running the device simulator solution with console messages displayed from the simulated IoT data.":::

## Launch the digital twin in Unity editor

1. Select the **Play** button in the Unity editor. The editor switches to the **Game** tab automatically and begins rendering your scene. The data in the UI panels reflect the data being generated from the `DeviceSimulator` application running.

   :::image type="content" source="../media/simulated-turbine-telemetry.png" alt-text="Screenshot of the Unity editor in play mode with the device simulator running." lightbox="../media/simulated-turbine-telemetry.png":::

1. Navigate in the **Game** tab by pressing and holding your right mouse button while you navigate. Move the scene so that the white circle hovers over a turbine or a turbine name in the **Site Overview Menu** panel, you see the **Turbine Panel** with specifics for that Turbine asset.

   :::image type="content" source="../media/device-simulator-3.png" alt-text="Screenshot of the command window open and running the device simulator solution with updated console messages are displayed from the simulated IoT data.":::

1. Observe what happens to the data displayed in the **Site Overview Menu** and **Turbine Panel** in your Unity **Game** view.

   :::image type="content" source="../media/simulated-turbine-event.png" alt-text="Screenshot of the Unity editor in play mode with the device simulator running and updated turbine data.":::

1. Observe wind turbine performance data by selecting the scriptable object of interest. Select **Assets** > **ScriptableObjects** > **Turbine Site Data** > **T103**. Examine the incoming data in the **Wind Turbine Data** section of the **Inspector** panel. You should see the **Time Interval**, **Wind Speed**, **Ambient Temperature**, **Rotor Speed**, and **Power** fluctuate as new telemetry messages are consumed by the application.

   :::image type="content" source="../media/wind-turbine-so.png" alt-text="Screenshot of the Unity Inspector with a turbine prefab selected.":::

## Stop the DeviceSimulator

Stopping the simulator is important to ensure you avoid unnecessary charges to your Azure account. Press **Ctrl**+**C** in the command prompt window or select **Stop** in Visual Studio.
