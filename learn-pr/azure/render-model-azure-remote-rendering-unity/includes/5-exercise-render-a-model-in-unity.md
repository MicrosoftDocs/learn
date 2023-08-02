In this exercise, you load a Unity sample project that includes a built-in 3D model of the truck engine. You configure the Unity scene, then enter your Azure Remote Rendering credentials in the `RemoteRendering` game object. You then use Remote Rendering to remotely render the truck engine 

## Clone and open the sample project

1. At a Windows command prompt, run the following commands to clone the GitHub sample repository and set up the necessary subdirectories and packages for the Unity project.

   ```cmd
   mkdir ARR
   cd ARR
   git clone https://github.com/Azure/azure-remote-rendering
   powershell -ExecutionPolicy RemoteSigned -File azure-remote-rendering\Scripts\DownloadUnityPackages.ps1
   ```

1. Open Unity Hub and add the sample project, which is the *ARR/azure-remote-rendering/Unity/Quickstart* folder. Allow Unity to upgrade the project to your installed version if necessary.
1. Once added, open the project in Unity.

> [!NOTE]
> For an overview of the process of configuring a Unity project for Windows Mixed Reality development, see the [Set up a Mixed Reality project in Unity with the Mixed Reality Toolkit](/training/modules/mixed-reality-toolkit-project-unity/?azure-portal=true) training module.

## Configure the Unity settings

1. Go to **File** > **Build Settings** and switch **Build Platform** to **Universal Windows Platform**.

1. Select **Player Settings** at the bottom of the **Build Settings** window.

1. Select **OpenXR** under **XR Plug-in Management** in the left navigation of the **Project Settings** window.

1. On the **OpenXR** screen, select **Single Pass Instanced** for **Render Mode** and **Depth 16 Bit** for **Depth Submission Mode**.

   :::image type="content" source="../media/optimize-xr-settings.png" alt-text="Screenshot of the OpenXR settings.":::

1. Close the **Settings** windows.

## Configure the RemoteRendering game object

1. In the **Project** pane, select the **Scenes** folder under **Assets** in the left navigation, and then select the **Quickstart** scene.

   :::image type="content" source="../media/project-window.png" alt-text="Screenshot of the Project pane with the Quickstart scene selected in the Scenes window.":::

1. In the **Hierarchy** pane at upper left, select the **RemoteRendering** game object.

1. In the **Inspector** pane on the right, enter the following Azure Remote Rendering credentials under **Remote Rendering (Script)**:

   - **Remote Rendering Domain**: Enter an Azure location near you in the format *\<region>.mixedreality.azure.com*. The rendering domain can be, but doesn't have to be, the same as the **Account Domain**.
   - **Account Domain**: Your Remote Rendering **Account Domain** that you copied from the Azure portal.
   - **Account Id**: Your Remote Rendering **Account ID** that you copied from the Azure portal.
   - **Account Key**: Your Remote Rendering **Primary key** that you copied from the Azure portal.

   > [!IMPORTANT]
   > Be sure not to expose these saved credentials by checking the project into a repository.

1. Set the **Max Lease Time** to 0 hours and 10 minutes. The maximum lease time is the duration of the remote rendering session.

   :::image type="content" source="../media/azure-credentials.png" alt-text="Screenshot of the Remote Rendering script settings.":::

## Start a session and render the model in play mode

In the Unity top toolbar, select the **Play** icon to enter play mode and start the session. An overlay with status text displays at the bottom of the **Game** window, and the session goes through a series of state transitions. 

In the **Starting** state, the server spins up, which takes several minutes. Upon success, the session transitions to the **Ready** state. Next, the session enters the **Connecting** state to reach the rendering runtime on the server.

When connected, the session transitions to the **Connected** state and downloads the model for rendering. The download can take a few minutes. When the download is complete, the remotely rendered model appears.

:::image type="content" source="../media/arr-sample-output.png" alt-text="Screenshot of the rendered engine in the Game window.":::
