Microsoft provides Azure AI services that support translation. Specifically, you can use the following services:

- The **Azure AI Translator** service, which supports text-to-text translation.
- The **Azure AI Speech** service, which enables speech to text and speech-to-speech translation.

## Azure AI Translator

**Azure AI Translator** is easy to integrate in your applications, websites, tools, and solutions. The service uses a Neural Machine Translation (NMT) model for translation, which analyzes the semantic context of the text and renders a more accurate and complete translation as a result.

**Language support**: Azure AI Translator supports text-to-text translation between [more than 130 languages](/azure/ai-services/Translator/language-support?azure-portal=true). When using the service, you must specify the language you are translating ***from*** and the language you are translating ***to*** using ISO 639-1 language codes, such as *en* for English, *fr* for French, and *zh* for Chinese. Alternatively, you can specify cultural variants of languages by extending the language code with the appropriate 3166-1 cultural code - for example, *en-US* for US English, *en-GB* for British English, or *fr-CA* for Canadian French. When using Azure AI Translator, you can specify one ***from*** language with multiple ***to*** languages, enabling you to simultaneously translate a source document into multiple languages.

## Azure AI Speech 

You can use **Azure AI Speech** to translate spoken audio from a streaming source, such as a microphone or audio file, and return the translation as text or an audio stream. This enables scenarios such as real-time closed captioning for a speech or simultaneous two-way translation of a spoken conversation.

**Language support**: As with Azure AI Translator, you can specify one source language and one or more target languages to which the source should be translated with Azure AI Speech. You can translate speech into [over 90 languages](/azure/ai-services/speech-service/language-support?tabs=stt#speech-translation?azure-portal=true). The source language must be specified using the extended language and culture code format, such as *es-US* for American Spanish. This requirement helps ensure that the source is understood properly, allowing for localized pronunciation and linguistic idioms. The target languages must be specified using a two-character language code, such as *en* for English or *de* for German.
