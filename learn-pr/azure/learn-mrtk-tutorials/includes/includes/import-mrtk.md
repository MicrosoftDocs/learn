1. In the Mixed Reality Feature Tool, select **Start**.

    :::image type="content" source="../../media/mixed-reality-feature-tool.png" alt-text="Screenshot of the Mixed Reality Feature Tool opening screen.":::

1. Select the Browse button (it's the "three-dot" button in the image below), then navigate to your project, and then open it.

    :::image type="content" source="../../media/002-open-your-project.png" alt-text="Open your project":::

    After you select a folder, the Tool checks to ensure that it's a valid Unity project folder.

    :::image type="content" source="../../media/007-project-path.png" alt-text="Screenshot of the Mixed Reality feature Tool Project Path screen.":::
  
1. Select **Discover Features**.

    **Note**: You may need to wait a few seconds while the Tool refreshes the packages from the feeds.

1. On the **Discover Features** page, note that there is a list of available package groups.

    :::image type="content" source="../../media/003-mixed-reality-feature-tool-groups.png" alt-text="The main groups of packages in the Mixed Reality Feature Tool":::

1. Select the "+" button to the left of **Platform Support (0 of 5)** and then select the latest version of **Mixed Reality OpenXR Plugin**.

     :::image type="content" source="../../media/008-package-selections.png" alt-text="Screenshot of package selections in the Mixed Reality Feature Tool.":::

1. Select "Select All" button to the right of **MRTK3** so that all features are selected.

     :::image type="content" source="../../media/009-package-selections_mrtk.png" alt-text="Screenshot of selecting all feature of MRTK3.":::

1. After you've made your selection(s), select **Get Features**.
1. Select **Validate** to validate the packages you selected. You should see a dialog that says **No validation issues were detected**. When you do, select **OK**.
1. On the **Import Features** page, the left-side column, **Features**, displays the packages you selected. The right-side column, **Required dependencies**, displays any dependencies. You can select the **Details** link for any of these items to learn more about them.
1. When you're ready to move on, select **Import.** On the **Review and Approve** page, you can review information about the packages.
1. Select **Approve.**
1. Return to the Unity Editor and select a blank area in the UI. You'll see a progress bar showing you that your packages are being imported.
 
## Configure the Unity project

1. After Unity has imported the packages, a warning appears asking if you want to enable the backends by restarting the editor. Select **Yes**.

    :::image type="content" source="../../media/unity-restart-option.png" alt-text="Screenshot of Unity Restart Option.":::
1. Unity will ask you about updating methods in the **XR InteractionLayerMask**, select **I Made a Backup, Go Ahead!** button and wait for Unity to restart.

    :::image type="content" source="../../media/unity-method-updates.png" alt-text="Screenshot of updating methods in the XR InteractionLayerMask.":::
1. On the menu bar, select Mixed Reality > Project > Apply recommended project settings for HoloLens 2.
1. On the menu bar, select **Edit** > **Project Settings...**. Select XR Plugin-in Management. Ensure that Initialize XR on Startup is selected, and then, under Plugin Providers, select Open XR

    :::image type="content" source="../../media/unity-xr-on-startup-option.png" alt-text="Screenshot of Initialize XR on Startup.":::

1. The OpenXR Plugin loads, and then two items appear underneath OpenXR. Select the first one, **Microsoft HoloLens feature group**. Select on the yellow exclamation mark.

    :::image type="content" source="../../media/unity-openxr-option.png" alt-text="Screenshot of Open XR option.":::

1. An then select Fix All
 :::image type="content" source="../../media/unity-validation-fix-all.png" alt-text="Screenshot of Fix All.":::
Some warnings may remain.  Ignore them for now.

1. Select OpenXR under XR Plug-in Management.
1. Under Interaction Profiles, add Microsoft Hand Interaction and Eye Gaze Interaction Profile if not been added.
:::image type="content" source="../../media/unity-add-interaction-profile.png" alt-text="Screenshot of Add Interaction Profiles." lightbox="../../media/unity-add-interaction-profile.png":::
1. Make sure **Microsoft Hololens** on the left is selected and **Hand Tracking**, **Mixed Reality Features** and **Motion Controller Model** on the right are selected.
1. Select on the warning sign next to "Eye Gaze Interaction Profile" to bring back the Project Validation window. Make sure you're on the UWP platform tab (the tab displays the Windows logo), and then select Fix all to resolve the validation issues. Note that there may be issues that remain after you select Fix All. In that case, select Fix All again, ignore any issues that are marked Scene specific, and then read the recommendations for the remaining issues (if any) and make any changes you want.
    
1. Under Project Settings, Select MRTK3, check if there is a valid Profile. If there is none, search for MRTKProfile in Packages (Packages/org.mixedrealitytoolkit.core/Configuration/Default Profiles/MRTKProfile.asset) of the project, and assign it to the Profile.
:::image type="content" source="../../media/unity-mrtk-profile.png" alt-text="Screenshot of MRTK profile.":::




## Configure project settings 

1. In the menu bar, select **Edit** > **Project Settings...**.
1. In the **Project Settings** window's left-side column, select **Player**.
1. Note that in the **Player** window, the **Product Name** is "MRTK Tutorial." This is taken from your project name and will be the name displayed in the HoloLens Start menu.

    :::image type="content" source="../../media/025-product-name.png" alt-text="Screenshot of Unity Publishing Settings with the Project Name box filled in.":::

    > [!TIP]
    > To make the app easier to locate during development, add an underscore in front of the name to sort it to the top of any list.

1. Select the **Publishing Settings** drop down, and then in the **Package name** field, enter a suitable name--for example, _MRTK-Tutorials-Getting-Started_:

    :::image type="content" source="../../media/026-package-name.png" alt-text="Screenshot of Unity Publishing Settings with the package name box filled in.":::

    > [!NOTE]
    > The package name is the unique identifier for the app. If you want to avoid overwriting previously installed versions of the app with the same name, you should change this identifier before deploying the app.

1. Close the **Project Settings** window.
