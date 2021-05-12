A complete Unity project has been prepared for you to assist with this learning path.  Download the code from the GitHub repository and extract the Zip file to your destination Unity Project Path of choice. 

To build Mixed Reality solutions in Unity, you require a number of different development tools.  You can have multiple versions of Unity on your computer, managed within the Unity Hub. 

1. Download and Unzip the compressed folder from GitHub and take note of the folder location to where you extracted the project.
2. From within the Unity Hub, select **Installs** from the panel on the left side.

    :::image type="content" source="../media/unity-hub-installs.png" alt-text="Screenshot of the Unity Hub application open to the installs window.":::

    > [!IMPORTANT]
    > **Unity 2020.3.0f1 LTS** is used for this learning path.  If you do not see it installed already, you must download the file from [Unity Download Archive](https://unity3d.com/unity/qa/lts-releases?version=2020.3), directly download an [.exe installation file](https://download.unity3d.com/download_unity/c7b5465681fb/UnityDownloadAssistant-2020.3.0f1.exe?_gl=1*xhk3at*_gcl_aw*R0NMLjE2MTk0NTIxNjEuQ2owS0NRand5Wm1FQmhDcEFSSXNBTEl6bW5MVDFtUkdzUDZvbGJxYXhjczJTSmh0b0trTWVoTFN6OEtRU3FtbllTdFc2NFo3ZnZETUpJWWFBb1BiRUFMd193Y0I.&_ga=2.32276217.651960466.1620515396-381725108.1597335987&_gac=1.15686084.1619452162.Cj0KCQjwyZmEBhCpARIsALIzmnLT1mRGsP6olbqaxcs2SJhtoKkMehLSz8KQSqmnYStW64Z7fvDMJIYaAoPbEALw_wcB), or install from [Unity Hub](unityhub://2020.3.0f1/c7b5465681fb).  The LTS stands for Long Term Support and Unity is committed to supporting 2020.3 LTS releases until March 2023. Depending on your PC and your Internet connection, this can take 10-15min.
    
## Install MRTK components

1. Launch the **Mixed Reality Feature Tool** (MixedRealityFeatureTool.exe) and select **Start** to begin installing MRTK components to your Unity Project. 

    :::image type="content" source="../media/mrft-splash-screen.png" alt-text="Screenshot of the Mixed Reality Feature Tool start window.":::

2. Click on **Select Project**. Click the three ellipses **“...”**  button to browse for the folder where you downloaded and extracted the Unity project. The folder you select here must be immediately above the **Asset** folder, which contains the entire Unity Project.

    :::image type="content" source="../media/mrft-select-project.png" alt-text="Screenshot of the Mixed Reality Feature Tool select project window.":::

3. Select Discover Features
4. Ensure you select the following versions to ensure compatibility with the supplied Unity project:
    - Mixed Reality Toolkit Extensions 2.5.4
    - Mixed Reality Toolkit Foundation 2.5.4
    - Mixed Reality Toolkit GPU Stats 1.0.3
    - Mixed Reality Toolkit Plane Finding 1.0.0
    - Mixed Reality Toolkit Standard Assets 2.5.4
    - Mixed Reality Open XR Plugin 0.1.3
    - Microsoft Spatializer 1.0176
    - Mixed Reality Input 0.9.2006

    :::image type="content" source="../media/mrft-discover-features.png" alt-text="Screenshot of the Mixed Reality Feature Tool discover features window.":::

5. Select **Get Features**. This will download the corresponding packages and keep them in a temporary location (i.e., package cache).
6. Validate your package selection and select **Import**. The packages will be copied into the Unity Project and the necessary modifications in the project’s package manifest are made.

    :::image type="content" source="../media/mrft-import-features.png" alt-text="Screenshot of the Mixed Reality Feature Tool import features window.":::

7. You may see the following screen if you've imported the same MRTK components previously.  It's safe to select **Approve**.

    :::image type="content" source="../media/mrft-review-and-approve.png" alt-text="Screenshot of the Mixed Reality Feature Tool review and approve window.":::

8. When the Tool completes, select **Exit** to leave the Mixed Reality Feature Tool.

## Verify Unity project dependencies

Open and verify your Unity Project has the required dependencies and settings.

1. Open the Unity Hub and select **Projects** from the upper left of the window.  Add your project to the list using the **ADD** button.  

    :::image type="content" source="../media/unity-project-spalsh-screen.png" alt-text="Screenshot of the Unity Hub application with the projects tab selected.":::

2. Browse to the folder where you extracted the Project contents from the Zip file obtained from GitHub and **Select Folder**.

    > [!NOTE]
    > If an orange exclamation mark shows under the project name, hover over it for a more detailed description of the message, including suggested actions (e.g., incorrect Unity version, install)

3. Open the Project by clicking on the project name.  This can take several minutes while Unity imports and compiles the associated packages  
4. Locate the Main scene in the Project panel in **Assets > Scenes > MainScene** and double-click it.

    :::image type="content" source="../media/main-scene.png" alt-text="Screenshot of the Unity editor with the Main Scene loaded." lightbox="../media/main-scene-expanded.png":::

If no error messages appear, your Project is ready to be configured / developed. You may notice Warning messages, which are acceptable and will not interfere with your Project functionality.

## Finalize project settings

This Project uses the OpenXR plug-in.  OpenXR is an open, royalty-free standard developed by Khronos that aims to simplify AR/VR development by allowing developers to seamlessly target a wide range of AR/VR devices.  This new plug-in requires a minor configuration change to support input that interfaces with OpenXR in the Unity Editor.  Before running the Project in Unity using the Play button:
- Enable the **Lock Input to the Game View** option. This can be found in the **Window > Analysis > Input Debugger > Options** dropdown menu.  This setting persists in your editor, so you only need to do this once.  

:::image type="content" source="../media/lock-input-game-view.png" alt-text="Screenshot of the Unity input debugger panel with the options dropdown selected and lock input to game view highlighted.":::