Your Holographic Remoting app is now ready to build on your PC. Follow the below steps and make these changes to build this application on to your PC.

### 1. Add HolographicRemoteConnect Script

Add the **HolographicRemoteConnect** script to an object in the scene, such as the **MRTK XR Rig**.
This script provides a minimalistic UI for entering the IP address of the HoloLens at runtime, and a button to connect and disconnect.
It is intended as an example for how to connect from C# code in builds. See also the section later about connecting in play mode
for faster testing.

### 2. Switch build platform

In the menu bar, select **File** > **Build Settings**.

1. In the Build Settings window, select PC, Mac & Linux Standalone Platform and select the Switch Platform button to change the Build Platform:

    :::image type="content" source="../../media/switch-build-platform.png" alt-text="Screenshot of Switching Build Platform." lightbox="../../media/switch-build-platform.png":::

### 3. Set the project settings

1. In the menu bar, select **Edit > Project Settings > XR Plug-in Management**. Ensure that you're in the Windows Standalone tab and then select **OpenXR**, **Windows Mixed Reality feature** and **Holographic Remoting remote app feature group**.

    :::image type="content" source="../../media/project-settings.png" alt-text="Screenshot of Project settings." lightbox="../../media/project-settings.png":::

2. In the Project Settings window, select **OpenXR**. Ensure that you're in the Windows Standalone tab, and then change the **Depth submission mode** from None to **Depth 16** Bit.

3. Add **Eye Gaze Interaction Profile** and **Microsoft Hand Interaction Profile** by clicking on the plus sign ("+") button in the Interaction Profiles tab.

    :::image type="content" source="../../media/eye-gaze-interaction-profile.png" alt-text="Screenshot of Eye Gaze Interaction Profile." lightbox="../../media/eye-gaze-interaction-profile.png":::

4. Under **Open XR feature groups > All features**, select **Holographic App Remoting**.

    :::image type="content" source="../../media/xr-feature-groups.png" alt-text="Screenshot of XR feature groups." lightbox="../../media/xr-feature-groups.png":::

### 4. Build the Unity project

In the menu bar, select **File** > **Build Settings**.

1. Select **Add Open Scenes** to add your current scene to the Scenes list in the Build Settings window. Then, in the Build list, select the **Build** button:

    :::image type="content" source="../../media/add-open-scene.png" alt-text="Screenshot of Add Open Scenes." lightbox="../../media/add-open-scene.png":::

2. Choose a suitable location to store your build--for example, Documents\MixedRealityLearning. Create a new folder and give it a proper name--for example, PCHolographicRemoting--and then select the **Select Folder** button to start the build process:

    :::image type="content" source="../../media/select-folder.png" alt-text="Screenshot of Select Folder." lightbox="../../media/select-folder.png":::

3. Wait for Unity to finish the build process.

    :::image type="content" source="../../media/build-process.png" alt-text="Screenshot of Wait for the build process." lightbox="../../media/build-process.png":::

    Double-click the Executable file to open the PC Holographic Remoting Application on your PC.

    > [!Note]
    > Due to some known issues in building the Holographic Remoting app for UWP, we're building as Windows Standalone for OpenXR.
