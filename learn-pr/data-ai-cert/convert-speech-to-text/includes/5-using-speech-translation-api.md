Performing speech translation with the Speech Translation API involves two steps.

1. Creating and opening an authorized WebSocket request to the subscription endpoint.
1. Processing the information returned from the call.

The method used to translate speech is the **Translate** method. When making a request to Translate, there are additional parameters provided to instruct the service as to source language, target language, as well as voice selection. A request to the Translate method to translate spoken content from English to French, for example, might look like this:

```text
wss://dev.microsofttranslator.com/speech/translate?from=en-US&to=fr&features=texttospeech&voice=fr-CA-Caroline
```

Notice the Translate method provides the following required parameters to instruct the API as to final translation results:

| Parameter | Description |
|-----------|-------------|
| **from**  | specifies the language of the incoming speech, from a list of supported language identifiers. |
| **to**    | specifies the language to translate the content into, from a list of supported language identifiers. |
| **features** | a comma-separated set of features, which can include *partial*, *texttospeech*, and *timinginfo*. |
| **voice** | the supported region-culture specific voice to be used for final synthesis, from a list of supported. |

The Translate method also provides the following optional parameters to handle things like audio output format and profanity masking:

| Parameter | Description |
|-----------|-------------|
| **format** | specifies the format of the text-to-speech audio stream returned by the service, either as "audio/wav" or "audio/mp3". |
| **profanityaction** | specifies how the service should handle profanity recognized in the speech. |
| **profanitymarker** | specifies how detected profanity is handled when the **profanityaction** parameter is used. |

Although an authorized WebSocket connection is created and open, speech translation requires specifying a target or "to" language. With such a large number of supported (and growing) languages, it's good to know the Speech Translation API provides a simple way to request lists of supported languages.
