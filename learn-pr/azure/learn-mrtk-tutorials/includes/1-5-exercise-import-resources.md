
## Install the Mixed Reality Feature Tool

To import the Mixed Reality Toolkit into your project we'll use the Mixed Reality Feature Tool, which allows developers to discover, update, and import feature packages. You can search packages by name or category, see their dependencies, and view proposed changes to your project's manifest file before importing.

1. Download the latest version of the Mixed Reality Feature Tool from the [Microsoft Download Center](https://aka.ms/MRFeatureTool).
1. After the download finishes, executable file MixedRealityFeatureTool.exe and then use it to launch the Mixed Reality Feature Tool.

    > [!NOTE]
    > Before you can run the Mixed Reality Feature Tool, you may need to install the [.NET 6.0 runtime](https://dotnet.microsoft.com/download/dotnet/6.0).

## Import the MRTK Unity foundation package

[!INCLUDE[](includes/import-mrtk.md)]

## Create the scene and configure MRTK

1. In the menu bar, select **File** > **New Scene**. Select the Basic (Built-in) option, then **Create**. 

1. In the Project window, navigate to the **Packages** > **MRTK Input** > **Assets** > **Prefabs**  folder. Drag the prefab **MRTK XR Rig** into the scene Hierarchy.
     :::image type="content" source="../media/mrtk-xr-rig-prefab.png" alt-text="Screenshot of the adding MRTK XR Rig in the Inspector.":::
1. Remove the **Main Camera** game object because **MRTK XR Rig** game object already contains a camera.
     :::image type="content" source="../media/023-add-mrtk.png" alt-text="Screenshot of the Mixed Reality Toolkit in the Inspector.":::

1. Add the **MRTK Input Simulator** (**Packages** > **MRTK Input** > **Simulation** > **Prefabs**) prefab to your scene.
 Note: This step is optional, but required by in-editor simulations.
    > [!NOTE]
    > This step is optional, but required by in-editor simulations.

     :::image type="content" source="../media/023-add-input-simulator.png" alt-text="Screenshot of the input simulator.":::
    
1. In the menu bar, select **File** > **Save As...**.

1. Navigate to the **Assets** > **Scenes** folder, then name your project, and then save your project.