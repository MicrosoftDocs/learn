In this module, you'll create a Mixed Reality application that explores the use of Azure Speech Services with the HoloLens 2. When you complete this series, you will be able to use your device's microphone to transcribe speech to text in real-time, translate your speech into other languages, and use the Intent recognition feature to understand voice commands using artificial intelligence.

## Create and prepare the Unity project

In this section, you will create a new Unity project and get it ready for MRTK development.

As a prerequisite, make sure you've completed the steps below to initialize your project and application:

1. Creating the Unity project and give it a suitable name, for example, *MRTK Tutorials*
2. Switching the build platform
3. Importing the TextMeshPro Essential Resources
4. Importing the Mixed Reality Toolkit
5. Configuring the Unity project
6. Creating and configuring the scene and give the scene a suitable name, for example, *AzureSpeechServices*

> [!NOTE]
> You can learn how to set up your mixed-reality project in the [Introduction to Mixed Reality Toolkit](/training/modules/learn-mrtk-tutorials/) module.

## Configure the capabilities

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Player Settings window, then locate the **Player** >  **Publishing Settings** section:

    :::image type="content" source="../media/configure-capabilities.png" alt-text="Screenshot of Configuring capabilities." lightbox="../media/configure-capabilities.png":::

2. In the  **Publishing Settings**, scroll down to the **Capabilities** section and double-check that the **InternetClient**, **Microphone**, and **SpatialPerception** capabilities (which you enabled when you created the project at the beginning of the tutorial) are still enabled. Then enable the **InternetClientServer** and **PrivateNetworkClientServer** capabilities:

    :::image type="content" source="../media/enable-capabilities.png" alt-text="Screenshot of Enable the capabilities." lightbox="../media/enable-capabilities.png":::

## Import the tutorial assets

1. Download and **import** the following Unity custom packages **in the order they are listed**:

    * [Microsoft.CognitiveServices.Speech.N.N.N.unitypackage](https://aka.ms/csspeech/unitypackage) (latest version)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0-pre.18.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v3.0.0-pre.18/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0-pre.18.unitypackage)
    * [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpeechServices.3.0.0-pre.18.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-speech-services-v3.0.0-pre.18/MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpeechServices.3.0.0-pre.18.unitypackage)

2. Once you import the tutorial assets your Project window should look like this:

    :::image type="content" source="../media/project-window.png" alt-text="Screenshot of Project window must look similar to this." lightbox="../media/project-window.png":::

## Prepare the scene

In this section, you will prepare the scene by adding the tutorial prefab and configure the Lunarcom Controller (Script) component to control your scene.

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.AzureSpeechServices** > **Prefabs** folder and drag the **Lunarcom** prefab into the Hierarchy window to add it to your scene:

    :::image type="content" source="../media/prepare-scene.png" alt-text="Screenshot of Preparing the scene." lightbox="../media/prepare-scene.png":::

2. With the **Lunarcom** object still selected in the Hierarchy window, in the Inspector window, use the **Add Component** button to add the **Lunarcom Controller (Script)** component to the Lunarcom object:

    :::image type="content" source="../media/lunarcom-controller.png" alt-text="Screenshot of Adding Lunarcom controller (Script)." lightbox="../media/lunarcom-controller.png":::

3. With the **Lunarcom** object still selected, expand it to reveal its child objects, then drag the **Terminal** object into the Lunarcom Controller (Script) component's **Terminal** field:

    :::image type="content" source="../media/terminal-field.png" alt-text="Screenshot of Terminal field." lightbox="../media/terminal-field.png":::

4. With the **Lunarcom** object still selected, expand the Terminal object to reveal its child objects, then drag the **ConnectionLight** object into the Lunarcom Controller (Script) component's **Connection Light** field and the **OutputText** object into the **Output Text** field:

    :::image type="content" source="../media/output-text-field.png" alt-text="Screenshot of Output text field." lightbox="../media/output-text-field.png":::

5. With the **Lunarcom** object still selected, expand the Buttons object to reveal its child objects, and then in the Inspector window, expand the **Buttons** list, set its **Size** to 3, and drag the **MicButton**, **SatelliteButton**, and **RocketButton** objects into the **Element** 0, 1, and 2 fields respectively:

    :::image type="content" source="../media/configure-buttons.png" alt-text="Screenshot of Configure the buttons." lightbox="../media/configure-buttons.png":::

## Connect the Unity project to the Azure resource

To use Azure Speech Services, you need to create an Azure resource and obtain an API key for the Speech Service. Follow the [quickstart](/azure/ai-services/multi-service-resource) instructions and make a note of your service region (also known as Location) and API key (also known as Key1 or Key2).

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, locate the **Lunarcom Controller (Script)** component's **Speech SDK Credentials** section and configure it as follows:

    * In the **Speech Service API Key** field, enter your API key (Key1 or Key2)
    * In the **Speech Service Region** field, enter your service region (Location) using lowercase letters and spaces removed

    :::image type="content" source="../media/configure-speech-sdk-credentials.png" alt-text="Screenshot of Configure Speech SDK Credentials." lightbox="../media/configure-speech-sdk-credentials.png":::

## Use speech recognition to transcribe speech

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Speech Recognizer (Script)** component to the Lunarcom object:

    :::image type="content" source="../media/lunarcom-speech-recognize.png" alt-text="Screenshot of Add Lunarcom Speech Recognizer (Script)." lightbox="../media/lunarcom-speech-recognize.png":::

2. If you now enter Game mode, you can test the speech recognition by first pressing the microphone button:

    :::image type="content" source="../media/enter-game-mode.png" alt-text="Screenshot of Enter game mode." lightbox="../media/enter-game-mode.png":::

3. Then, assuming your computer has a microphone, when you say something, your speech will be transcribed on the terminal panel:

    :::image type="content" source="../media/speech-transcribe.png" alt-text="Screenshot of Speech will be transcribed on the terminal panel." lightbox="../media/speech-transcribe.png":::

    > [!CAUTION]
    > The application needs to connect to Azure, so make sure your computer/device is connected to the internet.
