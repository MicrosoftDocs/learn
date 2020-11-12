The ability to synthesize text to speech output will require that your computer to have an audio output device. In this exercise, you will perform text-to-speech synthesis by typing in some text and having that text synthesized to speech and played through your computer's audio output.

>[!TIP]
>The sample code that will be used in this exercise will prompt you to type some text in the terminal window.  The text you enter will be used as the input for the text-to-speech conversion.  There are other options you could explore for text input such as a file. If you choose to use a file as input, keep in mind the length of the text and consider if you should use the **Long Audio API** and send the audio to a file, rather than creating real time audio.

The SpeechConfig configuration object accepts your Speech service key and region for authorization.  You can also use the SpeechConfig object to change how your speech synthesis works.  For example, the default voice will be used for speaking unless you modify the SpeechConfig object.  You can do so by providing a voice name for the SpeechConfig object as shown here:

```python
speech_config_obj.speech_synthesis_voice_name = "en-CA-Linda"
```

```csharp
config.SpeechSynthesisVoiceName = "en-CA-Linda";
```

The code sample shows how to configure an English language voice using Canadian English.  You will get a chance to try this in the exercise.  To understand the voices available, visit the [language support](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support#text-to-speech) page.

>[!TIP]
>Choosing a voice that is not native for the language you are using, may not provide the results you expect. For example, if you select a voice for German language support, and your text is in US English, the pronunciation may not be the same as a native US English speaker.

This exercise will use the default audio format for output but you can investigate the options on your own to further explore changing the audio format as demonstrated in the code snippets above.

## Environment setup

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.

### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.

With your environment setup, you are now ready to begin the coding exercise.

::: zone pivot="csharp"

## Exercise - Synthesize speech with C#

1. Using Windows Explorer, create a folder on your local drive to store the project files.  Name the folder **synthesize_text_to_speech**.
1. Open Visual Studio Code.
1. Open the folder you just created.
1. You will create a .NET Core application so right-click the **synthesize_text_to_speech** folder and choose **Open in Terminal**
1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder. You may need to expand the csharp folder to see the new files.
1. Select the Program.cs file and inspect its contents. You will modify and add code to this file for the exercise.

    >[!NOTE]
    >If you are prompted to install the C# Extension, select Install. Then select the reload option.
    >After the reload, you may also be prompted to install extensions, choose to install them

1. The first step is to add the necessary **using** statements at the top of the file.  Add the following statements directly underneath the existing ```using System;``` line of code.

```csharp
using System.Threading.Tasks;
using Microsoft.CognitiveServices.Speech;
using Microsoft.CognitiveServices.Speech.Audio;
```

The packages you are importing allow for asynchronous programming, and bring in the classes for using Cognitive Services Speech functionality.

1. It is recommended that you make calls to the services asynchronously so you will need to modify the **Main()** method to work in this manner.  Modify **Main()** to look like this.

```csharp
public static async Task SynthesisToSpeakerAsync()
{
}
```

1. Next, create a **config** object that derived from the **SpeechConfig** class. This is necessary to pass in the subscription and key information to authenticate your client. Add the following code immediately following the opening curly brace of **Main()**. 

```csharp
// Creates an instance of a speech config with specified subscription key and service region.
// Replace with your own subscription key and service region (e.g., "westus").
// The default language is "en-us".
var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");
```

1. Finalize the **SynthesisToSpeakerAsync()** method with the following code. The code creates a **SpeechSynthesizer** object that will be used to speak the entered text.

```csharp
// uncomment this line to change the voice used for synthesis
// config.SpeechSynthesisVoiceName = "en-CA-Linda";

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
```

1. When finished, your completed code should look similar to this listing.

```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;

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
                // config.SpeechSynthesisVoiceName = "en-CA-Linda";

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

            static async Task Main()
            {
                await SynthesisToSpeakerAsync();
            }
        }
    }
```

1.You will now need to add the Microsoft Cognitive Service Speech package to your application.

1. In the terminal, enter ```dotnet add package Microsoft.CognitiveServices.Speech```

   > [!NOTE]
   > Ensure you are in the proper folder.

1. Once the package is added, you are ready to run the application.
1. Get your key and region from the Speech resource your created on Azure and paste them in the **YourSubscriptionKey** and **YourServiceRegion** placeholders in the code.
1. In the terminal, type ```dotnet run``` and press Enter.
1. You will be prompted to enter some text.  Enter a phrase of your choosing and press Enter.
1. The computer will read back the text to you in the default voice.
1. Go back in the code and remove the comment on this line of code, ```// config.Speech = "en-CA-Linda";```
1. Removing the comment will modify the **SpeechConfig** object to use a voice other than the default. Explore the other voice options at the [language support](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support#text-to-speech) page.

::: zone-end

::: zone pivot="python"

## Exercise - Synthesize speech with Python

If you do not already have Python and Visual Studio Code installed on your local computer. Follow these instructions in the **Environment Setup** section above, to get your environment ready for the exercise.

1. Create a folder to store the project in by using your local file system.
1. In Visual Studio Code, select the File icon. Then open the folder you created.
1. Create a new Python source file, **texttospeech.py**, by selecting the new file icon.
1. Copy and paste the following Python code into the **texttospeech.py** file.

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
1. Before you run the code, you need to add the Cognitive Services speech package. In the terminal, enter the command ```pip install --upgrade azure-cognitiveservices-speech```

>[!Tip]
>The exact command will differ based on the Python environment you are using.  You may have to use ```sudo pip``` or ```python3 ``` in the command.

1. Select the **Run Python File in Terminal** (green arrow) or right-click in the Python file editor and select **Run Python File in Terminal**.
1. Type some text when you're prompted. The synthesized audio is played using the default voice.
1. 1. Go back in the code and remove the comment on this line of code, ```# speech_config.speech_synthesis_voice_name = "en-CA-Linda"```
1. Removing the comment will modify the **SpeechConfig** object to use a voice other than the default. Explore the other voice options at the [language support](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support#text-to-speech) page.

::: zone-end