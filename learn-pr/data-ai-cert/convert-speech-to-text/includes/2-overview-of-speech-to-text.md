The Speech-to-text aspect of the Speech services, in Azure Cognitive Services, provides real-time transcription of audio streams based on machine learning and artificial intelligence. The Speech services APIs allow developers to add end-to-end, real-time speech transcription to their applications or services.

Speech-to-text services are exposed through platform-independent [REST-based APIs](https://docs.microsoft.com/azure/cognitive-services/speech-service/rest-speech-to-text) or the [Speech SDK](https://docs.microsoft.com/azure/cognitive-services/speech-service/speech-sdk). These APIs allow you to integrate these services into any solution that requires speech translation of multiple languages.  The way in which you access these services will vary based on whether you are using the REST API or the Speech SDK.  The exercises in this module will make use of the Speech SDK.

Speech services are designed to perform real-time speech-to-text for scenarios like:

- Translation of live presentations
- In-person or remote translated communications
- Customer support
- Business intelligence
- Media subtitling
- Multilingual AI interactions

The speech-to-text service defaults to using the Universal language model. This model was trained using Microsoft-owned data and is deployed in the cloud. It's optimal for conversational and dictation scenarios. When using speech-to-text for recognition and transcription in a unique environment, you can create and train custom acoustic, language, and pronunciation models. Customization is helpful for addressing ambient noise or industry-specific vocabulary.

This module will not cover customization.  Future modules may cover this subject, or you can visit the [Custom Speech](https://docs.microsoft.com/azure/cognitive-services/speech-service/how-to-custom-speech) page for more information
