You can use **Azure AI Translator** with a programming language of your choice or the REST API. You can use some of its features with Language Studio. 

You can get started with **Azure AI Speech** with Speech Studio or a programming language of your choice or the REST API.  

## Azure resources for Azure AI Translator and Azure AI Speech

Before you can use Azure AI Translator or Azure AI Speech, you must provision appropriate resources in your Azure subscription.

There are dedicated **Translator** and **Speech** resource types for these services, which you can use if you want to manage access and billing for each service individually.

Alternatively, you can create an **Azure AI services** resource that provides access to both services through a single Azure resource, consolidating billing and enabling applications to access both services through a single endpoint and authentication key.

## Using Azure AI Translator

Azure AI Translator includes the following capabilities:

- **Text translation** - used for quick and accurate text translation in real time across all supported languages.
- **Document translation** - used to translate multiple documents across all supported languages while preserving original document structure.  
- **Custom translation** -  used to enable enterprises, app developers, and language service providers to build customized neural machine translation (NMT) systems. 

Azure AI Translator's application programming interface (API) offers some optional configuration to help you fine-tune the results that are returned, including:

- **Profanity filtering**.  Without any configuration, the service will translate the input text, without filtering out profanity. Profanity levels are typically culture-specific but you can control profanity translation by either marking the translated text as profane or by omitting it in the results.
- **Selective translation**. You can tag content so that it isn't translated. For example, you may want to tag code, a brand name, or a word/phrase that doesn't make sense when localized.

## Speech translation with Azure AI Speech

Azure AI Speech includes the following capabilities:

- **Speech to text** - used to transcribe speech from an audio source to text format.
- **Text to speech** - used to generate spoken audio from a text source.
- **Speech Translation** - used to translate speech in one language to text or speech in another.

>[!NOTE]
>You can learn more about Azure AI Speech and Speech Studio with the learn module [Fundamentals of Azure AI Speech](/training/modules/recognize-synthesize-speech/). 

