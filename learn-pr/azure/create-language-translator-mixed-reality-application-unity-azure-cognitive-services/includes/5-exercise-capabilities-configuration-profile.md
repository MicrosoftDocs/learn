In Unity, you must enable specific capabilities to use APIs and resources such as a microphone in a mixed reality experience. Recall that in the example of collaboration tools, there's a need for a microphone to capture speech. The example also needs the internet for using the Azure Cognitive Services Speech service. 

Here, you'll configure a Unity project to use the Azure Cognitive Services Speech SDK for speech translation.

## Create and configure a new Unity project for Windows Mixed Reality development by using the MRTK

> [!NOTE]
> If you're unfamiliar with the process of configuring a Unity project for Windows Mixed Reality development, see the [Set up a Mixed Reality project in Unity with the Mixed Reality Toolkit](https://docs.microsoft.com/learn/modules/mixed-reality-toolkit-project-unity/?azure-portal=true) Learn module for an overview.

1. Create a new 3D Unity project.
1. Go to **File** > **Build Settings** to switch **Build Platform** to **Universal Windows Platform**.
1. In the **Build Settings** window, select **Player Settings**. In the **Player** section, expand **XR Settings**. Enable **Virtual Reality Supported** and add the **Windows Mixed Reality** SDK.
    
   :::image type="content" source="../media/add-sdk.png" alt-text="Screenshot of the X R settings. The Virtual Reality Supported box is highlighted and selected. The plus icon to add a new S D K is highlighted and selected.":::
1. Optimize **XR Settings** as follows:
    - Set Windows Mixed Reality **Depth Format** to **16-bit depth**.
    - Select the Windows Mixed Reality **Enable Depth Sharing** check box.
    - Set **Stereo Rendering Mode** to **Single Pass Instanced**.
     
    :::image type="content" source="../media/optimize-xr-settings.png" alt-text="Screenshot of the X R settings. The Virtual Reality S D K section and Stereo Rendering Mode section are highlighted. Depth Format is set to 16-bit depth. The Enable Depth Sharing box is selected. Stereo Rendering Mode is set to Single Pass Instanced.":::
