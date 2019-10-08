The Speech services in Azure Cognitive Services provide real-time translation of spoken content based on machine learning and artificial intelligence. The Speech services APIs allow developers to add end-to-end, real-time speech translations to their applications or services.

Speech-translation services are exposed through platform-independent REST-based APIs. These APIs allow you to integrate these services into any solution that requires speech translation of multiple languages.

![Azure Cognitive Services speech translation](../media/2-overview-of-speech-translation-image-1.png)

Speech services are designed to perform real-time speech translation for scenarios like:

- Translation of live presentations
- In-person or remote translated communications
- Customer support
- Business intelligence
- Media subtitling
- Multilingual AI interactions

Access to all the features of Azure Cognitive Services speech translation is provided through the Speech Translation API.

The Speech Translation API provides algorithms, exposed as simple REST-based service calls, to add end-to-end, real-time speech translation to apps and services. Because these services are exposed via REST, you can easily add speech-translation features that are optimized for real-life conversation into your apps and services. The Speech Translation API also includes support for:

- Partial transcriptions
- Partial text translations
- Final transcriptions
- Final text translation
- Audio text-to-speech translation

> [!NOTE]
> You might be aware of a similar service in Azure: the Translator Speech API. Translator Speech is a legacy API that's being replaced by the new Speech Translation API. The Translator Speech API will be available until October 2019. Learn more about how to [migrate from the Translator Speech API to the Speech Translation API](https://docs.microsoft.com/azure/cognitive-services/speech-service/how-to-migrate-from-translator-speech-api) before it's turned off.

With the Speech Translation API, client applications stream speech audio to the service and receive back a stream of translated text-based results. The results include the recognized text in the original source language and the translated text in the target language.

Translated results are produced by applying automatic speech recognition (ASR) powered by deep neural networks to the incoming audio stream. The Speech Translation API provides a single method named `Translate`. This method is used for all aspects of real-time speech translation.

## Calling the Speech Translation API

Although fully REST-enabled, you usually call the `Translate` method of the Speech Translation API by using WebSocket requests to maintain full-duplex communication channels between the client and the server.

For example, here's a simplified version of what a call to the Speech Translation API might look like in Python:

```Python
ws = websocket.WebSocketApp('wss://dev.microsofttranslator.com/speech/translate')
ws.run_forever()
data = get_wave_header(audio_source.getframerate())
ws.send(data, websocket.ABNF.OPCODE_BINARY)
```

Making the same API call in C# simply requires a change in language-specific syntax:

```csharp
var ws = new MessageWebSocket();
var dataWriter = new DataWriter(ws.OutputStream) {
    ByteOrder = ByteOrder.LittleEndian,
};
dataWriter.WriteBytes(GetWaveHeader());
await this.webSocket.ConnectAsync(new Uri("wss://dev.microsofttranslator.com/speech/translate"));
```

> [!IMPORTANT]
> The Python and C# code snippets above have been reduced for brevity and would require more code to function properly in real scenarios.