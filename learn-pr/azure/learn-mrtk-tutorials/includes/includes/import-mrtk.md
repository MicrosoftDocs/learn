## [Unity 2020 + Openxr](#tab/openxr)

1. In the Mixed Reality Feature Tool, select **Start**.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of the Mixed Reality Feature Tool opening screen."

1. Select the Browse button (it's the "three-dot" button in the image below), then navigate to your project, and then open it.

    :::image type="content" source="../images/002-open-your-project.png" alt-text="Open your project":::
     
    > [!NOTE]
    > The **Project Path** box in the Tool must contain some value, so it inserts a backslash ("\_") by default.

    After you select a folder, the Tool checks to ensure that it's a valid Unity project folder.

    :::image type="content" source="../../media/007-project path.png" alt-text="Screenshot of the Mixed Reality feature Tool Project Path screen."
  
 1. Select **Discover Features**.

    **Note**: You may need to wait a few seconds while the Tool refreshes the packages from the feeds.

1. On the **Discover Features** page, note that there is a list of six package groups.

    :::image type="content" source="../images/003-mrft-groups.png" alt-text="The main groups of packages in the Mixed Reality Feature Tool":::

1. Click the "+" button to the left of **Mixed Reality Toolkit (0 of 10)** and then select the latest version of **Mixed Reality Toolkit Foundation**.
1. Click the "+" button to the left of **Platform Support (0 of 5)** and then select the latest version of **Mixed Reality OpenXR Plugin**.
 
     :::image type="content" source="../../008-package-selections.png" alt-text="Screenshot of package selections in the Mixed Reality Feature Tool."

1. After you've made your selection(s), click **Get Features**.
1. Select **Validate** to validate the packages you selected. You should see a dialog that says **No validation issues were detected**. When you do, click **OK**.
1. On the **Import Features** page, the left-side column, **Features**, displays the packages you just selected. The right-side column, **Required dependencies**, displays any dependencies. You can click the **Details** link for any of these items to learn more about them.
1. When you're ready to move on, select **Import.** On the **Review and Approve** page, you can review information about the packages.
1. Select **Approve.** The Tool displays a message that says your project has been updated.
1. Return to the Unity Editor and click a blank area in the UI. You'll see a message telling you that your packages are being imported.
 
## Configure the Unity project

1. After Unity has imported the package, select **Yes** to restart the Unity editor to enable to backends for new plugin.

    :::image type="content" source="../../media/unity-restart-option.png" alt-text="Screenshot of Unity Restart Option." lightbox="../../media/unity-restart-option.png":::

1. The MRTK Project Configurator should appear. If it doesn't, manually open it by selecting **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/mrtk-project-configurator-window.png" alt-text="Screenshot of Open MRTK project configurator window." lightbox="../../media/mrtk-project-configurator-window.png":::
    
1. Select **Unity OpenXR Plugin** to enable XR Plugin Management and add its required packages to your project.

    :::image type="content" source="../../media/open-xr-plug-in.png" alt-text="Screenshot of Add Unity OpenXR Plugin." lightbox="../../media/open-xr-plug-in.png":::

1. When the required Unity packages for XR Plugin Management have been imported, select **Show XR Plug-In Management Settings** in MRTK project Configurator.

    :::image type="content" source="../../media/xr-plug-in-management-settings.png" alt-text="Screenshot of Show XR Plug-In Management Settings." lightbox="../../media/xr-plug-in-management-settings.png":::

1. **Project Settings** opens. Under **XR Plug-in Management**, ensure that Universal Windows Platform settings (Windows logo tab) is active, and then ensure **Initialize XR on Startup**, **Open XR**, and **Microsoft HoloLens feature group** are all enabled (checkboxes are checked).

    :::image type="content" source="../../media/project-settings-window-3.png" alt-text="Screenshot of Project Settings Window 3." lightbox="../../media/project-settings-window-3.png":::

1. On the **MRTK Project Configurator** update message, select **Apply Settings**.

1. To validate OpenXR configuration, under **XR Plug-in Management** select **OpenXR** and verify the following items are checked:

    * Depth Submission Mode: **Depth 16 Bit**
    * Interaction Profiles: **Microsoft Hand Interaction Profile**

    :::image type="content" source="../../media/project-settings-window-4.png" alt-text="Screenshot of Project Settings Window 4." lightbox="../../media/project-settings-window-4.png":::

    > [!TIP]
    > Reducing the Depth Format to 16-bit is optional, but it may improve graphics performance in your project. To learn more about this topic, refer to  [Depth buffer sharing (HoloLens)](/windows/mixed-reality/mrtk-unity/performance/perf-getting-started#single-pass-instanced-rendering).

1. In the **MRTK Project Configurator** window, select **Next**, and then select **Apply**. (You can manually open the configurator from **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**)

    :::image type="content" source="../../media/mrtk-project-configurator.png" alt-text="Screenshot of MRTK Project Configurator." lightbox="../../media/mrtk-project-configurator.png":::

1. Unity must restart in order for the configuration to take effect. When prompted, select **Apply** to restart the Unity editor.

    :::image type="content" source="../../media/mrtk-project-configurator-2.png" alt-text="Screenshot of MRTK Project Configurator 2." lightbox="../../media/mrtk-project-configurator-2.png":::

1. When Unity restarts, from the Unity menu, open **MRTK Project Configurator**, and then select **Next** and **Done** to complete the configuration for OpenXR.

## Configure project settings for OpenXR


1. In the Unity menu, select **Edit** > **Project Settings...** to open **Project Settings**.

1. In **Project Settings**, select **Player** > **Publishing Settings**, and then in the **Package name** field, enter a suitable name; for example, _MRTKTutorials-GettingStarted_:

    :::image type="content" source="../../media/package-name-configured.png" alt-text="Screenshot of Unity Publishing Settings with package name configured." lightbox="../../media/package-name-configured.png":::

    > [!NOTE]
    > 'Package name' is the unique identifier for the app. You should change this identifier before deploying the app to avoid overwriting previously installed apps.

    > [!TIP]
    > 'Product Name' is the name displayed in the HoloLens Start menu. To make the app easier to locate during development, add an underscore in front of the name to sort it to the top of any list.

## [Unity 2019/2020 + windows xr plugin](#tab/winxr)

1. Once **MixedRealityFeatureTool** is opened, select **Settings**, and in the **Feature** tab, enable **Show preview releases**.
 
1. Select **OK** to save the settings.

    :::image type="content" source="../../media/mixed-reality-feature-tool-preview.png" alt-text="Screenshot of MixedRealityFeatureTool for preview." lightbox="../../media/mixed-reality-feature-tool-preview.png":::

1. Select **Start** to launch the Mixed Reality Feature Tool.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of MixedRealityFeatureTool." lightbox="../../media/mixed-reality-feature-tool.png":::

1. In **Mixed Reality Feature Tool**, next to **Project path**, select the **ellipsis** icon and browse to your project folder; for example, _D:\MixedRealityLearning\MRTK Tutorials_.

    :::image type="content" source="../../media/path.png" alt-text="Screenshot of Adding Unity Path for MixedRealityFeatureTool." lightbox="../../media/path.png":::

1. When you have located your project folder, select **Open**.

    > [!NOTE]
    > When browsing for the Unity project folder, by default, the dialog contains a backslash '\_' for the file name. You must provide a value in this field in order to select the folder.

    The **Mixed Reality Feature Tool** performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages, and Project Settings folders. 

1. In the Mixed Reality Feature Tool, select **Discover Features**. Features are grouped by category. 
 
1. Select **Mixed Reality Toolkit** to find packages relating to the Mixed Reality Toolkit.

    :::image type="content" source="../../media/discover-feature.png" alt-text="Screenshot of MixedRealityFeatureTool Discover Features." lightbox="../../media/discover-feature.png":::

1. Ensure **Mixed Reality Toolkit Foundation** is checked, and then in that field, select **MRTK 2.7.0**.
 
1. Select **Get features** to download the selected packages.

    :::image type="content" source="../../media/open-mixed-reality.png" alt-text="Screenshot of MixedRealityFeatureTool Open MixedReality." lightbox="../../media/open-mixed-reality.png":::

1. Select **Validate** to validate the selected package. The system should display **No validation issues were detected**. 
 
1. Select **OK** to close the dialog box, and then select **Import**.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text="Screenshot of MixedRealityFeatureTool Select required package." lightbox="../../media/select-required-package-validate.png":::

1. When prompted, select **Approve** to add the **Mixed Reality Toolkit** to your project.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text="Screenshot of MixedRealityFeatureTool Validate package." lightbox="../../media/select-required-package-validate.png":::

## Configure the Unity project

1. When the package has been imported, **MRTK Project Configurator** appears. If it doesn't, you can manually open it from **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**.

    :::image type="content" source="../../media/mrtk-configurator-tool.png" alt-text="Screenshot of opening MRTK configurator tool." lightbox="../../media/mrtk-configurator-tool.png":::

1. Select **Built-in Unity Plugin(non-OpenXR)** to enable XR Plugin Management in your project.

    :::image type="content" source="../../media/mrtk-configurator-tool-plugin.png" alt-text="Screenshot of MRTK configurator tool." lightbox="../../media/mrtk-configurator-tool-plugin.png":::

    > [!IMPORTANT]
    > The above screenshot is from Unity 2020. If you're using Unity 2019, please select **XR SDK/XR Management**.

1. When the import is complete, in **MRTK project Configurator**, select **Show Settings**.

    :::image type="content" source="../../media/player-set-window.png" alt-text="Screenshot of Player settings window." lightbox="../../media/player-set-window.png":::

1. In **Project Settings**, under **XR Plug-in Management**, ensure that you are in **Universal Windows Platform** settings, and that both **Initialize XR on Startup** and **Windows Mixed Reality** are checked.

    :::image type="content" source="../../media/window-enable-mixed-reality-1.png" alt-text= "Screenshot of Player settings for Enable Mixed Reality." lightbox="../../media/window-enable-mixed-reality-1.png":::

1. When Unity has imported the Windows Mixed Reality SDK, **MRTK Project Configurator** should appear again. If it doesn't, use the Unity menu to open it.

1. In **MRTK Project Configurator**, select **Next**, and then in **Audio spatializer** dropdown list, select **MS HRTF Spatializer**.
    
 1. Select  **Apply**.

    :::image type="content" source="../../media/set-window-enable-mixed-reality-2.png" alt-text= "Screenshot of Player settings window Enable Mixed Reality 2." lightbox="../../media/set-window-enable-mixed-reality-2.png":::

1. In **MRTK Project Configurator**, select **Next**, and then select **Done** to complete the configuration for XRSDK.

## Configure project settings for XR SDK

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

1. In the Project Settings window, select **XR Plug-in Management** > **Windows Mixed Reality** > **Runtime Settings**, and then in the **Depth Buffer Format** dropdown list, select **16-bit depth**:

    :::image type="content" source="../../media/enable-16-depth.png" alt-text= "Screenshot of Unity Enable 16 Depth." lightbox="../../media/enable-16-depth.png":::

1. In the Project Settings window, select **Player** > **Publishing Settings**, and then, in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_.

    :::image type="content" source="../../media/package-name-configured.png" alt-text= "Screenshot of Unity Publishing Settings with Package name configured." lightbox="../../media/package-name-configured.png":::

## [Legacy wsa](#tab/wsa)

1. In the **MixedRealityFeatureTool** select **Settings**, under **Feature** tab, enable **Show preview releases**, and then select **OK** to save your settings.

    :::image type="content" source="../../media/mixed-reality-feature-tool-preview.png" alt-text= "Screenshot of MixedRealityFeatureTool preview." lightbox="../../media/mixed-reality-feature-tool-preview.png":::

1. Select **Start** to launch the **Mixed Reality Feature Tool**.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text= "Screenshot of MixedRealityFeatureTool." lightbox="../../media/mixed-reality-feature-tool.png":::

1. In **Mixed Reality Feature Tool**, under **Project path**, select the **ellipsis** icon, and browse to your project folder; for example, _D:\MixedRealityLearning\MRTK Tutorials_.

    :::image type="content" source="../../media/path.png" alt-text= "Screenshot of Adding Unity Path for MixedRealityFeatureTool." lightbox="../../media/path.png":::

1. Select **Open**. 
  
    > [!NOTE]
    > When browsing for the Unity project folder, by default, the dialog contains a backslash '\_' for the file name. You must provide a value in this field in order to select the folder.

    The **Mixed Reality Feature Tool** performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages, and Project Settings folders. 

1. In the Mixed Reality Feature Tool, select **Discover Features**. Features are grouped by category.
    
 1. Select the **Mixed Reality Toolkit** to find packages relating to the Mixed Reality Toolkit.

    :::image type="content" source="../../media/discover-feature.png" alt-text= "Screenshot of MixedRealityFeatureTool Discover Features." lightbox="../../media/discover-feature.png":::

1. Ensure **Mixed Reality Toolkit Foundation** is checked, and in the dropdown list, select **MRTK 2.7.0**.
 
1. Select **Get features** to download the selected packages.

    :::image type="content" source="../../media/open-mixed-reality.png" alt-text= "Screenshot of MixedRealityFeatureTool Open MixedReality." lightbox="../../media/open-mixed-reality.png":::

1. Select **Validate** to validate the selected package. The system should return **No validation issues were detected**. 

1.  Select **OK** to close the dialog, and then select **Import**.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text= "Screenshot of MixedRealityFeatureTool Select required package." lightbox="../../media/select-required-package-validate.png":::

1. Select **Approve** to add the **Mixed Reality Toolkit** into the project.

    :::image type="content" source="../../media/select-required-package-validate.png" alt-text= "Screenshot of MixedRealityFeatureTool Validate package." lightbox="../../media/select-required-package-validate.png":::

## Configure the Unity project

1. After Unity has finished importing the package, **MRTK Project Configurator** should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/configure-unity-project-menu-path-1.png" alt-text= "Screenshot of Configure Unity Project menu path for MRTK." lightbox="../../media/configure-unity-project-menu-path-1.png":::

1. Select **Legacy XR** to enable it and add its required packages to your project.

    :::image type="content" source="../../media/legacy-xr.png" alt-text= "Screenshot of Select Legacy XR for the project." lightbox="../../media/legacy-xr.png":::

1. Select **Next** to enable XR pipeline settings.

    :::image type="content" source="../../media/project-menu-path-2.png" alt-text= "Screenshot of Unity Configure Unity Project menu path for XR pipeline." lightbox="../../media/project-menu-path-2.png":::

1. In **MRTK Project Configurator**, ensure all options are checked.
 
1. In **Audio spatializer**, select **MS HRTF Spatializer**, and then select **Apply**:

    :::image type="content" source="../../media/mrtk-configuration-window.png" alt-text= "Screenshot of MRTK MS HRTF configuration." lightbox="../../media/mrtk-configuration-window.png":::

1. Select **Next**, and then select **Done** to complete project configuration.

## Configure project settings for XR

1. In the Unity menu, select **Edit** > **Project Settings...** to open Project Settings.

1. In **Project Settings**, select **Player** > **XR Settings**, and then in the **Depth Format** dropdown list, select **16-bit depth**.

    :::image type="content" source="../../media/unity-enable-16-depth.png" alt-text= "Screenshot of Unity Enable 16 Depth." lightbox="../../media/unity-enable-16-depth.png":::

1. In **Project Settings**, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name; for example, _MRTKTutorials-GettingStarted_:

    :::image type="content" source="../../media/package-name-configured.png" alt-text= "Screenshot of Unity Publishing Settings with Package name configured." lightbox="../../media/package-name-configured.png":::
