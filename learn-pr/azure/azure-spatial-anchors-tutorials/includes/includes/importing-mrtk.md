# [Unity 2019/2020 + Windows XR Plugin](#tab/winxr)

2. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

:::image type="content" source="../../media/base-02-section4-step1-2-preview.PNG" alt-text="MixedRealityFeatureTool for preview" lightbox="base-02-section4-step1-2-preview.PNG":::

3. Next click on **Start** to get started with Mixed Reality Feature Tool.

:::image type="content" source="../../media/base-02-section4-step1-2.PNG" alt-text="MixedRealityFeatureTool" lightbox="base-02-section4-step1-2.PNG":::


4. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

:::image type="content" source="../../media/base-02-section4-step1-3.PNG" alt-text="Adding Unity Path for MixedRealityFeatureTool" lightbox="base-02-section4-step1-3.PNG":::

5. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**. The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

:::image type="content" source="../../media/base-02-section4-step1-4.PNG" alt-text="MixedRealityFeatureTool Discover Features" lightbox="base-02-section4-step1-4.PNG":::

6. check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**, then click on **Get features** button to download the selected packages.

:::image type="content" source="../../media/base-02-section4-step1-5.PNG" alt-text="MixedRealityFeatureTool Open MixedReality" lightbox="base-02-section4-step1-5.PNG":::

7. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

:::image type="content" source="../../media/base-02-section4-step1-6.PNG" alt-text="MixedRealityFeatureTool Select required package" lightbox="base-02-section4-step1-6.PNG":::

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

:::image type="content" source="../../media/base-02-section4-step1-7.PNG" alt-text="MixedRealityFeatureTool Validate package" lightbox="base-02-section4-step1-7.PNG":::

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

:::image type="content" source="../../media/base-02-section5-step1-1xrsdk.PNG" alt-text="opening MRTK configurator tool" lightbox="base-02-section5-step1-1xrsdk.PNG":::

2. Click on **Built-in Unity Plugin(non-OpenXR)** to Enable XR Plugin Management and add its required packages into your project.

:::image type="content" source="../../media/base-02-section5-step1-2xrsdk.PNG" alt-text="MRTK configurator tool" lightbox="base-02-section5-step1-2xrsdk.PNG":::

> [!NOTE]
> The above screenshot is from Unity 2020, if you using Unity 2019 please select **XR SDK/XR Management**

3. this imports required unity packages for XR Plugin Management, once done click on **Show Settings** in MRTK project Configurator.

:::image type="content" source="../../media/base-02-section5-step1-3xrsdk.PNG" alt-text="Player settings window" lightbox="base-02-section5-step1-3xrsdk.PNG":::

4. This opens **Project Settings window**, In the Project Settings window under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings also Ensure **Initialize XR on Startup** is checked, and check **Windows Mixed Reality** checkbox.

:::image type="content" source="../../media/base-02-section5-step1-4xrsdk.PNG" alt-text="Player settings window Enable Mixed Reality 1" lightbox="base-02-section5-step1-4xrsdk.PNG":::

5. After Unity has finished importing the Windows Mixed Reality SDK, the MRTK Project Configurator window should appear again. If it doesn't, use the Unity menu to open it.

In the MRTK Project Configurator window, click on **next** then use the Audio spatializer dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

:::image type="content" source="../../media/base-02-section5-step1-5xrsdk.PNG" alt-text="Player settings window Enable Mixed Reality 2" lightbox="base-02-section5-step1-5xrsdk.PNG":::

6. Click on **Next** then click on **Done** in the MRTK Project Configurator window to finish the Unity project configuration for XRSDK.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

In the Project Settings window, select **XR Plug-in Management** > **Windows Mixed Reality** > **Runtime Settings**, then use the **Depth Buffer Format** dropdown to select **16-bit depth**:

:::image type="content" source="../../media/base-02-section5-step2-1xrsdk.PNG" alt-text="Unity Enable 16 Depth" lightbox="base-02-section5-step2-1xrsdk.PNG":::

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

:::image type="content" source="../../media/base-02-section5-step2-2.PNG" alt-text="Unity Publishing Settings. Package name configured" lightbox="base-02-section5-step2-2.PNG":::

