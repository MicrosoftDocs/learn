We'll start by creating a new Unity project and configuring it for Windows Mixed Reality development. Unity offers some behaviors that are specific to mixed reality and can be modified through project settings.

## Create a new Unity project

1. Launch the **Unity Hub**.
1. In the **Projects** tab,  click **New Project**.

   :::image type="content" source="../media/001-new-project.png" alt-text="Screenshot of Unity Hub in Projects tab with the New Project button highlighted.":::

1. Click the drop-down underneath **New project** and then select the Editor version you want.

    :::image type="content" source="../media/002-editor-version.png" alt-text="Screenshot of Unity Hub with the Editor version drop-down displayed.":::

2. Ensure the chosen template is **3D Core**.
3. In the **Project name** box, enter a name for your project--for example, "MRTK Tutorial."
4. In the **Location** box, click the folder icon, and then navigate to the folder where you want to save your project and select it. You can also create a new folder.

    :::image type="content" source="../media/003-name-and-location.png" alt-text="Screenshot of Unity Hub with 3D, Project Name, Location, and Create highlighted.":::

5. Click **Create Project**. This opens your project in Unity.

    :::image type="content" source="../media/004-project-open-in-unity.png" alt-text="Screenshot of your project open in Unity." lightbox="../media/004-project-open-in-unity.png":::

> [!CAUTION]
> When working on Windows, there is a MAX_PATH limit of 255 characters. Unity is affected by these limits and may fail to compile if any file path is longer than 255 characters. Therefore, we recommend that you store your Unity project as close to the root of the drive as possible.

## Switch Build Platform

To target Windows Mixed Reality, your Unity project must be set to export as a Universal Windows Platform app. By default, the build settings for the Universal Windows Platform target any device, including immersive headsets. However, you can select a specific device using the **Target Device** drop down.

1. In the menu bar, select **File** > **Build Settings...**.
1. In the **Build Settings** window, select **Universal Windows Platform**.
1. Make sure the following settings are active:

    **Architecture**: ARM 64-bit

    **Build Type**: D3D Project

    **Target SDK Version**: Latest Installed

    **Minimum Platform Version**: 10.0.10240.0

    **Visual Studio Version**: Latest installed

    **Build and Run on**: Local Machine

    **Build configuration**: Release (there are known performance issues with Debug)

1. Click the **Switch Platform** button. Unity displays a progress bar while it switches platforms.
1. After the switch platform process is finished, close the **Build Settings** window.

