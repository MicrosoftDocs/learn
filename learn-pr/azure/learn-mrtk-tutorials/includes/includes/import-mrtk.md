## [Unity 2020 + Openxr](#tab/openxr)

1. Once **MixedRealityFeatureTool** is opened, click on **Start** to get started with Mixed Reality Feature Tool.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of MixedRealityFeatureTool." lightbox="../../media/mixed-reality-feature-tool.png":::

2. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    :::image type="content" source="../../media/path.png" alt-text="Screenshot of Adding Unity Path for MixedRealityFeatureTool." lightbox="../../media/path.png":::

3. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.
    > [!IMPORTANT]
    > The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

    Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit and click on **Platform Support** dropdown to find packages relating various supporting platforms.

    :::image type="content" source="../../media/discover-features.png" alt-text="Screenshot of MixedRealityFeatureTool Discover Features." lightbox="../../media/discover-features.png":::

4. check the **Mixed Reality Toolkit Foundation** and click on the dropdown next to it to select **MRTK 2.7.0**, also check the **Mixed Reality OpenXR Plugin** and click on the dropdown next to it to select most recent version available, then click on **Get features** button to download the selected packages.

    :::image type="content" source="../../media/mixed-reality-feature-tool-open-mixed-reality.png" alt-text="Screenshot of MixedRealityFeatureTool Open MixedReality." lightbox="../../media/mixed-reality-feature-tool-open-mixed-reality.png":::
5. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    :::image type="content" source="../../media/select-required-package.png" alt-text="Screenshot of MixedRealityFeatureTool Select required package." lightbox="../../media/select-required-package.png":::

6. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    :::image type="content" source="../../media/validate-package.png" alt-text="Screenshot of MixedRealityFeatureTool Validate package." lightbox="../../media/validate-package.png":::

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, a warning message appears to restart the unity editor to enable to backends for new plugin system, click on **Yes**

    :::image type="content" source="../../media/unity-restart-option.png" alt-text="Screenshot of Unity Restart Option." lightbox="../../media/unity-restart-option.png":::

2. Once the Unity restarts MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/mrtk-project-configurator-window.png" alt-text="Screenshot of Open MRTK project configurator window." lightbox="../../media/mrtk-project-configurator-window.png":::
3. Click on **Unity OpenXR Plugin** to Enable XR Plugin Management and add its required packages into your project.

    :::image type="content" source="../../media/open-xr-plug-in.png" alt-text="Screenshot of Add Unity OpenXR Plugin." lightbox="../../media/open-xr-plug-in.png":::

4. This imports required unity packages for XR Plugin Management, once done click on **Show XR Plug-In Management Settings** in MRTK project Configurator.

    :::image type="content" source="../../media/xr-plug-in-management-settings.png" alt-text="Screenshot of Show XR Plug-In Management Settings." lightbox="../../media/xr-plug-in-management-settings.png":::

5. This opens **Project Settings window**, In the Project Settings window  under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings(Windows logo tab). Also Ensure **Initialize XR on Startup** is checked, then check **Open XR** checkbox and **Microsoft HoloLens feature set** checkbox to enable them.

    :::image type="content" source="../../media/project-settings-window-3.png" alt-text="Screenshot of Project Settings Window 3." lightbox="../../media/project-settings-window-3.png":::

6. Once you check OpenXR checkbox, MRTK Project Configurator window will show
updated message with **Apply Settings** button. Click **Apply Settings** button.