# [Unity 2020 + OpenXR](#tab/openxr)

2. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

:::image type="content" source="../../media/base-02-section4-step1-2-preview.PNG" alt-text="MixedRealityFeatureTool preview" lightbox="base-02-section4-step1-2-preview.PNG":::

3. next click on **Start** to get started with Mixed Reality Feature Tool.

:::image type="content" source="../../media/base-02-section4-step1-2.PNG" alt-text="MixedRealityFeatureTool" lightbox="base-02-section4-step1-2.PNG":::

4. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

:::image type="content" source="../../media/base-02-section4-step1-3.PNG" alt-text="Adding Unity Path for MixedRealityFeatureTool" lightbox="base-02-section4-step1-3.PNG":::

5. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit and click on **Platform Support** dropdown to find packages relating various supporting platforms.

:::image type="content" source="../../media/base-02-section4-step1-4-openxr.png" alt-text="MixedRealityFeatureTool Discover Features" lightbox="base-02-section4-step1-4-openxr.png":::

6. check the **Mixed Reality Toolkit Foundation** and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**, also check the **Mixed Reality OpenXR Plugin** and click on the dropdown next to it to select most recent version available, then click on **Get features** button to download the selected packages.

:::image type="content" source="../../media/base-02-section4-step1-5-openxr.png" alt-text="MixedRealityFeatureTool Open MixedReality" lightbox="base-02-section4-step1-5-openxr.png":::

7. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

:::image type="content" source="../../media/base-02-section4-step1-6-openxr.png" alt-text="MixedRealityFeatureTool Select required package" lightbox="base-02-section4-step1-6-openxr.png":::

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

:::image type="content" source="../../media/base-02-section4-step1-7.png" alt-text="MixedRealityFeatureTool Validate package" lightbox="base-02-section4-step1-7.png":::

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, a warning message appears to restart the unity editor to enable to backends for new plugin system, click on **Yes**

:::image type="content" source="../../media/base-02-section5-step1-1-openxr.PNG" alt-text="Unity Restart Option" lightbox="base-02-section5-step1-1-openxr.PNG":::

2. Once the Unity restarts MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

:::image type="content" source="../../media/base-02-section5-step1-2-openxr.png" alt-text="Open MRTK project configurator window" lightbox="base-02-section5-step1-2-openxr.png":::

3. Click on **Unity OpenXR Plugin** to Enable XR Plugin Management and add its required packages into your project.

:::image type="content" source="../../media/base-02-section5-step1-3-openxr.png" alt-text="Add Unity OpenXR Plugin" lightbox="base-02-section5-step1-3-openxr.png":::

4. This imports required unity packages for XR Plugin Management, once done click on **Show XR Plug-In Management Settings** in MRTK project Configurator.

:::image type="content" source="../../media/base-02-section5-step1-4-openxr.png" alt-text="Show XR Plug-In Management Settings" lightbox="base-02-section5-step1-4-openxr.png":::

5. This opens **Project Settings window**, In the Project Settings window  under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings also Ensure **Initialize XR on Startup** is checked, then check **Open XR** checkbox and **Microsoft HoloLens feature set** checkbox to enable them.

:::image type="content" source="../../media/base-02-section5-step1-6-openxr.png" alt-text="Project Settings Window 3" lightbox="base-02-section5-step1-6-openxr.png":::

6. If you see a red warning icon next to **OpenXR Plugin**, click the icon and select **Fix all** before continuing. The Unity Editor may need to restart itself for the changes to take effect.

:::image type="content" source="../../media/base-02-section5-step1-7-openxr.png" alt-text="Project Settings Window 4" lightbox="base-02-section5-step1-7-openxr.png":::

7. Once all issues are fixed close the **Project Settings** window.
In the menu bar, navigate to **Mixed Reality**> **OpenXR** > **Apply recommended project settings for HoloLens 2** to get better app performance.

:::image type="content" source="../../media/base-02-section5-step1-8-openxr.png" alt-text="Project Settings Window 5" lightbox="base-02-section5-step1-8-openxr.png":::

8. Use the Unity menu to open MRTK Project Configurator, In the MRTK Project Configurator window, click on **next**, then click the **Apply** button to apply the settings:

