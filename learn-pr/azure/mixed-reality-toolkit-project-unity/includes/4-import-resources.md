The Mixed Reality Toolkit is an open-source toolkit, which can be imported into your Unity mixed reality project. Although you could create Windows Mixed Reality apps without the Mixed Reality Toolkit, consider importing the toolkit to accelerate your development. Here you'll learn about the contents of the Mixed Reality Toolkit.

## What is the Mixed Reality Toolkit?

The MRTK v2 with Unity is an open-source cross-platform development kit for mixed reality applications. MRTK version 2 is intended to accelerate development of applications targeting Microsoft HoloLens, Windows Mixed Reality immersive (VR) headsets, and OpenVR platform. Android and iOS device support is also available.

## MRTK Unity

MRTK-Unity is a Microsoft-driven project that provides a set of components and features, used to accelerate cross-platform MR app development in Unity. Here are some of its functions:

- Provides the basic building blocks for Unity development on HoloLens, Windows Mixed Reality, and OpenVR.
- Enables rapid prototyping via in-editor simulation that allows you to see changes immediately.
- Operates as an extensible framework that provides developers the ability to swap out core components.
- Supports a wide range of platforms, including
  - Microsoft HoloLens
  - Microsoft HoloLens 2
  - Windows Mixed Reality headsets
  - OpenVR headsets (HTC Vive / Oculus Rift)
  - Ultraleap Hand Tracking

## TextMesh Pro

Some MRTK prefabs and assets require TextMesh Pro. TextMesh Pro is Unity's default text component. TextMesh Pro uses advanced text rendering techniques along with a set of custom shaders to deliver visual quality improvements. TextMesh Pro also provides greater flexibility for text styling and texturing. The TextMesh Pro assets must be added to your project by importing **TMP Essential Resources**.

## MRTK Unity Foundation Package

MRTK provides four MRTK Unity packages which can be imported into your Unity project. The latest version of the packages can be found in the Mixed Reality Feature Tool. The **Mixed Reality Toolkit Foundation** package is the only **required** package that must be imported and configured to use MRTK with your project. This package includes the core components required to create a mixed reality application.

After MRTK is added to the scene and configured, two new objects are added to the Scene hierarchy window:

- MixedRealityToolkit
- MixedRealityPlayspace

The **MixedRealityToolkit** object contains the toolkit itself. The **MixedRealityPlayspace** object ensures the headset/controllers and other required systems are managed correctly in the scene.

The **Main Camera** object is moved as a child to the **MixedRealityPlayspace** object. This allows the playspace to manage the camera simultaneously with the SDKs.

> [!NOTE]
> The Mixed Reality Feature Tool enables developers to discover, update, and add Mixed Reality feature packages into Unity projects. You can search packages by name or category, see their dependencies, and even view proposed changes to your projects manifest file before importing. If you've never worked with a manifest file before, it's a JSON file containing all your projects packages. Once you've validated the packages you want, the Mixed Reality Feature tool will download them into the project of your choice.

## Configuration Profile

One of the main ways that MRTK is configured is through the many profiles available in the Foundation package. Profiles configure the behavior of MRTK core components. The **MixedRealityToolkit** object contains the active profile and can be viewed in the Inspector window. When MRTK is added to the scene, the **DefaultMixedRealityToolkitConfigurationProfile** is preselected.

:::image type="content" source="../media/configure-profile-organization.png" alt-text="Screenshot of the Mixed Reality Toolkit parameters for the Configuration Profile. The default Mixed Reality Toolkit configuration profile is selected.":::

MRTK provides additional default profiles, which cover most platforms and scenarios that MRTK supports. Because **DefaultMixedRealityToolkitConfigurationProfile** is a general use profile, it isn't optimized for any particular use case. If you want to use settings optimized for a specific platform, consider selecting the respective default profile.

## How are Configuration Profiles organized

There is essentially an entire tree of connected profiles that make up the configuration information for how to start the MRTK subsystems and features. The top-level MRTK Configuration Profile contains sub-profile data for each of the primary core systems. Each primary core system is designed to configure the behavior of their corresponding subsystems. Furthermore, these sub-profiles can contain references to other profile objects one level below them.

## How to customize and configure the default MRTK Profiles

The default MRTK profiles can't be modified. Instead, you must clone the profile if you would like to make a change. Cloning an MRTK profile creates a new profile with the same settings and assigns the profile as the Configuration Profile for the scene. Given the format of how Configuration Profiles are organized, you must also clone the sub-profiles if you would like to modify sub-profile settings.

:::image type="content" source="../media/clone-profile.png" alt-text="Screenshot of  the Mixed Reality Toolkit parameters for the Configuration Profile. The default mixed reality toolkit configuration profile is selected. The clone button is highlighted.":::
