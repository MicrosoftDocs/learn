The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. This script supports the direct manipulation input model as the script enables the user to touch holograms directly with their hands. Here you'll create a cube and use ObjectManipulator to enable hand interactions so that you can move, scale, and rotate the cube.

## Add a Cube to the scene

1. In the Unity menu, select **GameObject** > **3D Object** > **Cube** to add a cube object to the scene.

    ![Adding the cube](../media/base-2-section-8-step-1-1.png)

2. Click the **Cube** object in the Hierarchy window, then in the Inspector window configure
its **Transform** component as follows

    * **Position**: X = 0, Y = -0.1, Z = 0.5
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 0.1, Y = 0.1, Z = 0.1

    ![Changing the transform values of the cube](../media/base-2-section-8-step-1-1b.png)

3. Unity unit's 1 meter. We have updated cube's size to 10x10x10 cm, placed at 50cm from the headset position (0,0,0). 10cm below the eye level for comfortable interaction.

4. If you use the default scale (1,1,1), the cube will be too big. If you use the default position (0,0,0), the cube will be placed at the same position as your headset and you won't be able to see it until you move backward.

5. To focus in on the objects in the scene, you can double-click on the **Cube** object, and then zoom slightly in again. Or you can use F key to zoom and focus on the object.

5. To interact and grab an object with tracked hands, the object must have:

    * Collider component such as **Box Collider** (Unity's cube already has a Box Collider by default)
    * **Object Manipulator (Script)** component
    * **NearInteractionGrabbable(Script)** component

    MRTK's **ObjectManipulator** script makes an object movable, scalable, and rotatable
using one or two hands. This script supports the direct manipulation input model as the
Adding hand interaction to an object
script enables the user to touch holograms directly with their hands.

5. With the **Cube** still selected in the Hierarchy window, in the Inspector window ,click on
**Add Component** button, then search and select **Object Manipulator script** to add the
Object Manipulator script to the cube object.

    ![Adding the object manipulator](../media/base-2-section-8-step-1-2.png)

6. Repeat the same to add **Near Interaction Grabbable script** to the cube.

    ![Adding the Near Interaction Grabbable](../media/base-2-section-8-step-1-3.png)

    > [!NOTE]
    > When you add a Object Manipulator (Script), in this case, the Constraint Manager (Script) is automatically added because Object Manipulator (Script) depends on it.

## Move the Cube in play mode

* In the Unity toolbar, click the **Play** icon to enter play mode.
Using the Unity in-editor input simulation, press the space bar on your keyboard to simulate hand input with the right hand.
    ![Move the cube](../media/base-2-section-8-step-1-4.gif)

## Build your application to HoloLens 2

## 1. Build the Unity project

1. In the Unity menu, select **File** > **Build Settings...** to open the Build Settings window.

     In the **Build Settings** window, click the Add Open Scenes button to add your current scene to the **Scenes In Build** list, then click the **Build** button to open the Build Universal Windows Platform window:

    ![Adding Scenes in build](../media/base-2-section-9-step-1-1.png)

2. In the Build Universal Windows Platform window, choose a suitable location to store your build, for example, *D:\MixedRealityLearning\Builds*, create a new folder and give it a suitable name, for example, GettingStarted, and then click the **Select Folder** button to start the build process:

    ![Select a Build folder](../media/base-2-section-9-step-1-2.png)

3. Wait for Unity to finish the build process:

    ![Wait for the build process to finish](../media/base-02-section9-step1-3.png)

## 2. Build and deploy the application

1. When the build process has completed, Unity will prompt Windows File Explorer to open the location you stored the build. Navigate inside the folder, and double-click the solution file to open it in Visual Studio:

    ![File Explorer](../media/base-2-section-10-step-1-1.png)

2. Configure Visual Studio for HoloLens by selecting the **Master** or **Release** configuration, the **ARM64** architecture, and **Device** as target:

    ![Visual Studio window 1](../media/base-2-section-10-step-1-2.png)

    > [!TIP]
    > If you're deploying to HoloLens (1st generation), select the **x86** architecture.

    > [!NOTE]
    > For HoloLens, you'll typically build for the ARM architecture. However, there's a [known issue](https://github.com/microsoft/MixedRealityToolkit-Unity) in Unity 2019.3 that causes errors when selecting ARM as the build architecture in Visual Studio. The recommended workaround is to build for ARM64. If that isn't an option, go to **Edit** > **Project Settings** > **Player** > **Other Settings** and disable **Graphics Jobs**.

    > [!NOTE]
    > If you don't see Device as a target option, you may need to change the startup project for the Visual Studio solution from the IL2CPP project to the UWP project. To do this, in the Solution Explorer, right-click on YourProjectName (Universal Windows) and select **Set as StartUp Project**.

3. Connect your HoloLens to your computer, then select **Debug** > **Start Without Debugging** to build and deploy to your device:

    ![Visual Studio Window 2](../media/base-2-section-10-step-1-3.png)

    > [!IMPORTANT]
    > Before building to your device, the device must be in Developer Mode and paired with your development computer. Both of these steps can be completed by following [these instructions](https://docs.microsoft.com/windows/mixed-reality/develop/platform-capabilities-and-apis/using-visual-studio).

    > [!TIP]
    > You can also deploy to the [HoloLens Emulator](https://docs.microsoft.com/windows/mixed-reality/develop/platform-capabilities-and-apis/using-the-hololens-emulator) or create an [App Package](https://docs.microsoft.com/windows/uwp/packaging/packaging-uwp-apps) for sideloading.

4. Using Start Without Debugging automatically starts the app on your device without the Visual Studio debugger attached.

5. Select **Build** > **Deploy Solution** to deploy to your device without having the app start automatically.

    > [!NOTE]
    > You may notice the Diagnostics profiler in the app, which you can toggle on or off by using the speech command **"Toggle Diagnostics"**. It's recommended that you keep the profiler visible most of the time during development to understand when changes to the app may impact performance. For example, HoloLens apps should [continuously run at 60 FPS](https://docs.microsoft.com/windows/mixed-reality/develop/platform-capabilities-and-apis/understanding-performance-for-mixed-reality).
