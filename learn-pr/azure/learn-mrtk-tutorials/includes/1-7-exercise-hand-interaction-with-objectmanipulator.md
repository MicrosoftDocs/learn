The ObjectManipulator script supports the "direct manipulation" input model--when the script is attached to an object, the user can move, scale or rotate the object with their hands. In this exercise, you'll create a cube and then attach the ObjectManipulator script to it.

## Add a cube to the scene

1. In the menu bar, select **GameObject** > **3D Object** > **Cube**.

    :::image type="content" source="../media/027-add-cube.png" alt-text="Screenshot of menu commands for adding the cube.":::

To optimize the cube's size and position for our project, we'll need to make a few changes. 

## Change the cube's size

The cube's default size is one square meter--this is too big for our purposes. We'll scale the size down to 20x20x20 cm.

1. Select the cube, and then in the **Inspector**, change the cube's **Tranform/Scale** values to the following:
   
   X = 0.2, Y = 0.2, Z = 0.2
   
## Change the cube's position

The cube was placed in the scene at the default position of (0,0,0). This means the cube is at the same position as your headset, and the user won't be able to see it until they move backwards. We'll move the cube 50 cm forward on the Z axis and 10 cm down on the Y axis for more comfortable interaction.

1. In the **Inspector**, change the cube's **Tranform/Position** values to the following:
   
   X = -0.2, Y = -0.1, Z = 0.5

    :::image type="content" source="../media/028-cube-transform-values.png" alt-text="Screenshot of the cube's transform component after updates.":::

## Change the cube's rotation

We want to be able to see three sides of the cube, so we'll change the rotation, too. 

1. 1. In the **Inspector**, change the cube's **Tranform/Rotation** values to the following:
   
   X = 9, Y = 14, Z = 0

   > [!TIP]
   > To zoom in on the cube, select it, make sure cursor is hovering over the **Scene** window, and then press the F key. You can zoom in on any object this way.

## ________________

