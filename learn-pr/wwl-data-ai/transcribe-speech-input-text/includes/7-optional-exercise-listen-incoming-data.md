Another potential use for Speech-to-Text is to perform the translation operation on incoming speech that is being heard from a microphone.  This scenario can present itself in a presentation venue where the Speech Service provides the speech-to-text translation of the person(s) speaking, and then displays it as captions on a project screen.  In this exercise, you will see an example of listening for speech from a microphone and translating it to text output.

>[!Note]
>This exercise assumes you have completed the previous exercise on converting speech from an audio file. If you have not completed that exercise, you will need to import the appropriate packages into the C# or Python project. See the previous exercise mentioned, for instruction on adding the packages.

>[!Note]
>This exercise requires you to have a working microphone connected to the computer.

## Exercise - convert audio from a microphone

1. Create a local folder where you will store the project for this exercise.
2. Start Visual Studio Code and open the folder you created in step 1.

::: zone pivot="python"

3. Create a new file in your folder called **microphoneinput.py**.
4. Paste the following code into the newly created file.

    ```python
    import azure.cognitiveservices.speech as speechsdk

    speech_key, service_region = "YourSubscriptionKey", "YourServiceRegion"
    speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)

    speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config)

    print("Begin speaking...")

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

5. Locate the **Run Python File in Terminal** button in the upper right corner of VS Code Codespaces and select it to run the code.
6. Begin speaking so the application can collect the streaming audio.
7. When you finish, you should see transcribed text output in the terminal.

::: zone-end

::: zone pivot="csharp"

3. Open a terminal window in VS Code by pressing CTRL+`, the Control key plus the back tick.   Optionally, you can choose the View menu and then Terminal.
4. type the command ```dotnet new console``` and press Enter.
5. A project structure is created for you in the folder and a Program.cs file is also added.
6. In the terminal window, enter the following command, ```dotnet add package Microsoft.CognitiveServices.Speech```, and press Enter.
7. The necessary package will be added to your project and is required to access the Speech SDK.
8. Paste the following code into Program.cs, replacing the existing code.

    ```csharp
    //
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE.md file in the project root for full license information.
    //

    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;

    namespace helloworld
    {
        class Program
        {
            public static async Task RecognizeSpeechAsync()
            {
                var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

                using (var recognizer = new SpeechRecognizer(config))
                {
                    var result = await recognizer.RecognizeOnceAsync();

                    if (result.Reason == ResultReason.RecognizedSpeech)
                    {
                        Console.WriteLine($"We recognized: {result.Text}");
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

            static void Main()
            {
                Console.WriteLine("Begin speaking....");
                RecognizeSpeechAsync().Wait();
                Console.WriteLine("Please press <Return> to continue.");
                Console.ReadLine();
            }
        }
    }
    ```

9. Replace **"YourSubscriptionKey"** with the key from your Speech Service you created in this module.
10. Replace **"YourServiceRegion"** with the region in which you created your Speech Service, such as *westus*.
11. Ensure you have a microphone connected to your local computer and that it is working.
12. In the terminal, type ```dotnet run``` to start the application.
13. Begin speaking so the application can collect the streaming audio.
14. When you finish, you should see transcribed text output in the terminal.
15. When prompted, press <kbd>Enter</kbd> to quit the application.

::: zone-end

>[!Tip]
>The main difference between this optional exercise and the exercise on converting from an audio file, revolves around not requiring the **AudioConfig** class to handle the audio file formats. This code in this exercise assumes input from an attached microphone.
