Before you can get started creating an immersive experience for Windows Mixed Reality, you must configure your Unity Project for Windows Mixed Reality development. Unity offers some behaviors specific to mixed reality that can be modified through project settings. Here you'll create a new Unity project and configure it for Windows Mixed Reality development.

## Create a new Unity project

1. Launch the **Unity Hub**, select the **Projects** tab, and click the **down arrow** next to the **New** button.

    :::image type="content" source="../media/unity-hub-new.png" alt-text="Screenshot of Unity Hub with Projects and drop-down arrow for New highlighted.":::

1. Select the Unity version specified in the module Prerequisites.

    :::image type="content" source="../media/select-unity-version.png" alt-text="Screenshot of Unity Hub with Unity version 2019 dot 3 dot 14 f 1 highlighted.":::

1. In the **Create a new project** window:
    - Ensure **Templates** is set to **3D**
    - Enter a suitable **Project Name**, for example, *MRTK Tutorials*
    - Choose a suitable **Location** to store your project, for example, *D:\MixedRealityLearning*
    - Click the **Create** button to create and launch your new Unity project

    :::image type="content" source="../media/create-new-project.png" alt-text="Screenshot of Unity Hub with 3D, Project Name, Location, and Create highlighted. Project name field is M R T K Tutorials. Location field is D colon backlash Mixed Reality Learning.":::

> [!CAUTION]
> When working on Windows, there is a MAX_PATH limit of 255 characters. Unity is affected by these limits and may fail to compile if any file path is longer than 255 characters. Therefore, it is strongly recommended to store your Unity project as close to the root of the drive as possible.

## Configure Unity Project for Windows Mixed Reality

**Switch Build Platform**

1. In the Unity menu, select **File** > **Build Settings...** to open the **Build Settings window**.

    :::image type="content" source="../media/build-settings.png" alt-text="Screenshot of Unity editor with File menu expanded and Build Settings highlighted.":::

1. In the **Build Settings** window, select **Universal Windows Platform** and click the **Switch Platform** button. Unity will begin the process to switch the platform.

    :::image type="content" source="../media/switch-platform.png" alt-text="Screenshot of Build Settings with Universal Windows Platform and Switch Platform highlighted.":::

1. Close the **Build Settings** window once Unity has finished switching the platform.

    :::image type="content" source="../media/exit-build-settings.png" alt-text="Screenshot of Build Settings with X symbol highlighted to close the window.":::

**Enable Virtual Reality**

1. In the Unity menu, select **Edit** > **Project Settings...** to open the **Project Settings** window.

    :::image type="content" source="../media/project-settings.png" alt-text="Screenshot of Unity editor with Edit menu expanded and Project Settings highlighted.":::

1. In the Project Settings window, select **Player** > **XR Settings** to expand the **XR Settings**.

    :::image type="content" source="../media/xr-settings.png" alt-text="Screenshot of Project Settings window with Player and X R Settings highlighted.":::

1. In the XR Settings, check the **Virtual Reality Supported** checkbox to enable virtual reality.

    :::image type="content" source="../media/virtual-reality-supported.png" alt-text="Screenshot of Project Settings with Player selected and Virtual Reality Supported checked.":::

1. Next, click the **+** icon and select **Windows Mixed Reality** to add the Windows Mixed Reality SDK. Unity will begin the process to add the SDK.

    :::image type="content" source="../media/add-wmr-sdk.png" alt-text="Screenshot of Project Settings with Player selected. The plus icon for Virtual Reality S D Ks is highlighted. The Windows Mixed Reality option is highlighted in drop-down to add a Virtual Reality S D K.":::

1. After the SDK is added, optimize the **XR Settings** as follows:

    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**
    - Check the Windows Mixed Reality **Enable Depth Sharing** checkbox
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**.

    :::image type="content" source="../media/optimize-xr-settings.png" alt-text="Screenshot of Project Settings with Player selected. Within Virtual Realty S D Ks, the Depth Format and Enable Depth Buffer Sharing fields are highlighted. Depth Format is set to 16-bit depth. Enabled Depth Buffer Sharing is checked. The Stereo Rendering Mode field is highlighted with Single Pass Instanced selected.":::
