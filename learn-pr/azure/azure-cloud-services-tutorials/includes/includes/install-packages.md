## [Unity 2020 + OpenXR](#tab/openxr)

* In the Unity menu, select **Window** > **Package Manager** to open the Package Manager window, then verify that **AR Foundation** > **4.1.7** version is installed.

    :::image type="content" source="../../media/ar-foundation-open-xr.png" alt-text="Screenshot of Unity Package Manager with AR Foundation selected." lightbox="../../media/ar-foundation-open-xr.png":::

    > [!NOTE]
    > You are installing the AR Foundation package because the Azure Spatial Anchors SDK requires it, which you will import in the next section.

### Importing the tutorial assets

1) Add AzurespatialAnchors SDK V2.10 to your project, to add the packages please follow this [tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage)

2) Download and **import** the following Unity custom packages **in the order they are listed**:

    * [AzureStorageForUnity.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/AzureStorageForUnity.unitypackage)
    * [MRTK.Tutorials.AzureCloudServices.XRPlugginManagement.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/MRTK.Tutorials.AzureCloudServices.XRPlugginManagement.unitypackage)

    After you have imported the tutorial assets your Project window should look similar to this:

    :::image type="content" source="../../media/after-import-open-xr.png" alt-text="Screenshot of Unity Hierarchy, Scene, and Project windows after importing the tutorial assets." lightbox="../../media/after-import-open-xr.png":::

## [Unity 2020 + Windows XR Plugin](#tab/winxr)

* In the Unity menu, select **Window** > **Package Manager** to open the Package Manager window, then select **AR Foundation > 4.0.12** version and click the **Install** button to install the package:

    :::image type="content" source="../../media/ar-foundation-xr-sdk.png" alt-text="Screenshot of Unity Package Manager with AR Foundation selected." lightbox="../../media/ar-foundation-xr-sdk.png":::

    > [!NOTE]
    > You are installing the AR Foundation package because the Azure Spatial Anchors SDK requires it, which you will import in the next section.

### Importing the tutorial assets

1) Add AzurespatialAnchors SDK V2.10 to your project, to add the packages please follow this [tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage)

2) Download and **import** the following Unity custom packages **in the order they are listed**:

    * [AzureStorageForUnity.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/AzureStorageForUnity.unitypackage)
    * [MRTK.Tutorials.AzureCloudServices.XRPlugginManagement.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/MRTK.Tutorials.AzureCloudServices.XRPlugginManagement.unitypackage)

    After you have imported the tutorial assets your Project window should look similar to this:

    :::image type="content" source="../../media/after-import-xr-sdk.png" alt-text="Screenshot of Unity Hierarchy, Scene, and Project windows after importing the tutorial assets." lightbox="../../media/after-import-xr-sdk.png":::

## [Legacy WSA](#tab/wsa)

* In the Unity menu, select **Window** > **Package Manager** to open the Package Manager window, then select **AR Foundation > 3.1.3** version and click the **Install** button to install the package:

    :::image type="content" source="../../media/ar-foundation-legacy-xr.png" alt-text="Screenshot of Unity Package Manager with AR Foundation selected." lightbox="../../media/ar-foundation-legacy-xr.png":::

    > [!NOTE]
    > You are installing the AR Foundation package because the Azure Spatial Anchors SDK requires it, which you will import in the next section.

### Importing the tutorial assets

1) Add AzurespatialAnchors SDK V2.7.2 to your project, to add the packages please follow this [tutorial](/azure/spatial-anchors/how-tos/setup-unity-project?tabs=UPMPackage)

2) Download and **import** the following Unity custom packages **in the order they are listed**:

    * [AzureStorageForUnity.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/AzureStorageForUnity.unitypackage)
    * [MRTK.Tutorials.AzureCloudServices.LegacyWSA.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/MRTK.Tutorials.AzureCloudServices.LegacyWSA.unitypackage)

    After you have imported the tutorial assets your Project window should look similar to this:

    :::image type="content" source="../../media/after-import-legacy-xr.png" alt-text="Screenshot of Unity Hierarchy, Scene, and Project windows after importing the tutorial assets." lightbox="../../media/after-import-legacy-xr.png":::

    > [!NOTE]
    > If you see any CS0618 warnings regarding 'WorldAnchor.SetNativeSpatialAnchorPtr(IntPtr)' and 'WorldAnchor.GetNativeSpatialAnchorPtr()' being obsolete, you can ignore these warnings.
