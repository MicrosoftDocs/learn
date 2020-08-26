In Unity, specific capabilities must be enabled to use APIs and resources such as a microphone in a Mixed Reality experience. Recall that in the collaboration tools example, there's a need for a microphone to capture speech in addition to internet for using the Azure Cognitive Services Speech service. Here you'll configure a Unity project to use the Azure Cognitive Services Speech SDK for speech translation.

## Create and configure a new Unity project for Windows Mixed Reality development with MRTK

> [!NOTE]
> If you are unfamiliar with the process of configuring a Unity project for Windows Mixed Reality development, refer to the [Set Up a Mixed Reality Project in Unity with the Mixed Reality Toolkit](https://docs.microsoft.com/learn/modules/mixed-reality-toolkit-project-unity/?azure-portal=true) Learn module for an overview.

1. Create a new 3D Unity project.
1. Switch the **Build Platform** to **Universal Windows Platform**.
1. In **Project Settings**, enable Virtual Reality and add the **Windows Mixed Reality** SDK.
1. In **Project Settings**, optimize the **XR Settings** as follows:
    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**
    - Check the Windows Mixed Reality **Enable Depth Sharing** checkbox
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**
1. Navigate to **Window** > **TextMeshPro** and select **Import TMP Essential Resources** to import all of the TMP Essential Resources assets.
1. Navigate to **Assets** > **Import Package** > **Custom Package** and import all the assets within the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** package.
1. The MRTK Project Configurator window may open after the Mixed Reality Toolkit is imported into the project. If not, navigate to **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**. In the **Audio spatializer** drop down, select **MS HRTF Spatializer**.
1. Navigate to **Mixed Reality Toolkit** > **Add to Scene and Configure** to add the **Mixed Reality Toolkit** to the scene.

## Change Speech Commands Start Behavior

The default configuration profiles that come with the Mixed Reality Toolkit cannot be modified. To change the configuration profile settings, the profile must be cloned.

1. In the Unity menu, select the **MixedRealityPlayspace** object. The object's properties will display in the **Inspector** window.
    :::image type="content" source="../media/select-mixedrealityplayspace.png" alt-text="A screenshot of the Inspector window. The Mixed Reality Playspace object is highlighted.":::
1. In the **Inspector** window, select **DefaultMixedRealityToolkitConfigurationProfile** for the **Configuration Profile**.
    :::image type="content" source="../media/default-configuration-profile.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The Default Mixed Reality Toolkit Configuration Profile is highlighted.":::
1. In the **Inspector** window, select **Clone** to clone the profile. The **Cloning profile** window will open.
    :::image type="content" source="../media/configuration-profile-clone.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The clone button is highlighted.":::
1. In the **Cloning profile** window, enter **SpeechTranslationConfigurationProfile** as the **Profile Name**.
    :::image type="content" source="../media/name-speechtranslationconfigureprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Default Mixed Reality Toolkit Configuration Profile.":::
1. Select **Clone**.
    :::image type="content" source="../media/select-clone-configuration-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted.":::
1. In the **Inspector** window, select **Input** to open the Input settings.
    :::image type="content" source="../media/select-input.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The menu selection Input is highlighted.":::
1. In the **Input** settings, select **Clone** to clone the Input System Profile. The **Cloning profile** window will open.
    :::image type="content" source="../media/clone-input-system-profile.png" alt-text="A screenshot of the Input System profile settings. The clone button is highlighted.":::
1. In the **Cloning profile** window, enter **SpeechTranslationInputSystemProfile** as the **Profile Name**.
    :::image type="content" source="../media/name-speechtranslationinputsystemprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Speech Translation Input System Profile.":::
1. Select **Clone**.
    :::image type="content" source="../media/select-clone-input-system-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted.":::
1. In the **Input** settings, expand the **Speech** settings.
    :::image type="content" source="../media/expand-speech-settings.png" alt-text="A screenshot of the Mixed Reality Toolkit configuration profile. The Input menu option is highlighted. The Speech settings section is highlighted and expanded.":::
1. In the **Speech** settings, select **Clone** to clone the Speech Commands profile. The **Cloning profile** window will open.
    :::image type="content" source="../media/speech-commands-profile-clone.png" alt-text="A screenshot of the Speech Commands profile. The clone button is highlighted.":::
1. In the **Cloning profile** window, enter **SpeechTranslationSpeechCommandsProfile** as the **Profile Name**.
    :::image type="content" source="../media/name-speechtranslationspeechcommandsprofile.png" alt-text="A screenshot of the Cloning Profile window. The profile name is highlighted. The profile name is Speech Translation Speech Commands Profile.":::
1. Select **Clone**.
    :::image type="content" source="../media/select-clone-speech-commands-profile.png" alt-text="A screenshot of the Cloning Profile window. The clone button is highlighted.":::
1. In the **Speech** settings, select **Manual Start** for the **Start Behavior**.
    :::image type="content" source="../media/start-behavior.png" alt-text="A screenshot of the Speech Commands profile. The Start Behavior setting is highlighted. The drop option Manual Start is selected.":::

## Add Capabilities

1. In the Unity menu, select **Edit** > **Project Settings**.
    :::image type="content" source="../media/project-settings.png" alt-text="A screenshot of the Unity inteface. The Edit menu is open. Project settings is highlighted.":::
1. In the **Project Settings** window, select **Player** to the open the Player settings.
    :::image type="content" source="../media/player-settings.png" alt-text="A screenshot of the Project Settings window. The Player option from the left  menu is highlighted.":::
1. In the **Player** settings, expand the **Publishing Settings**.
    :::image type="content" source="../media/publishing-settings.png" alt-text="A screenshot of the Project Settings widow. The Publishing Settings is highlighted. The settings for Publishing Settings is expanded.":::
1. In the **Capabilities** section, enable the following capabilities:
    - InternetClient
    - InternetClientServer
    - PrivateNetworkClientServer
    - Microphone
    :::image type="content" source="../media/select-capabilities.png" alt-text="A screenshot of the Capabilities section. The Internet Client, Internet Client Server, Private Network Client Server and Microphone capabilities are enabled.":::

## Import the Cognitive Services Speech Unity package

1. Download the **Azure Cognitive Services Speech SDK** from [aka.ms/csspeech/unitypackage](https://aka.ms/csspeech/unitypackage/?azure-portal=true).
1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package**.
    :::image type="content" source="../media/import-package.png" alt-text="A screenshot of the Unity interface. The Edit menu is open and Import Package, Custom Package is highlighted.":::
1. In the **Import package...** window, select the **Azure Cognitive Services Speech SDK** you downloaded and click **Open**.
    :::image type="content" source="../media/select-speech-package.png" alt-text="A screenshot of the file explorer. The Azure Cognitive Services Speech S D K is highlighted. The Open button is also highlighted.":::
1. In the **Import Unity Package** window, click the **All** button to ensure all the assets are selected, then click the **Import** button to import the assets.
    :::image type="content" source="../media/import-speech-package.png" alt-text="A screenshot of the Import Unity Package window. The window displays all the assets within the Azure Cognitive Services Speech S D K. The All and Import buttons are highlighted.":::