The Azure AI Speech service supports speech recognition through two REST APIs:

- The **Speech to text** API, which is the primary way to perform speech recognition.
- The **Speech to text Short Audio** API, which is optimized for short streams of audio (up to 60 seconds).

You can use either API for interactive speech recognition, depending on the expected length of the spoken input. You can also use the **Speech to text** API for *batch transcription*, transcribing multiple audio files to text as a batch operation.

You can learn more about the REST APIs in the [Azure AI Speech to text REST API documentation](/azure/cognitive-services/speech-service/rest-speech-to-text). In practice, most interactive speech-enabled applications use the Azure AI Speech service through a (programming) language-specific SDK.

## Using the Azure AI Speech SDK

While the specific details vary, depending on the SDK being used (Python, C#, and so on); there's a consistent pattern for using the **Speech to text** API:

![A SpeechRecognizer object is created from a SpeechConfig and AudioConfig, and its RecognizeOnceAsync method is used to call the Speech API](../media/speech-to-text.png)

1. Use a **SpeechConfig** object to encapsulate the information required to connect to your Azure AI Speech resource. Specifically, its **location** and **key**.
2. Optionally, use an **AudioConfig** to define the input source for the audio to be transcribed. By default, this is the default system microphone, but you can also specify an audio file.
3. Use the **SpeechConfig** and **AudioConfig** to create a **SpeechRecognizer** object. This object is a proxy client for the **Speech to text** API.
4. Use the methods of the **SpeechRecognizer** object to call the underlying API functions. For example, the **RecognizeOnceAsync()** method uses the Azure AI Speech service to asynchronously transcribe a single spoken utterance.
5. Process the response from the Azure AI Speech service. In the case of the **RecognizeOnceAsync()** method, the result is a **SpeechRecognitionResult** object that includes the following properties:
    - Duration
    - OffsetInTicks
    - Properties
    - Reason
    - ResultId
    - Text

If the operation was successful, the **Reason** property has the enumerated value **RecognizedSpeech**, and the **Text** property contains the transcription. Other possible values for **Result** include **NoMatch** (indicating that the audio was successfully parsed but no speech was recognized) or **Canceled**, indicating that an error occurred (in which case, you can check the **Properties** collection for the **CancellationReason** property to determine what went wrong.)
