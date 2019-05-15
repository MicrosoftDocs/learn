Working with the Speech Translation API `Recognize` method starts with creating and opening an authorized WebSocket connection to the Speech Translation API endpoint. Because a real-time, conversational translation process is _ongoing_, the Speech service uses the concept of "listening" to a socket for incoming translation data.

![The process of listening](../media/9-listening-for-incoming-data-listen.png)

## Reading streams

Listening for incoming translation data means evaluating streams or byte arrays returned by the Speech service in a constant, consistent fashion, as if you were engaging in a real human conversation.

For example, in C#, listening for an initial incoming translation might look like this:

```csharp
string translatedOutput;
using (var dataReader = args.GetDataReader())
{
    dataReader.UnicodeEncoding = Windows.Storage.Streams.UnicodeEncoding.Utf8;
    translatedOutput = dataReader.ReadString(dataReader.UnconsumedBufferLength);
}

var result = JsonConvert.DeserializeObject<SpeechTranslationResult>(translatedOutput);
```

In the prior example, a `DataReader` object is used to continually interrogate the returned values based on stream or byte-array buffer length. The Speech Translation API `Translate` method does all the converting, cleans up the data, translates speech to text, and responds with the final (or interim) translated content.

## Initial return values

Because speech translation is a multistep process, initial data from a listening event comes in as a well-formatted JSON payload, just like it does for most other methods in the Azure Cognitive Services suite of APIs:

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

But after the text is translated, listening for translated text to be synthesized looks like any scenario where you're working with a stream or byte array instead of human-readable text:

```csharp
 using (var dataReader = args.GetDataReader())
 {
     dataReader.ByteOrder = ByteOrder.LittleEndian;
     this.onTextToSpeechData(AudioFrameHelper.GetAudioFrame(dataReader));
 }
```

> [!NOTE]
> Platform-specific code for playing the resulting synthesized audio stream has been removed for brevity.
