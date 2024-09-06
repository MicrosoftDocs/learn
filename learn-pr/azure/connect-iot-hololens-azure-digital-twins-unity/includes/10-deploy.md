Now that you have built the base terrain for your wind farm experience, placed your turbine assets, and connected your digital twin to Azure Digital Twins, it's time to see what you have created! You can build the project for HoloLens 2 and Windows Mixed Reality VR, or experience it directly from the Unity editor.

If you have a Windows Mixed Reality VR device set up with your PC, pressing the play button in the Unity editor launches the application to your headset. If you don't have a HoloLens 2 or mixed-reality device, pressing play in the Unity editor lets you interact with your application by using the Mixed Reality Toolkit (MRTK) interaction simulator. This module showcases how to deploy your application for HoloLens 2. After you've checked out your application, return to build out more functionality into your mixed-reality experience.

> [!IMPORTANT]
> When adjusting your build settings, be sure to **Add Open Scenes** if your scene doesn't appear in the **Scenes in Build**. Select the scene of interest before adjusting settings. Select Universal Windows Platform as the target platform.

:::image type="content" source="../media/build-settings.png" alt-text="Screenshot of the Unity build settings window open with main scene and universal windows platform options highlighted.":::

After your app has been deployed, you can put on your HoloLens 2 and begin testing the experience. The **Start** menu on HoloLens is where you open apps, see important status information, and access tools like the camera. To open your app from the **Start** menu, select an app tile. You can also say the name of the app to open it.

## Begin the wind farm device simulation

1. If closed, start Visual Studio and open *DeviceSimulator.sln*, which can be found in the functions folder and contains the **DeviceSimulator** solution.
1. Run the device simulator by selecting the **Play** button or **F5**.
1. A command window opens that displays Turbine IDs and messages indicating connectivity and device retrieval and creation.
1. Press any key to begin the simulation. This simulation generates a significant amount of data that simulates real world operations. The default is every five seconds. Azure consumption occurs.

## Observe overview of wind farm performance

1. Put on your HoloLens 2 device.
1. Launch your app.
1. Access the **Site overview** menu. When running the build on the HoloLens 2 device, look at either of your hands with a flat palm facing upwards. This action shows a floating UI panel with a button to show the **Site overview** panel. Select the button. The **Site overview** panel floats and follows you as you navigate around the map.

   :::image type="content" source="../media/site-overview.png" alt-text="Screenshot of the site overview menu on HoloLens 2 displaying turbine data.":::

1. Center on a turbine. Use **near** or **far** interactions to select a turbine from the list. Select with the pointer or finger to center the map on the turbine location.
1. Zoom in on the map. Use **near** or **far** interactions to interact with the handle of the slider at the base of the map. Moving the slider changes the current zoom level of the map.

## Navigate to turbines and view details

To navigate to individual turbines and view details in mixed reality:

1. Use the hand pointer to aim at a digital twin turbine model on the map.
1. Use a **click** gesture to select the turbine and display its information panel. You can also display the information panel by selecting the associated button in the **Site Overview** panel.

   :::image type="content" source="../media/turbine-ui.png" alt-text="Screenshot of a single information panel displaying turbine data on HoloLens 2.":::

## Stop the DeviceSimulator

1. Stopping the simulator is important to ensure you avoid unnecessary charges to your Azure account.
1. Press **Ctrl**+**C** in the command window or select **Stop** in Visual Studio.

   > [!IMPORTANT]
   > Be aware that this simulation generates a significant amount of data simulating real world operations and Azure consumption occurs. Remember to stop the simulator whenever it is not needed to avoid unnecessary charges on your Azure account.

## Exit the app

1. To exit an app that uses an immersive view, use the **Start gesture** to bring up the **Start menu**, then select the mixed-reality **Home** button.
1. After you exit the app, close the app window using the close icon in the top right of the window.
1. Remove your HoloLens 2 device.