1. Go to **Windows** > **TextMeshPro** and select **Import TMP Essential Resources** to import all of the TMP Essential Resources assets.
1. Download **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** from the [MRTK release page](https://github.com/Microsoft/MixedRealityToolkit-Unity/releases?azure-portal=true).
1. Go to **Assets** > **Import Package** > **Custom Package** and import all the assets within the **Microsoft.MixedReality.Toolkit.Unity.Foundation.2.X.X.unitypackage** package. After the import is complete, the Mixed Reality Toolkit (MRTK) is added to the top navigation menu.
1. The **MRTK Project Configurator** window might open after the Mixed Reality Toolkit is imported into the project. If not, in the top navigation menu, go to **Mixed Reality Toolkit** > **Utilities** > **Configure Unity Project**. In the **Audio spatializer** drop-down list, select **MS HRTF Spatializer**.
1. In the top navigation menu, go to **Mixed Reality Toolkit** > **Add to Scene and Configure** to add **Mixed Reality Toolkit** to the scene.

## Change the speech command for start behavior

By default, the MRTK speech commands are configured to start automatically when a Unity scene loads. Because this app requires speech input, the MRTK speech command **Start Behavior** must be set to **Manual Start** to not interfere with the Cognitive Services Speech SDK. The default configuration profiles that come with the Mixed Reality Toolkit can't be modified, so you must clone the configuration profile settings to modify the speech command **Start Behavior**.

1. On the Unity menu, select the **MixedRealityPlayspace** object. The object's properties appear in the **Inspector** window.

    :::image type="content" source="../media/select-mixedrealityplayspace.png" alt-text="Screenshot of the Inspector window. The Mixed Reality Playspace object is highlighted.":::

1. In the **Inspector** window, select **DefaultMixedRealityToolkitConfigurationProfile** for **Configuration Profile**.

    :::image type="content" source="../media/default-configuration-profile.png" alt-text="Screenshot of the Mixed Reality Toolkit configuration profile. The Default Mixed Reality Toolkit Configuration Profile name is highlighted.":::

1. In the **Inspector** window, select **Clone** to clone the profile.

    :::image type="content" source="../media/configuration-profile-clone.png" alt-text="Screenshot of the Mixed Reality Toolkit configuration profile. The Clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationConfigurationProfile** for **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationconfigureprofile.png" alt-text="Screenshot of the Cloning Profile window. The Speech Translation Configuration Profile name is highlighted.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-configuration-profile.png" alt-text="Screenshot of the Cloning Profile window. The Clone button is highlighted.":::

1. In the **Inspector** window, select **Input**.

    :::image type="content" source="../media/select-input.png" alt-text="Screenshot of the Mixed Reality Toolkit configuration profile. The menu selection Input is highlighted.":::

1. In the **Input** settings, select **Clone** to clone the Input System profile.

    :::image type="content" source="../media/clone-input-system-profile.png" alt-text="Screenshot of the Input System profile settings. The Clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationInputSystemProfile** for **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationinputsystemprofile.png" alt-text="Screenshot of the Cloning Profile window. The Speech Translation Input System Profile name is highlighted.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-input-system-profile.png" alt-text="Screenshot of the Cloning Profile window. The Clone button is highlighted.":::

1. In the **Input** settings, expand the **Speech** settings.

    :::image type="content" source="../media/expand-speech-settings.png" alt-text="Screenshot of the Mixed Reality Toolkit configuration profile. The Input menu option is highlighted. The Speech settings section is highlighted and expanded.":::

1. In the **Speech** settings, select **Clone** to clone the Speech Commands profile.

    :::image type="content" source="../media/speech-commands-profile-clone.png" alt-text="Screenshot of the Speech Commands profile. The Clone button is highlighted.":::

1. In the **Cloning profile** window, enter **SpeechTranslationSpeechCommandsProfile** for **Profile Name**.

    :::image type="content" source="../media/name-speechtranslationspeechcommandsprofile.png" alt-text="Screenshot of the Cloning Profile window. The Speech Translation Speech Commands Profile name is highlighted.":::

1. Select **Clone**.

    :::image type="content" source="../media/select-clone-speech-commands-profile.png" alt-text="Screenshot of the Cloning Profile window. The Clone button is highlighted.":::

1. In the **Speech** settings, select **Manual Start** for **Start Behavior**.

    :::image type="content" source="../media/start-behavior.png" alt-text="Screenshot of the Speech Commands profile. The Start Behavior setting is highlighted. The Manual Start option is selected.":::

## Add capabilities

To enable APIs or resources (such as a microphone) to access the app, you must enable the capability in the Unity Project Settings.

1. On the Unity menu, select **Edit** > **Project Settings**.

    :::image type="content" source="../media/project-settings.png" alt-text="Screenshot of the Unity interface. The Edit menu is open. The Project Settings item is highlighted.":::

1. In the **Project Settings** window, select **Player**.

    :::image type="content" source="../media/player-settings.png" alt-text="Screenshot of the Project Settings window. The Player option from the left  menu is highlighted.":::

1. In the **Player** settings, expand **Publishing Settings**.

    :::image type="content" source="../media/publishing-settings.png" alt-text="Screenshot of the Project Settings widow. The Publishing Settings area is highlighted and expanded.":::

1. In the **Capabilities** section, enable the following capabilities:
    - **InternetClient**
    - **InternetClientServer**
    - **PrivateNetworkClientServer**
    - **Microphone**
    
    :::image type="content" source="../media/select-capabilities.png" alt-text="Screenshot of the Capabilities section. The Internet Client, Internet Client Server, Private Network Client Server, and Microphone capabilities are enabled.":::

## Import the Cognitive Services Speech Unity package

1. [Download](https://aka.ms/csspeech/unitypackage/?azure-portal=true) the Azure Cognitive Services Speech SDK.
1. On the Unity menu, select **Assets** > **Import Package** > **Custom Package**.

    :::image type="content" source="../media/import-package.png" alt-text="Screenshot of the Unity interface. The Edit menu is open, and Import Package and Custom Package are highlighted.":::

1. In the **Import package** window, select **Azure Cognitive Services Speech SDK** > **Open**.

    :::image type="content" source="../media/select-speech-package.png" alt-text="Screenshot of the file explorer. The Azure Cognitive Services Speech S D K and the Open button are highlighted.":::

1. In the **Import Unity Package** window, select the **All** button to ensure that all the assets are selected. Then select the **Import** button to import the assets.

    :::image type="content" source="../media/import-speech-package.png" alt-text="Screenshot of the Import Unity Package window and all the assets within the Azure Cognitive Services Speech S D K. The All and Import buttons are highlighted.":::