In order for an object to be "grabbable" with tracked hands, it must have three components attached: 

    * A Collider component (Unity's cube already has a Box Collider by default)
    * Object Manipulator (Script) component
    * NearInteractionGrabbable (Script) component

    MRTK's **ObjectManipulator** script makes an object movable, scalable, and rotatable using one or two hands. This script supports the direct manipulation input model as the Adding hand interaction to an object script enables the user to touch holograms directly with their hands.

1. With the cube still selected, in the **Inspector** window, click the **Add Component** button, and then search for and select the **Object Manipulator** script.

    :::image type="content" source="../media/029-select-object-manipulator.png" alt-text="Screenshot of adding the Object Manipulator script.":::

1. Repeat the same steps to add the **Near Interaction Grabbable script** to the cube.

    > [!NOTE]
    > When you add the Object Manipulator script, the Constraint Manager script is automatically added as well because the Object Manipulator script depends on it.

    :::image type="content" source="../media/030-constraint-manager.png" alt-text="Screenshot of the Constraint Manager script added to the cube.":::

## Duplicating the cube

1. In the **Hierarchy**, select the cube, and then select **Duplicate**. The duplicated cube appears with the name "Cube (1)."
1. Right-click the original cube, select **Rename**, and then name the cube "Near Cube."
1. Right-click the duplicated cube, select **Rename**, and then name the cube "Far Cube."

Let's change Far Cube's position and rotation.

1. With Far Cube still selected, change its values in its **Transform** component to the following:

    Position: X = 0.6, Y = 0.1, Z = 1.1
    Rotation: X = 27, Y = 0, Z = 0

## Grab and move the cubes in Play mode

1. Click the Play button. When the project starts playing, the view switches to the **Game** window.

    :::image type="content" source="../media/031-game-window.png" alt-text="Screenshot of the Game window after entering Play mode.":::

1. Click the three-dot button above the upper-right corner of the **Game** window and then select **Maximize**.

    :::image type="content" source="../media/032-maximize-command.png" alt-text="Screenshot of Maximize command for the Game window.":::

1. Press the space bar to make the simulated right hand appear in the view.

    :::image type="content" source="../media/032-maximize-command.png" alt-text="Screenshot of Maximize command for the Game window.":::

1. Move the simulated hand closer to the cube until it touches the cube on the side or bottom.

    :::image type="content" source="../media/033-touch-cube.png" alt-text="Screenshot of Maximize command for the Game window.":::

1. Click the left mouse button (this makes the hand "grab" the cube) and then drag the cube around the scene.

    :::image type="content" source="../media/move-cube.gif" alt-text="Screenshot of Move the cube." lightbox="../media/move-cube.gif":::

To grab and move "Far Cube," we'll use the far pointer attached to the simulated hand.

1. If you need to, press the space bar again to make the simulated right hand appear. Note the far pointer that extends from the end of hand's index finger.

    :::image type="content" source="../media/034-far-pointer.gif" alt-text="Screenshot of simulated hand's far pointer.":::

1. Move the hand closer to the Far Cube until you can see the tip of the pointer on the cube. You may have to move the hand around in a circular motion a few times to make the tip of the pointer appear.

    :::image type="content" source="../media/035-far-pointer-touches-cube.gif" alt-text="Screenshot of the far pointer touching the cube.":::

1. Click the left mouse button (this makes the hand close into a "grabbing" position) and then drag the cube around the scene.

## Unity in-editor input simulation

The Unity in-editor input simulation allows you to test holographic object behavior when using hand or eye interaction.

**To move around in the scene:**

* Use **W/A/S/D** keys to move the camera forward/left/back/right.
* Use **Q/E** to move the camera vertically.
* Press and hold the **right mouse button** to rotate the camera.

**To simulate hand input:**

* Press and hold the **space bar** to enable the right hand.
* While holding the space bar, move your mouse to move the hand.
* Use the **mouse scroll wheel** to adjust the depth of the hand.
* Click the **left mouse button** to simulate the pinch gesture.
* Use **T/Y** keys to make the hand persistent in the view.
* Hold the **CTRL** key and move the mouse to rotate the hand.
* Press and hold the **left shift key** to enable the left hand.

## Build your application in Unity

1. In the menu bar, select **File** > **Build Settings...**.
1. In the **Build Settings** window, click the **Add Open Scenes** button to add your current scene to the **Scenes In Build** list.
1. Click the **Build** button.
1. In the **Build Universal Windows Platform** window, navigate to the folder where you want to store your build, or create a new folder and navigate to it, and then click the **Select Folder** button to start the build process.

    :::image type="content" source="../media/select-build-folder.png" alt-text="Screenshot of Select a Build folder." lightbox="../media/select-build-folder.png":::

    A progress bar appears to let you know how the build is proceeding.

## (Optional) Build and deploy the application

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. Devices can be purchased at [HoloLens.com](http://hololens.com/).

1. When the build process has completed, Windows File Explorer opens and displays the build folder. Navigate inside the folder and then double-click the solution file to open it in Visual Studio:

    :::image type="content" source="../media/036-builds-folder.png" alt-text="Screenshot of File Explorer with the builds folder displayed." :::

1. Configure Visual Studio for HoloLens by selecting the **Master** or **Release** configuration, the **ARM64** architecture, and **Device** as target:

    :::image type="content" source="../media/037-visual-studio-build-options.png" alt-text="Screenshot of Visual Studio window with the build options for the project.":::

    > [!TIP]
    > If you're deploying to HoloLens (1st generation), select the **x86** architecture.
    
    > [!NOTE]
    > For HoloLens, you'll typically build for the ARM architecture. However, there's a [known issue](https://github.com/microsoft/MixedRealityToolkit-Unity) in Unity 2019.3 that causes errors when selecting ARM as the build architecture in Visual Studio. As a workaround, we recommend that you build for ARM64. If that isn't an option, in Unity, go to **Edit** > **Project Settings** > **Player** > **Other Settings** and disable **Graphics Jobs**.
    
    > [!NOTE]
    > If you don't see "Device" as a target option in Visual Studio, you may need to change the startup project for the solution from the IL2CPP project to the UWP project. To do this, in the **Solution Explorer**, right-click [**your project name**]**(Universal Windows)** and then select **Set as StartUp Project**.

    > [!IMPORTANT]
    > Before building to your device, the device must be in Developer Mode and paired with your development computer. Both of these steps can be completed by following [these instructions](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-visual-studio).

1. Connect your HoloLens to your computer, and then in Visual Studio, do one of the following:
   - To automatically start the app on your device without the Visual Studio debugger attached, select **Debug** > **Start Without Debugging**.
   - To deploy to your device without having the app start automatically, select **Build** > **Deploy Solution**.

    :::image type="content" source="../media/038-start-without-debugging.png" alt-text="Screenshot of Visual Studio with the Start Without Debugging menu item displayed.":::

    > [!TIP]
    > You can also deploy to the [HoloLens Emulator](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-the-hololens-emulator) or create an [App Package](/windows/uwp/packaging/packaging-uwp-apps) for sideloading.

    > [!NOTE]
    > You may notice the Diagnostics profiler in the app. You can toggle it on or off by using the speech command **"Toggle Diagnostics"**. We recommend that you keep the profiler visible most of the time during development to understand when changes to the app might impact performance. For example, HoloLens apps should [continuously run at 60 FPS](/windows/mixed-reality/develop/platform-capabilities-and-apis/understanding-performance-for-mixed-reality).
