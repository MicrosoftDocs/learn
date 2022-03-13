
## Import the MRTK Unity foundation package

To import the Mixed Reality Toolkit into your project we'll use the Mixed Reality Feature Tool, which allows developers to discover, update, and import feature packages. You can search packages by name or category, see their dependencies, and even view proposed changes to your project's manifest file before importing.

1. Download the latest version of the Mixed Reality Feature Tool from the [Microsoft Download Center](https://aka.ms/MRFeatureTool). 1. After the download finishes, unzip the file and save it to your desktop.

    > [!NOTE]
    > Before you can run the Mixed Reality Feature Tool, you must install the [.NET 5.0 runtime](https://dotnet.microsoft.com/download/dotnet/5.0)

1. In the unzipped folder, navigate to the executable file **MixedRealityFeatureTool.exe** and then use it to launch the Mixed Reality Feature Tool.

:::image type="content" source="../media/open-mixed-reality-feature-tool.png" alt-text="Screenshot of Opening MixedRealityFeatureTool." lightbox="../media/open-mixed-reality-feature-tool.png":::

[!INCLUDE[](includes/import-mrtk.md)]

## Create the scene and configure MRTK

1. In the Unity menu, select **File** > **New Scene**:

2. In the **New Scene** window select **Basic (Built-in)** and click on create to **create** a new scene:

3. In the Unity menu, select **Mixed Reality** > **Toolkit** > **Add to Scene and Configure...** to add the MRTK to your current scene:

4. With the **MixedRealityToolkit** object still selected in the Hierarchy window, in the Inspector window, verify that the **MixedRealityToolkit** configuration profile is set to
**DefaultMixedRealityToolkitConfigurationProfile:**

5. In the Unity menu, select **File** > **Save As...** to open the Save Scene window:

6. Save the scene in you project under **Asset** > **Scenes**.