The ObjectManipulator script supports the "direct manipulation" modality of the "hands and motion controllers" input model. When the script is attached to an object, the user can move, scale or rotate the object with their hands. In this exercise, you'll create two cubes, attach the necessary scripts to them, and then move the cubes around.

## Add and adjust the first cube

1. In the menu bar, select **GameObject** > **3D Object** > **Cube**.

    :::image type="content" source="../media/027-add-cube.png" alt-text="Screenshot of menu commands for adding the cube.":::

    The cube's default size is one square meter--this is too large for our purposes. We'll scale the size down to 20x20x20 cm.

1. Select the cube, and then in the **Inspector**, change the cube's **Tranform/Scale** values to the following:
   
   X = 0.2, Y = 0.2, Z = 0.2
   
    The cube was placed in the scene at the default position of (0,0,0). This means the cube is at the same position as the user's headset, and the user won't be able to see the cube until they move backwards. We'll change the cube's position values so it'll be in a better location for viewing.

1. In the **Inspector**, change the cube's **Tranform/Position** values to the following:
   
   X = -0.2, Y = 1.6, Z = 0.5

    :::image type="content" source="../media/028-cube-transform.png" alt-text="Screenshot of the cube's transform component after updates.":::

    We want to be able to see three sides of the cube, so we'll change the cube's rotation, too. 

1. In the **Inspector**, change the cube's **Tranform/Rotation** values to the following:
   
   X = 9, Y = 14, Z = 0

   > [!TIP]
   > To zoom in on the cube, select it, make sure cursor is hovering over the **Scene** window, and then press the F key. You can zoom in on any object this way.

## Add the scripts to the cube

In order for an object to be "grabbable" with tracked hands, it must have three components attached: 

- A Collider component (You don't need to do anything here--Unity's cube already has a Box Collider attached by default)
- Object Manipulator (Script) component

1. With the cube still selected, in the **Inspector** window, click the **Add Component** button, and then search for and select the **Object Manipulator** script.

    :::image type="content" source="../media/029-select-object-manipulator.png" alt-text="Screenshot of adding the Object Manipulator script.":::

    The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. When you add the Object Manipulator script, the Constraint Manager script is automatically added as well because the Object Manipulator script depends on it.

    :::image type="content" source="../media/030-constraint-manager.png" alt-text="Screenshot of the Constraint Manager script added to the cube.":::

## Update the cube's material

For performance purposes, it is recommended to use MRTK materials instead of the default Unity materials. 

1. With the cube still selected, find the "Materials" section on the Mesh Renderer component.
1. Replace the default material with the **MRTK_Standard_White** material, located under **MRTK Standard Assets** > **Materials**.

## Add a second cube

1. In the **Hierarchy**, right-click the cube, and then select **Duplicate**. The duplicated cube appears with the name "Cube (1)."
1. Right-click the original cube, select **Rename**, and then name the cube "Near Cube."
1. Right-click the duplicated cube, select **Rename**, and then name the cube "Far Cube."

    At the moment, it looks like there's only one cube in the **Scene** view. That's because Near Cube and Far Cube are in the same exact place. Let's change Far Cube's position and rotation.

1. With Far Cube still selected, change its values in its **Transform** component to the following:

    Position: X = 0.6, Y = 1.6, Z = 1.1

    Rotation: X = 27, Y = 0, Z = 0

    Now the camera should see Near cube on the left and Far Cube a little further away on the right. To confirm this, in the **Hierarchy**, select **Main Camera** (under **MRTK XR Rig** > **Camera Offset**) and then look at the **Main Camera** window in the **Scene** window.

    :::image type="content" source="../media/040-main-camera-view.png" alt-text="Screenshot of the Main Camera view in the Scene window.":::

    > [!TIP]
    > If you want the view in the **Scene** window to look more like what the camera sees, scroll around in the **Scene** window. You might have to set the Clear Flags of the camera to Skybox if it is not by default.


## Grab and move the cubes in Play mode

