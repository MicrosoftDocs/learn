## [Unity 2021 + OpenXR](#tab/openxr)

1. On the menu bar, select **Window** > **Package Manager**. 

1. Verify that AR Foundation version 4.1.7 is installed.

    :::image type="content" source="../../media/install-package.png" alt-text="Screenshot of selections for verifying the A R Foundation version for Package Manager." lightbox="../../media/install-package.png":::

## Import the tutorial assets

1. Add AzurespatialAnchors SDK V2.10, or the latest version, to your project by following [this tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage).

2. Download and import the following Unity custom packages in this order:

    * [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v3.0.0/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0.unitypackage)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpatialAnchors.3.0.0.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-spatial-anchors-v3.0.0/MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpatialAnchors.3.0.0.unitypackage)

    After you've imported the tutorial assets, your **Project** pane should look similar to this image:

    :::image type="content" source="../../media/install-azure-spatial-anchors.png" alt-text="Screenshot of the Project pane with imported tutorial assets." lightbox="../../media/install-azure-spatial-anchors.png":::

    > [!Note]
    > If you see any CS0618 warnings that say "WorldAnchor.SetNativeSpatialAnchorPtr(IntPtr)" is obsolete, you can ignore them.
    
    > [!Tip]
    > You can refer to these instructions for importing tutorial assets when you need a reminder on how to import a Unity custom package.

