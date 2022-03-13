We'll start by creating a new Unity project and configuring it for Windows Mixed Reality development. Unity offers some behaviors specific to mixed reality that can be modified through project settings. 

## Create a new Unity project

1. Launch the **Unity Hub**.
1. In the **Projects** tab,  click **New Project**.

   :::image type="content" source="../media/001-new-project.png" alt-text="Screenshot of Unity Hub in Projects tab with the New Project button highlighted.":::

1. Click the drop-down underneath **New project** and then select the Editor version you want.

    :::image type="content" source="../media/002-editor-version.png" alt-text="Screenshot of Unity Hub with with the Editor version drop-down displayed.":::

1. Ensure the chosen template is **3D Core**.
1. In the **Project name** box, enter a name for your project--for example, "MRTK Tutorial."
1. In the **Location** box, click the folder, and then navigate to the folder where you want to save your project and select it. You can also create a new folder.

    :::image type="content" source="../media/003-name-and-location.png" alt-text="Screenshot of Unity Hub with 3D, Project Name, Location, and Create highlighted.":::

1. Click **Create Project**. This opens your project in Unity.

    :::image type="content" source="../media/004-project-open-in-unity.png" alt-text="Screenshot of your project open in Unity.":::

> [!CAUTION]
> When working on Windows, there is a MAX_PATH limit of 255 characters. Unity is affected by these limits and may fail to compile if any file path is longer than 255 characters. Therefore, we recommend that you store your Unity project as close to the root of the drive as possible.

## Configure Unity Project for Windows Mixed Reality

**Switch Build Platform**

1. In the menu bar, select **File** > **Build Settings...**.
1. In the **Build Settings** window, select **Universal Windows Platform**.
1. Make sure the following settings are active:

**Target device****: HoloLens
**Architecture**: ARM 64
**Build Type**: D3D Project
**Target SDK Version**: Latest Installed
**Minimum Platform Version**: 10.0.10240.0
**isual Studio Version**: Latest installed
**Build and Run on**: Local Machine
**Build configuration**: Release (there are known performance issues with Debug)

1. Click the **Switch Platform** button. Unity proceeds to switch the platform and displays a progress bar.
1. After the switch platform process is finished, close the **Build Settings** window.