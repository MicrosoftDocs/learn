At this point, speech translation may seem like like a straight forward process — simply by building on existing speech translation technology. However, what is required for a meaningful and accurate speech translation system is much more than than simply plugging an existing “traditional” human-to-machine speech recognition engine to the existing text translation one.

Speech translation using the Speech Translation API actually goes through a four-step process.

- Speech recognition: Converts source audio into text
- Normalizes the source text to make it more appropriate for translation
- Evaluate/translate: Passes content though the translation engine against language models specially designed for real life spoken conversations
- Text-to-speech: Synthesizes the translated target language text to audio

## Exercise - Perform Speech to Speech Translation

In this exercise, you will learn how to accept audio input from a microphone and translate that audio to a different language. The translation output will be sent to the terminal window as text. The exercise will also use the Speech service to synthesize the translation to speech.  As a result of requiring audio capabilities of your computer, this exercise relies on code being executed locally.  The exercise will not use the Visual Studio Code Online environment as a result.

The speech translation capabilities require working with some key objects:

- A SpeechTranslationConfig object that will accept
    - your subscription key and region information
    - attributes for source and target language
    - a speech output voice name
- A TranslationRecognizer object that will accept
    - the SpeechTranslationConfig object listed above
    - calling the method to start the recognition process
- A TranslationRecognitionResult object is returned for you to evaluate for the result
- A Speech Synthesizer object to play the audio output in the target language

### Setup a Speech Service

For you to be successful in completing the exercises for this module, you must have the proper resources in place on Azure. The following steps outline creating an Azure subscription, or using a trial key.  Creating the Speech Service resources on Azure is required for the exercises to work successfully for synthesizing text to speech.  Complete this section before moving on to the remaining exercises.

### Create an Azure Speech Resource

