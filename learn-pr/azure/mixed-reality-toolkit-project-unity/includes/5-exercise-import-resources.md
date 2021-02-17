The Mixed Reality Toolkit provides a set of components and features which could be used to accelerate your Windows Mixed Reality app development. To use the toolkit in your mixed reality project, you must import the package and configure the resources added to the project. Here you'll import and configure resources to add the Mixed Reality Toolkit to your project.

## Import TextMesh Pro Essential Resources

1. In the Unity menu, select **Window** > **TextMeshPro** > **Import TMP Essential Resources**.

    :::image type="content" source="../media/import-tmp-essential-resources.png" alt-text="Screenshot of the Unity Editor with the Window menu expanded. Text Mesh Pro and Import T M P Essential Resources are highlighted.":::

1. In the **Import Unity Package** window, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

    :::image type="content" source="../media/tmp-all-import.png" alt-text="Screenshot of the Import Unity Package window. The window displays the assets for T M P essential resources. The All and Import buttons are highlighted.":::

## Import the MRTK Unity Foundation package

1. In the Mixed Reality Feature Tool, select the **Mixed Reality Toolkit Foundation** package within the feature package catalog followed by **Get Features**.

    :::image type="content" source="../media/feature-package-catalog.png" alt-text="Screenshot of the Mixed Reality Feature Tool. The Mixed Reality Toolkit Foundation package is highlighted.":::

1. On the **Import Features** screen, select **Validate** to ensure the Unity project can successfully import the selected features. If successful, the message **No validation issues were detected** displays in a pop-up.

    :::image type="content" source="../media/feature-tool-validate.png" alt-text="Screenshot of the Mixed Reality Feature Tool. The Validate button is highlighted.":::

1. For **Project path** use the **ellipsis** button to select the target location of the Unity project.

    :::image type="content" source="../media/feature-tool-project-path.png" alt-text="Screenshot of the Mixed Reality Feature Tool. The Project path field is highlighted.":::

1. Select **Import** to import the package and dependencies.

1. On the **Review and Approve** screen, select **Approve**.

    :::image type="content" source="../media/feature-tool-approve.png" alt-text="Screenshot of the Mixed Reality Feature Tool. The Approve button is highlighted.":::

1. After the project update is successful, select **Exit** on the **Unity Project Updated** screen. 

The Unity project should now contain a **Packages** folder. Inside the **Packages** folder is the **Mixed Reality Toolkit Foundation** package and installed dependencies.

## Open the MRTK Project Configurator window

After the MRTK Foundation package is imported, the **MRTK Project Configurator** window will appear. If the window does not appear, you can open via the Unity menu.

In the Unity menu, select **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**.

:::image type="content" source="../media/open-mrtk-project-configurator.png" alt-text="Open MRTK Project Configurator window.":::

## Configure the Unity project for the Mixed Reality Toolkit

1. In the **MRTK Project Configurator** window, click the **Audio spatializer** dropdown and select **MS HRTF Spatializer**.

    :::image type="content" source="../media/audio-spatializer.png" alt-text="Screenshot of the M R T K Project Configurator window. Audio spatializer and the drop-down options for the settings are highlighted. The M S H R T F spatializer option is highlighted in blue.":::

1. Ensure all options are checked, and click the **Apply** button to apply the settings.

    :::image type="content" source="../media/mrtk-project-configurator-apply.png" alt-text="Screenshot of the M R T K Project Configurator window with Apply highlighted.":::

## Configure the Mixed Reality Toolkit

In the Unity menu, select **Mixed Reality Toolkit** > **Add to Scene and Configure...** to add MRTK to your current scene. Two new objects are added to the Hierarchy: **MixedRealityToolkit** and **MixedRealityPlayspace**.

:::image type="content" source="../media/new-mrtk-objects.png" alt-text="New MRTK objects.":::
