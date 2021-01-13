In this exercise, you will make use of the Speech Service you created earlier.  This exercise requires configuration on your local computer for a development environment as we will use Visual Studio Code as the editor. If you running in a hosted environment, most of the software should already be installed for you.

## Environment setup

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.

### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.
1. You will also make use of a recorded .wav file in this exercise. Download the narration.wav file by [cloning this repo](https://github.com/MicrosoftLearning/AI-102-Process-Speech/tree/master/transcribe_speech_to_text) to your local computer. Once you have cloned the repo, either place the narration.wav file 
in a location where your code will be executed, or update the path in the code to match the location of the file.


With your environment setup, you are now ready to begin the coding exercise.

## Exercise - convert speech input to text

::: zone pivot="python"

1. Start by opening Visual Studio Code.
1. Create a new folder with a name of your choosing, example **SpeechToTextPython**.
1. Create a new file in the folder called **speechtotext.py**.
1. If you get any messages about installing additional extensions or components, choose to do so.
1. Select the **speechtotext.py** file in the explorer pane.
1. The first item we need to focus on is creating a **speech_config** object. The **speech_config** object is based on the **SpeechConfig** class and will include information related to your subscription such as the key, region, endpoint, etc. For our purpose here, we will only be concerned with the **subscription key** and **region**.
1. In the code window, inside **speechtotext.py**, enter the following code to create two variables and a **speech_config** object. The first line imports the necessary package for the speech sdk.

    ```python
    import azure.cognitiveservices.speech as speechsdk
    speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"
    speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)
    ```

1. Locate the **YourSubscriptionKey**, **YourServiceRegion** line in the file and paste your key into the proper spot and set the region to where you created your **Speech Service**, such as **westus**.
1. Once you have the **speech_config** object created, the next step is to initialize a **recognizer**. The **recognizer** is based on the **SpeechRecognizer** class. You will pass in the **speech_config** object into the **recognizer** as the credentials required to connect to and validate your request, with the Speech service.
1. The **SpeechRecognizer** can accept input from a microphone or from a file. This exercise will use a file as the input so you will need to add an **AudioConfig** component to the application. Enter the following code to enable reading audio from a file.

    >[!Note]
    >The **narration.wav** entry in the filename variable will need to be modified based on where you stored the file.

    ```python
    audio_input = speechsdk.AudioConfig(filename="/narration.wav")
    ```

1. Enter the following code to initialize the **speech_recognizer** object with the **speech_config** and **audio_config** information.

    ```python
    speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config=audio_input)
    ```

1. Enter the following code to output a status message and to call the service, placing the converted text into a variable.

    ```python
    print("Recognizing first result...")

    result = speech_recognizer.recognize_once()
    ```

1. Finally, you will enter code to check the result of the service call. It should succeed but we also include some checks for potential errors that may occur.  Enter the following lines of code to check the status and output the results accordingly.

    ```python
    if result.reason == speechsdk.ResultReason.RecognizedSpeech:
        print("Recognized: {}".format(result.text))
    elif result.reason == speechsdk.ResultReason.NoMatch:
        print("No speech could be recognized: {}".format(result.no_match_details))
    elif result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = result.cancellation_details
        print("Speech Recognition canceled: {}".format(cancellation_details.reason))
        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            print("Error details: {}".format(cancellation_details.error_details))
    ```

1. Your completed code should look similar to this.

    ```python
    import azure.cognitiveservices.speech as speechsdk

    speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"
    speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)

    audio_filename = "/narration.wav"
    audio_input = speechsdk.AudioConfig(filename=audio_filename)

    speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config=audio_input)

    print("Recognizing first result...")

    result = speech_recognizer.recognize_once()
    if result.reason == speechsdk.ResultReason.RecognizedSpeech:
        print("Recognized: {}".format(result.text))
    elif result.reason == speechsdk.ResultReason.NoMatch:
        print("No speech could be recognized: {}".format(result.no_match_details))
    elif result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = result.cancellation_details
        print("Speech Recognition canceled: {}".format(cancellation_details.reason))
        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            print("Error details: {}".format(cancellation_details.error_details))
    ```

1. You will need to add a package for the Cognitive Services speech functions so open a terminal window in Visual Studio Code and paste the following command in the terminal window, and hit Enter to add the package: `pip install --upgrade azure-cognitiveservices-speech`
1. Locate the **Run Python File in Terminal** button in the upper right corner of VS Code Codespaces and select it to run the code.
1. The result of the speech to text transcription is displayed in the terminal window.
1. Feel free to record your own audio file and test with the service.

::: zone-end

::: zone pivot="csharp"

1. Start by opening Visual Studio Code.
1. Create a new folder with a name of your choosing, example **SpeechToTextCsharp**.
1. Right-click the **SpeechToTextCsharp** folder and choose **Open in Integrated Terminal**.

    >[!Note]
    >Visual Studio Code may have different menu options depending on the packages you have installed.  You are looking for a terminal window at the bottom of Visual Studio Code that offers a command prompt/terminal.

1. We will be using C# and .NET Core for this exercise so type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder.
1. Open the **Program.cs** file to edit the contents.
1. At the top of **Program.cs**, add the following using statements immediately following the existing one.

    ```csharp

    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;

    ```

1. It's always a good idea to access the services in an asynchronous fashion where possible so modify **Main()** to look like this code.

    ```csharp
    static async Task Main()
    {
        await RecognizeSpeechAsync();
    }
    ```

1. You will create a method to call the service asynchronously so start be creating the method signature.

    ```csharp
    static async Task RecognizeSpeechAsync()
    {

    }
    ```

1. Next, you will create a speech configuration object to hold the subscription information for the service.

    ```csharp
    // Configure the subscription information for the service to access.
    // Use either key1 or key2 from the Speech Service resource you have created
    var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");
    ```

1. Locate your key and region from the **Speech** service you created earlier. Paste then into the placeholders in the method signature.
1. You will use an audio file for the speech input in this exercise. Enter this code to configure the **AudioConfig** object.

    ```csharp
    // Setup the audio configuration, in this case, using a file that is in local storage.
    using (var audioInput = AudioConfig.FromWavFileInput("YourAudioFileName"))
    ```

1. The final pieces of code will pass in the required parameters to the speech service, call the service, check the results, and output values accordingly.

    ```csharp
    // Pass the required parameters to the Speech Service which includes the configuration information
    // and the audio file name that you will use as input
    using (var recognizer = new SpeechRecognizer(config, audioInput))
    {
        Console.WriteLine("Recognizing first result...");
        var result = await recognizer.RecognizeOnceAsync();

        switch (result.Reason)
        {
            case ResultReason.RecognizedSpeech:
                // The file contained speech that was recognized and the transcription will be output
                // to the terminal window
                Console.WriteLine($"We recognized: {result.Text}");
                break;
            case ResultReason.NoMatch:
                // No recognizable speech found in the audio file that was supplied.
                // Out an informative message
                Console.WriteLine($"NOMATCH: Speech could not be recognized.");
                break;
            case ResultReason.Canceled:
                // Operation was cancelled
                // Output the reason
                var cancellation = CancellationDetails.FromResult(result);
                Console.WriteLine($"CANCELED: Reason={cancellation.Reason}");

                if (cancellation.Reason == CancellationReason.Error)
                {
                    Console.WriteLine($"CANCELED: ErrorCode={cancellation.ErrorCode}");
                    Console.WriteLine($"CANCELED: ErrorDetails={cancellation.ErrorDetails}");
                    Console.WriteLine($"CANCELED: Did you update the subscription info?");
                }
                break;
        }
    }
    ```

1. The next step is to modify **Main()** to call our **RecognizeSpeechAsync()** method. Replace the existing *Hello World* code in **Main()** with the following line of code.

    ```csharp
    await RecognizeSpeechAsync();
    ```

1. For comparison, your complete code should look like this:

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;

    namespace SpeechToTextCsharp
    {
        class Program
        {
            static async Task Main(string[] args)
            {
                await RecognizeSpeechAsync();
            }

            static async Task RecognizeSpeechAsync()
            {
                // Configure the subscription information for the service to access.
                // Use either key1 or key2 from the Speech Service resource you have created
                var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

                // Setup the audio configuration, in this case, using a file that is in local storage.
                using (var audioInput = AudioConfig.FromWavFileInput("../narration.wav"))

                // Pass the required parameters to the Speech Service which includes the configuration information
                // and the audio file name that you will use as input
                using (var recognizer = new SpeechRecognizer(config, audioInput))
                {
                    Console.WriteLine("Recognizing first result...");
                    var result = await recognizer.RecognizeOnceAsync();

                    switch (result.Reason)
                    {
                        case ResultReason.RecognizedSpeech:
                            // The file contained speech that was recognized and the transcription will be output
                            // to the terminal window
                            Console.WriteLine($"We recognized: {result.Text}");
                            break;
                        case ResultReason.NoMatch:
                            // No recognizable speech found in the audio file that was supplied.
                            // Out an informative message
                            Console.WriteLine($"NOMATCH: Speech could not be recognized.");
                            break;
                        case ResultReason.Canceled:
                            // Operation was cancelled
                            // Output the reason
                            var cancellation = CancellationDetails.FromResult(result);
                            Console.WriteLine($"CANCELED: Reason={cancellation.Reason}");

                            if (cancellation.Reason == CancellationReason.Error)
                            {
                                Console.WriteLine($"CANCELED: ErrorCode={cancellation.ErrorCode}");
                                Console.WriteLine($"CANCELED: ErrorDetails={cancellation.ErrorDetails}");
                                Console.WriteLine($"CANCELED: Did you update the subscription info?");
                            }
                            break;
                    }
                }
            }
        }
    }

    ```

1. Before your application will work, you will need to bring in the appropriate packages.
1. In the terminal window, type the following command 
    ```dotnet add package Microsoft.CognitiveServices.Speech``` and press <kbd>Enter</kbd>.
1. Ensure that the **narration.wav** file is correctly identified in the ```using (var audioInput = AudioConfig.FromWavFileInput("../narration.wav"))``` line.
1. In the terminal window, type ```dotnet run``` and if all was entered correctly, you should see the result of the translation in the terminal window.

::: zone-end
