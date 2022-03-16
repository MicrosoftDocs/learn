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
   
   X = 0, Y = -0.1, Z = 0.5

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

* In the Unity toolbar, click the **Play** icon to enter play mode.
    Using the Unity in-editor input simulation, press the space bar on your keyboard to simulate hand input with the right hand.
    :::image type="content" source="../media/move-cube.gif" alt-text="Screenshot of Move the cube." lightbox="../media/move-cube.gif":::

## Build your application to HoloLens 2

## 1. Build the Unity project

1. In the Unity menu, select **File** > **Build Settings...** to open the Build Settings window.

    In the **Build Settings** window, click the Add Open Scenes button to add your current scene to the **Scenes In Build** list, then click the **Build** button to open the Build Universal Windows Platform window:

   :::image type="content" source="../media/add-scenes.png" alt-text="Screenshot of Adding Scenes in build." lightbox="../media/add-scenes.png":::

2. In the Build Universal Windows Platform window, choose a suitable location to store your build, for example, *D:\MixedRealityLearning\Builds*, create a new folder and give it a suitable name, for example, GettingStarted, and then click the **Select Folder** button to start the build process:

    :::image type="content" source="../media/select-build-folder.png" alt-text="Screenshot of Select a Build folder." lightbox="../media/select-build-folder.png":::

3. Wait for Unity to finish the build process:

    :::image type="content" source="../media/build-process.png" alt-text="Screenshot of Wait for the build process to finish." lightbox="../media/build-process.png":::

## 2. (Optional) Build and deploy the application

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. Devices can be purchased at [HoloLens.com](http://hololens.com/).

1. When the build process has completed, Unity will prompt Windows File Explorer to open the location you stored the build. Navigate inside the folder, and double-click the solution file to open it in Visual Studio:

    :::image type="content" source="../media/file-explorer.png" alt-text="Screenshot of File Explorer." lightbox="../media/file-explorer.png":::

2. Configure Visual Studio for HoloLens by selecting the **Master** or **Release** configuration, the **ARM64** architecture, and **Device** as target:

    :::image type="content" source="../media/visual-studio-window-select-release.png" alt-text="Screenshot of Visual Studio window 1." lightbox="../media/visual-studio-window-select-release.png":::

    > [!TIP]
    > If you're deploying to HoloLens (1st generation), select the **x86** architecture.
    
    > [!NOTE]
    > For HoloLens, you'll typically build for the ARM architecture. However, there's a [known issue](https://github.com/microsoft/MixedRealityToolkit-Unity) in Unity 2019.3 that causes errors when selecting ARM as the build architecture in Visual Studio. The recommended workaround is to build for ARM64. If that isn't an option, go to **Edit** > **Project Settings** > **Player** > **Other Settings** and disable **Graphics Jobs**.
    
    > [!NOTE]
    > If you don't see Device as a target option, you may need to change the startup project for the Visual Studio solution from the IL2CPP project to the UWP project. To do this, in the Solution Explorer, right-click on YourProjectName (Universal Windows) and select **Set as StartUp Project**.

3. Connect your HoloLens to your computer, then select **Debug** >

    :::image type="content" source="../media/visual-studio-window-2-debug.png" alt-text="Screenshot of Visual Studio Window 2." lightbox="../media/visual-studio-window-2-debug.png":::

    > [!IMPORTANT]
    > Before building to your device, the device must be in Developer Mode and paired with your development computer. Both of these steps can be completed by following [these instructions](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-visual-studio).
    
    > [!TIP]
    > You can also deploy to the [HoloLens Emulator](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-the-hololens-emulator) or create an [App Package](/windows/uwp/packaging/packaging-uwp-apps) for sideloading.

4. Using Start Without Debugging automatically starts the app on your device without the Visual Studio debugger attached.

5. Select **Build** > **Deploy Solution** to deploy to your device without having the app start automatically.

    > [!NOTE]
    > You may notice the Diagnostics profiler in the app, which you can toggle on or off by using the speech command **"Toggle Diagnostics"**. It's recommended that you keep the profiler visible most of the time during development to understand when changes to the app may impact performance. For example, HoloLens apps should [continuously run at 60 FPS](/windows/mixed-reality/develop/platform-capabilities-and-apis/understanding-performance-for-mixed-reality).
