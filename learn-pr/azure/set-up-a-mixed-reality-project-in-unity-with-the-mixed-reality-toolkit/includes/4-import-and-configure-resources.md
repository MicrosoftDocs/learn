## What is the Mixed Reality Toolkit?

The Mixed Reality Toolkit (MRTK) is an open-source development toolkit for building Mixed Reality applications. To use MRTK in your mixed reality project, you need to complete the following:

1. Import TextMeshPro Essential Resources
1. Import the MRTK Unity Foundation package
1. Add MRTK to the scene and configure

## TextMesh Pro

Some MRTK prefabs and assets require TextMesh Pro. TextMesh Pro is Unity's default text component. TextMesh Pro uses advanced text rendering techniques along with a set of custom shaders to deliver visual quality improvements. TextMesh Pro also provides greater flexibility for text styling and texturing. The TextMesh Pro assets must be added to your project by importing **TMP Essential Resources**.

## MRTK Unity Foundation Package

MRTK provides four MRTK Unity packages which can be imported into your Unity project. The latest version of the packages can be found on the [MRTK Releases](https://github.com/Microsoft/MixedRealityToolkit-Unity/releases) page. The **Microsoft.MixedRealityToolkit.Unity.Foundation.unitypackage** is the only **required** package that must be downloaded, imported and configured to use MRTK with your project. This package includes the core components required to create a mixed reality application.

After MRTK is added to the scene and configured, two new objects are added to the Scene hierarchy window:

- MixedRealityToolkit
- MixedRealityPlayspace

The **MixedRealityToolkit** object contains the toolkit itself. The **MixedRealityPlayspace** ensures the headset/controllers and other required systems are managed correctly in the scene.

The **Main Camera** object is moved as a child to the **MixedRealityPlayspace** object. This allows the playspace to manage the camera simultaneously with the SDKs.

## Configuration Profile

One of the main ways that MRTK is configured is through the many profiles available in the Foundation package. Profiles configure the behavior of MRTK core components. The **MixedRealityToolkit** object contains the active profile and can be viewed in the Inspector window. When MRTK is added to the scene, the **DefaultMixedRealityToolkitConfigurationProfile** is preselected.

:::image type="content" source="../media/configure-profile-organization.png" alt-text="Configuration Profile":::

MRTK provides additional default profiles which cover most platforms and scenarios that MRTK supports. Note that because **DefaultMixedRealityToolkitConfigurationProfile** is a general use profile, it is not optimized for any particular use case. If you want to use settings optimized for a specific platform, consider selecting the respective default profile.

## How are Configuration Profiles organized

There is essentially an entire tree of connected profiles that make up the configuration information for how to start the MRTK sub-systems and features. The top level MRTK Configuration Profile contains sub-profile data for each of the primary core systems. Each primary core system is designed to configure the behavior of their corresponding sub-systems. Furthermore, these sub-profiles can contain references to other profile objects one level below them.

## How to customize and configure the default MRTK Profiles

The default MRTK profiles cannot be modified. Instead, you must clone the profile if you would like to make a change. Cloning a MRTK profile creates a new profile with the same settings and assigns the profile as the Configuration Profile for the scene. Given the format of how Configuration Profiles are organized, you must also clone the sub-profiles if you would like to modify sub-profile settings.

:::image type="content" source="../media/clone-profile.png" alt-text="Clone Configuration Profile":::
