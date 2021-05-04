Now that you have built the base terrain for your Wind Farm experience, placed your turbine assets, and connected your Digital Twin to ADT, build the project and deploy it to the HoloLens 2.  After you have deployed and tested, return to build out more functionality into your Mixed Reality experience.

[Building your application to your HoloLens 2 -  Mixed Reality](https://docs.microsoft.com/windows/mixed-reality/develop/unity/tutorials/mr-learning-base-02?tabs=winxr#building-your-application-to-your-hololens-2)

When adjusting your build settings, be sure to **Add Open Scenes** if your Scene does not appear in the **Scenes in Build**.  Then be sure to select the Scene of interest before adjusting settings.  Select Universal Windows Platform as the target Platform. 

:::image type="content" source="" alt-text="":::

Once your app has been deployed, you can put on your HoloLens 2 and begin testing the experience.  The Start menu on HoloLens is where you'll open apps, see important status info, and access tools like the camera.  To open your app from the Start menu, simply select an app tile. You can also say the name of the app to open it.  

## Begin the wind farm device simulation

1.	If closed, start the Visual Studio IDE and open **DeviceSimulator.sln**, which can be found in the functions folder and contains the **DeviceSimulator** solution. 
2.	Run the DeviceSimulator by pressing the **Play** button or **F5**
3.	A Command window will open displaying Turbine IDs and messages indicating connectivity and device retrieval / creation
4.	Press any key to begin the simulation.  Be aware that this simulation generates a significant amount of data, simulating real world operations and Azure consumption will occur.

## Observe overview of Wind Farm performance

1.	Summon the Site overview menu.  When running the build on the device, look at either of your hands with a flat palm facing upwards. This will show a floating UI panel with a button to show the Site Overview Panel. Click the button.  The Site overview panel will float and follow you as you walk around the map. 

:::image type="content" source="" alt-text="":::

2.	Centre on a turbine.  Use near or far interactions to select a turbine from the list. Click with the pointer or finger to centre the map on the turbine location.
3.	Zoom in on the map.  Use **near** or **far** interactions to interact with the handle of the slider at the base of the map. Moving the slider to the left or right will change the current zoom level of the map

## Navigate to individual turbines and view details in Mixed Reality

1.	Select a turbine model on the Map
2.	Use the hand pointer to aim at a turbine model on the 3D Map. 
3.	Use a click gesture to select the turbine and display its information panel. The information panel can also be displayed.

:::image type="content" source="" alt-text="":::

## Stop the DeviceSimulator

1.	This is important to ensure you avoid unnecessary charges to your Azure account
2.	Press **Ctrl-C** in the Command Window or the **Stop** button in the Visual Studio IDE

## Exit the app

1.	To exit an app that uses an immersive view, use the **Start gesture** to bring up the **Start** menu, then select the Mixed reality Home button. 
2.	Once you have exited the app, close the app window using the close icon in the top right of the window.

After you are done testing your wind farm experience, uninstall the app:

## Uninstall from the Start menu
1.	On the **Start** menu or in the **All apps** list, browse to the app. Select and hold until the menu appears, then select **Uninstall**.

## Uninstall from Settings
1.	On the **Start** menu, select **Settings -> Apps**. Find the app from the list, select it and then click **Uninstall**.