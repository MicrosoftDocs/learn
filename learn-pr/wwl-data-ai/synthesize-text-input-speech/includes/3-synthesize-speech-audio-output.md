The ability to synthesize text to speech output will require that your computer to have an audio output device. In this exercise, you will perform text-to-speech synthesis by typing in some text and having that text synthesized to speech and played through your computer's audio output.

>[!TIP]
>The sample code that will be used in this exercise will prompt you to type some text in the terminal window.  The text you enter will be used as the input for the text-to-speech conversion.  There are other options you could explore for text input such as a file. If you choose to use a file as input, keep in mind the length of the text and consider if you should use the **Long Audio API** and send the audio to a file, rather than creating real time audio.

The SpeechConfig configuration object accepts your Speech service key and region for authorization.  You can also use the SpeechConfig object to change how your speech synthesis works.  For example, the default voice will be used for speaking unless you modify the SpeechConfig object.  You can do so by providing a voice name for the SpeechConfig object as shown here:

```python
speech_config_obj = speech_synthesis_voice_name = "en-CA-Linda"
```

```csharp
config.SpeechSynthesisVoiceName = "en-CA-Linda";
```

The code sample shows how to configure an English language voice using Canadian English.  You will get a chance to try this in the exercise.  To understand the voices available, visit the [language support](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support#text-to-speech) page.

>[!TIP]
>Choosing a voice that is not native for the language you are using, may not provide the results you expect. For example, if you select a voice for German language support, and your text is in US English, the pronunciation may not be the same as a native US English speaker.

This exercise will use the default audio format for output but you can investigate the options on your own to further explore changing the audio format as demonstrated in the code snippets above.

>[!NOTE]
>There are two sets of instructions included.  One for Visual Studio Code Online and one for a local environment
>Audio may not play in the online environment.  If it does not, you will need to use the instructions for a local
>environment so you can hear the audio played back.

::: zone pivot="csharp"

## Using visual studio codespaces

> [!NOTE]
> At this time, Safari is not a supported browser for the preview of Visual Studio Codespaces.

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/)

    >[!NOTE]
    > You will require an Azure subscription to create an environment for Visual Studio Codespaces. If you did not create an Azure subscription but have chosen to use the trial API key, you will need to [download Visual Studio Code](https://code.visualstudio.com/) to your computer and follow along with the lab steps locally.

1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription.
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Environment**.
1. Select your Subscription in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create your first environment.  
1. If the **Create Environment** panel does not open automatically, select **Create environment**.
1. Enter an environment name of your choosing, example **TextToSpeechCS**.
1. Copy the following URL and paste it into the Git Repository area on the **Create Environment** panel: `https://github.com/MicrosoftLearning/AI-102-Process-Speech`
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Speech service in the Azure portal and copy one of your keys, and also note the region where the service was created.
1. Once the environment indicates that it is available, either select the title or select the three vertical dots in the lower right of the environment box and choose **Connect**.
1. We will be using C# and .NET Core for this exercise so wait for the Visual Studio Codespaces window to open.
1. Expand the **synthesize_text_to_speech** folder.
1. You will create a .NET Core application so right-click the **csharp** folder and choose **Open in Terminal**

    >[!TIP]
    > If you are using a local copy of Visual Studio Code, create a new folder on your local computer, then right-click that folder name, in VS Code, and select Open in Terminal.  Continue on with the lab steps.

1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder. You may need to expand the csharp folder to see the new files.
1. Select the Program.cs file and replace its contents with the following code.

    >[!NOTE]
    >If you are prompted to install the C# Extension, select Install. Then select the reload option.
    >After the reload, you may also be prompted to install extensions, choose to install them

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;

    namespace texttospeech
    {
        class Program
        {
            public static async Task SynthesisToSpeakerAsync()
            {
                // Creates an instance of a speech config with specified subscription key and service region.
                // Replace with your own subscription key and service region (e.g., "westus").
                // The default language is "en-us".
                var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

                // uncomment this line to change the voice used for synthesis
                // config.Speech = "en-CA-Linda";

                // Creates a speech synthesizer using the default speaker as audio output.
                using (var synthesizer = new SpeechSynthesizer(config))
                {
                    // Prompt for text input from the console
                    Console.WriteLine("Type some text that you want to speak...");
                    Console.Write("> ");

                    // read the text string from the console input
                    string text = Console.ReadLine();

                    // Call the SpeakTextAsync method on the SpeechSynthesizer object
                    // we are using an asynchronous call with the await keyword
                    // passing in the text string input from the console
                    using (var result = await synthesizer.SpeakTextAsync(text))
                    {
                        if (result.Reason == ResultReason.SynthesizingAudioCompleted)
                        {
                            Console.WriteLine($"Speech synthesized to speaker for text [{text}]");
                        }
                        else if (result.Reason == ResultReason.Canceled)
                        {
                            var cancellation = SpeechSynthesisCancellationDetails.FromResult(result);
                            Console.WriteLine($"CANCELED: Reason={cancellation.Reason}");

                            if (cancellation.Reason == CancellationReason.Error)
                            {
                                Console.WriteLine($"CANCELED: ErrorCode={cancellation.ErrorCode}");
                                Console.WriteLine($"CANCELED: ErrorDetails=[{cancellation.ErrorDetails}]");
                                Console.WriteLine($"CANCELED: Did you update the subscription info?");
                            }
                        }
                    }

                    // This is to give some time for the speaker to finish playing back the audio
                    Console.WriteLine("Press any key to exit...");
                    Console.ReadKey();
                }
            }

            static void Main()
            {
                SynthesisToSpeakerAsync().Wait();
            }
        }
    }
    ```

You will now need to add the Microsoft Cognitive Service Speech package to your application.

1. In the terminal, enter ```dotnet add package Microsoft.CognitiveServices.Speech```

>[!NOTE]
>Ensure you are in the csharp folder. The previous extension install will change the folder for the Terminal

1. Once the package is added, you are ready to run the application.
1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the terminal, type ```dotnet run```
and press Enter.
1. You will be prompted to enter some text.  Enter a phrase of your choosing and press Enter.
1. The computer will read back the text to you in the default voice.

## Using visual studio code locally

If you want to run the code on your local computer and not use VS Code online, ensure you have the latest version of [Visual Studio Code](https://code.visualstudio.com/) installed.

1. Create a new folder for the project.  Name the folder **text-to-speech** or a name of your choosing
1. In the folder pane of VS Code, right-click the folder name and choose **Open in terminal**
1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder.
1. Open the Program.cs file and replace its contents with the C# code above.
1. Review the code and the comments to understand what is taking place when the program runs.

You will now need to add the Microsoft Cognitive Service Speech package to your application.

1. In the terminal, where you typed the ```dotnet new console``` command, enter ```dotnet add package Microsoft.CognitiveServices.Speech```
1. Once the package is added, you are ready to run the application.
1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the terminal, type ```dotnet run```
and press Enter.
1. You will be prompted to enter some text.  Enter a phrase of your choosing and press Enter.
1. The computer will read back the text to you in the default voice.

::: zone-end

::: zone pivot="python"

## Using visual studio codespaces

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/).

    > [!NOTE]
    > At this time, Safari is not a supported browser for the preview of Visual Studio Codespaces.

    You will require an Azure subscription to create an environment for Visual Studio Codespaces.
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription.
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Environment**.
1. Select your **Subscription** in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create you first environment.  
1. If the **Create Environment** panel does not open automatically, select **Create environment**.
1. Enter an environment name of your choosing, example **TextToSpeechPython**.
1. Copy the following URL and paste it into the Git Repository area on the **Create Environment** panel: `https://github.com/MicrosoftLearning/AI-SpeechToText`
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your **Speech** service in the **Azure portal** and copy one of your keys, and also note the region where the service was created.
1. Once the environment indicates that it is available, either select the title, or select the three vertical dots in the lower right of the environment box and choose **Connect**.
1. Visual Studio Codespaces will now synchronize the GitHub repo and run the scripts that were present in the devcontainer.  This is required to set up the proper Python environment, in this case 3.5.3.
1. If you get any messages about installing additional extensions or components, choose to do so.
1. Refresh teh browser window to ensure all settings are applied.
1. Expand the synthesize_text_to_speech folder
1. Expand the python folder
1. Right-click the python folder and choose **New File** and name it texttospeech.py
1. Copy and paste the following code into the texttospeech.py file

    ```python
    import azure.cognitiveservices.speech as speechsdk

    # Creates an instance of a speech config with specified subscription key and service region.
    # Replace with your own subscription key and service region (e.g., "westus").
    speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"
    speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)

    # uncomment this line to change the voice used for synthesis
    # speech_config.speech_synthesis_voice_name = "en-CA-Linda"

    # Creates a speech synthesizer using the default speaker as audio output.
    speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config)

    # Receives a text from console input.
    print("Type some text that you want to speak...")
    text = input()

    # Synthesizes the received text to speech.
    # The synthesized speech is expected to be heard on the speaker with this line executed.
    result = speech_synthesizer.speak_text_async(text).get()

    # Checks result.
    if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
        print("Speech synthesized to speaker for text [{}]".format(text))
    elif result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = result.cancellation_details
        print("Speech synthesis canceled: {}".format(cancellation_details.reason))
        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            if cancellation_details.error_details:
                print("Error details: {}".format(cancellation_details.error_details))
        print("Did you update the subscription info?")
    ```

1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. Select the Run Python File in Terminal (green arrow) or right-click in the Python file editor and select Run Python File in Terminal.
1. Type some text when you're prompted. The synthesized audio is played using the default voice.

## Using python or visual studio code locally

If you do not already have Python and Visual Studio Code installed on your local computer. Follow these instructions to get your environment ready for the exercise.

1. Download and install a 64-bit version of [Python](https://www.python.org/downloads/), 3.5 to 3.8, on your computer.
1. Download and install [Visual Studio Code](https://code.visualstudio.com/Download).
1. Open Visual Studio Code and install the Python extension. Select File > Preferences > Extensions from the menu. Search for Python.
1. Create a folder to store the project in. An example is by using Windows Explorer.
1. In Visual Studio Code, select the File icon. Then open the folder you created.
1. Create a new Python source file, texttospeech.py, by selecting the new file icon.
1. Copy and paste the Python code from above in the Visual Studio Code Online section.
1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. If selected, a Python interpreter displays on the left side of the status bar at the bottom of the window. Otherwise, bring up a list of available Python interpreters. Open the command palette (Ctrl+Shift+P) and enter Python: Select Interpreter. Choose an appropriate one.
1. You can install the Speech SDK Python package from within Visual Studio Code. Do that if it's not installed yet for the Python interpreter you selected. To install the Speech SDK package, open a terminal. Bring up the command palette again (Ctrl+Shift+P) and enter Terminal: Create New Integrated Terminal. In the terminal that opens, enter the command ```python -m pip install azure-cognitiveservices-speech```.
1. To run the code, right-click somewhere inside the editor. Select Run Python File in Terminal.
1. Type some text when you're prompted. The synthesized audio is played using the default voice.

::: zone-end
