In this tutorial you will create a Unity HoloLens app that uses [Azure Object Anchors](/azure/object-anchors/overview) When you're done, you'll have a Unity-based HoloLens app that can detect objects in the real world. You'll learn how to set up the Unity build settings so that the sample app can be deployed and launched on your HoloLens 2 device.

## Open the sample project

For this tutorial you will use the same sample project you downloaded from this [repository](https://github.com/Azure/azure-object-anchors) to convert your 3D model into an Azure Object Anchors model in [Chapter-4](/learn/modules/azure-object-anchors-tutorials/4-exercise-convert-upload-3d-model-to-hololens-2). In the downloaded sample project open the **quickstarts/apps/unity/basics** with Unity preferably with **Unity 2019.4.28f**.

 > [!NOTE]
 > Once you open the project in Unity you may see some errors, these errors will be cleared once we added required packages into the project.

## Set up the project

### Download and add the Azure Object Anchors package for Unity

Once the project is opened, the next step is to download the Azure Object Anchors package for Unity.

[!INCLUDE [Download Unity Package](includes/object-anchor-unity-package-import.md)]

### Switch Build platform

1) In the Unity menu, select **File** > **Build Settings...** to open the Build Settings window:

    :::image type="content" source="../media/open-build-settings.png" alt-text="Screenshot of build settings window." lightbox="../media/open-build-settings.png":::

2) In the Build Settings window, select **Universal Windows Platform** and click the Switch Platform button:

    :::image type="content" source="../media/switch-build-platform.png" alt-text="Screenshot of switching platform." lightbox="../media/switch-build-platform.png":::

3) When Unity has finished switching the platform, click the **x** icon to close the Build Settings window:

    :::image type="content" source="../media/close-build-settings.png" alt-text="Screenshot of how to close the build platform." lightbox="../media/close-build-settings.png":::

### Configure the account information

In the Assets folder go to **Assets** > **AzureObjectAnchors.SDK** > **Resources** and select **ObjectAnchorsConfig** file and add the credentials from the Azure Object Anchors account created in the previous section of this series.

* In the **Objects Anchor Account Id** field, paste the **Account ID** from your Azure Object Anchors account
* In the **Objects Anchor Account Key** field, paste the primary **Key** from your Azure Object Anchors account
* In the **Objects Anchor Account Domain** field, paste the **Account Domain** from your Azure Object Anchors account

    :::image type="content" source="../media/configure-account-information.png" alt-text="Screenshot of adding Azure Object Anchor account information." lightbox="../media/configure-account-information.png":::

## Build your application to HoloLens2

### Build the Unity project

1) In the Unity menu, select **File** > **Build Settings...** to open the Build Settings window, in the **Build settings** window ensure that only **MixedReality.AzureObjectAnchors/Scenes/AOASampleScene** is selected. Now click the Build button to open the Build Universal Windows Platform window.

    :::image type="content" source="../media/build-scene.png" alt-text="Screenshot of adding required scene to the build settings." lightbox="../media/build-scene.png":::

2) In the Build Universal Windows Platform window, choose a suitable location to store your build, and then click the Select Folder button to start the build process:

    :::image type="content" source="../media/build-location.png" alt-text="Screenshot of selecting required folder for build process." lightbox="../media/build-location.png":::

3) Wait for Unity to finish the build process:

    :::image type="content" source="../media/build-complete.png" alt-text="Screenshot of build process." lightbox="../media/build-complete.png":::

### Build and deploy the application

1) When the build process has been completed, Unity will prompt Windows File Explorer to open the location you stored the build. Navigate inside the folder, and double-click the solution file to open it in Visual Studio

    :::image type="content" source="../media/open-project-solution-file.png" alt-text="screenshot of sln file in the folder." lightbox="../media/open-project-solution-file.png":::

2) Configure Visual Studio for HoloLens by selecting the **Master** or **Release** configuration, the **ARM64** architecture, and Device as target

    :::image type="content" source="../media/solution-file-settings.png" alt-text="screenshot of the solution file with required settings." lightbox="../media/solution-file-settings.png":::

    > [!NOTE]
    > If you don't see Device as a target option, you may need to change the startup project for the Visual Studio solution from the IL2CPP project to the UWP project. To do this, in the Solution Explorer, right-click on YourProjectName (Universal Windows) and select **Set as StartUp Project**.

3) Connect your HoloLens to your computer, then select

    a. **Debug** > **Start Without Debugging** to automatically start the app on your device without the Visual Studio debugger attached.

    :::image type="content" source="../media/start-without-debug.png" alt-text="Screenshot of the debugging process." lightbox="../media/start-without-debug.png":::

    b. Use **Build** > **Deploy Solution** to deploy to your device without having the app to start automatically.

    :::image type="content" source="../media/deploy-solution.png" alt-text="Screenshot of Deploying solution." lightbox="../media/deploy-solution.png":::

    > [!IMPORTANT]
    > Before building to your device, the device must be in Developer Mode and paired with your development computer. Both of these steps can be completed by following [these instructions](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-visual-studio).

    > [!TIP]
    > You can also deploy to the [HoloLens Emulator](/windows/mixed-reality/develop/platform-capabilities-and-apis/using-the-hololens-emulator) or create an [App Package](/windows/uwp/packaging/packaging-uwp-apps) for sideloading.

## Use the deployed application to detect your object in physical space

When the Build process is finished, the app launches onto the Unity splash screen, where you'll get a notification stating that the Object Observer has been initialized. The app continuously looks for the objects and once the objects are detected in the current field of view it tracks them.

Instance of the detected object will be removed when it's 6 meters away from the user's location. The debug text shows details about an instance, like ID, updated timestamp and surface coverage ratio.
