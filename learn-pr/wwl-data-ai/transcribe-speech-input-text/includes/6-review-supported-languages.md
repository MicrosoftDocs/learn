Speech-translation services are designed to target specific language-translation scenarios. The supported speech languages are delineated by the following types: *speech to text*, *speech translation*, and *text to speech*. Language support varies by Speech service functionality.

For example, under speech-to-text, you find support for English in six locales:

- English (Australia) - en-AU
- English (Canada) - en-CA
- English (United Kingdom) - en-GB
- English (India) - en-IN
- English (New Zealand) - en-NZ
- English (United States) - en-US

When deciding the services you will use for your needs, visit the [supported language and region page](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support) for up-to-date information on the supported languages.  You can also programmatically discover language support by using a query string, ```https://dev.microsofttranslator.com/languages?scope=speech,text,tts&api-version=3.0``` which returns the supported languages in JSON format that you can then parse.  A snippet of the returned results is shown here:

```json
{
    "translation": {
        "af": {
            "name": "Afrikaans",
            "nativeName": "Afrikaans",
            "dir": "ltr"
        },
        "ar": {
            "name": "Arabic",
            "nativeName": "العربية",
            "dir": "rtl"
        },
        "bg": {
            "name": "Bulgarian",
            "nativeName": "Български",
            "dir": "ltr"
        },
        "bn": {
            "name": "Bangla",
            "nativeName": "বাংলা",
            "dir": "ltr"
        },
        "bs": {
            "name": "Bosnian",
            "nativeName": "bosanski (latinica)",
            "dir": "ltr"
        },
        "ca": {
            "name": "Catalan",
            "nativeName": "Català",
            "dir": "ltr"
        }
    }
}
```

The supported languages page shows the languages supported by both the Speech SDK and REST API so you can have support for your preferred method of accessing the services.  You can also perform some customization, for a subset of languages, to help improve accuracy.  Customization is offered for a subset of the languages through uploading Audio + Human-labeled Transcripts or Related Text: Sentences. Pronunciation customization is currently only available for en-US and de-DE. Learn more about customization [here](https://docs.microsoft.com/azure/cognitive-services/speech-service/how-to-custom-speech).
