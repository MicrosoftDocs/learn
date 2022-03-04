Speech-to-text is a technology that accurately converts voice audio to text data in real time. It has become the underlying technology that supports most voice-related systems today. For example, speech-to-text powers real-time transcription to make live videos or meetings more accessible to people with hearing impairments.

In the scenario of the amusement park application, we can use speech-to-text to recognize magic spells. When a user says the spell, the speech-to-text service converts the audio data to text. Then, the app can match the transcribed text against the text representation of the expected spell to see if the user has said a certain spell.

Here, you will learn about the speech-to-text service provided as a part of the Azure Speech Services.

## Azure Speech Services

Azure Cognitive Services is a set of cloud services that make cognitive intelligence accessible through REST APIs and client library SDKs. This means that we can empower our applications with artificial intelligence-powered capabilities without the need to train our own models.

Speech Service is one of the main categories under Azure Cognitive Services. It encompasses services such as speech-to-text, text-to-speech, speaker recognition, speech translation, and so on.

## Azure Speech-to-text

The Speech-to-text service under Azure Speech Services can be used to transcribe an audio stream or a local file. The service supports transcription in more than three dozens of languages, and it uses Microsoft's Universal Language Model by default.

However, several options exist for customizing the transcription model. You can create a customized model by using the Custom Speech service. There, you can upload your own test data and train a unique model based on the set of data. Or, you can add certain phrases into the Phrase List to help the model identify those phrases in your use case more accurately.

## Privacy and security

Azure Speech Services is certified by SOC, FedRAMP, PCI DSS, HIPAA, HITECH, and ISO. Both audio input and transcription data are not logged, and all custom speech data and models are encrypted when saved in storage. You can also view or delete any custom speech data or models at any time.
