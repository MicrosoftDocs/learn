In this exercise, you'll create an XML file that contains Speech Synthesis Markup Language (SSML), which you'll use to customize the audio output from the Azure Cognitive Services speech APIs.

## Create an SSML file for your application to read

1. In the Cloud Shell on the right, create a new XML file that your application will read:

    ```dotnetcli
    code Shakespeare.xml
    ```

1. When the code editor appears, enter the following XML:

    ```xml
    <speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
   
    </speak>
    ```

    This code excerpt defines the root `<speak>` element that will contain a series of `<voice>` elements that specify other voices to use.

1. Within the `<speak>` element, add the following XML to define text that the `en-GB-LibbyNeural` voice will read:

    ```xml
    <voice name="en-GB-LibbyNeural">
      <prosody rate="-10%" pitch="-5%">
      The following quotes are from act 2, scene 7, of William Shakespeare's play "As You Like It."
      </prosody>
    </voice>
    ```

    This code excerpt defines a `<voice>` element that specifies a different voice than the default, and wraps the text within a `<prosody>` element that slows the speaking rate by 10% and lowers the pitch by 5%.

1. Add the following xml after the previous `<voice>` element to define text that the `en-GB-RyanNeural` voice will read.

    ```xml
    <voice name="en-GB-RyanNeural">
      <prosody rate="-5%" pitch="-10%">
        <break time="1s" />
        All the world's a stage,
        And all the men and women merely players:
        <break time="1s" />
        They have their exits and their entrances;
        And one man in his time plays many parts,
        His acts being seven ages.
      </prosody>
    </voice>
    ```

    Like the previous code excerpt, this excerpt defines a `<voice>` element that specifies a different voice and wraps the text within a `<prosody>` element that alters the speaking rate and pitch. However, this excerpt also contains `<break>` elements that add pauses between phrases.

1. Add the following xml after the previous `<voice>` element to define text that the `en-IE-ConnorNeural` voice will read.

    ```xml
    <voice name="en-IE-ConnorNeural">
      <prosody rate="-10%" pitch="-5%">
        <break time="1s" />
        Thou <phoneme alphabet="sapi" ph="s i eh s t">seest</phoneme> we are not all alone unhappy:
        <break time="1s" />
        This wide and universal theatre
        Presents more woeful pageants than the scene
        Wherein we play in.
      </prosody>
    </voice>
    ```

    Like the last two code excerpts, this excerpt defines a `<voice>` element that specifies a different voice and wraps the text within a `<prosody>` element that alters the speaking rate and pitch, and also contains `<break>` elements that add a pause between phrases. However, this excerpt also contains a `<phoneme>` element that helps the text-to-speech engine to pronounce an older English word that it might not know how to pronounce.

1. When you've finished adding all of the code, your XML file should resemble the following example:

    ```xml
    <speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
      
      <voice name="en-GB-LibbyNeural">
        <prosody rate="-10%" pitch="-5%">
        The following quotes are from act 2, scene 7, of William Shakespeare's play "As You Like It."
        </prosody>
      </voice>
    
      <voice name="en-GB-RyanNeural">
        <break time="1s" />
        <prosody rate="-5%" pitch="-10%">
        All the world's a stage,
        And all the men and women merely players:
        <break time="1s" />
        They have their exits and their entrances;
        And one man in his time plays many parts,
        His acts being seven ages.
        </prosody>
      </voice>

      <voice name="en-IE-ConnorNeural">
        <break time="1s" />
        <prosody rate="-10%" pitch="-5%">
        Thou <phoneme alphabet="sapi" ph="s i eh s t">seest</phoneme> we are not all alone unhappy:
        <break time="1s" />
        This wide and universal theatre
        Presents more woeful pageants than the scene
        Wherein we play in.
        </prosody>
      </voice>
    
    </speak>
    ```

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Update the code for your text-to-speech application for SSML

1. In the Cloud Shell on the right, open the *Program.cs* file:

    ```dotnetcli
    code Program.cs
    ```

1. Leave the existing `using` statements unmodified, but replace the rest with the following code, which will modify the application to use the contents of an SSML file instead of a text file. Replace the `azureKey` and `azureLocation` values with the ones you copied in the first exercise.

    ```csharp
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string ssmlFile = "Shakespeare.xml";
    string waveFile = "Shakespeare.wav";

    try
    {
        FileInfo fileInfo = new FileInfo(ssmlFile);
        if (fileInfo.Exists)
        {
            string ssmlContent = File.ReadAllText(fileInfo.FullName);
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
            var speechResult = await speechSynthesizer.SpeakSsmlAsync(ssmlContent);
            using var audioDataStream = AudioDataStream.FromResult(speechResult);
            await audioDataStream.SaveToWaveFileAsync(waveFile);       
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    ```

    This code excerpt is largely the same as the code from the previous exercise. The main differences are the lines that specify the XML file instead of the text file, and using the `SpeakSsmlAsync()` method to process the SSML code.

1. When you've finished modifying the code, your file should resemble the following example.

    ```csharp
    using System.Text;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    
    string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
    string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
    string ssmlFile = "Shakespeare.xml";
    string waveFile = "Shakespeare.wav";
    
    try
    {
        FileInfo fileInfo = new FileInfo(ssmlFile);
        if (fileInfo.Exists)
        {
            string ssmlContent = File.ReadAllText(fileInfo.FullName);
            var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
            using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
            var speechResult = await speechSynthesizer.SpeakSsmlAsync(ssmlContent);
            using var audioDataStream = AudioDataStream.FromResult(speechResult);
            await audioDataStream.SaveToWaveFileAsync(waveFile);       
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
                 
    }
    ```

    As with the previous exercise, make sure that you update the values for the `azureKey` and `azureLocation` variables with your key and location from the first exercise.

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Run your application

1. To run your application, use the following command in the Cloud Shell on the right.

    ```dotnetcli
    dotnet run
    ```

1. If you don't see any errors, your application has run successfully. To verify, run the following command to get a list of files in the directory.

    ```bash
    ls -l
    ```

    You should get a response like the following example, and you should have the *Shakespeare.wav* file in the list of files.

    ```bash
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 bin
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 obj
    -rw-r--r-- 1 user   user     1328 Oct  1 11:11 Program.cs
    -rw-r--r-- 1 user   user      413 Oct  1 11:11 Shakespeare.txt
    -rw-r--r-- 1 user   user   978260 Oct  1 11:11 Shakespeare.wav
    -rw-r--r-- 1 user   user     1117 Oct  1 11:11 Shakespeare.xml
    -rw-r--r-- 1 user   user      348 Oct  1 11:11 text to speech.csproj
    ```

## Optional: Listen to your WAV file

[!include[](listen-to-your-wave-file.md)]
