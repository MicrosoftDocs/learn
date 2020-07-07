Before you can get started creating an immersive experience for Windows Mixed Reality, you must configure your Unity Project for Windows Mixed Reality development. Unity offers some behaviors specific to mixed reality that can be modified through project settings. Here you will configure your Unity project for Windows Mixed Reality development.

## Create a new Unity project

1. Launch the **Unity Hub**, select the **Projects** tab, and click the **down arrow** next to the **New** button.

    :::image type="content" source="../media/unity_hub_new.png" alt-text="Unity Hub":::

1. Select the Unity version specified in the module Prerequisites.

    :::image type="content" source="../media/select_unity_version.png" alt-text="Select Unity Version":::

1. In the **Create a new project** window:
    - Ensure **Templates** is set to **3D**
    - Enter a suitable **Project Name**, for example, *MRTK Tutorials*
    - Choose a suitable **Location** to store your project, for example, *D:\MixedRealityLearning*
    - Click the **Create** button to create and launch your new Unity project

    :::image type="content" source="../media/create_new_project.png" alt-text="Create new Unity project":::

> [!CAUTION]
> When working on Windows, there is a MAX_PATH limit of 255 characters. Unity is affected by these limits and may fail to compile if any file path is longer than 255 characters. Therefore, it is strongly recommended to store your Unity project as close to the root of the drive as possible.

## Configure Unity Project for Windows Mixed Reality

**Switch Build Platform**

1. In the Unity menu, select **File** > **Build Settings...** to open the **Build Settings window**.

    :::image type="content" source="../media/build_settings.png" alt-text="Open Build Settings window":::

1. In the **Build Settings** window, select **Universal Windows Platform** and click the **Switch Platform** button. Unity will begin the process to switch the platform.

    :::image type="content" source="../media/switch_platform.png" alt-text="Switch Build platform":::

1. Close the **Build Settings** window once Unity has finished switching the platform.

    :::image type="content" source="../media/exit_build_settings.png" alt-text="Close Build Settings window":::

**Enable Virtual Reality**

1. In the Unity menu, select **Edit** > **Project Settings...** to open the **Project Settings** window.

    :::image type="content" source="../media/project_settings.png" alt-text="Open Project Settings window":::

1. In the Project Settings window, select **Player** > **XR Settings** to expand the **XR Settings**.

    :::image type="content" source="../media/xr_settings.png" alt-text="Expand XR Settings":::

1. In the XR Settings, check the **Virtual Reality Supported** checkbox to enable virtual reality.

    :::image type="content" source="../media/virtual_reality_supported.png" alt-text="Enable Virtual Reality Supported":::

1. Next, click the **+** icon and select **Windows Mixed Reality** to add the Windows Mixed Reality SDK. Unity will begin the process to add the SDK.

    :::image type="content" source="../media/add_wmr_sdk.png" alt-text="Add Windows Mixed Reality SDK":::

1. After the SDK is added, optimize the **XR Settings** as follows:

    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**
    - Check the Windows Mixed Reality **Enable Depth Sharing** checkbox
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**.

    :::image type="content" source="../media/optimize_xr_settings.png" alt-text="Optimize XR Settings":::