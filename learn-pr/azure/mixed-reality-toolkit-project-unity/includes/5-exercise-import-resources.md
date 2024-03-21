## Install the Mixed Reality Feature Tool

To import the Mixed Reality Toolkit into your project, you'll use the Mixed Reality Feature Tool. The tool allows developers to discover, update, and import feature packages. You can search packages by name or category, see their dependencies, and view proposed changes to your project's manifest file before importing.

1. Download the latest version of the Mixed Reality Feature Tool from the [Microsoft Download Center](https://aka.ms/MRFeatureTool).
1. After the download finishes, open the executable file `MixedRealityFeatureTool.exe` and use it to launch the Mixed Reality Feature Tool.

    > [!NOTE]
    > Before you can run the Mixed Reality Feature Tool, you might need to install the [.NET 6.0 runtime](https://dotnet.microsoft.com/download/dotnet/6.0).

## Import the MRTK Unity foundation package

1. In the Mixed Reality Feature Tool, select **Start**.

    :::image type="content" source="../media/mixed-reality-feature-tool.png" alt-text="Screenshot of the Mixed Reality Feature Tool opening screen.":::

1. Select the **Browse** button (it's the **...** button in the following image), navigate to your project, and open it.

    :::image type="content" source="../media/002-open-your-project.png" alt-text="Open your project":::

    After you select a folder, the tool checks to ensure that it's a valid Unity project folder.

    :::image type="content" source="../media/007-project-path.png" alt-text="Screenshot of the Mixed Reality feature Tool Project Path screen.":::
  
1. Select **Discover Features**.

    **Note**: You might need to wait a few seconds while the Tool refreshes the packages from the feeds.

1. On the **Discover Features** page, note that there's a list of available package groups.

    :::image type="content" source="../media/003-mixed-reality-feature-tool-groups.png" alt-text="The main groups of packages in the Mixed Reality Feature Tool":::

1. Select the **+** button to the left of **Platform Support (0 of 5)** and then select the latest version of **Mixed Reality OpenXR Plugin**.

    :::image type="content" source="../media/008-package-selections.png" alt-text="Screenshot of package selections in the Mixed Reality Feature Tool.":::

1. Select the **Select All** button to the right of **MRTK3** so that all features are selected.

    :::image type="content" source="../media/009-package-selections_mrtk.png" alt-text="Screenshot of selecting all feature of MRTK3.":::

    > [!NOTE]
    > If you see any packages that are marked as deprecated, you should remove them and make sure that **Settings > Feature > Show deprecated packages** is deselected.

1. After you've made your selection(s), select **Get Features**.
1. Select **Validate** to validate the packages you selected. You should see a dialog that says **No validation issues were detected**. When you do, select **OK**.
1. On the **Import Features** page, the left-side column, **Features**, displays the packages you selected. The right-side column, **Required dependencies**, displays any dependencies. You can select the **Details** link for any of these items to learn more about them.
1. When you're ready to move on, select **Import.** On the **Review and Approve** page, you can review information about the packages.
1. Select **Approve**, then select **Exit**.
1. Return to the Unity Editor and select a blank area in the UI. You'll see a progress bar showing you that your packages are being imported.

## Configure the Unity project

1. After Unity has imported the packages, a warning appears asking if you want to enable the backends by restarting the editor. Select **Yes**.

    :::image type="content" source="../media/unity-restart-option.png" alt-text="Screenshot of Unity Restart Option.":::

1. Unity might ask you about updating methods in the **XR InteractionLayerMask**. Select the **I Made a Backup, Go Ahead!** button and wait for Unity to restart.

    :::image type="content" source="../media/unity-method-updates.png" alt-text="Screenshot of updating methods in the XR InteractionLayerMask.":::

   <!-- 1. On the menu bar, select **Mixed Reality** > **Project** > **Apply recommended project settings for HoloLens 2**. -->
1. On the menu bar, select **Edit** > **Project Settings**. Select **XR Plugin-in Management**. Ensure that **Initialize XR on Startup** is selected, and then select the checkbox for **Open XR** under **Plug-in Providers**.

    :::image type="content" source="../media/unity-xr-on-startup-option.png" alt-text="Screenshot of Initialize XR on Startup.":::

1. The OpenXR Plugin loads, and two items appear under OpenXR. Check the box for the first one, **Microsoft HoloLens feature group**. Select the yellow **exclamation mark**.

    :::image type="content" source="../media/unity-openxr-option.png" alt-text="Screenshot of Open XR option.":::

1. Select **Fix All**.

    :::image type="content" source="../media/unity-validation-fix-all.png" alt-text="Screenshot of Fix All.":::

    Some warnings might remain. Ignore them for now.

1. Select **OpenXR** under **XR Plug-in Management**.
1. Under **Interaction Profiles**, select **+**, then add **Microsoft Hand Interaction Profile** and **Eye Gaze Interaction Profile** if they're not already added.

    :::image type="content" source="../media/unity-add-interaction-profile.png" alt-text="Screenshot of Add Interaction Profiles." lightbox="../media/unity-add-interaction-profile.png":::

1. Make sure **Microsoft Hololens** on the left is selected and **Hand Tracking**, **Mixed Reality Features** and **Motion Controller Model** on the right are selected.
1. Select the yellow **exclamation mark** next to **Eye Gaze Interaction Profile** to bring back the Project Validation window. Make sure you're on the UWP platform tab (the tab displays the Windows logo), and then select **Fix All** to resolve the validation issues. Note that some issues might remain. In that case, select **Fix All** again, ignore any issues that are marked Scene specific, and then read the recommendations for the remaining issues (if any) and make any changes you want.

1. In the **Project Settings** window, Select **MRTK3** and check if there's a valid **Profile**. If there's not, search for *MRTKProfile* in the project's Packages (Packages/org.mixedrealitytoolkit.core/Configuration/Default Profiles/MRTKProfile.asset) and assign it to the Profile.

    :::image type="content" source="../media/unity-mrtk-profile.png" alt-text="Screenshot of MRTK profile.":::

## Configure project settings

1. In the menu bar, select **Edit** > **Project Settings**.
1. In the **Project Settings** window, select **Player**.
1. Note that in the **Player** window, the **Product Name** is *MRTK Tutorial*. This is taken from your project name and will be the name displayed in the HoloLens Start menu.

    :::image type="content" source="../media/025-product-name.png" alt-text="Screenshot of Unity Publishing Settings with the Project Name box filled in.":::

    > [!TIP]
    > To make the app easier to locate during development, add an underscore in front of the name to sort it to the top of any list.

1. Select the **Publishing Settings** drop-down, then in the **Package name** field, enter a suitable name; for example, *MRTK-Tutorials-Getting-Started*:

    :::image type="content" source="../media/026-package-name.png" alt-text="Screenshot of Unity Publishing Settings with the package name box filled in.":::

    > [!NOTE]
    > The package name is the unique identifier for the app. If you want to avoid overwriting previously installed versions of the app with the same name, you should change this identifier before deploying the app.

1. Close the **Project Settings** window.

## Create the scene and configure MRTK

1. In the menu bar, select **File** > **New Scene**. Select the **Basic (Built-in)** option, then select **Create**.

1. In the **Project** window, navigate to the **Packages** > **MRTK Input** > **Assets** > **Prefabs** folder. Drag the prefab **MRTK XR Rig** into the scene Hierarchy.

     :::image type="content" source="../media/mrtk-xr-rig-prefab.png" alt-text="Screenshot of the adding MRTK XR Rig in the Inspector.":::

1. Remove the **Main Camera** game object, because the **MRTK XR Rig** game object already contains a camera.

     :::image type="content" source="../media/023-add-mrtk.png" alt-text="Screenshot of the Mixed Reality Toolkit in the Inspector.":::

1. Add the **MRTK Input Simulator** (**Packages** > **MRTK Input** > **Simulation** > **Prefabs**) prefab to your scene.

    > [!NOTE]
    > This step is optional, but required by in-editor simulations.

     :::image type="content" source="../media/023-add-input-simulator.png" alt-text="Screenshot of the input simulator.":::

1. In the menu bar, select **File** > **Save As**.

1. Navigate to the **Assets** > **Scenes** folder, then name and save your project.
