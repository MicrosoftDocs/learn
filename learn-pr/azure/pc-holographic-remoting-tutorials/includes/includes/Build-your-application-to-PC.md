# [Unity 2020 + OpenXR](#tab/openxr)

## 1. Switching Build Platform
In the Unity menu, select File > Build Settings to open the Build Settings window.

1. In the Build Settings window, select PC, Mac & Linux Standalone Platform and click the Switch Platform button to change the Build Platform:

:::image type="content" source="../media/tutorial2-section2-step4-1.png" alt-text="Switching Build Platform." lightbox="tutorial2-section2-step4-1.png":::

## 2. Set the project settings

1. In the Unity menu, select **Edit > Project Settings > XR Plug-in Management** ensure that you are in Windows Standalone tab and check the **OpenXR** and **Windows Mixed Reality feature** set checkbox.

:::image type="content" source="../media/a4.png" alt-text="Project settings." lightbox="a4.png":::

2. In Project Settings window, select **OpenXR** and ensure that you are in Windows Standalone tab and change the **Depth submission mode** from None to **Depth 16** Bit.

3. In interaction profiles tab add **Eye Gaze Interaction Profile**and **Microsoft Hand Interaction Profile** by clicking on the + symbol.

:::image type="content" source="../media/a5.png" alt-text="Eye Gaze Interaction Profile" lightbox="a5.png":::

4. Under **Open XR feature groups > All features** > check the Holographic App Remoting checkbox.

:::image type="content" source="../media/a6.png" alt-text="XR feature groups" lightbox="a6.png":::

5. Next select the **Windows Mixed Reality** check box and under Windows Mixed Reality group select the **Holographic App Remoting** checkbox.

:::image type="content" source="../media/a7.png" alt-text="Holographic App Remoting" lightbox="a7.png":::

## 3. Build the Unity Project

In the Unity menu, select File > Build Settings to open the Build Settings window.

1. In the Build Settings window, click the **Add Open Scenes** button to add your current scene to the Scenes. In the Build list, then click the **Build** button:

:::image type="content" source="../media/a8.png" alt-text="Add Open Scenes" lightbox="a8.png":::

2. Choose a suitable location to store your build, for example, Documents\MixedRealityLearning. Create a new folder and give it a suitable name, for example, PCHolographicRemoting. Then click the **Select Folder** button to start the build process:

:::image type="content" source="../media/a9.png" alt-text="Select Folder" lightbox="a9.png":::

3. Wait for Unity to finish the build process.

:::image type="content" source="../media/a10.png" alt-text="Wait for the build process" lightbox="a10.png":::

Double click on the Executable file to open the PC Holographic Remoting Application in your PC.

>[!Note]
>Due to some known issues in Holographic Remoting for PC app Built as UWP we are Building the PC App as Windows Standalone for OpenXR.

# [Legacy WSA](#tab/wsa)

## 1. Set the player settings

1. In the **XR Settings** section, select the **WSA Holographic Remoting Supported** checkbox and enable the Holographic Remoting.

:::image type="content" source="../media/a12.png" alt-text="XR Settings" lightbox="a12.png":::

## 2. Build the Unity Project
In the Unity menu, select File > Build Settings to open the Build Settings window.

1. In the Build Settings window, click the **Add Open Scenes**button to add your current scene to the Scenes. In the Build list, then click the **Build** button to open the Build Universal Windows Platform window:

:::image type="content" source="../media/a13.png" alt-text="Add Open Scenes" lightbox="a13.png":::

2. In the Build Universal Windows Platform window, choose a suitable location to store your build, for example, Documents\MixedRealityLearning. Create a new folder and give it a suitable name, for example, PCHolographicRemoting. Then click the **Select Folder** button to start the build process:

:::image type="content" source="../media/a14.png" alt-text="Select Folder" lightbox="a14.png":::

3. Wait for Unity to finish the build process.
:::image type="content" source="../media/a15.png" alt-text="Wait for build process" lightbox="a15.png":::

## 3. Build and deploy the application

1. When the build process is completed, Unity will prompt Windows File Explorer to open the location you stored the build. Navigate inside the folder, and double-click the .sln file to open it in Visual Studio:

:::image type="content" source="../media/a16.png" alt-text="Double-click the .sln file" lightbox="a16.png":::

>[!Note]
>If Visual Studio asks you to install new components, take a moment to ensure that all prerequisite components are installed as specified in the Install the Tools documentation.

2. Configure Visual Studio for PC by selecting the Release configuration, the x64 architecture, and Local Machine as target:

:::image type="content" source="../media/a17.png" alt-text="Configure Visual Studio" lightbox="a17.png":::

Click the button that says **Local Machine**. It starts to build and deploy the application on to your PC. The application will be installed in your PC by default.



