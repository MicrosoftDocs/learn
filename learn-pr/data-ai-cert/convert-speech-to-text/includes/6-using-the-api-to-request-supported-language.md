Speech Translation services are designed to target specific language translation scenarios, and delineates supported speech languages by the following types: **speech to text**, **text translation**, and **text to speech**, supplied as the **scopes** value of the query string, when requesting supported languages.

- **speech**: (speech to text) retrieves the set of languages available to transcribe speech into text
- **text**: (text translation) retrieves the set of languages available to translate transcribed text
- **tts**: (text to speech) retrieves the set of languages and voices available to synthesize translated text back into speech

The method used to request a list of supported speech languages is the Translator Speech **Languages** method, and is simply a matter of making a standard (and authorized) HTTP GET request to the Translator Speech API endpoint and specifying the Languages method with a comma-delimited list of requested language scopes:

```text
https://dev.microsofttranslator.com/languages?scope=speech,text,tts
```

## Return values

Textual information is returned from the Speech Translation API in JSON payloads. When reading the information returned from the API, textual data is always a well-formatted JSON object or array.

Using the previous example of requesting supported languages for **speech to text**, **text translation**, and **text to speech** (all scopes) the following payload will be returned:

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

With an authorized  WebSocket connection created, and a list of supported languages available, the final piece of the puzzle is performing actual speech translation. Since the Translator Speech API Translate method is designed to be real time (and in most programming languages this means full-duplex via WebSockets), requesting translation is more of a process of listening for incoming translation data.
