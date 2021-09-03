## 2. Exercise: Integrating And Using Speech Recognition And Transcription

In this module, you will create a Mixed Reality application that explores the use of Azure Speech Services with the HoloLens 2. When you complete this series, you will be able to use your device's microphone to transcribe speech to text in real-time, translate your speech into other languages, and you will be able to leverage the Intent recognition feature to understand voice commands using artificial intelligence.

## Creating And Preparing The Unity Project

In this section, you will create a new Unity project and get it ready for MRTK development.

For this, first follow the Initializing your project and first application, excluding the Build your application to your device instructions, which includes the following steps:

1. Creating the Unity project and give it a suitable name, for example, *MRTK Tutorials*
2. Switching the build platform
3. Importing the TextMeshPro Essential Resources
4. Importing the Mixed Reality Toolkit
5. Configuring the Unity project
6. Creating and configuring the scene and give the scene a suitable name, for example, *AzureSpeechServices*

Then follow the Changing the Spatial Awareness Display Option instructions to ensure the MRTK configuration profile for your scene is **DefaultHoloLens2ConfigurationProfile**  and change the display options for the spatial awareness mesh to **Occlusion**.

## Configuring The Speech Commands Start Behavior

Because you will use the Speech SDK for speech recognition and transcription, you need to configure the MRTK Speech Commands, so they do not interfere with the Speech SDK functionality. To achieve this, you can change the speech commands start behavior from Auto Start to Manual Start.


1. With the **MixedRealityToolkit** object selected in the Hierarchy window, in the Inspector window, select the **Input** tab, clone the **DefaultHoloLens2InputSystemProfile** and the **DefaultMixedRealitySpeechCommandsProfile**, and then change the speech commands **Start Behavior** to **Manual Start**:

![Change the speech commands](../media/tutorial-1-section-2-step-1-1.png)

## Configuring The Capabilities

1. In the Unity menu, select **Edit** > **Project Settings...** to open the Player Settings window, then locate the **Player** >  **Publishing Settings** section:

![Configuring capabilities](../media/tutorial-1-section-3-step-1-1.png)

2. In the  **Publishing Settings**, scroll down to the **Capabilities** section and double-check that the **InternetClient**, **Microphone**, and **SpatialPerception** capabilities, which you enabled when you created the project at the beginning of the tutorial, are enabled. Then, enable the **InternetClientServer** and **PrivateNetworkClientServer** capabilities:

![Enable the capabilities](../media/tutorial-1-section-3-step-1-2.png)

## Importing The Tutorial Assets

1. Download and **import** the following Unity custom packages **in the order they are listed**:

* [Microsoft.CognitiveServices.Speech.N.N.N.unitypackage](https://aka.ms/csspeech/unitypackage) (latest version)
* [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.3.0.3.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v2.3.0.3/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.3.0.3.unitypackage)
* [MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpeechServices.2.5.1.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/2.5.1/MRTK.HoloLens2.Unity.Tutorials.Assets.AzureSpeechServices.2.5.1.unitypackage)

2. After you have imported the tutorial assets your Project window should look similar to this:

![Project window must look similar to this](../media/tutorial-1-section-4-step-1-1.png)

## Preparing The Scene

In this section, you will prepare the scene by adding the tutorial prefab and configure the Lunarcom Controller (Script) component to control your scene.

1. In the Project window, navigate to **Assets** > **MRTK.Tutorials.AzureSpeechServices** > **Prefabs** folder and drag the **Lunarcom** prefab into the Hierarchy window to add it to your scene:

![Preparing the scene](../media/tutorial-1-section-5-step-1-1.png)

2. With the **Lunarcom** object still selected in the Hierarchy window, in the Inspector window, use the **Add Component** button to add the **Lunarcom Controller (Script)** component to the Lunarcom object:

![Add Lunarcom controller (Script)](../media/tutorial-1-section-5-step-1-2.png)

3. With the **Lunarcom** object still selected, expand it to reveal its child objects, then drag the **Terminal** object into the Lunarcom Controller (Script) component's **Terminal** field:

![Terminal field](../media/tutorial-1-section-5-step-1-3.png)

4. With the **Lunarcom** object still selected, expand the Terminal object to reveal its child objects, then drag the **ConnectionLight** object into the Lunarcom Controller (Script) component's **Connection Light** field and the **OutputText** object into the **Output Text** field:

![Output text field](../media/tutorial-1-section-5-step-1-4.png)

5. With the **Lunarcom** object still selected, expand the Buttons object to reveal its child objects, and then in the Inspector window, expand the **Buttons** list, set its **Size** to 3, and drag the **MicButton**, **SatelliteButton**, and **RocketButton** objects into the **Element** 0, 1, and 2 fields respectively:

![Configure the buttons](../media/tutorial-1-section-5-step-1-5.png)

## Connecting The Unity Project To The Azure Resource

To use Azure Speech Services, you need to create an Azure resource and obtain an API key for the Speech Service. Follow the [Try the Speech service for free](/azure/cognitive-services/speech-service/get-started) instructions and make a note of your service region (also known as Location) and API key (also known as Key1 or Key2).

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, locate the **Lunarcom Controller (Script)** component's **Speech SDK Credentials** section and configure it as follows:

* In the **Speech Service API Key** field, enter your API key (Key1 or Key2)
* In the **Speech Service Region** field, enter your service region (Location) using lowercase letters and spaces removed

![Configure Speech SDK Credentials](../media/tutorial-1-section-6-step-1-1.png)

## Using Speech Recognition To Transcribe Speech

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Speech Recognizer (Script)** component to the Lunarcom object:

![Add Lunarcom Speech Recognizer (Script)](../media/tutorial-1-section-7-step-1-1.png)

2. If you now enter Game mode, you can test the speech recognition by first pressing the microphone button:

![Enter game mode](../media/tutorial-1-section-7-step-1-2.png)

3. Then, assuming your computer has a microphone, when you say something, your speech will be transcribed on the terminal panel:

![Speech will be transcribed on the terminal panel](../media/tutorial-1-section-7-step-1-3.png)

> [!CAUTION]
> The application needs to connect to Azure, so make sure your computer/device is connected to the internet.
