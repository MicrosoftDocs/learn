# [Unity 2019/2020 + Windows XR Plugin](#tab/winxr)

2. After you open **MixedRealityFeatureTool**, to access preview releases, click **Settings** and then enable **Show preview releases** under the **Feature** tab. Click **ok** to save the settings.

![MixedRealityFeatureTool for preview](../../media/base-02-section4-step1-2-preview.PNG)

3. Click **Start** to get started with Mixed Reality Feature Tool.

![MixedRealityFeatureTool](../../media/base-02-section4-step1-2.PNG)

4. Click the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer--for example _D:\MixedRealityLearning\MRTK Tutorials_.

![Adding Unity Path for MixedRealityFeatureTool](../../media/base-02-section4-step1-3.PNG)

5. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**. The Mixed Reality Feature Tool performs validation to ensure that it has been directed to a Unity project folder. The folder must contain Assets, Packages and Project Settings folders.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find. Click the **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

![MixedRealityFeatureTool Discover Features](../../media/base-02-section4-step1-4.PNG)

6. Select the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**, then click the **Get features** button to download the selected packages.

![MixedRealityFeatureTool Open MixedReality](../../media/base-02-section4-step1-5.PNG)

7. Next click the **Validate** button to validate the selected package. You'll get a popup with the message **No validation issues were detected**. Click on **OK** to close the popup and then click the **Import** button.

![MixedRealityFeatureTool Select required package](../../media/base-02-section4-step1-6.PNG)

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

![MixedRealityFeatureTool Validate package](../../media/base-02-section4-step1-7.PNG)

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

![opening MRTK configurator tool](../../media/base-02-section5-step1-1.PNG)

2. Click on **Built-in Unity Plugin(non-OpenXR)** to Enable XR Plugin Management and add its required packages into your project.

![MRTK configurator tool](../../media/base-02-section5-step1-2xrsdk.PNG)

> [!NOTE]
> The above screenshot is from Unity 2020. If you're using Unity 2019 please select **XR SDK/XR Management**

3. This imports required unity packages for XR Plugin Management. Once done click on **Show Settings** in MRTK project Configurator.

![Player settings window](../../media/base-02-section5-step1-3xrsdk.PNG)

4. This opens **Project Settings window**. In the Project Settings window under **XR Plug-in Management** ensure that you're in Universal Windows Platform settings. Also, ensure **Initialize XR on Startup** is selected, and select the **Windows Mixed Reality** checkbox.

![Player settings window Enable Mixed Reality 1](../../media/base-02-section5-step1-4xrsdk.PNG)

5. After Unity has finished importing the Windows Mixed Reality SDK, the MRTK Project Configurator window should appear again. If it doesn't, use the menu bar to open it.

In the MRTK Project Configurator window, click on **next** then use the Audio spatializer dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

![Player settings window Enable Mixed Reality 2](../../media/base-02-section5-step1-5xrsdk.PNG)

6. Click on **Next** then click on **Done** in the MRTK Project Configurator window to finish the Unity project configuration for XRSDK.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:

In the Project Settings window, select **XR Plug-in Management** > **Windows Mixed Reality** > **Runtime Settings**, then use the **Depth Buffer Format** dropdown to select **16-bit depth**:

![Unity Enable 16 Depth](../../media/base-02-section5-step2-1xrsdk.PNG)

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

![Unity Publishing Settings. Package name configured](../../media/base-02-section5-step2-2.PNG)

# [Unity 2020 + OpenXR](#tab/openxr)

2. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

![MixedRealityFeatureTool preview](../../media/base-02-section4-step1-2-preview.PNG)

3. Click on **Start** to get started with Mixed Reality Feature Tool.

![MixedRealityFeatureTool](../../media/base-02-section4-step1-2.png)

4. Click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer--for example, _D:\MixedRealityLearning\MRTK Tutorials_.

![Adding Unity Path for MixedRealityFeatureTool](../../media/base-02-section4-step1-3.png)

5. When you've located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find. Click the **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit and click the **Platform Support** dropdown to find packages related to various supporting platforms.

![MixedRealityFeatureTool Discover Features](../../media/base-02-section4-step1-4.png)

6. Select the **Mixed Reality Toolkit Foundation** and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**. Also, select the **Mixed Reality OpenXR Plugin** and click on the dropdown next to it to select most recent version available. Click the **Get features** button to download the selected packages.

![MixedRealityFeatureTool Open MixedReality](../../media/base-02-section4-step1-5-openxr.png)

7. Next click on the **Validate** button to validate the selected package. You'll get a popup with message **No validation issues were detected**. Click on **OK** to close the popup and then click on **Import** button.

![MixedRealityFeatureTool Select required package](../../media/base-02-section4-step1-6-OpenXR.png)

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

![MixedRealityFeatureTool Validate package](../../media/base-02-section4-step1-7.PNG)

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, a warning message appears to restart the unity editor to enable to backends for new plugin system. Click on **Yes**

![Unity Restart Option](../../media/base-02-section5-step1-1-openxr.PNG)

2. Once Unity restarts, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:

![Open MRTK project configurator window](../../media/base-02-section5-step1-2-openxr.png)

3. Click on **Unity OpenXR Plugin** to Enable XR Plugin Management and add its required packages into your project.

![Add Unity OpenXR Plugin](../../media/base-02-section5-step1-3-openxr.PNG)

4. This imports required unity packages for XR Plugin Management. Once done, click on **Show XR Plug-In Management Settings** in MRTK project Configurator.

