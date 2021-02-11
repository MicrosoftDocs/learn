A sample project is available which includes a built-in model of the truck engine to render. To render the model, the Unity scene must first be configured. Afterwards, your Remote Rendering resource credentials must be entered for the **RemoteRendering** game object.
	
Here, you will configure the Unity project and scene to render the truck engine in Unity.

## Clone the sample project and configure the Unity scene

> [!NOTE]
> If you're unfamiliar with the process of configuring a Unity project for Windows Mixed Reality development, see the [Set up a Mixed Reality project in Unity with the Mixed Reality Toolkit](https://docs.microsoft.com/learn/modules/mixed-reality-toolkit-project-unity/?azure-portal=true) Learn module for an overview.

1. In the command prompt (type **cmd** in Windows start menu), run the following commands to clone the GitHub repository which contains the Unity project.

    ```bash
    mkdir ARR
    cd ARR
    git clone https://github.com/Azure/azure-remote-rendering
    ```

1. In the Unity Hub, add the sample project which is the **ARR/azure-remote-rendering/Unity/Quickstart** folder. If necessary, allow Unity to upgrade the project to your installed version. Once added, open the project in Unity.

1. Go to **File** > **Build Settings** to switch **Build Platform** to **Universal Windows Platform**.

1. In the **Build Settings** window, select **Player Settings**. In the **Player** section, expand **XR Settings**. Enable **Virtual Reality Supported** and add the **Windows Mixed Reality SDK**.

    :::image type="content" source="../media/add-sdk.png" alt-text="    Screenshot of the X R settings. The Virtual Reality Supported box is highlighted and selected. The plus icon to add a new S D K is highlighted and selected.":::

1. Optimize XR Settings as follows:

- Set Windows Mixed Reality **Depth Format** to **16-bit depth**.
- Select the Windows Mixed Reality **Enable Depth Buffer Sharing** check box.
- Set **Stereo Rendering Mode** to **Single Pass Instanced**.

:::image type="content" source="../media/optimize-xr-settings.png" alt-text="    Screenshot of the X R settings. The Virtual Reality S D K section and Stereo Rendering Mode section are highlighted. Depth Format is set to 16-bit depth. The Enable Depth Sharing box is selected. Stereo Rendering Mode is set to Single Pass Instanced.":::

## Configure the RemoteRendering game object

1. In the **Project** window, navigate to the **Scenes** folder and open the **Quickstart** scene

    :::image type="content" source="../media/project-window.png" alt-text="Screenshot of the project window. The scene folder and quick start file are highlighted.":::

1. In the **Hierarchy** window, select the **RemoteRendering** game object.

1. In the **Inspector** window, enter the following in the **Remote Rendering (Script)** component:

- **Account Domain**: The **Account Domain** for the Remote Rendering resource.
- **Account Authentication Domain**: The **Account Domain** for the Remote Rendering resource.
- **Account ID**: The **Account ID** for the Remote Rendering resource.
- **Account Key**: The **Primary key** for the Remote Rendering resource.

    :::image type="content" source="../media/azure-credentials.png" alt-text="Screenshot of the remote rendering script. The account domain, account authentication domain, account i d and account key are highlighted.":::

> [!WARNING]
> Be sure to not check the project with your saved credentials into a repository.

## Start a session and render the model in play mode

In the Unity toolbar, select the **Play** icon to enter play mode and start the session. An overlay with status text should display at the bottom of the **Game** window. The session will undergo a series of state transitions. 

In the **Starting** state, the server is spun up, which takes several minutes. Upon success, it transitions to the **Ready** state. Next, the session enters the **Connecting** state, where it tries to reach the rendering runtime on that server. When successful, the sample transitions to the **Connected** state. At this point, it will start downloading the model for rendering. Because of the model's size, the download can take a few more minutes. Once the download is complete, the remotely rendered model will appear.

:::image type="content" source="../media/arr-sample-output.png" alt-text="Screenshot of the rendered engine in the game window.":::
