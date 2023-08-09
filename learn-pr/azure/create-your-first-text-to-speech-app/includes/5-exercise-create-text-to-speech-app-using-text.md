In this exercise, you'll create a text file that you'll use to create an audio file by using the Azure Cognitive Services speech synthesizer.

## Create your text to speech application

1. In the Cloud Shell on the right, create a directory for your application, then switch folders to your new folder:

    ```bash
    mkdir text-to-speech
    cd text-to-speech
    ```

1. Create a new .NET Core application:

    ```dotnetcli
    dotnet new console
    ```

    This command should take a few seconds to complete.

1. When your .NET Core application has been created, add the Cognitive Services package to your application:

    ```dotnetcli
    dotnet add package Microsoft.CognitiveServices.Speech
    ```

    This command should take a few seconds to complete.

## Add the code for your text to speech application

1. In the Cloud Shell on the right, open the *Program.cs* file:

    ```dotnetcli
    code Program.cs
    ```

1. Replace the existing code with the following `using` statements, which enable the Azure Cognitive Services Speech APIs for your application:

    ```csharp
    using System.Text;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    ```

1. Below the `using` statements, add the following code, which uses Azure Cognitive Services Speech APIs to convert the contents of the text file that you'll create to create a WAV file with the synthesized voice. Replace the `azureKey` and `azureLocation` values with the ones you copied in the last exercise.

    ```csharp
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string textFile = "Shakespeare.txt";
    string waveFile = "Shakespeare.wav";

    try
    {
        FileInfo fileInfo = new FileInfo(textFile);
        if (fileInfo.Exists)
        {
            string textContent = File.ReadAllText(fileInfo.FullName);
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
            var speechResult = await speechSynthesizer.SpeakTextAsync(textContent);
            using var audioDataStream = AudioDataStream.FromResult(speechResult);
            await audioDataStream.SaveToWaveFileAsync(waveFile);       
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
         
    }
    ```

    This code uses your key and location to initialize a connection to Azure Cognitive Services, then reads the contents of the text file you'll create, then uses the `SpeakTextAsync()` method of the speech synthesizer to convert the text to audio, then uses an audio stream to save the results to an audio file.

1. When you've finished adding all of the code, your file should resemble the following example:

    ```csharp
    using System.Text;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string textFile = "Shakespeare.txt";
    string waveFile = "Shakespeare.wav";
        
    try
    {
        FileInfo fileInfo = new FileInfo(textFile);
        if (fileInfo.Exists)
        {
            string textContent = File.ReadAllText(fileInfo.FullName);
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
            var speechResult = await speechSynthesizer.SpeakTextAsync(textContent);
            using var audioDataStream = AudioDataStream.FromResult(speechResult);
            await audioDataStream.SaveToWaveFileAsync(waveFile);       
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);                
    }
    ```

    Make sure that you update the values for the `azureKey` and `azureLocation` variables with your key and location from the previous exercise.

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Create a text file for your application to read

1. In the Cloud Shell on the right, create a new text file that your application will read:

    ```dotnetcli
    code Shakespeare.txt
    ```

1. When the code editor appears, enter the following text.

    ```text
    The following quotes are from act 2, scene 7, of William Shakespeare's play "As You Like It."

    Thou seest we are not all alone unhappy:
    This wide and universal theatre
    Presents more woeful pageants than the scene
    Wherein we play in.

    All the world's a stage,
    And all the men and women merely players:
    They have their exits and their entrances;
    And one man in his time plays many parts,
    His acts being seven ages.
    ```

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Run your application

1. To run your application, use the following command in the Cloud Shell on the right:

    ```dotnetcli
    dotnet run
    ```

1. If you don't see any errors, your application has run successfully. To verify, run the following command to get a list of files in the directory.

    ```bash
    ls -l
    ```

    You should get a response like the following example, and you should have the *Shakespeare.wav* file in the list of files:

    ```bash
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 bin
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 obj
    -rw-r--r-- 1 user   user     1328 Oct  1 11:11 Program.cs
    -rw-r--r-- 1 user   user      413 Oct  1 11:11 Shakespeare.txt
    -rw-r--r-- 1 user   user   955282 Oct  1 11:11 Shakespeare.wav
    -rw-r--r-- 1 user   user      348 Oct  1 11:11 text to speech.csproj
    ```

## Optional: Listen to your WAV file

[!include[](listen-to-your-wave-file.md)]

## Optional: Change the voice

The `SpeechConfig` class has a `SpeechSynthesisVoiceName` property you can use to specify a voice other than the default. You can find a list of voices you can use in the **Text to speech** section of the [Language and voice support for the Speech service](/azure/cognitive-services/speech-service/language-support#text-to-speech) article.

To specify the voice, use the following steps.

1. In the Cloud Shell on the right, open the *Program.cs* file:

    ```dotnetcli
    code Program.cs
    ```

1. Locate the following line of code:

    ```csharp
    var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
    ```

1. Add the following line after the previous line:

    ```csharp
    speechConfig.SpeechSynthesisVoiceName = "en-SG-WayneNeural";
    ```

1. The resulting section of code should look like the following example:

    ```csharp
    string textContent = File.ReadAllText(fileInfo.FullName);
    var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
    speechConfig.SpeechSynthesisVoiceName = "en-SG-WayneNeural";
    using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
    ```

    When you make this change and recompile your application, the text-to-speech synthesis will use the new voice.