You will require an Azure subscription in order to complete this exercise.  With the Azure subscription, you can create the necessary Speech Service resource. If you do not have an Azure subscription, [create one here](https://azure.microsoft.com/free).

Microsoft also provides the ability to try some of the Cognitive Services without an Azure subscription.  You can choose to use the free trial by getting an API key on the [Try Cognitive Service](https://azure.microsoft.com/try/cognitive-services/) page. If you choose the free option, you can skip the following section on creating an Azure resource.  You will use the API key in the later parts of the exercises.

#### Using an Azure Subscription

>[!NOTE]
>If you have already created a Speech Service resource that is still active, you can skip this section and move to the code section of your choice.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **+ Create a resource**. In the **Search the Marketplace** box, type **speech** and press Enter.

1. In the **Results** list, select **Speech**. In the **Speech** pane, select **Create**.
1. Enter a unique name for your Speech Service resource.
1. Select an appropriate subscription.
1. Choose a location to host the resource.  This is typically the region where the resource will be used.
1. For **Pricing tier**, select a tier.  The tiers may change but currently, you can select F0 or S0.  For testing, we selected F0.
1. Create a new resource group (RG) named **mslearn-speechapi** to hold your resources.  You can also choose an existing RG if you wish
1. Select **Create** to create a subscription to the Speech Translation API.

After a short delay, your new Speech Translation API subscription will be available, and new API keys will be generated for programmatic use.  

> [!TIP]
> If you miss the notification that your resource is published, select the notification icon in the top bar of the portal, and then select **Go to resource**, as shown in the following figure:

   ![Selecting "Go to resource" from the notification icon](../media/3-subscribe-speech-translation-go-resource.png)

#### View the subscription keys and endpoint

To access your Speech Service from an application, you will need to get two pieces of information from the Azure portal:

- A *subscription key* that's passed with every request to authenticate the call.
- The *endpoint* that exposes your service on the network.

You will need the subscription key when using the Speech SDK or the REST APIs but the endpoint will only be required for the REST API access.   Using the Speech SDK in an application uses the key, but also requires a region.  You will see the use of the key and region information in the exercise later in the module.

1. In the left menu of the portal, select **Resource groups**, and then select the **mslearn-speechapi** resource group that you created for the Speech Translation API.
1. Select the Speech Translation subscription name (such as **SpeechTranslation**).
1. There are two locations that will display your endpoint and at least one key. 
1. Under the **RESOURCE MANAGEMENT** group, select the **Quick start** option to display **Key1** and **Endpoint** values.
1. The second option is used to view a second key for the service. Under the **RESOURCE MANAGEMENT** group, select **Keys and Endpoint** to view the Service name, the endpoint, and two API keys.
1. Copy the value of **KEY 1** or **KEY 2** to the clipboard for use in an application.

:::zone pivot="csharp"

## Environment Setup

This exercise will make use of C# for the programming language.  To ensure cross-platform capability, the application code will use [.NET Core](https://dotnet.microsoft.com/download/dotnet-core). If you do not have .NET Core installed on your computer, please download and install from the link.

You will also require [Visual Studio Code](https://code.visualstudio.com/). Download and install before starting the exercises.

## Create the Project

1. Ensure you have [Visual Studio Code](https://code.visualstudio.com/) and [.NET Core](https://dotnet.microsoft.com/download/dotnet-core) installed before moving forward.
1. Create a new folder for this project. Name the folder **Translate_Speech**.
1. Open Visual Studio Code and then open the **Translate_Speech** folder.
1. In the folder pane of Visual Studio Code, select the **Translate_Speech** folder and select the **Terminal** menu and then **New Terminal**.
1. When the terminal opens, enter the following command ```dotnet new console```
1. Visual Studio Code will create the project structure for a new .NET Core console-based application.
1. Select the Program.cs file to open it in an editor view.
1. If you receive a message indicating **Required assets to build and debug are missing....**, select Yes to install them.
1. Copy the following code and paste at the top of Program.cs to ensure the necessary using statements bring in the libraries required.

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Translation;

    namespace helloworld
    {
        class Program
        {
            public static async Task TranslateSpeechToSpeech()
            {
                // Creates an instance of a speech translation config with specified subscription key and service region.
                // Replace with your own subscription key and region identifier from here: https://aka.ms/speech/sdkregion
                var config = SpeechTranslationConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

                // Sets source and target languages.
                // In this example, the service will translate a US English input speech to a German language spoken output
                // Replace with the languages of your choice, from list found here: https://aka.ms/speech/sttt-languages
                string fromLanguage = "en-US";
                string toLanguage = "de";
                config.SpeechRecognitionLanguage = fromLanguage;
                config.AddTargetLanguage(toLanguage);

                // Sets the synthesis output voice name.
                // Replace with the language of your choice, from list found here: https://aka.ms/speech/tts-languages
                config.SpeechSynthesisVoiceName = "de-DE-Hedda";

                // Creates a speech synthesizer using the SpeechSynthesisVoiceName for the audio output.
                var speech_synthesizer = new SpeechSynthesizer(config);

                // Creates a translation recognizer using the default microphone audio input device.
                using (var recognizer = new TranslationRecognizer(config))
                {
                    // Starts translation, and returns after a single utterance is recognized. The end of a
                    // single utterance is determined by listening for silence at the end or until a maximum of 15
                    // seconds of audio is processed. The task returns the recognized text as well as the translation.
                    // Note: Since RecognizeOnceAsync() returns only a single utterance, it is suitable only for single
                    // shot recognition like command or query.
                    // For long-running multi-utterance recognition, use StartContinuousRecognitionAsync() instead.
                    Console.WriteLine("Say something...");
                    var result = await recognizer.RecognizeOnceAsync();

                    // Checks result.
                    if (result.Reason == ResultReason.TranslatedSpeech)
                    {
                        Console.WriteLine($"RECOGNIZED '{fromLanguage}': {result.Text}");
                        Console.WriteLine($"TRANSLATED into '{toLanguage}': {result.Translations[toLanguage]}");

                        // Now that the audio was translated and output as text
                        // use the synthesized voice to speak the translation
                        await speech_synthesizer.SpeakTextAsync(result.Translations[toLanguage]);
                    }
                    else if (result.Reason == ResultReason.RecognizedSpeech)
                    {
                        Console.WriteLine($"RECOGNIZED '{fromLanguage}': {result.Text} (text could not be translated)");
                    }
                    else if (result.Reason == ResultReason.NoMatch)
                    {
                        Console.WriteLine($"NOMATCH: Speech could not be recognized.");
                    }
                    else if (result.Reason == ResultReason.Canceled)
                    {
                        var cancellation = CancellationDetails.FromResult(result);
                        Console.WriteLine($"CANCELED: Reason={cancellation.Reason}");

                        if (cancellation.Reason == CancellationReason.Error)
                        {
                            Console.WriteLine($"CANCELED: ErrorCode={cancellation.ErrorCode}");
                            Console.WriteLine($"CANCELED: ErrorDetails={cancellation.ErrorDetails}");
                            Console.WriteLine($"CANCELED: Did you update the subscription info?");
                        }
                    }
                }
            }

            static void Main(string[] args)
            {
                TranslateSpeechToSpeech().Wait();
                Console.WriteLine("Press any key to quit...");
                Console.ReadLine();
            }
        }
    }
    ```

1. You may notice that there are some code issues with squiggly lines.  This is because we need to add the appropriate package to the project.  Type the following command to add the Speech package, ```dotnet add package Microsoft.CognitiveServices.Speech```
1. Once you import the package, ensure that your computer has a default microphone input configured and working.
1. Paste your Speech service key and region into the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the Terminal, type the command ```dotnet run``` to run the code.
1. At the prompt **Say something...**, speak an English phrase and then pause.
1. When the program detects a pause in the speech, it will send the audio to the service for translation.
1. You should see the response output in the Terminal window, indicating the recognized text from your audio and the showing the conversion into the target language.
1. Explore other language options by changing the **to** language attributes for another destination language
1. Change the SpeechSynthesisVoiceName to an appropriate voice for the **to** language to hear the translation spoken with a native sounding voice for that language.

::: zone-end

::: zone pivot="python"

## Using Python or Visual Studio Code Locally

If you do not already have Python and Visual Studio Code installed on your local computer. Follow these instructions to get your environment ready for the exercise.

1. Download and install a 64-bit version of [Python](https://www.python.org/downloads/), 3.5 to 3.8, on your computer.
1. Download and install [Visual Studio Code](https://code.visualstudio.com/Download).
1. Open Visual Studio Code and install the Python extension. Select File > Preferences > Extensions from the menu. Search for Python.
1. Create a folder to store the project in. An example is by using Windows Explorer.
1. In Visual Studio Code, select the File icon. Then open the folder you created.
1. Create a new Python source file, texttospeech.py, by selecting the new file icon.
1. Copy and paste the Python code here.

    ```python
    import azure.cognitiveservices.speech as speechsdk

    speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"

    def translate_speech_to_speech():

        # Creates an instance of a speech translation config with specified subscription key and service region.
        # Replace with your own subscription key and region identifier from here: https://aka.ms/speech/sdkregion
        translation_config = speechsdk.translation.SpeechTranslationConfig(subscription=speech_key, region=service_region)

        speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)

        # Sets the synthesis output voice name.
        # Replace with the languages of your choice, from list found here: https://aka.ms/speech/tts-languages
        speech_config.speech_synthesis_voice_name = "de-DE-Hedda"

        # Creates a speech synthesizer using the configured voice for audio output.
        speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config)

        # Sets source and target languages.
        # In this example, the service will translate a US English spoken input, to a German language spoken output
        # Replace with the languages of your choice, from list found here: https://aka.ms/speech/sttt-languages
        fromLanguage = 'en-US'
        toLanguage = 'de'
        translation_config.speech_recognition_language = fromLanguage
        translation_config.add_target_language(toLanguage)

        # Creates a translation recognizer using and audio file as input.
        recognizer = speechsdk.translation.TranslationRecognizer(translation_config=translation_config)

        # Prepare to handle the synthesized audio data.
        def synthesis_callback(evt):
            size = len(evt.result.audio)
            print('AUDIO SYNTHESIZED: {} byte(s) {}'.format(size, '(COMPLETED)' if size == 0 else ''))

        recognizer.synthesizing.connect(synthesis_callback)

        # Starts translation, and returns after a single utterance is recognized. The end of a
        # single utterance is determined by listening for silence at the end or until a maximum of 15
        # seconds of audio is processed. It returns the recognized text as well as the translation.
        # Note: Since recognize_once() returns only a single utterance, it is suitable only for single
        # shot recognition like command or query.
        # For long-running multi-utterance recognition, use start_continuous_recognition() instead.
        print("Say something...")
        result = recognizer.recognize_once()

        # Check the result
        if result.reason == speechsdk.ResultReason.TranslatedSpeech:
            print("RECOGNIZED '{}': {}".format(fromLanguage, result.text))
            print("TRANSLATED into {}: {}".format(toLanguage, result.translations['de']))

            # Synthesizes the received text to speech.
            # The synthesized speech is expected to be heard on the speaker with this line executed.
            result = speech_synthesizer.speak_text_async(result.translations['de']).get()

        elif result.reason == speechsdk.ResultReason.RecognizedSpeech:
            print("RECOGNIZED: {} (text could not be translated)".format(result.text))
        elif result.reason == speechsdk.ResultReason.NoMatch:
            print("NOMATCH: Speech could not be recognized: {}".format(result.no_match_details))
        elif result.reason == speechsdk.ResultReason.Canceled:
            print("CANCELED: Reason={}".format(result.cancellation_details.reason))
            if result.cancellation_details.reason == speechsdk.CancellationReason.Error:
                print("CANCELED: ErrorDetails={}".format(result.cancellation_details.error_details))

    translate_speech_to_speech()
    ```

1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. If selected, a Python interpreter displays on the left side of the status bar at the bottom of the window. Otherwise, bring up a list of available Python interpreters. Open the command palette (Ctrl+Shift+P) and enter Python: Select Interpreter. Choose an appropriate one.
1. You can install the Speech SDK Python package from within Visual Studio Code. Do that if it's not installed yet for the Python interpreter you selected. To install the Speech SDK package, open a terminal. Bring up the command palette again (Ctrl+Shift+P) and enter Terminal: Create New Integrated Terminal. In the terminal that opens, enter the command ```python -m pip install azure-cognitiveservices-speech```.
1. To run the code, right-click somewhere inside the editor. Select Run Python File in Terminal.
1. At the prompt **Say something...**, speak an English phrase and then pause.
1. When the program detects a pause in the speech, it will send the audio to the service for translation.
1. You should see the response output in the Terminal window, indicating the recognized text from your audio and the showing the conversion into the target language.
1. Explore other language options by changing the **to** language attributes for another destination language
1. Change the SpeechSynthesisVoiceName to an appropriate voice for the **to** language to hear the translation spoken with a native sounding voice for that language.

::: zone-end
