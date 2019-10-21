Translating speech with the Speech Translation API involves two steps:

1. Creating and opening an authorized WebSocket request to the subscription endpoint.
1. Processing the information returned from the call.

`Translate` is the method you use to translate speech. When making a request to `Translate`, you provide parameters to tell the service the source language, the target language, and the voice selection. For example, a request to the `Translate` method to translate spoken content from English to French might look like this:

```text
wss://dev.microsofttranslator.com/speech/translate?from=en-US&to=fr&features=texttospeech&voice=fr-CA-Caroline
```

The `Translate` method provides the following required parameters:

| Parameter | Description |
|-----------|-------------|
| `from` | Specifies the language of the incoming speech, from a list of supported language identifiers. |
| `to` | Specifies the language to translate the content into, from a list of supported language identifiers. |
| `features` | A comma-separated set of features, which can include `partial`, `texttospeech`, and `timinginfo`. |
| `voice` | The locale-specific voice to use for final synthesis, from a list of supported voices. |

The `Translate` method also provides the following optional parameters to handle things like the audio-output format and profanity masking:

| Parameter | Description |
|-----------|-------------|
| `format` | Specifies the format of the text-to-speech audio stream returned by the service, either as `audio/wav` or `audio/mp3`. |
| `profanityaction` | Specifies how the service should handle profanity recognized in the speech. |
| `profanitymarker` | Specifies how detected profanity is handled when the `profanityaction` parameter is used. |

Although an authorized WebSocket connection is created and opened, speech translation requires you to specify a target, or "to", language. Because of its large number of supported (and growing) languages, the Speech Translation API provides a simple way to request lists of supported languages.
