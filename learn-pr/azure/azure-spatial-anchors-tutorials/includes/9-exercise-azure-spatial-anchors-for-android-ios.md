In this unit, you'll learn how to build your project to Android and iOS devices by using AR Foundation, ARCore XR Plugin, and ARKit XR Plugin.

## Install in-built Unity packages

[!INCLUDE[](includes/install-inbuilt-unity-packages.md)]

## Configure the MRTK for an AR Foundation camera

In this section, you'll configure the MRTK to deploy to a mobile device.

1. On the **Hierarchy** pane, select the **MixedRealityToolkit** object. On the **Inspector** pane, select the **Camera** tab, clone the camera profile, and give it a suitable name like **AzureSpatialAnchors_ARCameraProfile**.

    :::image type="content" source="../media/configure-mrtk.png" alt-text="Screenshot of configuring the Mixed Reality Toolkit for an augmented reality camera." lightbox="../media/configure-mrtk.png":::

    > [!Tip]
    > For information on how to clone MRTK profiles, see [Configuring the Mixed Reality Toolkit profiles](/windows/mixed-reality/mrtk-unity/configuration/mixed-reality-configuration-guide).

2. With the **Camera** tab still selected on the **Inspector** pane, expand **Camera Settings Providers**. Select the minus sign (**-**) to remove **Windows Mixed Reality Camera Settings** or **XR SDK Windows Mixed Reality Camera Settings**.

    :::image type="content" source="../media/camera-settings.png" alt-text="Screenshot of camera settings." lightbox="../media/camera-settings.png":::

3. Select the + **Add Camera Settings Provider** button, and then expand the newly added data provider.

    :::image type="content" source="../media/add-camera-setting.png" alt-text="Screenshot of adding a camera settings provider." lightbox="../media/add-camera-setting.png":::

4. In the **Type** dropdown list, change the type to **Microsoft.MixedReality.Toolkit.Experimental.UnityAR** > **UnityARCameraSettings**.

    :::image type="content" source="../media/camera-setting-provider.png" alt-text="Screenshot of changing the type of the added camera settings provider." lightbox="../media/camera-setting-provider.png":::

5. Update the MRTK UnityAR script definitions by selecting **Mixed Reality** > **Toolkit** > **Utilities** > **UnityAR** > **Update Scripting Defines**.

## Build your application to your Android device

In this section, you'll configure your project to build and deploy it to an Android device.

1. On the Unity menu, select **File** > **Build Settings** to open the **Build Settings** dialog. Switch the platform to Android.

    :::image type="content" source="../media/change-build-settings.png" alt-text="Screenshot of changing build settings." lightbox="../media/change-build-settings.png":::

    >[!Tip]
    >For information on how to switch the build platform, see [Switching the build platform](https://docs.unity3d.com/Manual/BuildSettings.html) in the Unity documentation.

    Close the **Build Settings** dialog.

2. On the Unity menu, select **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK** to open the **MRTK Project Configurator** dialog. Ensure that all options are selected, and then select the **Apply** button to apply the settings.

    :::image type="content" source="../media/mrtk-project-configurator-window.png" alt-text="Screenshot of the project configurator dialog for the Mixed Reality Toolkit." lightbox="../media/mrtk-project-configurator-window.png":::

3. On the Unity menu, select **Edit** > **Project Settings** to open the **Project Settings** dialog. Then locate the **Player** > **Other Settings** section, select **Vulkan**, and remove it by selecting the minus sign (**-**).

    :::image type="content" source="../media/project-settings.png" alt-text="Screenshot of project settings." lightbox="../media/project-settings.png":::

    [!INCLUDE[](includes/build-application-to-android-device.md)]

4. In the **Build Settings** dialog, select the **Add Open Scenes** button to add your current scene to the **Scenes In Build** list. Use a USB cable to connect your Android device to your computer, and the select the device from the **Run Device** dropdown list.

    :::image type="content" source="../media/run-device-dropdown.png" alt-text="Screenshot of the Run Device dropdown list." lightbox="../media/run-device-dropdown.png":::

    >[!Note]
    >If your device doesn't appear in the **Run Device** dropdown list, you might need to select the **Refresh** button next to the box.

5. In the **Build Settings** dialog, select the **Build And Run** button to open the **Build Android** dialog.

6. Choose a suitable location to store your build&mdash;for example, **D:\MixedRealityLearning\Builds**. Give the .apk file a suitable name&mdash;for example, **MRTKTutorials-AzureSpatialAnchors**. Then select the **Save** button to start the build process.

    :::image type="content" source="../media/build-android.png" alt-text="Screenshot of building to Android." lightbox="../media/build-android.png":::

    >[!Note]
    >If you get an error in the Unity Console Window related to Android SDK, NDK, or JDK modules, open Unity Hub and install the associated Android Build Support modules.

    When the build process is complete, your apps should automatically load on your Android device.

## Build your application to your iOS device

In this section, you'll configure your project to build and deploy it to your iOS device.

1. On the Unity menu, select **File** > **Build Settings** to open the **Build Settings** dialog. Switch the platform to **iOS**.

    :::image type="content" source="../media/build-settings.png" alt-text="Screenshot of build settings and selecting the operating system." lightbox="../media/build-settings.png":::

    >[!Tip]
    >For information on how to switch the build platform, see [Switching the build platform](https://docs.unity3d.com/Manual/BuildSettings.html) in the Unity documentation.

    Close the **Build Settings** dialog.

2. On the Unity menu, select **Mixed Reality** > **Toolkit** > **Utilities** > **Configure Project for MRTK** to open the **MRTK Project Configurator** window. Ensure that all options are selected, and then select the **Apply** button to apply the settings.

    :::image type="content" source="../media/mrtk-project-configurator.png" alt-text="Screenshot of the Mixed Reality Toolkit project configurator." lightbox="../media/mrtk-project-configurator.png":::

    [!INCLUDE[](includes/build-application-to-ios-device.md)]

3. On the Unity menu, select **Edit** > **Project Settings** to open the **Player Settings** dialog. Locate the **Player** > **Other Settings** section and clear the **Strip Engine Code** checkbox.

    :::image type="content" source="../media/strip-engine-code.png" alt-text="Screenshot of the Strip Engine Code checkbox." lightbox="../media/strip-engine-code.png":::

    Close the **Player Settings** dialog and open the **Build Settings** dialog again.

4. In the **Build Settings** dialog, select the **Add Open Scenes** button to add your current scene to the **Scenes In Build** list.

    :::image type="content" source="../media/build-scenes.png" alt-text="Screenshot of scenes in build." lightbox="../media/build-scenes.png":::

5. In the **Build Settings** dialog, select the **Build** button to open the **Build iOS** dialog.

6. Choose a suitable location to store your Xcode project&mdash;for example, **D:\MixedRealityLearning\Builds**. Create a new folder and give it a suitable name&mdash;for example, **MRTKTutorials-AzureSpatialAnchors**. Then select the **Select Folder** button to start the build process.

    :::image type="content" source="../media/select-folder.png" alt-text="Screenshot of selecting a folder." lightbox="../media/select-folder.png":::

    When the build process is complete, follow the [Export the Xcode project](/azure/spatial-anchors/quickstarts/get-started-unity-ios?tabs=azure-portal#export-the-xcode-project) instructions to deploy your Xcode project to your iOS device.
