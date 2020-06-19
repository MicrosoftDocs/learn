# Exercise - Import and configure resources

In this unit, you will import and configure resources to add the Mixed Reality Tookit to your project.

## Import TextMesh Pro Essential Resources

1. In the Unity menu, select **Window** > **TextMeshPro** > **Import TMP Essential Resources**.
1. In the **Import Unity Package** window, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

## Import the MRTK Unity Foundation package

1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package**.
1. In the **Import package...** window, select the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.2.0.unitypackage** you downloaded and click **Open**.
1. In the **Import Unity Package window**, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.

## Open the MRTK Project Configurator window

After the MRTK Foundation package is imported, the **MRTK Project Configurator** window will appear. If the window does not appear, you can open via the Unity menu. In the Unity menu, select **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**.

## Configure the Unity project for the Mixed Reality Toolkit

1. In the **MRTK Project Configurator** window, click the **Audio spatializer** dropdown and select **MS HRTF Spatializer**.
1. Ensure all options are checked, and click the **Apply** button to apply the settings.

## Configure the Mixed Reality Toolkit

In the Unity menu, select **Mixed Reality Toolkit** > **Add to Scene and Configure...** to add MRTK to your current scene. Two new objects are added to the Hierarchy: **MixedRealityToolkit** and **MixedRealityPlayspace**.
