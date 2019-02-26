The **Speech Service** API in Azure Cognitive Services provides robust, machine learning and artificial intelligence-based services focusing specifically on **real-time translation of spoken content**. The API allows developers to add end-to-end, real-time speech translations to their applications or services. 

Speech translation services are exposed through platform-independent REST-based APIs that allow them to be integrated into any solution requiring multi-language speech translation.

![Azure Cognitive Services Translator Speech](../media/2-overview-of-speech-translation-image-1.png)

Speech Translation is designed to perform **real-time speech translation** for scenarios such as:

- Live presentation translation
- In-person or remote translated communications
- Customer support
- Business intelligence
- Media subtitling
- Multilingual AI interactions

Access to all the goodness of Microsoft Cognitive Service Translator Speech is provided via the **Speech Translation API**.

The Speech Translation API provides algorithms, exposed as simple REST-based service calls, to add end-to-end, real-time, speech translation to apps and services. Exposing service via REST, provides an easy way for developers to add powerful, artificial intelligence-based speech translation features into their apps and services, optimized for real-life conversation. The Speech Translation API also includes support for partial transcriptions, partial text translations, final transcriptions, final text translation, and even audio text-to-speech translation.

With the Speech Translation API, client applications stream speech audio to the service and receive back a stream of translated text-based results. The results include the recognized text in the original source language and the translated text in the target language.

> Translated results are produced by applying Automatic Speech Recognition (ASR) powered by deep neural networks to the incoming audio stream.

The Speech Translation API provides a single method: **Translate** which is used for all aspects of real-time speech translation.

Although fully REST-enabled, calling the Translate method of the Speech Translation API **typically occurs via WebSocket requests**, as opposed to standard HTTP requests to maintain **full-duplex communication channels between the client and the server**. 

For example, here's an overly simplified version of what a call to the Speech Translation API might look like in Python:

```Python
ws = websocket.WebSocketApp('wss://dev.microsofttranslator.com/speech/translate')
ws.run_forever()
data = get_wave_header(audio_source.getframerate())
ws.send(data, websocket.ABNF.OPCODE_BINARY)
```

Making the same API call in C# is simply a change in language-specific syntax:

```csharp
var ws = new MessageWebSocket();
var dataWriter = new DataWriter(ws.OutputStream) {
    ByteOrder = ByteOrder.LittleEndian,
};
dataWriter.WriteBytes(GetWaveHeader());
await this.webSocket.ConnectAsync(new Uri("wss://dev.microsofttranslator.com/speech/translate"));
```

> [!IMPORTANT]
> The Python and C# code snippets above have been greatly scaled back for brevity, and would require a bit more code to function properly in real scenarios.