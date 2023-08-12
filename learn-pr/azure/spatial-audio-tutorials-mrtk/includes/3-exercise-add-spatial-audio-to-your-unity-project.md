Through this module series, you'll learn how to use spatial audio on HoloLens 2 with the Microsoft Spatializer plugin. The [MixedRealityLearning repository](https://github.com/marlenaklein-msft/MixedRealityLearning) has a completed Unity project of this tutorial sequence.

## Create and prepare the Unity project

In this section, you'll create a new Unity project and get it ready for MRTK development. 

For this, first follow the [this tutorial](/training/modules/mixed-reality-toolkit-project-unity), excluding the Build your application to your device instructions. This will include the following steps:

1. Creating the Unity project and give it a suitable name, for example, *MRTK Tutorials*
2. Switching the build platform
3. Importing the TextMeshPro Essential Resources
4. Importing the Mixed Reality Toolkit
5. Configuring the Unity project
6. Creating and setting the scene and give the scene a suitable name, for example, *SpatialAudio*


## Add the spatializer package via the Mixed Reality Feature Tool
 
1. Download the Mixed Reality Feature Tool from https://aka.ms/mrfeaturetool.

2. Select the Microsoft Spatializer component from the Spatial Audio group and integrate the plugin into your project using the Get Features button.

    :::image type="content" source="../media/MRFeatureTool.png" alt-text="Screenshot of Mixed Reality Feature Tool." lightbox="../media/MRFeatureTool.png":::
 

## Enable the Microsoft Spatializer plugin

* After importing the **Microsoft Spatializer** you need to enable it. Open **Edit -> Project Settings -> Audio**, and change **Spatializer Plugin** to "Microsoft Spatializer".

    :::image type="content" source="../media/spatializer-plugin.png" alt-text="Screenshot of Project Settings showing spatializer plugin." lightbox="../media/spatializer-plugin.png":::

## Enable Spatial audio on your workstation

 * On desktop versions of Windows, Spatial audio is disabled by default. Enable it by right-clicking on the volume icon in the task bar to get to sound settings. From there navigate to **More sound settings** > **Properties** > **Spatial sound**. To get the best representation of what you'll hear on HoloLens 2, choose **Windows Sonic for Headphones**.

    :::image type="content" source="../media/spatial-audio-settings.png" alt-text="Screenshot of Desktop spatial audio settings." lightbox="../media/spatial-audio-settings.png":::

> [!NOTE]
> This setting is only required if you plan to test your project in the Unity editor.
