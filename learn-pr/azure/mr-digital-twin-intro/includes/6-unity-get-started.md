A complete Unity project has been prepared for you to assist with this learning path.  Download the code from the GitHub repository and extract the Zip file to your destination Unity Project Path of choice. 

## Install the tools

To build Mixed Reality solutions in Unity, you need a few different development tools:  

- Install the [required tools](https://docs.microsoft.com/windows/mixed-reality/develop/install-the-tools?tabs=unity)
    - You can have multiple versions of Unity on your computer, managed within the Unity Hub.  When selecting a version of Unity, install **Unity 2020.3.x LTS**, which is supported for this module.  The LTS stands for Long-Term Support and Unity is committed to supporting 2020.3 LTS releases until March 2023.
    - Launch the **Mixed Reality Feature Tool** (MixedRealityFeatureTool.exe) and select **Start** to begin installing MRTK components to your Unity Project. 

:::image type="content" source="../media/mrft-splash-screen.png" alt-text="Screenshot of the Mixed Reality Feature Tool start window.":::

- Click on **Select Project**. Click the three ellipses **“...”**  button to browse for the folder where you downloaded and extracted the Unity project. The folder you select here must be immediately above the Asset folder, which contains the entire Unity Project.

:::image type="content" source="../media/mrft-select-project.png" alt-text="Screenshot of the Mixed Reality Feature Tool select project window.":::

- Select Discover Features
- Ensure you select the following versions to ensure compatibility with the supplied Unity project:
    - Mixed Reality Toolkit Extensions 2.5.4
    - Mixed Reality Toolkit Foundation 2.5.4
    - Mixed Reality Toolkit GPU Stats 1.0.3
    - Mixed Reality Toolkit Plane Finding 1.0.0
    - Mixed Reality Toolkit Standard Assets 2.5.4
    - Mixed Reality Open XR Plugin 0.1.3
    - Microsoft Spatializer 1.0176
    - Mixed Reality Input 0.9.2006

:::image type="content" source="../media/mrft-discover-features.png" alt-text="Screenshot of the Mixed Reality Feature Tool discover features window.":::

- After making these selections, select **Get Features**. This will download the corresponding packages and keep them in a temporary location (that is, package cache).
- Validate your package selection and select **Import**. The packages will be copied into the Unity Project and the necessary modifications in the project’s package manifest are made.

:::image type="content" source="../media/mrft-import-features.png" alt-text="Screenshot of the Mixed Reality Feature Tool import features window.":::

- You may see the following screen if you've imported the same MRTK components previously.  It's safe to select **Approve**.

:::image type="content" source="../media/mrft-review-and-approve.png" alt-text="Screenshot of the Mixed Reality Feature Tool review and approve window.":::

- When the Tool completes, select **Exit** to leave the Mixed Reality Feature Tool.

## Verify Unity project dependencies

Open and verify your Unity Project has the required dependencies and settings.

- Open the Unity Hub and select **Projects** from the upper left of the window.  Add your project to the list using the **ADD** button.  

:::image type="content" source="../media/unity-project-spalsh-screen.png" alt-text="Screenshot of the Unity Hub application with the projects tab selected.":::

- Browse to the folder where you extracted the Project contents from the Zip file obtained from GitHub and Select Folder.
- Open the Project by clicking on the project name.  
    - If an orange exclamation point shows under the project name, hover over it for a description and suggested actions (for example, incorrect Unity version, install)
- Locate the Main scene in the Project panel in **Assets > Scenes > MainScene** and double-click it.

:::image type="content" source="../media/main-scene.png" alt-text="Screenshot of the Unity editor with the Main Scene loaded.":::

If no error messages appear, your Project is ready to be configured / developed.

## Finalize project settings

This Project uses the OpenXR plug-in.  OpenXR is an open, royalty-free standard developed by Khronos that aims to simplify AR/VR development by allowing developers to seamlessly target a wide range of AR/VR devices.  This new plug-in requires a minor configuration change to support input that interfaces with OpenXR in the Unity Editor.  Before running the Project in Unity using the Play button:
- Enable the **Lock Input to the Game View** option. This can be found in the **Window > Analysis > Input Debugger > Options** dropdown menu.  This setting persists in your editor, so you only need to do this once.  

:::image type="content" source="../media/lock-input-game-view.png" alt-text="Screenshot of the Unity input debugger panel with the options dropdown selected and lock input to game view highlighted.":::

Gizmos are a graphic overlay associated with a GameObject in a Scene, and displayed in the Scene View. Built-in scene tools such as the move tool are Gizmos, and you can create custom Gizmos using textures or scripting. Some Gizmos are only drawn when the GameObject is selected, while other Gizmos are drawn by the Editor no matter which GameObjects are selected.  You'll want to adjust the size of the Gizmos for your Scene, so that your Scene is not overwhelmed by ‘large blue objects’.  

- Select the **Gizmos** dropdown and adjust the size via the slider.  
- Also, you can toggle Gizmos on and off by selecting the Gizmos button at the top of your Scene.

:::image type="content" source="../media/gizmos-size.png" alt-text="Screenshot of the Unity editor with gizmos selected.":::