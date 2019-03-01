Working with the Speech Translation API **Recognize** method starts with creating and opening an authorized WebSocket connection to the Translator Speech API endpoint, however, since a real-time, conversational translation process is _ongoing_, Translator Speech leverages the concept of "listening" to a socket for incoming translation data.

![The process of listening](../media/9-listening-for-incoming-data-listen.png)

## Reading streams

Listening for incoming translation data is really the process of evaluating streams or byte arrays returned from the Translator Speech service, in a constant, consistent fashion, as if you were engaging in a real human conversation.

For example, in C#, listening for an initial incoming translation in code, might look like this:

```csharp
string translatedOutput;
using (var dataReader = args.GetDataReader())
{
    dataReader.UnicodeEncoding = Windows.Storage.Streams.UnicodeEncoding.Utf8;
    translatedOutput = dataReader.ReadString(dataReader.UnconsumedBufferLength);
}

var result = JsonConvert.DeserializeObject<SpeechTranslationResult>(translatedOutput);
```

Notice the use of a `DataReader` object to continually interrogate returned values based on stream or byte array buffer length. The Translator Speech API Translate method does all the heavy lifting of converting, cleaning up data, translating speech to text and responds with final (or even interim) translated content.

## Initial return values

As speech translation is actually a multi-step process, initial data from a listening even would come in as well-formatting JSON payload, just like most other methods in the Azure Cognitive Services suite of APIs:

```Json
{
  type: "final"
  id: "23.2",
  recognition: "I love Microsoft cognitive services.",
  translation: "Me encantan los servicios cognitivos de Microsoft.",
  audioStreamPosition: 319680,
  audioSizeBytes: 25840,
  audioTimeOffset: 2731600000,
  audioTimeSize: 11900000
}
```

Once text is translated, however, listening for translated text to be synthesized would look similar to any scenario where you would be working with a stream or byte array, instead of human-readable text:

```csharp
 using (var dataReader = args.GetDataReader())
 {
     dataReader.ByteOrder = ByteOrder.LittleEndian;
     this.onTextToSpeechData(AudioFrameHelper.GetAudioFrame(dataReader));
 }
```

> [!NOTE]
> Platform-specific code for playing the resulting synthesized audio stream has been removed for brevity, and be entirely based on the platform and code language being used for playback.
