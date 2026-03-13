Azure Speech in Foundry Tools provides multiple APIs that you can use to build speech-enabled applications and agents. The Speech Translation API enables you to build solutions that translate spoken input and return the translation as text or speech.

## Use Azure Speech translation in application code

To support speech translation, Azure Speech provides an APi that you can use from your application code through the **TranslationRecognizer** object; which you can create by connecting to your Azure Speech resource using a **SpeechTranslationConfig** object.

### Connect to an Azure Speech resource

To use the Azure Speech Translation API in client code, you must use a **SpeechTranslationConfig** object to connect to an Azure Speech resource. Microsoft Foundry provides Azure Speech as a tool in a Foundry resource, and you can connect by specifying the relevant *endpoint* or *region* for your resource, as shown in this code example:

```python
import azure.cognitiveservices.speech as speech_sdk

# Connect to a Foundry resource endpoint
translation_cfg = speech_sdk.translation.SpeechTranslationConfig(
                    subscription="FOUNDRY_KEY", endpoint="FOUNDRY_ENDPOINT")

# Or connect using a region
translation_cfg = speech_sdk.translation.SpeechTranslationConfig(
                    subscription="FOUNDRY_KEY", region="FOUNDRY_REGION")

```

> [!TIP]
> For more information about the **SpeechTranslationConfig** constructor, see the [Azure Speech Python SDK documentation](/python/api/azure-cognitiveservices-speech/azure.cognitiveservices.speech.translation.speechtranslationconfig?azure-portal=true#constructor).

### Configure translation languages and input

Azure Speech can translate spoken audio input to one or more languages. You use the **SpeechTranslationConfig** object to configure the source and target languages, and an **AudioConfig** object to specify the source audio stream.

For example, the following code configures the **SpeechTranslationConfig** object for translation from US English (*en-US*) to French (*fr*) and Japanese (*ja*); and uses an **AudioConfig** object to specify the source audio as coming from the default system microphone.

```python
# Configure languages
translation_cfg.speech_recognition_language = 'en-US'
translation_cfg.add_target_language('fr')
translation_cfg.add_target_language('ja')
print('Ready to translate from',translation_cfg.speech_recognition_language)

# Configure audio source
audio_cfg = speech_sdk.AudioConfig(use_default_microphone=True)
```

> [!TIP]
> For more information about the **AudioConfig** class, see the [Azure Speech Python SDK documentation](/python/api/azure-cognitiveservices-speech/azure.cognitiveservices.speech.audio.audioconfig?azure-portal=true).

### Translate speech to text

Now you're ready to translate spoken input using a **TranslationRecognizer** object, like this:

```python
# Get a TranslationRecognizr object
translator = speech_sdk.translation.TranslationRecognizer(translation_config=translation_cfg,
                                                          audio_config=audio_cfg)
# Get input from mic and translate
print("Speak now...")
translation_results = translator.recognize_once_async().get()
print(f"Translating '{translation_results.text}'")

# Print each translation
translations = translation_results.translations
for translation_language in translations:
    print(f"{translation_language}: '{translations[translation_language]}'")
```

Running this code and saying "hello" into the microphone results in the following output:

```
Speak now...
Translating 'Hello.'
fr: 'Bonjour.'
ja: 'こんにちは。'
```

> [!TIP]
> For more information about the **TranslationRecognizer** class, see the [Azure Speech Python SDK documentation](/python/api/azure-cognitiveservices-speech/azure.cognitiveservices.speech.translation.translationrecognizer?azure-portal=true).

## Synthesize translations as speech

If you need to implement speech-to-speech translation, there are two common approaches you can choose from:

### Manual synthesis

Manual synthesis is a straightforward way to synthesize the results of speech translation You can use manual synthesis to generate audio from text translations. It's essentially just the combination of two separate operations in which you:

1. Use a **TranslationRecognizer** to translate spoken input into text transcriptions in one or more target languages.
1. Iterate through the **Translations** in the result of the translation operation, using a **SpeechSynthesizer** to synthesize an audio stream for each language.

For example, we could expanded the previous example to use Azure Speech to synthesize each translation that is returned, like this:

```python
import azure.cognitiveservices.speech as speech_sdk

# Configure translation
translation_cfg = speech_sdk.translation.SpeechTranslationConfig(subscription="FOUNDRY_KEY",
                                                                 endpoint="FOUNDRY_ENDPOINT")
translation_cfg.speech_recognition_language = 'en-US'
translation_cfg.add_target_language('fr')
translation_cfg.add_target_language('ja')
audio_cfg = speech_sdk.AudioConfig(use_default_microphone=True)

# Configure speech synthesis
speech_cfg = speech_sdk.SpeechConfig(subscription="FOUNDRY_KEY", 
                                     endpoint="FOUNDRY_ENDPOINT")
audio_out_cfg = speech_sdk.audio.AudioOutputConfig(use_default_speaker=True)
voices = {
        "fr": "fr-FR-HenriNeural",
        "ja": "ja-JP-NanamiNeural"
}

# Get trsnslations
translator = speech_sdk.translation.TranslationRecognizer(translation_config=translation_cfg,
                                                          audio_config=audio_cfg)
print("Speak now...")
translation_results = translator.recognize_once_async().get()
print(f"Translating '{translation_results.text}'")


# process the translation results
translations = translation_results.translations
for translation_language in translations:

    # Print ressults
    print(f"{translation_language}: '{translations[translation_language]}'")

    # Speak results
    speech_cfg.speech_synthesis_voice_name = voices.get(translation_language)
    speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_cfg, audio_out_cfg)
    speak = speech_synthesizer.speak_text_async(translations[translation_language]).get()

    # CHeck for speech failure
    if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
        print(speak.reason)
```

Note that you need to create a **SpeechConfig** object for the speech synthesis API, and a separate **AudioConfig** to direct the spoken output to the default speaker. You can also specify language-specific voices to optimize pronunciation of the translated speech.

### Event-based synthesis

When you want to perform 1:1 translation (translating from one source language into a single target language), you can use event-based synthesis to capture the translation as an audio stream. To do this, you need to:

- Specify the desired voice for the translated speech in the **TranslationConfig**.
- Create an event handler for the **TranslationRecognizer** object's **Synthesizing** event.
- In the event handler, use the **GetAudio**() method of the **Result** parameter to retrieve the byte stream of translated audio.

> [!NOTE]
> You can't use event-based synthesis for multi-language translation.

For example, the following Python code uses an inline event handler to capture the translated audio stream and save it as a file. The code subsequently plays the file using the **playsound** library.

```python
import azure.cognitiveservices.speech as speech_sdk
from playsound3 import playsound

# Configure translation
source_language, target_language = "en-US", "fr"
output_file = "translation.wav"
translation_cfg = speech_sdk.translation.SpeechTranslationConfig(subscription="FOUNDRY_KEY",
                                                                 endpoint="FOUNDRY_ENDPOINT")
translation_cfg.speech_recognition_language = source_language
translation_cfg.add_target_language(target_language)
translation_cfg.voice_name = "fr-FR-HenriNeural"
audio_cfg = speech_sdk.AudioConfig(use_default_microphone=True)
translator = speech_sdk.translation.TranslationRecognizer(translation_config=translation_cfg,
                                                          audio_config=audio_cfg)

# Event handler function to save the synthesized audio to a file
def synthesis_callback(evt):
    size = len(evt.result.audio)
    print(f'Audio synthesized: {size} byte(s) {"(COMPLETED)" if size == 0 else ""}')

    if size > 0:
        file = open(output_file, 'wb+')
        file.write(evt.result.audio)
        file.close()

# Connect the event handler function
translator.synthesizing.connect(synthesis_callback)

# Get input from mic and translate it
print(f"Speak now (in {source_language})...")
translation_results = translator.recognize_once()
print(f"Translating '{translation_results.text}'")

# Print and play the translation results
print(translation_results.translations[target_language])
playsound(output_file)
```

> [!TIP]
> For more information about synthesizing translations, see the [Azure Speech documentation](/azure/ai-services/speech-service/how-to-translate-speech?tabs=terminal&pivots=programming-language-python&azure-portal=true#synthesize-translations).
