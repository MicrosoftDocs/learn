The Mixed Reality Toolkit provides a set of components and features which could be used to accelerate your Windows Mixed Reality app development. To use the toolkit in your mixed reality project, you must import the package and configure the resources added to the project. Here you'll import and configure resources to add the Mixed Reality Toolkit to your project.

## Import TextMesh Pro Essential Resources

1. In the Unity menu, select **Window** > **TextMeshPro** > **Import TMP Essential Resources**.

    :::image type="content" source="../media/import-tmp-essential-resources.png" alt-text="Screenshot of the Unity Editor with the Window menu expanded. Text Mesh Pro and Import T M P Essential Resources are highlighted.":::

1. In the **Import Unity Package** window, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

    :::image type="content" source="../media/tmp-all-import.png" alt-text="Screenshot of the Import Unity Package window. The window displays the assets for T M P essential resources. The All and Import buttons are highlighted.":::

## Import the MRTK Unity Foundation package

1. Download the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** from the [MRTK release page](https://github.com/Microsoft/MixedRealityToolkit-Unity/releases?azure-portal=true).

1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package**.

    :::image type="content" source="../media/import-custom-package.png" alt-text="Screenshot of the Unity editor with the Assets menu expanded. The Import Package and Custom Package options are highlighted.":::

1. In the **Import package...** window, select the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** you downloaded and click **Open**.

    :::image type="content" source="../media/select-mrtk-package.png" alt-text="Screenshot of the Import package explorer window open. The Mixed Reality Toolkit foundation package is highlighted in the explorer. The Open button is highlighted.":::

1. In the **Import Unity Package window**, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

    :::image type="content" source="../media/import-mrtk.png" alt-text="Screenshot of the Import Unity Package window. The window displays the assets for the Mixed Reality Toolkit foundation 2 dot 4 dot 0 package. The All and Import buttons are highlighted.":::

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
