The Mixed Reality Toolkit provides a set of components and features which could be used to accelerate your Windows Mixed Reality app development. To use the toolkit in your mixed reality project, you must import the package and configure the resources added to the project. Here you'll import and configure resources to add the Mixed Reality Toolkit to your project.

## Import the MRTK Unity foundation package

To Import Mixed Reality Toolkit into the Unity Project you'll have to use Mixed Reality Feature Tool, which allows developers to discover, update, and add Mixed Reality feature packages into Unity projects. You can search packages by name or category, see their dependencies, and even view proposed changes to your projects manifest file before importing.

Download the latest version of the Mixed Reality Feature Tool from the [Microsoft Download Center](https://aka.ms/MRFeatureTool) , When the download is complete, unzip the file and save it to your
desktop.

> [!NOTE]
> Before you can run the Mixed Reality Feature Tool please install [.NET 5.0 runtime](https://dotnet.microsoft.com/download/dotnet/5.0)

Open the executable file **MixedRealityFeatureTool** from the downloaded folder to launch the Mixed Reality Feature Tool.

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
