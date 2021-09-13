## [Unity 2020 + OpenXR](#tab/openxr)

1. Once **MixedRealityFeatureTool** is opened, click on **Start** to get started with Mixed Reality Feature Tool.

    :::image type="content" source="../../media/base-2-section-4-step-1-2.png" alt-text="MixedRealityFeatureTool" lightbox="../media/base-2-section-4-step-1-2.png":::

2. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    ![Adding Unity Path for MixedRealityFeatureTool](../../media/base-2-section-4-step-1-3.png)

3. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

    > [!IMPORTANT]
    > The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

    Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit and click on **Platform Support** dropdown to find packages relating various supporting platforms.

    ![MixedRealityFeatureTool Discover Features](../../media/base-2-section-4-step-1-4-openxr.png)

4. check the **Mixed Reality Toolkit Foundation** and click on the dropdown next to it to select **MRTK 2.7.0**, also check the **Mixed Reality OpenXR Plugin** and click on the dropdown next to it to select most recent version available, then click on **Get features** button to download the selected packages.

    ![MixedRealityFeatureTool Open MixedReality](../../media/base-2-section-4-step-1-5-openxr.png)

5. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    ![MixedRealityFeatureTool Select required package](../../media/base-2-section-4-step-1-6-openxr.png)

6. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    ![MixedRealityFeatureTool Validate package](../../media/base-2-section-4-step-1-7.png)

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, a warning message appears to restart the unity editor to enable to backends for new plugin system, click on **Yes**

    ![Unity Restart Option](../../media/base-2-section-5-step-1-1-openxr.png)

2. Once the Unity restarts MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    ![Open MRTK project configurator window](../../media/base-2-section-5-step-1-2-openxr.png)

3. Click on **Unity OpenXR Plugin** to Enable XR Plugin Management and add its required packages into your project.

    ![Add Unity OpenXR Plugin ](../../media/base-2-section-5-step-1-3-openxr.png)

4. This imports required unity packages for XR Plugin Management, once done click on **Show XR Plug-In Management Settings** in MRTK project Configurator.

    ![Show XR Plug-In Management Settings ](../../media/base-2-section-5-step-1-4-openxr.png)

5. This opens **Project Settings window**, In the Project Settings window  under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings(Windows logo tab). Also Ensure **Initialize XR on Startup** is checked, then check **Open XR** checkbox and **Microsoft HoloLens feature set** checkbox to enable them.

    ![Project Settings Window 3](../../media/base-2-section-5-step-1-6-openxr.png)

6. Once you check OpenXR checkbox, MRTK Project Configurator window will show
updated message with **Apply Settings** button. Click **Apply Settings** button.