1. Click the Play button. When the project starts playing, the view switches to the **Game** window.

    :::image type="content" source="../media/031-game-window.png" alt-text="Screenshot of the Game window after entering Play mode.":::

    > [!NOTE]
    >  Before Playing, confirm that there is a valid Profile set under **Project Settings** > **MRTK3**.

1. Click the three-dot button above the upper-right corner of the **Game** window and then select **Maximize**.

    :::image type="content" source="../media/032-maximize-command.png" alt-text="Screenshot of Maximize command for the Game window.":::

1. Press the space bar to make the simulated right hand appear in the view.
1. Move the simulated hand closer to Near Cube until it touches the cube on the side or bottom.

    :::image type="content" source="../media/033-touch-cube.png" alt-text="Screenshot of the simulated right hand touching the Near Cube.":::

1. Click the left mouse button (this makes the hand "grab" the cube) and then drag the cube around the scene.

    :::image type="content" source="../media/move-cube.gif" alt-text="Screenshot of Move the cube." lightbox="../media/move-cube.gif":::

    To grab and move Far Cube, we'll use the far pointer attached to the simulated hand.

1. If you need to, press the space bar again to make the simulated right hand appear. Note the far pointer that extends from the end of the hand's index finger.

    :::image type="content" source="../media/034-far-pointer.png" alt-text="Screenshot of simulated hand's far pointer.":::

1. Move the hand closer to Far Cube until you can see the tip of the pointer on the cube. You may have to move the hand around in a circular motion a few times to make the tip of the pointer appear on the cube.

    :::image type="content" source="../media/035-far-pointer-touches-cube.png" alt-text="Screenshot of the far pointer touching the cube.":::

1. Click the left mouse button (this makes the hand close, taking on what we call the "pinch gesture") and then drag the cube around the scene.

## Unity in-editor input simulation

You can test holographic object behavior with the Unity in-editor input simulation features.

**Change the view in the scene:**

* To move the camera forward/left/back/right, press the W/A/S/D keys.
* To move the camera vertically, press the Q and E keys.
* To rotate the camera, press the right mouse button and then drag.

**Simulate hand input:**

* To enable the simulated right hand, press and hold the space bar. To remove the hand, release the space bar.
* To enable the left simulated hand, press and hold the left shift key. To remove the hand, release the key.
* To move either hand around the scene, move the mouse.
* To move the hand forward or backward, rotate the mouse scroll wheel.
* To simulate the pinch gesture, click the left mouse button.
* To rotate the hand, press and hold down the space bar + CTRL key (right hand) or left shift key + CTRL key (left hand) and then move the mouse.

**Persistent hands**

* To enable a hand and keep it onscreen without continuing to hold down a key, press T (left hand) or Y (right hand). To remove the hands, press those keys again.
 
## Build your application in Unity

1. In the menu bar, select **File** > **Build Settings...**.
1. In the **Build Settings** window, click the **Add Open Scenes** button to add your current scene to the **Scenes In Build** list.
1. Click the **Build** button.
1. In the **Build Universal Windows Platform** window, navigate to the folder where you want to store your build, or create a new folder and navigate to it, and then click the **Select Folder** button to start the build process.

    :::image type="content" source="../media/044-build-project.png" alt-text="Screenshot of the location to save your build.":::

    A progress bar appears to let you know how the build is proceeding.

