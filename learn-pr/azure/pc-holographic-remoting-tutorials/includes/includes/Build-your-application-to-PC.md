# [Unity 2020 + OpenXR](#tab/openxr)

## 1. Switching Build Platform
In the menu bar, select **File** > **Build Settings**.

1. In the Build Settings window, select PC, Mac & Linux Standalone Platform and click the Switch Platform button to change the Build Platform:

![Switching Build Platform](../../media/tutorial2-section2-step4-1.png)

## 2. Set the project settings

1. In the menu bar, select **Edit > Project Settings > XR Plug-in Management**. Ensure that you're in the Windows Standalone tab and then select **OpenXR** and **Windows Mixed Reality feature**.

![Project settings](../../media/a4.png)

2. In the Project Settings window, select **OpenXR**. Ensure that you're in the Windows Standalone tab, and then change the **Depth submission mode** from None to **Depth 16** Bit.

3. In the Interaction Profiles tab, add **Eye Gaze Interaction Profile**and **Microsoft Hand Interaction Profile** by clicking on the plus sign ("+") button.

![Eye Gaze Interaction Profile](../../media/a5.png)

4. Under **Open XR feature groups > All features** , select **Holographic App Remoting**.

![XR feature groups](../../media/a6.png)

5. Select **Windows Mixed Reality**, and then under the **Windows Mixed Reality** group, select **Holographic App Remoting**.

![Holographic App Remoting](../../media/a7.png)

## 3. Build the Unity Project

In the menu bar, select **File** > **Build Settings**.

1. In the Build Settings window, click **Add Open Scenes** to add your current scene to the Scenes list. In the Build list, click the **Build** button:

![Add Open Scenes](../../media/a8.png)

2. Choose a suitable location to store your build--for example, Documents\MixedRealityLearning. Create a new folder and give it a suitable name--for example, PCHolographicRemoting--and then click the **Select Folder** button to start the build process:

![Select Folder](../../media/a9.png)

3. Wait for Unity to finish the build process.

![Wait for the build process](../../media/a10.png)

Double-click the Executable file to open the PC Holographic Remoting Application on your PC.

> [!Note]
> Due to some known issues in building the Holographic Remoting app for UWP, we're building as Windows Standalone for OpenXR.

# [Legacy WSA](#tab/wsa)

## 1. Set the player settings

1. In the **XR Settings** section, select  **WSA Holographic Remoting Supported** to enable Holographic Remoting.

![XR Settings](../../media/a12.png)

## 2. Build the Unity Project
In the menu bar, select **File** > **Build Settings**.

1. In the Build Settings window, click the **Add Open Scenes**button to add your current scene to the Scenes. In the Build list, then click the **Build** button to open the Build Universal Windows Platform window:

![Add Open Scenes](../../media/a13.png)

2. In the Build Universal Windows Platform window, choose a suitable location to store your build--for example, Documents\MixedRealityLearning. Create a new folder and give it a suitable name--for example, PCHolographicRemoting--and then click the **Select Folder** button to start the build process:

![Select Folder](../../media/a14.png)

3. Wait for Unity to finish the build process.

![Wait for build process](../../media/a15.png)

## 3. Build and deploy the application

1. After the build process has finished, Unity will prompt Windows File Explorer to open the location where you stored the build. Navigate to the folder and then double-click the .sln file to open it in Visual Studio:

![Double-click the .sln file](../../media/a16.png)

> [!Note]
> If Visual Studio asks you to install new components, take a moment to ensure that all prerequisite components are installed as specified in the Install the Tools documentation.

2. Configure Visual Studio for PC by selecting the Release configuration, the x64 architecture, and Local Machine as target:

![Configure Visual Studio](../../media/a17.png)

Click the button that says **Local Machine**. This begins the process to build the application and deploy it to your PC. The application is installed on your PC by default.



