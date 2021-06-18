The first step to creating an immersive experience for Windows Mixed Reality requires configuring your Unity project for Windows Mixed Reality development. Configuring Unity for Windows Mixed Reality development is a manual process, which must be completed whenever you create a new Unity project or open a project that's shared with you. After your project is configured, your app will be able to do basic holographic rendering and spatial input.

To configure Unity for Windows Mixed Reality development, follow these steps:

1. Go to **File** > **Build Settings** to switch **Build Platform** to **Universal Windows Platform**.

1. In the **Build Settings** window, select **Player Settings**. In the **Player** section, expand **XR Settings**. Enable **Virtual Reality Supported**, and add the **Windows Mixed Reality** SDK.

   ![Screenshot of the X R settings in the projects window. The virtual reality supported and plus icon are highlighted.](../media/xr-settings.png)

1. Optimize Cross Reality (XR) settings as follows:

   - Set Windows Mixed Reality **Depth Format** to **16-bit depth**.
   - Select the Windows Mixed Reality **Enable Depth Buffer Sharing** checkbox.
   - Set **Stereo Rendering Mode** to **Single Pass Instanced**.

   ![A screenshot of the X R settings. The depth format, enable depth buffer sharing, and stereo rendering mode settings are highlighted.](../media/optimize-settings.png)

## Add MRTK to the scene and configure

Typically, if you were to start this project from scratch, you'd need to use the [Mixed Reality Feature Tool](/windows/mixed-reality/develop/unity/welcome-to-mr-feature-tool?azure-portal=true) to import the Mixed Reality Toolkit (MRTK) Foundation package. However, this sample project contains the MRTK Foundation package.

Before you can use the MRTK features, you'll need to add MRTK to the scene, and configure it.

In the Unity menu, select **Mixed Reality Toolkit** > **Add to Scene and Configure...** to add MRTK to your current scene.

![Screenshot of the M R T K menu. The Add to Scene and Configure option is highlighted.](../media/add-to-scene-configure.png)

Two new objects are added to the hierarchy: **MixedRealityToolkit** and **MixedRealityPlayspace**.

![Screenshot of the hierarchy window. The M R T K objects are highlighted.](../media/mrtk-hierarchy.png)

The `MixedRealityToolkit` object contains the toolkit itself. The `MixedRealityPlayspace` object ensures that the headset, controllers, and other required systems are managed correctly in the scene.

The `Main Camera` object is moved as a child to the `MixedRealityPlayspace` object. This allows the playspace to manage the camera simultaneously with the SDKs.

## Select the configuration profile

One of the main ways that MRTK is configured is through the many profiles available in the Foundation package. Profiles configure the behavior of MRTK core components. The `MixedRealityToolkit` object contains the active profile, and you can view it in the **Inspector** window.

When MRTK is added to the scene, the **DefaultMixedRealityToolkitConfigurationProfile** is preselected.

![Screenshot of the Inspector window. The configuration profile is highlighted.](../media/configuration-profile.png)

MRTK provides additional default profiles, which cover most platforms and scenarios that MRTK supports. Because `DefaultMixedRealityToolkitConfigurationProfile` is a general use profile, it isn't optimized for any particular use case. If you want to use settings optimized for a specific platform, consider selecting the respective default profile.

> [!NOTE]
> This module uses `DefaultHoloLens2ConfigurationProfile`.

## Import TextMesh Pro Essential Resources

Some MRTK prefabs and assets require TextMesh Pro. TextMesh Pro is Unity's default text component. TextMesh Pro uses advanced text rendering techniques and a set of custom shaders to deliver visual quality improvements. TextMesh Pro also provides greater flexibility for text styling and texturing. The TextMesh Pro assets must be added to your project by importing its essential resources.

In the Unity menu, select **Window** > **TextMeshPro** > **Import TMP Essential Resources**.

![Screenshot of the Window menu. TextMeshPro and Import TMP Essential Resources are highlighted.](../media/import-tmp.png)

In the **Import Unity Package** window, select **All** to ensure that all the assets are selected. Then select **Import**.

![Screenshot of the Import Unity Package window for the T M P Essential Resources package. The All and Import buttons are highlighted.](../media/textmesh-pro-package.png)

© 2021 Warner Bros. Ent. All Rights Reserved.