![Show XR Plug-In Management Settings](../../media/base-02-section5-step1-4-openxr.PNG)

5. In the Project Settings window  under **XR Plug-in Management**, ensure that you're in Universal Windows Platform settings. Ensure **Initialize XR on Startup** is checked, then check **Open XR** checkbox and **Microsoft HoloLens feature set** checkbox to enable them.

![Project Settings Window 3](../../media/base-02-section5-step1-6-openxr.PNG)

6. If you see a red warning icon next to **OpenXR Plugin**, click the icon and select **Fix all** before continuing. The Unity Editor may need to restart itself for the changes to take effect.

![Project Settings Window 4](../../media/base-02-section5-step1-7-openxr.PNG)

7. Once all issues are fixed close the **Project Settings** window.
In the menu bar, navigate to **Mixed Reality**> **OpenXR** > **Apply recommended project settings for HoloLens 2** to get better app performance.

![Project Settings Window 5](../../media/base-02-section5-step1-8-openxr.PNG)

8. Use the menu bar to open MRTK Project Configurator. In the MRTK Project Configurator window, click on **next**, then click the **Apply** button to apply the settings:

![Project Settings Window 6](../../media/base-02-section5-step1-9-openxr.PNG)


9. Once you click on Apply, Unity will try to restart for the input system to take into effect. Click on **Apply** to restart the Unity editor

![Project Settings Window 7](../../media/base-02-section5-step1-10-openxr.PNG)

10. Once Unity restarts open MRTK Project Configurator from the menu bar. Click on **Next** then click on **Done** to finish the Unity project configuration for OpenXR.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **XR Plug-in Management** > **OpenXR**, then use the **Depth Submission Mode** dropdown to select **Depth 16-bit**:

![Unity Enable 16 Depth](../../media/base-02-section5-step2-1-openxr.PNG)

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

![Unity Publishing Settings. Package name configured](../../media/base-02-section5-step2-2.png)

# [Legacy WSA](#tab/wsa)

2. Once **MixedRealityFeatureTool** is opened, to access preview releases click on **Settings** and enable **Show preview releases** under **Feature** tab, then click on **ok** to save the settings.

![MixedRealityFeatureTool preview](../../media/base-02-section4-step1-2-preview.PNG)


3. Next click on **Start** to get started with Mixed Reality Feature Tool.

![MixedRealityFeatureTool](../../media/base-02-section4-step1-2.png)

4. The first step is to point the Mixed Reality Feature Tool to your **Project path** using the **ellipsis** button. Click on the Three dots ellipsis button next to the Project path and browse to your project folder in the explorer for example _D:\MixedRealityLearning\MRTK Tutorials_.

![Adding Unity Path for MixedRealityFeatureTool](../../media/base-02-section4-step1-3.png)

5. When you have located your project's folder, click the Open button to return to the Mixed Reality Feature Tool. Then click on **Discover Features**.

> [!NOTE]
> The dialog that's displayed when browsing for the Unity project folder contains '_' as the file name. There must be a value for the file name to enable the folder to be selected.

Features are grouped by category to make things easier to find. Click the **Mixed Reality Toolkit** dropdown to find packages relating to the Mixed Reality Toolkit.

![MixedRealityFeatureTool Discover Features](../../media/base-02-section4-step1-4.png)

6. Check the **Mixed Reality Toolkit Foundation**, and click on the dropdown next to it to select **MRTK 2.7.0-preview.4**, then click on **Get features** button to download the selected packages.

![MixedRealityFeatureTool Open MixedReality](../../media/base-02-section4-step1-5.png)

7. Next click on the **Validate** button to validate the selected package. You'll  get a popup with message **No validation issues were detected**. Click on **OK** to close the popup and click on **Import** button.

![MixedRealityFeatureTool Select required package](../../media/base-02-section4-step1-6.png)

8. Click on **Approve** Button to add the **Mixed Reality Toolkit** into the project.

![MixedRealityFeatureTool Validate package](../../media/base-02-section4-step1-7.png)

## Configuring the Unity project

1. After Unity has finished importing the package from the previous section, the MRTK Project Configurator window should appear. If it doesn't, you can manually open it by going to **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK**:


![Unity Configure Unity Project menu path 1](../../media/base-02-section5-step1-1.png)

2. Click on **Legacy XR** to enable Legacy XR and to add its required packages  into your project.

![Add required packges](../../media/base-02-section5-step1-2.png)

3. Click on next button to enable XR pipeline settings for Legacy XR.

![Unity Configure Unity Project menu path 2](../../media/base-02-section5-step1-3.png)

4. In the MRTK Project Configurator window, ensure all options are checked and also use the **Audio spatializer** dropdown to select the **MS HRTF Spatializer**, then click the **Apply** button to apply the setting:

![MRTK configuration window](../../media/base-02-section5-step1-4.png)

5. Click on **Next** then click the **Done** button in MRTK Project Configurator window to finish the Unity project configuration for Legacy XR.

### Configure additional project settings

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Project Settings window:
In the Project Settings window, select **Player** > **XR Settings**, then use the **Depth Format** dropdown to select **16-bit depth**:

![Unity Enable 16 Depth](../../media/base-02-section5-step2-1.png)

2. In the Project Settings window, select **Player** > **Publishing Settings**, then in the **Package name** field, enter a suitable name, for example, _MRTKTutorials-GettingStarted_:

![Unity Publishing Settings. Package name configured](../../media/base-02-section5-step2-2.png)