7. To validate OpenXR configuration, click **OpenXR** under **XR Plug-in Management** and check these items:

    * Depth Submission Mode: **Depth 16 Bit**
    * Interaction Profiles: **Microsoft Hand Interaction Profile**

    ![Project Settings Window 4](../../media/base-2-section-5-step-1-7-openxr.png)

    > [!TIP]
    > Reducing the Depth Format to 16-bit is optional but may help improve graphics performance in your project. To learn more about this topic, you can refer to the [Depth buffer sharing (HoloLens)](/windows/mixed-reality/mrtk-unity/performance/perf-getting-started#single-pass-instanced-rendering) section of MRTK's Performance documentation.

8. In the **MRTK Project Configurator** window, click on **Next**, then click the **Apply** button to apply the settings. (You can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**)

    ![MRTK Project Configurator](../../media/base-2-section-5-step-1-9-openxr.png)

9. Once you click on Apply, Unity will try to restart for the input system to take into
effect, click on **Apply** to restart the Unity editor

    ![MRTK Project Configurator 2](../../media/base-2-section-5-step-1-10-openxr.png)

10. Once the Unity restarts open MRTK Project Configurator from the unity menu and Click on **Next** then click on **Done** finish the Unity project configuration for OpenXR.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window.

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    ![Unity Publishing Settings. Package name configured](../../media/base-2-section-5-step-2-2.png)

    > [!NOTE]
    > The 'Package name' is the unique identifier for the app. You should change this identifier before deploying the app to avoid overwriting previously installed apps.
    > [!TIP]
    > The 'Product Name' is the name displayed in the HoloLens Start menu. To make the app easier to locate during development, add an underscore in front of the name to sort it to the top.

## [Unity 2019/2020 + Windows XR Plugin](#tab/winxr)

1. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

    ![MixedRealityFeatureTool for preview](../../media/base-2-section-4-step-1-2-preview.png)

2. Next click on **Start** to get started with Mixed Reality Feature Tool.

    ![MixedRealityFeatureTool ](../../media/base-2-section-4-step-1-2.png)

3. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    ![Adding Unity Path for MixedRealityFeatureTool](../../media/base-2-section-4-step-1-3.png)

4. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**. The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

5. Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.
    ![MixedRealityFeatureTool Discover Features](../../media/base-2-section-4-step-1-4.png)

6. check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0**, then click on **Get features** button to download the selected packages.

    ![MixedRealityFeatureTool Open MixedReality](../../media/base-2-section-4-step-1-5.png)

7. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    ![MixedRealityFeatureTool Select required package](../../media/base-2-section-4-step-1-6.png)

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    ![MixedRealityFeatureTool Validate package](../../media/base-2-section-4-step-1-7.png)

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    ![opening MRTK configurator tool](../../media/base-2-section-5-step-1-1-xr-sdk.png)

2. Click on **Built-in Unity Plugin(non-OpenXR)** to Enable XR Plugin Management and add its required packages into your project.

    ![ MRTK configurator tool](../../media/base-2-section-5-step-1-2-xr-sdk.png)

    > [!NOTE]
    > The above screenshot is from Unity 2020, if you using Unity 2019 please select **XR SDK/XR Management**

3. this imports required unity packages for XR Plugin Management, once done click on **Show Settings** in MRTK project Configurator.

    ![Player settings window](../../media/base-2-section-5-step-1-3-xr-sdk.png)

4. This opens **Project Settings window**, In the Project Settings window under **XR Plug-in Management** Ensure that you are in Universal Windows Platform settings also Ensure **Initialize XR on Startup** is checked, and check **Windows Mixed Reality** checkbox.

    ![Player settings window Enable Mixed Reality 1](../../media/base-2-section-5-step-1-4-xr-sdk.png)

5. After Unity has finished importing the Windows Mixed Reality SDK, the MRTK Project Configurator window should appear again. If it doesn't, use the Unity menu to open it.

    In the MRTK Project Configurator window, click on **next** then use the Audio spatializer dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

    ![Player settings window Enable Mixed Reality 2](../../media/base-2-section-5-step-1-5-xr-sdk.png)

6. Click on **Next** then click on **Done** in the MRTK Project Configurator window to finish the Unity project configuration for XRSDK.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

    In the Project Settings window, select **XR Plug-in Management** > **Windows Mixed Reality** > **Runtime Settings**, then use the **Depth Buffer Format** dropdown to select **16-bit depth**:

    ![Unity Enable 16 Depth](../../media/base-2-section-5-step-2-1-xr-sdk.png)

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    ![Unity Publishing Settings. Package name configured](../../media/base-2-section-5-step-2-2.png)

## [Legacy WSA](#tab/wsa)

1. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

    ![MixedRealityFeatureTool preview](../../media/base-2-section-4-step-1-2-preview.png)

2. Next click on **Start** to get started with Mixed Reality Feature Tool.

    ![MixedRealityFeatureTool](../../media/base-2-section-4-step-1-2.png)

3. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button, click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

    ![Adding Unity Path for MixedRealityFeatureTool](../../media/base-2-section-4-step-1-3.png)

4. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

    > [!NOTE]
    > The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

    Features are grouped by category to make things easier to find, click on **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

    ![MixedRealityFeatureTool Discover Features](../../media/base-2-section-4-step-1-4.png)

5. Check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0**, then click on **Get features** button to download the selected packages.

    ![MixedRealityFeatureTool Open MixedReality](../../media/base-2-section-4-step-1-5.png)

6. Next click on the **Validate** button to validate the selected package, you will get a popup with message **No validation issues were detected** click on **OK** to close the popup and click on **Import** button.

    ![MixedRealityFeatureTool Select required package](../../media/base-2-section-4-step-1-6.png)

7. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

    ![MixedRealityFeatureTool Validate package](../../media/base-2-section-4-step-1-7.png)

## Configure the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

    ![Unity Configure Unity Project menu path 1](../../media/base-2-section-5-step-1-1.png)

2. Click on **Legacy XR** to enable Legacy XR and to add its required packages  into your project.

    ![s](../../media/base-2-section-5-step-1-2.png)

3. Click on next button to enable XR pipeline settings for Legacy XR.

    ![Unity Configure Unity Project menu path 2](../../media/base-2-section-5-step-1-3.png)

4. In the MRTK Project Configurator window, ensure all options are checked and also use the **Audio spatializer** dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

    ![MRTK configuration window](../../media/base-2-section-5-step-1-4.png)

5. Click on **Next** then click on**Done** button in MRTK Project Configurator window to finish the Unity project configuration for Legacy XR.

## Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **Player** > **XR Settings**, then use the **Depth Format** dropdown to select **16-bit depth**:

    ![Unity Enable 16 Depth](../../media/base-2-section-5-step-2-1.png)

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

    ![Unity Publishing Settings. Package name configured](../../media/base-2-section-5-step-2-2.png)