7. To validate OpenXR configuration, click **OpenXR** under **XR Plug-in Management** and check these items:

    * Depth Submission Mode: **Depth 16 Bit**
    * Interaction Profiles: **Microsoft Hand Interaction Profile**

    :::image type="content" source="../../media/project-settings-window-4.png" alt-text="Screenshot of Project Settings Window 4." lightbox="../../media/project-settings-window-3.png":::

    > [!TIP]
    > Reducing the Depth Format to 16-bit is optional but may help improve graphics performance in your project. To learn more about this topic, you can refer to the [Depth buffer sharing (HoloLens)](/windows/mixed-reality/mrtk-unity/performance/perf-getting-started#single-pass-instanced-rendering) section of MRTK's Performance documentation.

8. In the **MRTK Project Configurator** window, click on **Next**, then click the **Apply** button to apply the settings. (You can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**)

    :::image type="content" source="../../media/mrtk-project-configurator.png" alt-text="Screenshot of MRTK Project Configurator." lightbox="../../media/mrtk-project-configurator.png":::

9. Once you click on Apply, Unity will try to restart for the input system to take into
effect, click on **Apply** to restart the Unity editor

    :::image type="content" source="../../media/mrtk-project-configurator-2.png" alt-text="Screenshot of MRTK Project Configurator 2." lightbox="../../media/mrtk-project-configurator-2.png":::

10. Once the Unity restarts open MRTK Project Configurator from the unity menu and Click on **Next** then click on **Done** finish the Unity project configuration for OpenXR.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window.

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    :::image type="content" source="../../media/package-name-configured.png" alt-text="Screenshot of Unity Publishing Settings. Package name configured." lightbox="../../media/package-name-configured.png":::

    > [!NOTE]
    > The 'Package name' is the unique identifier for the app. You should change this identifier before deploying the app to avoid overwriting previously installed apps.
    > [!TIP]
    > The 'Product Name' is the name displayed in the HoloLens Start menu. To make the app easier to locate during development, add an underscore in front of the name to sort it to the top.

## [Unity 2019/2020 + windows xr plugin](#tab/winxr)

1. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

    :::image type="content" source="../../media/mixed-reality-feature-tool-preview.png" alt-text="Screenshot of MixedRealityFeatureTool for preview." lightbox="../../media/mixed-reality-feature-tool-preview.png":::

2. Next click on **Start** to get started with Mixed Reality Feature Tool.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of MixedRealityFeatureTool." lightbox="../../media/mixed-reality-feature-tool.png":::

3. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    :::image type="content" source="../../media/path.png" alt-text="Screenshot of Adding Unity Path for MixedRealityFeatureTool." lightbox="../../media/path.png":::

4. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**. The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

5. Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

    :::image type="content" source="../../media/discover-feature.png" alt-text="Screenshot of MixedRealityFeatureTool Discover Features." lightbox="../../media/discover-feature.png":::

6. check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0**, then click on **Get features** button to download the selected packages.

    :::image type="content" source="../../media/open-mixed-reality.png" alt-text="Screenshot of MixedRealityFeatureTool Open MixedReality." lightbox="../../media/open-mixed-reality.png":::

7. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text="Screenshot of MixedRealityFeatureTool Select required package." lightbox="../../media/select-required-package-validate.png":::

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text="Screenshot of MixedRealityFeatureTool Validate package." lightbox="../../media/select-required-package-validate.png":::

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/mrtk-configurator-tool.png" alt-text="Screenshot of opening MRTK configurator tool." lightbox="../../media/mrtk-configurator-tool.png":::

2. Click on **Built-in Unity Plugin(non-OpenXR)** to Enable XR Plugin Management and add its required packages into your project.

    :::image type="content" source="../../media/mrtk-configurator-tool-plugin.png" alt-text="Screenshot of MRTK configurator tool." lightbox="../../media/mrtk-configurator-tool-plugin.png":::

    > [!NOTE]
    > The above screenshot is from Unity 2020, if you using Unity 2019 please select **XR SDK/XR Management**

3. this imports required unity packages for XR Plugin Management, once done click on **Show Settings** in MRTK project Configurator.

    :::image type="content" source="../../media/player-set-window.png" alt-text="Screenshot of Player settings window." lightbox="../../media/player-set-window.png":::

4. This opens **Project Settings window**, In the Project Settings window under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings also Ensure **Initialize XR on Startup** is checked, and check **Windows Mixed Reality** checkbox.

    :::image type="content" source="../../media/window-enable-mixed-reality-1.png" alt-text= "Screenshot of Player settings window Enable Mixed Reality 1." lightbox="../../media/window-enable-mixed-reality-1.png":::

5. After Unity has finished importing the Windows Mixed Reality SDK, the MRTK Project Configurator window should appear again. If it doesn't, use the Unity menu to open it.

    In the MRTK Project Configurator window, click on **next** then use the Audio spatializer dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

    :::image type="content" source="../../media/set-window-enable-mixed-reality-2.png" alt-text= "Screenshot of Player settings window Enable Mixed Reality 2." lightbox="../../media/set-window-enable-mixed-reality-2.png":::

6. Click on **Next** then click on **Done** in the MRTK Project Configurator window to finish the Unity project configuration for XRSDK.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

    In the Project Settings window, select **XR Plug-in Management** > **Windows Mixed Reality** > **Runtime Settings**, then use the **Depth Buffer Format** dropdown to select **16-bit depth**:

    :::image type="content" source="../../media/enable-16-depth.png" alt-text= "Screenshot of Unity Enable 16 Depth." lightbox="../../media/enable-16-depth.png":::

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    :::image type="content" source="../../media/package-name-configured.png" alt-text= "Screenshot of Unity Publishing Settings. Package name configured." lightbox="../../media/package-name-configured.png":::

## [Legacy wsa](#tab/wsa)

1. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

    :::image type="content" source="../../media/mixed-reality-feature-tool-preview.png" alt-text= "Screenshot of MixedRealityFeatureTool preview." lightbox="../../media/mixed-reality-feature-tool-preview.png":::

2. Next click on **Start** to get started with Mixed Reality Feature Tool.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text= "Screenshot of MixedRealityFeatureTool." lightbox="../../media/mixed-reality-feature-tool.png":::

3. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    :::image type="content" source="../../media/path.png" alt-text= "Screenshot of Adding Unity Path for MixedRealityFeatureTool." lightbox="../../media/path.png":::

4. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

    Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

    :::image type="content" source="../../media/discover-feature.png" alt-text= "Screenshot of MixedRealityFeatureTool Discover Features." lightbox="../../media/discover-feature.png":::

5. Check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0**, then click on **Get features** button to download the selected packages.

    :::image type="content" source="../../media/open-mixed-reality.png" alt-text= "Screenshot of MixedRealityFeatureTool Open MixedReality." lightbox="../../media/open-mixed-reality.png":::

6. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text= "Screenshot of MixedRealityFeatureTool Select required package." lightbox="../../media/select-required-package-validate.png":::

7. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text= "Screenshot of MixedRealityFeatureTool Validate package." lightbox="../../media/select-required-package-validate.png":::

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/configure-unity-project-menu-path-1.png" alt-text= "Screenshot of Unity Configure Unity Project menu path 1." lightbox="../../media/configure-unity-project-menu-path-1.png":::

2. Click on **Legacy XR** to enable Legacy XR and to add its required packages  into your project.

    :::image type="content" source="../../media/legacy-xr.png" alt-text= "Screenshot of Select Legacy XR for the Project." lightbox="../../media/legacy-xr.png":::

3. Click on next button to enable XR pipeline settings for Legacy XR.

    :::image type="content" source="../../media/project-menu-path-2.png" alt-text= "Screenshot of Unity Configure Unity Project menu path 2." lightbox="../../media/project-menu-path-2.png":::

4. In the MRTK Project Configurator window, ensure all options are checked and also use the **Audio spatializer** dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

    :::image type="content" source="../../media/mrtk-configuration-window.png" alt-text= "Screenshot of MRTK configuration window." lightbox="../../media/mrtk-configuration-window.png":::

5. Click on **Next** then click on**Done** button in MRTK Project Configurator window to finish the Unity project configuration for Legacy XR.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **Player** > **XR Settings**, then use the **Depth Format** dropdown to select **16-bit depth**:

    :::image type="content" source="../../media/unity-enable-16-depth.png" alt-text= "Screenshot of Unity Enable 16 Depth." lightbox="../../media/unity-enable-16-depth.png":::

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    :::image type="content" source="../../media/package-name-configured.png" alt-text= "Screenshot of Unity Publishing Settings. Package name configured." lightbox="../../media/package-name-configured.png":::
