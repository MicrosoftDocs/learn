Now that you have built the base terrain for your Wind Farm experience, placed your turbine assets, and connected your Digital Twin to ADT, it's time to see what you have created!  You can build the project for HoloLens 2 and Windows Mixed Reality, or experience it directly from the Unity editor.  If you have a Windows Mixed Reality device set up with your PC, pressing the play button in the Unity editor will launch the applicaiton to your headset.  If you don't have a HoloLens 2 or mixed reality device, pressing play in the Unity editor will let you interact with your application via the MRTK interaction simulator.  For this module, we showcase how to deploy your applicaiton for HoloLens 2.  After you've checked out your application, return to build out more functionality into your Mixed Reality experience.


> [!IMPORTANT]
> When adjusting your build settings, be sure to **Add Open Scenes** if your Scene doesn't appear in the **Scenes in Build**.  Then be sure to select the Scene of interest before adjusting settings.  Select Universal Windows Platform as the target Platform. 

:::image type="content" source="../media/build-settings.png" alt-text="Screenshot of the Unity build settings window open with main scene and universal windows platform options highlighted.":::

Once your app has been deployed, you can put on your HoloLens 2 and begin testing the experience.  The **Start** menu on HoloLens is where you'll open apps, see important status info, and access tools like the camera.  To open your app from the Start menu, simply select an app tile. You can also say the name of the app to open it.  

## Begin the wind farm device simulation

1. If closed, start the Visual Studio IDE and open **DeviceSimulator.sln**, which can be found in the functions folder and contains the **DeviceSimulator** solution. 
2. Run the DeviceSimulator by pressing the **Play** button or **F5**
3. A Command window will open displaying Turbine IDs and messages indicating connectivity and device retrieval / creation
4. Press any key to begin the simulation.  This simulation generates a significant amount of data (every 5 seconds by default_, simulating real world operations.  Azure consumption will occur.

## Observe overview of wind farm performance

1. Put on your HoloLens 2 device.
2. Launch your app.
3. Summon the Site overview menu.  When running the build on the HoloLens 2 device, look at either of your hands with a flat palm facing upwards. This will show a floating UI panel with a button to show the **Site Overview** Panel. Click the button.  The Site overview panel will float and follow you as you navigate around the map. 
 
    :::image type="content" source="../media/site-overview.png" alt-text="Screenshot of the site overview menu on HoloLens 2 displaying turbine data.":::

4. Center on a turbine.  Use **near** or **far** interactions to select a turbine from the list. Click with the pointer or finger to center the map on the turbine location.
5. Zoom in on the map.  Use **near** or **far** interactions to interact with the handle of the slider at the base of the map. Moving the slider to the left or right will change the current zoom level of the map

## Navigate to individual turbines and view details in mixed reality

1. Use the hand pointer to aim at a Digital Twin turbine model on the map. 
2. Use a **click** gesture to select the turbine and display its information panel. The information panel can also be displayed by clicking the associated button in the **Site Overview** panel.

    :::image type="content" source="../media/turbine-ui.png" alt-text="Screenshot of a single information panel displaying turbine data on HoloLens 2.":::

## Stop the DeviceSimulator

1. This is important to ensure you avoid unnecessary charges to your Azure account
2. Press **Ctrl-C** in the Command Window or the **Stop** button in the Visual Studio IDE

    > [!IMPORTANT]
    > Be aware that this simulation generates a significant amount of data simulating real world operations and Azure consumption will occur.  Remember to stop the simulator whenever it is not needed, to avoid unnecessary charges on your Azure account.

## Exit the app

1. To exit an app that uses an immersive view, use the **Start gesture** to bring up the **Start menu**, then select the Mixed Reality **Home** button. 
2. Once you've exited the app, close the app window using the close icon in the top right of the window.
3. Remove your HoloLens 2 device.