## (Optional) Build and deploy the application

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. Devices can be purchased at [HoloLens.com](http://hololens.com/).

1. When the build process has completed, Windows File Explorer opens and displays the build folder. Navigate inside the folder and then double-click the solution file to open it in Visual Studio:

    :::image type="content" source="../media/036-builds-folder.png" alt-text="Screenshot of File Explorer with the builds folder displayed." :::

1. Configure Visual Studio for HoloLens by selecting the **Master** or **Release** configuration and the **ARM64** architecture:

    :::image type="content" source="../media/037-visual-studio-build-options.png" alt-text="Screenshot of Visual Studio window with the build options for the project.":::

    > [!TIP]
    > If you're deploying to HoloLens (1st generation), select the **x86** architecture.
    
    > [!NOTE]
    > If you don't see "Device" as a target option in Visual Studio, you may need to change the startup project for the solution from the IL2CPP project to the UWP project. To do this, in the **Solution Explorer**, right-click [**your project name**]**(Universal Windows)** and then select **Set as StartUp Project**.

    > [!IMPORTANT]
    > Before building to your device, the device must be in Developer Mode and paired with your development computer. See the section named "Enabling Developer Mode" on [this page](/windows/mixed-reality/develop/advanced-concepts/using-visual-studio).

1. Click the deployment target drop-down and then do one of the following:

   - If you're building and deploying via Wi-Fi, select **Remote Machine**.

    :::image type="content" source="../media/041-target-remote-machine.png" alt-text="Screenshot of Visual Studio window with Remote Machine as the target.":::

   - If you're building and deploying via USB, select **Device**.

    :::image type="content" source="../media/042-target-device.png" alt-text="Screenshot of Visual Studio window with Device as the target.":::

1. Set your remote connection: on the menu bar, select **Project > Properties**.
1. In the project's **Property Pages** window, select **Configuration Properties > Debugging**.
1. Click the **Debugger to launch** drop down and then select **Remote Machine** if it's not selected already.

    > [!IMPORTANT]
    > We recommend that you manually enter your IP address rather than depend on the "Auto Detected" feature. To find your IP address, on your HoloLens, go to **Settings > Updates & Security > For developers**. The IP address is listed towards the bottom of the window under **Ethernet**.

1. In the **Machine Name** field, enter the IP address of your device.

    ![Remote connection dialog in Visual Studio](../media/043-vs-machine-name.png)

1. Set the **Authentication Mode** to **Universal (Unencrypted protocol)**.
1. Connect your HoloLens to your computer, and then in Visual Studio, do one of the following:
   - To deploy to your HoloLens and automatically start the app without the Visual Studio debugger attached, select **Debug** > **Start Without Debugging**.
   - To deploy to your HoloLens without having the app start automatically, select **Build** > **Deploy Solution**.

    :::image type="content" source="../media/038-start-without-debugging.png" alt-text="Screenshot of Visual Studio with the Start Without Debugging menu item displayed.":::

## Pairing your device

The first time you deploy an app to your HoloLens from your PC, you'll be prompted for a PIN. To create a PIN:

1. In your HoloLens, go to **Settings > Updates & Security > For developers**.
1. Select **Pair.** This displays the PIN in the HoloLens.
1. Enter the PIN in the dialog in Visual Studio. 
1. After pairing is complete, in the HoloLens, select **Done**. 
   
Your PC is now paired with your HoloLens and you can deploy apps automatically. Repeat these steps for every PC that's used to deploy apps to your HoloLens.

## Running your app on your HoloLens

1. After your app finishes building, in the HoloLens **Start** menu, find the app tile for your app, and then select it.
1. After the app starts, reach out to the Near Cube, and then grab it and drag it around.
1. Use the far pointer to grab the Far Cube, and then drag it around.

    > [!TIP]
    > The HoloLens gives you more flexibility than when you were testing your app in Unity. You can physically move around and use the far pointer on the Near Cube or reach out and grab the Far Cube with your hand!

## Tips

- You can also deploy to the [HoloLens Emulator](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-the-hololens-emulator) or create an [App Package](/windows/uwp/packaging/packaging-uwp-apps) for sideloading.

- You may notice the Diagnostics profiler in the app. You can toggle it on or off by using the speech command **"Toggle Diagnostics"**. We recommend that you keep the profiler visible most of the time during development so you can understand how changes to the app might affect performance. For example, you can monitor your app to ensure that [the frame rate is at least 60 FPS](/windows/mixed-reality/develop/platform-capabilities-and-apis/understanding-performance-for-mixed-reality).
