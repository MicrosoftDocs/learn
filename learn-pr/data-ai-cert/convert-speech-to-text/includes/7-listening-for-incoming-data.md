Another potential use for Speech-to-Text is to perform the translation operation on incoming speech that is being heard from a microphone.  This scenario can present itself in a presentation venue where the the Speech Service provides the speech-to-text translation of the person(s) speaking, and then displays it as captions on a project screen.  In this exercise, you will see an example of listening for speech from a microphone and translating it to text output.

> [!Note]
> This is an optional exercise as it requires the use of a local computer and the installation of software to make the exercise steps successful.

In order to test this scenario, the online environment will create issues with accessing the microphone so we will be using your local computer for this scenario.   As a result, you will need to have either Visual Studio or Visual Studio Code installed.  Because Visual Studio Code is a free development tool that is supported on Windows, Mac, and Linux, it is the tool we will use.   Visit the [Visual Studio Code](https://code.visualstudio.com/) page to download and install the application on your local computer.  Once the install completes, begin the exercise.

1. Create a local folder where you will store the project for this exercise
1. Start Visual Studio Code and open the folder you created in step 1
1. Open a terminal window in VS Code by pressing CTRL+`, the Control key plus the back tick.   Optionally, you can choose the View menu and then Terminal
1. type the command ```dotnet new console``` and press Enter
1. Dotnet Core creates a project structure for you in your folder and adds a Program.cs file
1. In the terminal window, enter the following command, ```dotnet add package Microsoft.CognitiveServices.Speech``` and press Enter
1. The necessary package will be added to your project and is required to access the Speech SDK
1. Paste the following code into Program.cs, replacing the existing code

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

1. Replace **"YourSubscriptionKey"** with the key from your Speech Service you created in this module
1. Replace **"YourServiceRegion"** with the region in which you created your Speech Service, such as *westus*.
1. Ensure you have a microphone connected to your local computer and that it is working.
1. In the terminal, type ```dotnet run``` to start the application
1. Begin speaking so the application can collect the streaming audio
1. When you finish, you should see transcribed text output in the terminal
1. When prompted, press Enter to quit the application
