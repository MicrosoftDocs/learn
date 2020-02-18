
In this exercise, you will make use of the Speech Service you created earlier.  This exercise does not require any configuration on your local computer for a development environment as we will use Visual Studio Code Online.  The steps will detail what is required to get the online environment configured correctly, tasks that will be required for each exercise to work correctly.   All resources are stored in a GitHub repo that you will link to during the exercise steps.

::: zone pivot="python"

1. Start by opening a browser tab or window and navigating to [Visual Studio Code Online](https://visualstudio.microsoft.com/services/visual-studio-online/)

    [!NOTE] At this time, Safari is not a supported browser for the preview of VS Code Online

1. You will require an Azure subscription to create an environment for Visual Studio Code Online
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Environment**
1. Select your **Subscription** in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create you first environment.  
1. If the **Create Environment** panel does not open automatically, select **Create environment**.
1. Enter an environment name of your choosing, example **SpeechToTextPython**
1. Copy the following URL and past it into the Git Repository area on the **Create Environment** panel, https://github.com/MicrosoftLearning/AI-SpeechToText
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your **Speech** service in the **Azure portal** and copy one of your keys, and also note the region where the service was created.
1. Once the environment indicates that it is available, either select the title, or select the three vertical dots in the lower right of the environment box and choose **Connect**.
1. VS Code Online will now synchronize the GitHub repo and run the scripts that were present in the devcontainer.  This is required to set up the proper Python environment, in this case 3.5.3.
1. If you get any messages about installing additional extensions or components, choose to do so.  This is only for your local system and is not required to run the code in the online environment.
1. Select the **speechtotext.py** file in the explorer pane.
1. Locate the **speech_key**, **service_region** line in the file and paste your key into the proper spot and set the region to where you created your **Speech Service**, such as **westus**.
1. You will need to add a package for the Cognitive Services speech functions so open a terminal window in VS Code Online and paste the following command in the terminal window, and hit Enter to add the package, 
    ```sudo pip install --upgrade azure-cognitiveservices-speech```
1. Locate the **Run Python File in Terminal** button in the upper right corner of VS Code Online and select it to run the code.
1. The result of the speech to text transcription is displayed in the terminal window.  Feel free to download the **narration.wav** file from the GitHub repo if you want to hear the audio that was used.
1. You can also upload your own audio file to the repo, sync VS Code Online with the repo, change the **audio_filename** option, and run it again.

::: zone-end

::: zone pivot="csharp"

1. Start by opening a browser tab or window and navigating to [Visual Studio Code Online](https://visualstudio.microsoft.com/services/visual-studio-online/)

    [!NOTE] At this time, Safari is not a supported browser for the preview of VS Code Online

1. You will require an Azure subscription to create an environment for Visual Studio Code Online
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription.
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Environment**
1. Select your Subscription in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create your first environment.  
1. If the **Create Environment** panel does not open automatically, select **Create environment**.
1. Enter an environment name of your choosing, example **SpeechToTextCS**.
1. Copy the following URL and past it into the Git Repository area on the **Create Environment** panel, https://github.com/MicrosoftLearning/SpeechToTextCS
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Speech service in the Azure portal and copy one of your keys, and also note the region where the service was created.
1. Once the environment indicates that it is available, either select the title or select the three vertical dots in the lower right of the environment box and choose **Connect**.
1. We will be using C# and .NET Core for this exercise so once the VS Code window opens, start the Terminal by selecting the hamburger menu, **View**, and then **Terminal**.
1. Once you start typing a command, you will receive a message that the terminal is read-only.  Select the button to open a new terminal.
1. Verify that **Bash** is selected in the Select Default Shell drop-down to the right.
1. Type in the command ```dotnet new console``` and press Enter.
1. A new C# dotnet core project structure is set up for you complete with a Program.cs file, a workspace.csproj file, and the obj folder.
1. Open the Program.cs file and replace its contents with the following code.

    ```csharp
    //
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE.md file in the project root for full license information.
    //

    using System;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;

    namespace HelloWorld
    {
        class Program
        {
            // It's always a good idea to access services in an async fashion
            static async Task Main()
            {
                await RecognizeSpeechAsync();
            }

            static async Task RecognizeSpeechAsync()
            {
                // Configure the subscription information for the service to access.
                // Use either key1 or key2 from the Speech Service resource you have created
                var config = SpeechConfig.FromSubscription("YourSubscriptionKey", "YourServiceRegion");

                // Setup the audio configuration, in this case, using a file that is in local storage.
                using (var audioInput = AudioConfig.FromWavFileInput("YourAudioFileName"))

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
1. In the terminal window, type the following command 
    ```dotnet add package Microsoft.CognitiveServices.Speech``` 
    and press Enter
1. In the terminal windows, type the following command to also add the Audio package, ``` dotnet add package Microsoft.CognitiveServices.Speech.Audio```, and press Enter
1. Visual Studio Code installs the package for use with the AudioConfig class that will be used in the code
1. Include the package in Program.cs by entering the following using statement 
    ```csharp
        using Microsoft.CognitiveServices.Speech.Audio;
    ```
1. In the Program.cs file, paste your Speech Service key where the text **YourSubscriptionKey** is
1. Enter your location, such as **westus** in the **YourServiceRegion** option of that same line
1. Locate the text **YourAudioFileName** and replace it with **narration.wav**
1. In the terminal window, type ```dotnet run``` and if all was entered correctly, you should see the result of the translation in the terminal window.

::: zone-end

