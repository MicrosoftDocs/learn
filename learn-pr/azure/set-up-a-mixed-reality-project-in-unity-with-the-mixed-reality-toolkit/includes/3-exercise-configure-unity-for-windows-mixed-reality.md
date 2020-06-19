In this unit, you will create a new Unity project and configure for Windows Mixed Reality.

## Create a new Unity project

1. Launch the **Unity Hub**, select the **Projects** tab, and click the **down arrow** next to the **New** button.
2. Select the Unity version specified in the module Prerequisites.
3. In the **Create a new project** window:
    - Ensure **Templates** is set to **3D**
    - Enter a suitable **Project Name**, for example, *MRTK Tutorials*
    - Choose a suitable **Location** to store your project, for example, *D:\MixedRealityLearning*
    - Click the **Create** button to create and launch your new Unity project

> [!CAUTION]
> When working on Windows, there is a MAX_PATH limit of 255 characters. Unity is affected by these limits and may fail to compile if any file path is longer than 255 characters. Therefore, it is strongly recommended to store your Unity project as close to the root of the drive as possible.

## Configure Unity Project for Windows Mixed Reality

**Switch Build Platform**

1. In the Unity menu, select **File** > **Build Settings...** to open the **Build Settings window**.
1. In the **Build Settings** window, select **Universal Windows Platform** and click the **Switch Platform** button. Unity will begin the process to switch the platform.
1. Close the **Build Settings** window once Unity has finished switching the platform.

**Enable Virtual Reality**

1. In the Unity menu, select **Edit** > **Project Settings...** to open the **Project Settings** window.
1. In the Project Settings window, select **Player** > **XR Settings** to expand the **XR Settings**.
1. In the XR Settings, check the **Virtual Reality Supported** checkbox to enable virtual reality.
1. Next, click the **+** icon and select **Windows Mixed Reality** to add the Windows Mixed Reality SDK. Unity will begin the process to add the SDK.
1. After the SDK is added, optimize the **XR Settings** as follows:

    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**
    - Check the Windows Mixed Reality **Enable Depth Sharing** checkbox
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**.

## Add a Cube to the scene

1. In the **Hierarchy** window, click the **+** icon and select **3D Object** > **Cube**.
1. Adjust the Scene view camera using the Scene Gizmo to view the front of the cube.
1. Select the **Cube** object in the **Hierarchy** window. The Cube's properties will display in the **Inspector** window.
1. In the **Inspector** window, change the Cube's **Transform Scale** to **.25**, **.25**, **.25**. This will make the cube smaller.
1. Change the Cube **Transform Position** to **0**, **0**, **.8**. This will move the cube object further back on the z-axis. When you later import the Mixed Reality Toolkit into your project, this change will provide a better view of the cube in the **Game** window.

## View the Scene in play mode

1. In the Unity toolbar, click the **Play** icon to enter play mode. The Play icon will turn blue to indicate that you are in play mode.
1. After viewing the cube, click the **Play** icon to exit play mode. The Play icon will return to it's default color to indicate that you are in edit mode.