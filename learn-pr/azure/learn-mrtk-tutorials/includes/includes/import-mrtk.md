## [Unity 2020 + Openxr](#tab/openxr)

1. In the Mixed Reality Feature Tool, select **Start**.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of the Mixed Reality Feature Tool opening screen.":::

1. Select the Browse button (it's the "three-dot" button in the image below), then navigate to your project, and then open it.

    :::image type="content" source="../../media/002-open-your-project.png" alt-text="Open your project":::
     
    > [!NOTE]
    > The **Project Path** box in the Tool must contain some value, so it inserts a backslash ("\_") by default.

    After you select a folder, the Tool checks to ensure that it's a valid Unity project folder.

    :::image type="content" source="../../media/007-project-path.png" alt-text="Screenshot of the Mixed Reality feature Tool Project Path screen.":::
  
1. Select **Discover Features**.

    **Note**: You may need to wait a few seconds while the Tool refreshes the packages from the feeds.

1. On the **Discover Features** page, note that there is a list of available package groups.

    :::image type="content" source="../../media/003-mrft-groups.png" alt-text="The main groups of packages in the Mixed Reality Feature Tool":::

1. Click the "+" button to the left of **Mixed Reality Toolkit (0 of 10)** and then select the latest version of **Mixed Reality Toolkit Foundation**.

    > [!NOTE]
    > The Mixed Reality Toolkit Foundation package is the only package that must be imported and configured in order to use MRTK with your project. This package includes the core components required to create a mixed reality application.

1. Click the "+" button to the left of **Platform Support (0 of 5)** and then select the latest version of **Mixed Reality OpenXR Plugin**.
 
     :::image type="content" source="../../media/008-package-selections.png" alt-text="Screenshot of package selections in the Mixed Reality Feature Tool.":::

1. After you've made your selection(s), click **Get Features**.
1. Select **Validate** to validate the packages you selected. You should see a dialog that says **No validation issues were detected**. When you do, click **OK**.
1. On the **Import Features** page, the left-side column, **Features**, displays the packages you just selected. The right-side column, **Required dependencies**, displays any dependencies. You can click the **Details** link for any of these items to learn more about them.
1. When you're ready to move on, select **Import.** On the **Review and Approve** page, you can review information about the packages.
1. Select **Approve.**
1. Return to the Unity Editor and click a blank area in the UI. You'll see a progress bar showing you that your packages are being imported.
 
## Configure the Unity project

1. After Unity has imported the packages, a warning appears asking if you want to enable the backends by restarting the editor. Select **Yes**.

    :::image type="content" source="../../media/unity-restart-option.png" alt-text="Screenshot of Unity Restart Option.":::

1. The MRTK Project Configurator should appear. If it doesn't, open it manually: on the menu bar, select **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    :::image type="content" source="../../media/009-open-mrtk-configurator.png" alt-text="Screenshot of the menu bar command for opening the MRTK Configurator.":::
    
1. Select **Unity OpenXR Plugin** to enable XR Plugin Management and add the Unity OpenXR Plugin to your project.

    :::image type="content" source="../../media/010-configurator-select-openxr.png" alt-text="Screenshot of MRTK project configurator window with OpenXR selected.":::

1. On the **Welcome to MRTK!** screen, select **Show XR Plug-In Management Settings**.

    :::image type="content" source="../../media/011-show-xr-plugin-management.png" alt-text="Screenshot of the Show XR Plug-In Management Settings button.":::

1. The **Project Settings** window opens. Ensure that you're on the **XR Plug-in Management** page with the Universal Windows Platform settings (Windows logo tab) displayed.

    :::image type="content" source="../../media/012-xr-plugin-mgmt-page.png" alt-text="Screenshot of the Project Settings Window open to the XR Plugin Management Page and Universal Windows Platform tab.":::

 1. Ensure that **Initialize XR on Startup** is selected, and then, under **Plugin Providers**, click **Open XR**.

    :::image type="content" source="../../media/013-init-xr-on-startup.png" alt-text="Screenshot of Project Settings Window 3.":::

1. The OpenXR Plugin loads, and then two items appear underneath **OpenXR**. Select the first one, **Microsoft HoloLens feature group**.
1. Close the **Project Settings** window.
1. In the **MRTK Project Configurator** window, select **Apply Settings**.

    :::image type="content" source="../../media/022-configurator-apply-settings.png" alt-text="Screenshot of MRTK Project Configurator with the Apply Settings button.":::

1. In the **Project Validation** window that appears, make sure you're on the UWP platform tab (the tab displays the Windows logo), and then click **Fix all** to resolve the validation issues. Note that there may be issues that remain after you click **Fix All**. In that case, click **Fix All** again, ignore any issues that are marked **Scene specific**, and then read the recommendations for the remaining issues (if any) and make any changes you want.
2. In the **MRTK Configurator**, click **Next**, and then click **Apply** to apply the recommended settings.
3. Click**Next**, and then click **Import TMP Essentials**.
4. When the **MRTK Setup Completed!** panel appears, click **Done**.

## Configure project settings for OpenXR

1. After Unity restarts, in the menu bar, select **Edit** > **Project Settings...**.

1. In the **Project Settings** window's left-side column, select **Player**.
1. Note that in the **Player** window, the **Product Name** is "MRTK Tutorial." This is taken from your project name and will be the name displayed in the HoloLens Start menu.

    :::image type="content" source="../../media/025-product-name.png" alt-text="Screenshot of Unity Publishing Settings with the Project Name box filled in.":::

    > [!TIP]
    > To make the app easier to locate during development, add an underscore in front of the name to sort it to the top of any list.

1. Click the **Publishing Settings** drop down, and then in the **Package name** field, enter a suitable name--for example, _MRTK-Tutorials-Getting-Started_:

    :::image type="content" source="../../media/026-package-name.png" alt-text="Screenshot of Unity Publishing Settings with the package name box filled in.":::

    > [!NOTE]
    > The package name is the unique identifier for the app. If you want to avoid overwriting previously installed versions of the app with the same name, you should change this identifier before deploying the app.

1. Close the **Project Settings** window.

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
