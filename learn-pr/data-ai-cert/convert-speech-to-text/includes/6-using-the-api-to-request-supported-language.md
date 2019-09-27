Speech-translation services are designed to target specific language-translation scenarios. The supported speech languages are delineated by the following types: *speech to text*, *text translation*, and *text to speech*. When you're requesting a list of supported languages, you specify the type as the `scope` value of the query string.

| Scope value | Language type | Result |
|---------|---------|---------|
| `speech` | Speech to text | Retrieves the set of languages available to transcribe speech into text. |
| `text` | Text translation | Retrieves the set of languages available to translate transcribed text. |
| `tts` | Text to speech | Retrieves the set of languages and voices available to synthesize translated text back into speech. |

To request a list of supported speech languages, you use the Speech Translation API `Languages` method. To use this method, make a standard (and authorized) HTTP GET request to the Speech Translation API endpoint and specify the `Languages` method with a comma-delimited list of requested language scopes:

```text
https://dev.microsofttranslator.com/languages?scope=speech,text,tts&api-version=3.0
```
**Note** The version number at the end of this GET request can and will change.  You may need to research the current version and update accordingly.

## Return values

Textual information is returned from the Speech Translation API in a well-formatted JSON object or array.

The previous example of requesting supported languages for speech to text, text translation, and text to speech (all scopes) will return the following result:

```json
{
    "speech": {
        "en-US": { name: "English", language: "en" },
        "de-DE": { name: "German", language: "de" }
    },
    "text": {
        "en-US": { name: "English", language: "en" },
        "ja-JP": { name: "Japanese", language: "ja" }
    },
    "tts": {
       "en-US": { name: "English", language: "en" },
       "it-IT": { name: "Italian", language: "it" }
    }
}
```

> [!NOTE]
> For brevity, most supported languages have been removed from this list.

With an authorized WebSocket connection created and a list of supported languages available, your final step is translating the actual speech. Because the Speech Translation API `Translate` method is designed for use in real time, requesting translation is largely a process of "listening" for incoming translation data. For most programming languages, real-time usage occurs through full-duplex communication via WebSocket connections.
