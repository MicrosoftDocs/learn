When synthesizing text to speech and using audio output on your computer, the SpeechSynthesizer object's constructor only took one argument, a SpeechConfig object. For saving the audio output to a file, you will be required to also create an AudioConfig object and pass that to the SpeechSynthesizer.  The AudioConfig object uses a file name as the property where it will store the audio output. You will also need to add another ```using``` statement to include the Audio portion of the Speech SDK.

The file output will be in .wav format so you can play the audio on any device the supports .wav files. In the code samples used here, you will use the default file format and the default audio properties.

## Environment setup (Optional if you completed this setup already)

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.

### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.
1. You will also make use of a recorded .wav file in this exercise. [Download the narration.wav file](https://github.com/MicrosoftLearning/AI-102-Process-Speech/tree/master/transcribe_speech_to_text/media) and place it in a location where your code will be executed.

## Exercise - Convert text to an audio file

With your environment setup, you are now ready to begin the coding exercise.

::: zone pivot="csharp"

>[!Note]
>You can use the exercise files from the previous exercise if you want to avoid creating multiple folders. Simply
> add the new method indicated in this code and comment out the previous code inside **Main()**.

1. Create a new folder for the project.  Name the folder **TextToAudioFileCsharp** or a name of your choosing
1. In the folder pane of VS Code, right-click the folder name and choose **Open in terminal**
1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder.
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

            // Modify the file name to an appropriate path on your local computer
            var fileName = "text_to_speech.wav";

            using (var fileOutput = AudioConfig.FromWavFileOutput(fileName))
                {
                    using (var synthesizer = new SpeechSynthesizer(config, fileOutput))
                    {
                        var result = await synthesizer.SpeakTextAsync(text);

                        if (result.Reason == ResultReason.SynthesizingAudioCompleted)
                        {
                            Console.WriteLine($"Input synthesized to [{fileName}] for text [{text}]");
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

    ```

    >[!NOTE]
    >You will need to modify the ``` var fileName = "text_to_speech.wav";``` line to point to the file on your local machine.

1. Replace the **Main()** method with this code that will call the newly created method.

```csharp
static async Task Main()
{
    await SynthesisToAudioFileAsync();
}
```

1. In the header, add the following using statement,

```csharp
using Microsoft.CognitiveServices.Speech.Audio
```

1. Ensure your key and region from the Speech resource your created on Azure are in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the terminal, type ```dotnet run``` and press Enter.
1. You will be prompted to enter some text.  Enter a phrase of your choosing and press Enter.
1. A new file will be created in the media folder you specified in the code. Open the file to hear the audio output.

::: zone-end

::: zone pivot="python"

1. Create a folder to store the project in.
1. In Visual Studio Code, select the File icon. Then open the folder you created.
1. Create a new Python source file, **texttospeech.py**, by selecting the new file icon.
1. Copy and paste this Python code into the new file.


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

>[!NOTE]
>You will need to modify the ``` audio_filename = "transcribe_speech_to_text/media/text-to-speech-py.wav" ``` line to point >to the file on your local machine.

1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. If selected, a Python interpreter displays on the left side of the status bar at the bottom of the window. Otherwise, bring up a list of available Python interpreters. Open the command palette (Ctrl+Shift+P) and enter Python: Select Interpreter. Choose an appropriate one.
1. You can install the Speech SDK Python package from within Visual Studio Code. Do that if it's not installed yet for the Python interpreter you selected. To install the Speech SDK package, open a terminal. Bring up the command palette again (Ctrl+Shift+P) and enter Terminal: Create New Integrated Terminal. In the terminal that opens, enter the command ```python -m pip install azure-cognitiveservices-speech```.
1. To run the code, right-click somewhere inside the editor. Select **Run Python File in Terminal**.
1. Type some text when you're prompted.
1. A new file will be created in the folder you specified in code. You can open the file with an audio player to hear the contents that were generated from the text you entered.
1. Open the file to play it and hear the audio that was created.

::: zone-end
