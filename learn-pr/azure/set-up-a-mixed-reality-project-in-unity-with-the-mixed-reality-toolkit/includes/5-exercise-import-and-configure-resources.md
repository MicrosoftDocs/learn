In this unit, you will import and configure resources to add the Mixed Reality Tookit to your project.

## Import TextMesh Pro Essential Resources

1. In the Unity menu, select **Window** > **TextMeshPro** > **Import TMP Essential Resources**.

:::image type="content" source="../media/import-tmp-essential-resources.png" alt-text="Import TextMesh Pro Essential Resources":::

2. In the **Import Unity Package** window, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

:::image type="content" source="../media/tmp-all-import.png" alt-text="Import All TMP assets":::

## Import the MRTK Unity Foundation package

1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package**.

:::image type="content" source="../media/import-custom-package.png" alt-text="Import Custom Package":::

2. In the **Import package...** window, select the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.2.0.unitypackage** you downloaded and click **Open**.

:::image type="content" source="../media/select-mrtk-package.png" alt-text="Select the MRTK Foundation package":::

3. In the **Import Unity Package window**, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

:::image type="content" source="../media/import-mrtk.png" alt-text="Import All MRTK assets":::

## Open the MRTK Project Configurator window

After the MRTK Foundation package is imported, the **MRTK Project Configurator** window will appear. If the window does not appear, you can open via the Unity menu. 

In the Unity menu, select **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**.

:::image type="content" source="../media/open-mrtk-project-configurator.png" alt-text="Open MRTK Project Configurator window":::

## Configure the Unity project for the Mixed Reality Toolkit

1. In the **MRTK Project Configurator** window, click the **Audio spatializer** dropdown and select **MS HRTF Spatializer**.

:::image type="content" source="../media/audio-spatializer.png" alt-text="Select MS HRTF Spatializer for Audio spatializer":::

2. Ensure all options are checked, and click the **Apply** button to apply the settings.

:::image type="content" source="../media/mrtk-project-configurator-apply.png" alt-text="Apply default settings":::

## Configure the Mixed Reality Toolkit

In the Unity menu, select **Mixed Reality Toolkit** > **Add to Scene and Configure...** to add MRTK to your current scene. Two new objects are added to the Hierarchy: **MixedRealityToolkit** and **MixedRealityPlayspace**.

:::image type="content" source="../media/new-mrtk-objects.png" alt-text="New MRTK objects":::