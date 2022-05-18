
## Import the MRTK Unity foundation package

To import the Mixed Reality Toolkit into your project we'll use the Mixed Reality Feature Tool, which allows developers to discover, update, and import feature packages. You can search packages by name or category, see their dependencies, and view proposed changes to your project's manifest file before importing.

1. Download the latest version of the Mixed Reality Feature Tool from the [Microsoft Download Center](https://aka.ms/MRFeatureTool).
1. After the download finishes, unzip the file and save it to your desktop.

    > [!NOTE]
    > Before you can run the Mixed Reality Feature Tool, you must install the [.NET 5.0 runtime](https://dotnet.microsoft.com/download/dotnet/5.0)

1. In the unzipped folder, navigate to the executable file **MixedRealityFeatureTool.exe** and then use it to launch the Mixed Reality Feature Tool.

    :::image type="content" source="../media/open-mixed-reality-feature-tool.png" alt-text="Screenshot of Opening MixedRealityFeatureTool.":::

[!INCLUDE[](includes/import-mrtk.md)]

## Create the scene and configure MRTK

1. In the menu bar, select **File** > **New Scene**.

1. In the **New Scene** window select **Basic (Built-in)** and then click **Create**.

1. In the menu bar, select **Mixed Reality** > **Toolkit** > **Add to Scene and Configure...**.

    The Mixed Reality Toolkit settings appear in the Inspector.

    :::image type="content" source="../media/023-add-mrtk.png" alt-text="Screenshot of the Mixed Reality Toolkit in the Inspector.":::

    After MRTK is added to the scene and configured, two new objects are added to the **Hierarchy**  window:

    **MixedRealityToolkit**

    **MixedRealityPlayspace**

    The MixedRealityToolkit object contains the Toolkit itself. The MixedRealityPlayspace object ensures that the headset/controllers and other required systems are managed correctly in the scene.

    The Main Camera object becomes a child to the MixedRealityPlayspace object. This allows the play space to manage the camera simultaneously with the SDKs.

    :::image type="content" source="../media/039-mrtk-objects-in-hierarchy.png" alt-text="Screenshot of new objects in the Hierarchy after MRTK is added.":::

1. In the Inspector, verify that the profile drop down displays **DefaultMixedRealityToolkitConfigurationProfile:**

    :::image type="content" source="../media/024-default-profile.png" alt-text="Screenshot of the Mixed Reality Toolkit in the Inspector with the DefaultMixedRealityToolkitConfiguration profile displayed.":::

    > [!NOTE]
    > One of the main ways that you can configure MRTK is by selecting a profile made available through the Foundation package. Profiles configure the behavior of MRTK core components. When MRTK is added to the scene, "DefaultMixedRealityToolkitConfigurationProfile" is preselected. This profile is for general use--it isn't optimized for any particular use case. MRTK provides additional default profiles that cover most platforms and scenarios that MRTK supports. You may want to choose a profile that's optimized for the specific platform you're using. To learn more about configuration profiles, see the [MRTK profile configuration guide](/windows/mixed-reality/mrtk-unity/configuration/mixed-reality-configuration-guide).

1. In the menu bar, select **File** > **Save As...**.

1. Navigate to the **Assets** > **Scenes** folder, then name your project, and then save your project.