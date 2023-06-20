In this exercise, you'll create an application that uses single-shot recognition to transcribe a sample audio file that you'll download.

## Create your speech to text application

1. In the Cloud Shell on the right, create a directory for your application, then change to your new directory:

    ```bash
    mkdir speech-to-text
    cd speech-to-text
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

## Download a WAVE file for recognition

In the Cloud Shell on the right, run the following command to download a sample WAV file that contains a series of quotes from William Shakespeare's play "As You Like It."

```bash
curl -L https://aka.ms/ShakespeareWAV -o Shakespeare.wav
```

You'll use this WAV file for the application in this exercise and the application in the next exercise.

## Add the code for your text to speech application

1. In the Cloud Shell on the right, open the *Program.cs* file:

    ```dotnetcli
    code Program.cs
    ```

1. Remove all the existing code and add the following `using` statements, which enable the Azure Cognitive Services Speech APIs for your application:

    ```csharp
    using System.Text;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    ```

1. Add the following code, which uses Azure Cognitive Services Speech APIs to convert the contents of the WAV file that you created earlier to create a text file with the transcribed speech. Replace the `azureKey` and `azureLocation` values with the values you copied in the last exercise.

    ```csharp
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string textFile = "Shakespeare.txt";
    string waveFile = "Shakespeare.wav";
    
    try
    {
        FileInfo fileInfo = new FileInfo(waveFile);
        if (fileInfo.Exists)
        {
            Console.WriteLine("Speech recognition started.");
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
            using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
            var result = await speechRecognizer.RecognizeOnceAsync();
                        
            FileStream fileStream = File.OpenWrite(textFile);
            StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
            streamWriter.WriteLine(result.Text);
            streamWriter.Close();
            Console.WriteLine("Speech recognition stopped.");
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    ```

    This code uses your key and location to initialize a connection to Azure Cognitive Services. It then reads the contents of the WAV file that you downloaded, then uses the `RecognizeOnceAsync()` method of the `SpeechRecognizer` to convert the audio to text, then it uses a stream writer to save the results to a text file.

1. When you've finished adding all of the code, your file should resemble the following example:

    ```csharp
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string textFile = "Shakespeare.txt";
    string waveFile = "Shakespeare.wav";
    
    try
    {
        FileInfo fileInfo = new FileInfo(waveFile);
        if (fileInfo.Exists)
        {
            Console.WriteLine("Speech recognition started.");
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
            using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
            var result = await speechRecognizer.RecognizeOnceAsync();
                        
            FileStream fileStream = File.OpenWrite(textFile);
            StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
            streamWriter.WriteLine(result.Text);
            streamWriter.Close();
            Console.WriteLine("Speech recognition stopped.");
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    ```

    Make sure that you update the values for the `azureKey` and `azureLocation` variables with your key and location from the previous exercise.

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Run your application

1. To run your application, use the following command in the Cloud Shell on the right:

    ```dotnetcli
    dotnet run
    ```

1. If you don't see any errors, your application has run successfully, and you should see the following responses displayed:

    ```text
    Speech recognition started.
    Speech recognition stopped.
    ```

1. Run the following command to get a list of files in the directory:

    ```bash
    ls -l
    ```

    You should see a response like the following example, and you should see the *Shakespeare.txt* in the list of files:

    ```bash
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 bin
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 obj
    -rw-r--r-- 1 user   user     1476 Oct  1 11:11 Program.cs
    -rw-r--r-- 1 user   user       98 Oct  1 11:11 Shakespeare.txt
    -rwxr-xr-x 1 user   user   978242 Oct  1 11:11 Shakespeare.wav
    -rw-r--r-- 1 user   user      348 Oct  1 11:11 speech to text.csproj
    ```

    You'll notice that the size of the text file is small; in this example, it's only 98 bytes.

1. To view the contents of the *Shakespeare.txt* file, use the following command:

    ```bash
    cat Shakespeare.txt
    ```

    You should see a response like the following example:

    ```text
    The following quotes are from Act 2, scene seven of William Shakespeare's play as you like it.
    ```

    If you listened to the sample WAV file, you'd notice that this text is only the first few seconds of the audio. Because we used the `RecognizeOnceAsync()` method of the `SpeechRecognizer`, the speech-to-text recognition stopped when the speaker paused.

In the next exercise, you'll learn how to continue the speech to text recognition for the entire audio file.
