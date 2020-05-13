When synthesizing text to speech and using audio output on your computer, the SpeechSynthesizer object's constructor only took one argument, a SpeechConfig object. For saving the audio output to a file, you will be required to also create an AudioConfig object and pass that to the SpeechSynthesizer.  The AudioConfig object uses a file name as the property where it will store the audio output. You will also need to add another ```using``` statement to include the Audio portion of the Speech SDK.

The file output will be in .wav format so you can play the audio on any device the supports .wav files. In the code samples used here, you will use the default file format and the default audio properties.

::: zone pivot="csharp"

## Using visual studio codespaces

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/)

    > [!NOTE]
    > At this time, Safari is not a supported browser for the preview of VS Codespaces.

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
1. Refresh the browser window to apply the environment changes.
1. We will be using C# and .NET Core for this exercise so once the VS Code window opens, start the Terminal by selecting the hamburger menu, **View**, and then **Terminal**.
1. Open the Program.cs file and edit the content to add a new function using this code

```csharp
public static async Task SynthesisToAudioFileAsync()
    {
        // Creates an instance of a speech config with specified subscription key and service region.
        // Replace with your own subscription key and service region (e.g., "westus").
        // The default language is "en-us".
        var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

        // Prompt for text input from the console
        Console.WriteLine("Type some text that you want to save to the audio file...");
        Console.Write("> ");

        // read the text string from the console input
        string text = Console.ReadLine();

        var fileName = "../media/text_to_speech.wav";

        using (var fileOutput = AudioConfig.FromWavFileOutput(fileName))
            {
                using (var synthesizer = new SpeechSynthesizer(config, fileOutput))
                {
                    var result = await synthesizer.SpeakTextAsync(text);

                    if (result.Reason == ResultReason.SynthesizingAudioCompleted)
                    {
                        Console.WriteLine($"Speech synthesized to [{fileName}] for text [{text}]");
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
            }
        }
    }

```

1. Comment out the existing line of code in Main()

```csharp
    await RecognizeSpeechAsync()
```

1. Add this line of code

```csharp
    await SynthesisToAudioFileAsync();
```

1. Ensure your key and region from the Speech resource your created on Azure are in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the terminal, type ```dotnet run```
and press Enter.
1. You will be prompted to enter some text.  Enter a phrase of your choosing and press Enter.
1. A new file will be created in the media folder of your application. You may need to clone the repo locally so that you can open the file with an audio player to hear the contents that were generated from the text you entered.

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
1. A new file will be created at the root of your application folder. You can open the file with an audio player to hear the contents that were generated from the text you entered.

::: zone-end

::: zone pivot="python"

## Using visual studio codespaces

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/).

    > [!NOTE]
    > At this time, Safari is not a supported browser for the preview of VS Codespaces.

    You will require an Azure subscription to create an environment for Visual Studio Codespaces.
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription.
1. If this is the first time you have used Visual Studio Codespaces, you will be required to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Environment**.
1. Select your **Subscription** in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create you first environment.  
1. If the **Create Environment** panel does not open automatically, select **Create environment**.
1. Enter an environment name of your choosing, example **TextToSpeechPython**.
1. Copy the following URL and paste it into the Git Repository area on the **Create Environment** panel: `https://github.com/MicrosoftLearning/AI-102-Process-Speech`
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your **Speech** service in the **Azure portal** and copy one of your keys, and also note the region where the service was created.
1. Once the environment indicates that it is available, either select the title, or select the three vertical dots in the lower right of the environment box and choose **Connect**.
1. VS Code Online will now synchronize the GitHub repo and run the scripts that were present in the devcontainer.  This is required to set up the proper Python environment, in this case 3.5.3.
1. If you get any messages about installing additional extensions or components, choose to do so.
1. Refresh the browser window to apply the environment changes.
1. Expand the **python** folder
1. Create a new file called texttospeechfile.py
1. Copy and paste the following code into the texttospeechfile.py file

```python
import azure.cognitiveservices.speech as speechsdk

# Replace with your own subscription key and region identifier
speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"
speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)

# Creates an audio configuration that points to an audio file.
# Replace with your own audio filename.
audio_filename = "transcribe_speech_to_text/media/text-to-speech-py.wav"
audio_output = speechsdk.audio.AudioOutputConfig(filename=audio_filename)

# Creates a synthesizer with the given settings
speech_synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_output)

# Receives a text from console input.
print("Type some text that you want to speak...")
text = input()

# Synthesizes the text to speech.
result = speech_synthesizer.speak_text_async(text).get()

# Checks result.
if result.reason == speechsdk.ResultReason.SynthesizingAudioCompleted:
    print("Speech synthesized to [{}] for text [{}]".format(audio_filename, text))
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
1. Type some text when you're prompted.
1. A new file will be created at the root of your application folder. You can open the file with an audio player to hear the contents that were generated from the text you entered.

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
1. Type some text when you're prompted.
1. A new file will be created at the root of your application folder. You can open the file with an audio player to hear the contents that were generated from the text you entered.

::: zone-end
