## [Unity 2020 + OpenXR](#tab/openxr)

Your Holographic Remoting app is now ready to build on your PC. Follow the below steps and make these changes to build this application on to your PC.

### 1. Switch build platform

In the menu bar, select **File** > **Build Settings**.

1. In the Build Settings window, select PC, Mac & Linux Standalone Platform and click the Switch Platform button to change the Build Platform:

    :::image type="content" source="../../media/switch-build-platform.png" alt-text="Screenshot of Switching Build Platform." lightbox="../../media/switch-build-platform.png":::

### 2. Set the project settings

1. In the menu bar, select **Edit > Project Settings > XR Plug-in Management**. Ensure that you're in the Windows Standalone tab and then select **OpenXR** and **Windows Mixed Reality feature**.

    :::image type="content" source="../../media/project-settings.png" alt-text="Screenshot of Project settings." lightbox="../../media/project-settings.png":::

2. In the Project Settings window, select **OpenXR**. Ensure that you're in the Windows Standalone tab, and then change the **Depth submission mode** from None to **Depth 16** Bit.

3. Add **Eye Gaze Interaction Profile** and **Microsoft Hand Interaction Profile** by clicking on the plus sign ("+") button in the Interaction Profiles tab.

    :::image type="content" source="../../media/eye-gaze-interaction-profile.png" alt-text="Screenshot of Eye Gaze Interaction Profile." lightbox="../../media/eye-gaze-interaction-profile.png":::

4. Under **Open XR feature groups > All features**, select **Holographic App Remoting**.

    :::image type="content" source="../../media/xr-feature-groups.png" alt-text="Screenshot of XR feature groups." lightbox="../../media/xr-feature-groups.png":::

5. Select **Windows Mixed Reality** and then under the **Windows Mixed Reality** group, select **Holographic App Remoting**.

    :::image type="content" source="../../media/holographic-app-remoting.png" alt-text="Screenshot of Holographic App Remoting." lightbox="../../media/holographic-app-remoting.png":::

### 3. Build the Unity project

In the menu bar, select **File** > **Build Settings**.

1. Click **Add Open Scenes** to add your current scene to the Scenes list in the Build Settings window. Then, in the Build list, click the **Build** button:

    :::image type="content" source="../../media/add-open-scene.png" alt-text="Screenshot of Add Open Scenes." lightbox="../../media/add-open-scene.png":::

2. Choose a suitable location to store your build--for example, Documents\MixedRealityLearning. Create a new folder and give it a proper name--for example, PCHolographicRemoting--and then click the **Select Folder** button to start the build process:

    :::image type="content" source="../../media/select-folder.png" alt-text="Screenshot of Select Folder." lightbox="../../media/select-folder.png":::

3. Wait for Unity to finish the build process.

    :::image type="content" source="../../media/build-process.png" alt-text="Screenshot of Wait for the build process." lightbox="../../media/build-process.png":::

    Double-click the Executable file to open the PC Holographic Remoting Application on your PC.

    > [!Note]
    > Due to some known issues in building the Holographic Remoting app for UWP, we're building as Windows Standalone for OpenXR.

## [Legacy WSA](#tab/wsa)

Your Holographic Remoting app is now ready to build on your PC. Follow the below steps and make these changes to build this application on to your PC.

### 1. Set the player settings

1. In the **XR Settings** section, select  **WSA Holographic Remoting Supported** to enable Holographic Remoting.

    :::image type="content" source="../../media/xr-settings.png" alt-text="Screenshot of XR Settings." lightbox="../../media/xr-settings.png":::

### 2. Build the Unity project

1. In the menu bar, select **File** > **Build Settings**, In the Build Settings window, click the **Add Open Scenes** button to add your current scene to the Scenes. In the Build list, then click the **Build** button to open the Build Universal Windows Platform window:

    :::image type="content" source="../../media/add-open-scenes.png" alt-text="Screenshot of Add Open Scenes." lightbox="../../media/add-open-scenes.png":::

2. In the Build Universal Windows Platform window, choose a suitable location to store your build--for example, Documents\MixedRealityLearning. Next, create a new folder and give it a proper name--for example, PCHolographicRemoting--and then click the **Select Folder** button to start the build process:

    :::image type="content" source="../../media/folder-select.png" alt-text="Screenshot of Select Folder." lightbox="../../media/folder-select.png":::

3. Wait for Unity to finish the build process.

    :::image type="content" source="../../media/finish-build-process.png" alt-text="Screenshot of Wait for the build process." lightbox="../../media/finish-build-process.png":::

### 3. Build and deploy the application

1. After the build process has finished, Unity will prompt Windows File Explorer to open where you stored the build. Navigate to the folder and then double-click the .sln file to open it in Visual Studio:

    :::image type="content" source="../../media/sln-file.png" alt-text="Screenshot of the sln file." lightbox="../../media/sln-file.png":::

    > [!Note]
    > If Visual Studio asks you to install new components, take a moment to ensure that all prerequisite components are installed as specified in the Install the Tools documentation.

2. Configure Visual Studio for PC by selecting the Release configuration, the x64 architecture, and Local Machine as target:

    :::image type="content" source="../../media/release-configuration.png" alt-text="Screenshot of Select the Release configuration." lightbox="../../media/release-configuration.png":::

    Click the button that says **Local Machine**. This begins the process of building the application and deploys it to your PC. The application is installed on your PC by default.