:::image type="content" source="../../media/base-02-section5-step1-9-openxr.png" alt-text="Project Settings Window 6" lightbox="base-02-section5-step1-9-openxr.png":::

9. Once you click on Apply, Unity will try to restart for the input system to take into effect, click on **Apply** to restart the Unity editor

:::image type="content" source="../../media/base-02-section5-step1-10-openxr.png" alt-text="Project Settings Window 7" lightbox="base-02-section5-step1-10-openxr.png":::

10. Once the Unity restarts open MRTK Project Configurator from the unity menu and Click on **Next** then click on **Done** finish the Unity project configuration for OpenXR.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **XR Plug-in Management** > **OpenXR**, then use the **Depth Submission Mode** dropdown to select **Depth 16-bit**:

:::image type="content" source="../../media/base-02-section5-step2-1-openxr.png" alt-text="Unity Enable 16 Depth" lightbox="base-02-section5-step2-1-openxr.png":::

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

:::image type="content" source="../../media/base-02-section5-step2-2.png" alt-text="Unity Publishing Settings. Package name configured" lightbox="base-02-section5-step2-2.png":::

# [Legacy WSA](#tab/wsa)

2. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

:::image type="content" source="../../media/base-02-section4-step1-2-preview.PNG" alt-text="MixedRealityFeatureTool preview" lightbox="base-02-section4-step1-2-preview.PNG":::

3. Next click on **Start** to get started with Mixed Reality Feature Tool.

:::image type="content" source="../../media/base-02-section4-step1-2.PNG" alt-text="MixedRealityFeatureTool" lightbox="base-02-section4-step1-2.PNG":::

4. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

:::image type="content" source="../../media/base-02-section4-step1-3.PNG" alt-text="Adding Unity Path for MixedRealityFeatureTool" lightbox="base-02-section4-step1-3.PNG":::

5. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

:::image type="content" source="../../media/base-02-section4-step1-4.PNG" alt-text="MixedRealityFeatureTool Discover Features" lightbox="base-02-section4-step1-4.PNG":::

6. Check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**, then click on **Get features** button to download the selected packages.

:::image type="content" source="../../media/base-02-section4-step1-5.PNG" alt-text="MixedRealityFeatureTool Open MixedReality" lightbox="base-02-section4-step1-5.PNG":::

7. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

:::image type="content" source="../../media/base-02-section4-step1-6.PNG" alt-text="MixedRealityFeatureTool Select required package" lightbox="base-02-section4-step1-6.PNG":::

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

:::image type="content" source="../../media/base-02-section4-step1-7.PNG" alt-text="MixedRealityFeatureTool Validate package" lightbox="base-02-section4-step1-7.PNG":::

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

:::image type="content" source="../../media/base-02-section5-step1-1.PNG" alt-text="Unity Configure Unity Project menu path 1" lightbox="base-02-section5-step1-1.PNG":::

2. Click on **Legacy XR** to enable Legacy XR and to add its required packages  into your project.

:::image type="content" source="../../media/base-02-section5-step1-2.PNG" alt-text="s" lightbox="base-02-section5-step1-2.PNG":::

3. Click on next button to enable XR pipeline settings for Legacy XR.

:::image type="content" source="../../media/base-02-section5-step1-3.PNG" alt-text="Unity Configure Unity Project menu path 2" lightbox="base-02-section5-step1-3.PNG":::

4. In the MRTK Project Configurator window, ensure all options are checked and also use the **Audio spatializer** dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

:::image type="content" source="../../media/base-02-section5-step1-4.PNG" alt-text="MRTK configuration window" lightbox="base-02-section5-step1-4.PNG":::

5. Click on **Next** then click on**Done** button in MRTK Project Configurator window to finish the Unity project configuration for Legacy XR.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **Player** > **XR Settings**, then use the **Depth Format** dropdown to select **16-bit depth**:

:::image type="content" source="../../media/base-02-section5-step2-1.PNG" alt-text="Unity Enable 16 Depth" lightbox="base-02-section5-step2-1.PNG":::

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

:::image type="content" source="../../media/base-02-section5-step2-2.PNG" alt-text="Unity Publishing Settings. Package name configured" lightbox="base-02-section5-step2-2.PNG":::

