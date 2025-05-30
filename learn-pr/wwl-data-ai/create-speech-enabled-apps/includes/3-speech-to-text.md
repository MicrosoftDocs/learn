
The Azure AI Speech service supports speech recognition through the following features:

- **Real-time transcription**: Instant transcription with intermediate results for live audio inputs.
- **Fast transcription**: Fastest synchronous output for situations with predictable latency.
- **Batch transcription**: Efficient processing for large volumes of prerecorded audio.
- **Custom speech**: Models with enhanced accuracy for specific domains and conditions.

## Using the Azure AI Speech SDK

While the specific details vary, depending on the SDK being used (Python, C#, and so on); there's a consistent pattern for using the **Speech to text** API:

:::image type="content" source="../media/speech-to-text.png" alt-text="A diagram showing how a SpeechRecognizer object is created from a SpeechConfig and AudioConfig, and its RecognizeOnceAsync method is used to call the Speech API.":::

1. Use a **SpeechConfig** object to encapsulate the information required to connect to your Azure AI Speech resource. Specifically, its **location** and **key**.
1. Optionally, use an **AudioConfig** to define the input source for the audio to be transcribed. By default, this is the default system microphone, but you can also specify an audio file.
1. Use the **SpeechConfig** and **AudioConfig** to create a **SpeechRecognizer** object. This object is a proxy client for the **Speech to text** API.
1. Use the methods of the **SpeechRecognizer** object to call the underlying API functions. For example, the **RecognizeOnceAsync()** method uses the Azure AI Speech service to asynchronously transcribe a single spoken utterance.
1. Process the response from the Azure AI Speech service. In the case of the **RecognizeOnceAsync()** method, the result is a **SpeechRecognitionResult** object that includes the following properties:
    - Duration
    - OffsetInTicks
    - Properties
    - Reason
    - ResultId
    - Text

If the operation was successful, the **Reason** property has the enumerated value **RecognizedSpeech**, and the **Text** property contains the transcription. Other possible values for **Result** include **NoMatch** (indicating that the audio was successfully parsed but no speech was recognized) or **Canceled**, indicating that an error occurred (in which case, you can check the **Properties** collection for the **CancellationReason** property to determine what went wrong).
