In this exercise, you'll create an application that uses continuous recognition to transcribe the sample audio file that you downloaded in the previous exercise.

## Modify the code for your text to speech application

1. In the Cloud Shell on the right, open the *Program.cs* file.

    ```dotnetcli
    code Program.cs
    ```

1. Update the try/catch block with the following code to modify the application to use continuous recognition instead of single-shot recognition:

    ```csharp
    try
    {
        FileInfo fileInfo = new FileInfo(waveFile);
        if (fileInfo.Exists)
        {
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
            using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
            var stopRecognition = new TaskCompletionSource<int>();

            FileStream fileStream = File.OpenWrite(textFile);
            StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);

            speechRecognizer.Recognized += (s, e) =>
            {
                switch(e.Result.Reason)
                {
                    case ResultReason.RecognizedSpeech:
                        streamWriter.WriteLine(e.Result.Text);
                        break;
                    case ResultReason.NoMatch:
                        Console.WriteLine("Speech could not be recognized.");
                        break;
                }
            };

            speechRecognizer.Canceled += (s, e) =>
            {
                if (e.Reason != CancellationReason.EndOfStream)
                {
                    Console.WriteLine("Speech recognition canceled.");
                }
                stopRecognition.TrySetResult(0);
                streamWriter.Close();
            };

            speechRecognizer.SessionStopped += (s, e) =>
            {
                Console.WriteLine("Speech recognition stopped.");
                stopRecognition.TrySetResult(0);
                streamWriter.Close();
            };

            Console.WriteLine("Speech recognition started.");
            await speechRecognizer.StartContinuousRecognitionAsync();
            Task.WaitAny(new[] { stopRecognition.Task });
            await speechRecognizer.StopContinuousRecognitionAsync();
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    ```

1. When you've finished modifying the code, your file should resemble the following example:

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
        FileInfo fileInfo = new FileInfo(waveFile);
        if (fileInfo.Exists)
        {
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
            using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
            var stopRecognition = new TaskCompletionSource<int>();

            FileStream fileStream = File.OpenWrite(textFile);
            StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);

            speechRecognizer.Recognized += (s, e) =>
            {
                switch(e.Result.Reason)
                {
                    case ResultReason.RecognizedSpeech:
                        streamWriter.WriteLine(e.Result.Text);
                        break;
                    case ResultReason.NoMatch:
                        Console.WriteLine("Speech could not be recognized.");
                        break;
                }
            };

            speechRecognizer.Canceled += (s, e) =>
            {
                if (e.Reason != CancellationReason.EndOfStream)
                {
                    Console.WriteLine("Speech recognition canceled.");
                }
                stopRecognition.TrySetResult(0);
                streamWriter.Close();
            };

            speechRecognizer.SessionStopped += (s, e) =>
            {
                Console.WriteLine("Speech recognition stopped.");
                stopRecognition.TrySetResult(0);
                streamWriter.Close();
            };

            Console.WriteLine("Speech recognition started.");
            await speechRecognizer.StartContinuousRecognitionAsync();
            Task.WaitAny(new[] { stopRecognition.Task });
            await speechRecognizer.StopContinuousRecognitionAsync();
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    ```

    As with the previous exercise, make sure that you update the values for the `azureKey` and `azureLocation` variables with your key and location from the first exercise.

1. To save your changes, press <kbd>Ctrl+S</kbd> to save the file, then press <kbd>Ctrl+Q</kbd> to exit the editor.

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
    -rw-r--r-- 1 user   user     2926 Oct  1 11:11 Program.cs
    -rw-r--r-- 1 user   user      412 Oct  1 11:11 Shakespeare.txt
    -rwxr-xr-x 1 user   user   978242 Oct  1 11:11 Shakespeare.wav
    -rw-r--r-- 1 user   user      348 Oct  1 11:11 speech to text.csproj
    ```

    You'll notice that the text file is larger than the result of the previous exercise. This difference in file size is because the continuous speech recognition converted more of the audio file.

1. To view the contents of the *Shakespeare.txt* file, use the following command:

    ```bash
    cat Shakespeare.txt
    ```

    You should see a response like the following example:

    ```text
    The following quotes are from Act 2, scene seven of William Shakespeare's play as you like it.
    Though CS we are not all alone unhappy.
    This wide and universal theater presents more woeful pageants than the scene wherein we play in.
    All the world's a stage and all the men and women merely players.
    They have their exits and their entrances, and one man in his time plays many parts, his act being seven ages.
    ```

    If you listened to the sample WAV file, you'd notice that this text now contains the entirety of the audio. Because we used the `StartContinuousRecognitionAsync()` method of the `SpeechRecognizer`, the speech to text recognition continued even when the speaker paused.

## Improve your application's recognition results

In the previous section, you'll notice that the results for the second line of text weren't perfect; this error in recognition was due to the old English vocabulary in William Shakespeare's play. This example is analogous to the specialized vocabulary that your medical clients will use for their notes and dictations.

Azure AI Speech allows you to help improve your recognition results by specifying a list of phrases that might be unfamiliar to the speech recognition engine.

To see an example of this type of improvement in action, use the following steps.

1. In the Cloud Shell on the right, open the *Program.cs* file:

    ```dotnetcli
    code Program.cs
    ```

1. Locate the following two lines of code:

    ```csharp
    FileStream fileStream = File.OpenWrite(textFile);
    StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
    ```

1. Add the following lines of code after those two lines:

    ```csharp
    var phraseList = PhraseListGrammar.FromRecognizer(speechRecognizer);
    phraseList.AddPhrase("thou seest");
    ```

    These lines will enable the speech recognition engine to detect the old English phrase from Shakespeare's play.

1. To save your changes, press <kbd>Ctrl+S</kbd> to save the file, then press <kbd>Ctrl+Q</kbd> to exit the editor.

1. Rerun your application by using the following command:

    ```dotnetcli
    dotnet run
    ```

1. When your application has finished, use the following command to view the contents of the *Shakespeare.txt* file:

    ```bash
    cat Shakespeare.txt
    ```

    You should see a response like the following example:

    ```text
    The following quotes are from Act 2, scene seven of William Shakespeare's play as you like it.
    Thou seest, we are not all alone unhappy.
    This wide and universal theater presents more woeful pageants than the scene wherein we play in.
    All the world's a stage and all the men and women merely players.
    They have their exits and their entrances, and one man in his time plays many parts, his act being seven ages.
    ```

    You'll notice that the recognition error is fixed in the results.
