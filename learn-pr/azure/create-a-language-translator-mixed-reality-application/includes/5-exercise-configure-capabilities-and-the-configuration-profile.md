In Unity, specific capabilities must be enabled to use APIs and resources such as a microphone in a Mixed Reality experience. Recall that in the collaboration tools example, there's a need for a microphone to capture speech also internet for using the Azure Cognitive Services Speech service. Here you'll configure a Unity project to use the Azure Cognitive Services Speech SDK for speech translation.

## Create and configure a new Unity project for Windows Mixed Reality development with MRTK

> [!NOTE]
> If you are unfamiliar with the process of configuring a Unity project for Windows Mixed Reality development, refer to the [Set Up a Mixed Reality Project in Unity with the Mixed Reality Toolkit](https://docs.microsoft.com/learn/modules/mixed-reality-toolkit-project-unity/?azure-portal=true) Learn module for an overview.

1. Create a new 3D Unity project.
1. Navigate to **File** > **Build Settings** to switch the **Build Platform** to **Universal Windows Platform**.
1. In the **Build Settings** window, select **Player Settings** at  the bottom left of the window. In the **Player** section, expand **XR Settings** (located at the bottom of the window). Enable Virtual Reality and add the **Windows Mixed Reality** SDK.
    :::image type="content" source="../media/add-sdk.png" alt-text="A screenshot of the X R settings. The virtual reality supported box is highlighted and checked. The plus icon to add a new S D K is highlighted and checked.":::
1. Optimize the **XR Settings** as follows:
    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**
    - Check the Windows Mixed Reality **Enable Depth Sharing** checkbox
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**
    :::image type="content" source="../media/optimize-xr-settings.png" alt-text="A screenshot of the X R settings. The Virtual Reality S D K s section is highlighted. The Depth Format is set to 16 bit depth. The Enable Depth Sharing box is checked. Also, the Stereo Rendering Mode section is highlighted.  The Stereo Rendering Mode is set to single pass instanced.":::
1. Navigate to **Window** > **TextMeshPro** and select **Import TMP Essential Resources** to import all of the TMP Essential Resources assets.
1. Download the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** from the [MRTK release page](https://github.com/Microsoft/MixedRealityToolkit-Unity/releases?azure-portal=true).
1. Navigate to **Assets** > **Import Package** > **Custom Package** and import all the assets within the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** package. After the import is complete, the Mixed Reality Toolkit is added to the top navigation menu.
1. The MRTK Project Configurator window may open after the Mixed Reality Toolkit is imported into the project. If not, in the top navigation menu, navigate to **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**. In the **Audio spatializer** drop down, select **MS HRTF Spatializer**.
1. In the top navigation menu, navigate to **Mixed Reality Toolkit** > **Add to Scene and Configure** to add the **Mixed Reality Toolkit** to the scene.

## Change Speech Commands Start Behavior

By default, the MRTK Speech Commands are configured to start automatically when a Unity scene loads. Since this app requires speech input, the MRTK Speech Commands **Start Behavior** must be set to **Manual Start** to not interfere with the Cognitive Services Speech SDK. Given the default configuration profiles that come with the Mixed Reality Toolkit cannot be modified, the configuration profile settings must be cloned to modify the MRTK Speech Commmands **Start Behavior**.

1. In the Unity menu, select the **MixedRealityPlayspace** object. The object's properties will display in the **Inspector** window.

    :::image type="content" source="../media/select-mixedrealityplayspace.png" alt-text="A screenshot of the Inspector window. The Mixed Reality Playspace object is highlighted.":::

1. In the **Inspector** window, select **DefaultMixedRealityToolkitConfigurationProfile** for the **Configuration Profile**.

    :::image type="content" source="../media/default-configuration-profile.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The Default Mixed Reality Toolkit Configuration Profile is highlighted.":::

1. In the **Inspector** window, select **Clone** to clone the profile. The **Cloning profile** window will open.

    :::image type="content" source="../media/configuration-profile-clone.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationConfigurationProfile** as the **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationconfigureprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Default Mixed Reality Toolkit Configuration Profile.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-configuration-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted to clone the Speech Translation Configuration profile.":::

1. In the **Inspector** window, select **Input** to open the Input settings.

    :::image type="content" source="../media/select-input.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The menu selection Input is highlighted.":::

1. In the **Input** settings, select **Clone** to clone the Input System Profile. The **Cloning profile** window will open.

    :::image type="content" source="../media/clone-input-system-profile.png" alt-text="A screenshot of the Input System profile settings. The clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationInputSystemProfile** as the **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationinputsystemprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Speech Translation Input System Profile.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-input-system-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted to clone the default mixed reality input system profile.":::

1. In the **Input** settings, expand the **Speech** settings.

    :::image type="content" source="../media/expand-speech-settings.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The Input menu option is highlighted. The Speech settings section is highlighted and expanded.":::

1. In the **Speech** settings, select **Clone** to clone the Speech Commands profile. The **Cloning profile** window will open.

    :::image type="content" source="../media/speech-commands-profile-clone.png" alt-text="A screenshot of the Speech Commands profile. The clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationSpeechCommandsProfile** as the **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationspeechcommandsprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Speech Translation Speech Commands Profile.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-speech-commands-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted to clone the default mixed reality speech commands profile.":::

1. In the **Speech** settings, select **Manual Start** for the **Start Behavior**.

    :::image type="content" source="../media/start-behavior.png" alt-text="A screenshot of the Speech Commands profile. The Start Behavior setting is highlighted. The drop option Manual Start is selected.":::

## Add Capabilities

To enable APIs or resources (such as a microphone) to access the app, you must enable the capability in the Unity Project Settings.

1. In the Unity menu, select **Edit** > **Project Settings**.

    :::image type="content" source="../media/project-settings.png" alt-text="A screenshot of the Unity interface. The Edit menu is open. Project settings is highlighted.":::

1. In the **Project Settings** window, select **Player** to the open the Player settings.

    :::image type="content" source="../media/player-settings.png" alt-text="A screenshot of the Project Settings window. The Player option from the left  menu is highlighted.":::

1. In the **Player** settings, expand the **Publishing Settings**.

    :::image type="content" source="../media/publishing-settings.png" alt-text="A screenshot of the Project Settings widow. The Publishing Settings is highlighted. The settings for Publishing Settings are expanded.":::

1. In the **Capabilities** section, enable the following capabilities:
    - InternetClient
    - InternetClientServer
    - PrivateNetworkClientServer
    - Microphone
    
    :::image type="content" source="../media/select-capabilities.png" alt-text="A screenshot of the Capabilities section. The Internet Client, Internet Client Server, Private Network Client Server, and Microphone capabilities are enabled.":::

## Import the Cognitive Services Speech Unity package

1. Download the **Azure Cognitive Services Speech SDK** from [aka.ms/csspeech/unitypackage](https://aka.ms/csspeech/unitypackage/?azure-portal=true).
1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package**.

    :::image type="content" source="../media/import-package.png" alt-text="A screenshot of the Unity interface. The Edit menu is open and Import Package, Custom Package is highlighted.":::

1. In the **Import package...** window, select the **Azure Cognitive Services Speech SDK** you downloaded and select **Open**.

    :::image type="content" source="../media/select-speech-package.png" alt-text="A screenshot of the file explorer. The Azure Cognitive Services Speech S D K is highlighted. The Open button is also highlighted.":::

1. In the **Import Unity Package** window, select the **All** button to ensure all the assets are selected, then select the **Import** button to import the assets.

    :::image type="content" source="../media/import-speech-package.png" alt-text="A screenshot of the Import Unity Package window. The window displays all the assets within the Azure Cognitive Services Speech S D K. The All and Import buttons are highlighted.":::