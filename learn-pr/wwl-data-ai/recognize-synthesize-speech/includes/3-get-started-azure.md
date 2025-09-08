Microsoft Azure offers speech recognition and synthesis capabilities through **Azure AI Speech** service, which supports many capabilities, including:

- **Speech to text** 
- **Text to speech** 
- **Speech translation**

## Speech to text

You can use Azure AI Speech to text API to perform real-time or batch transcription of audio into a text format. The audio source for transcription can be a real-time audio stream from a microphone or an audio file.

The model that is used by the Speech to text API, is based on the Universal Language Model that was trained by Microsoft.  The data for the model is Microsoft-owned and deployed to Microsoft Azure.  The model is optimized for two scenarios, conversational and dictation. You can also create and train your own custom models including acoustics, language, and pronunciation if the pre-built models from Microsoft don't provide what you need.

**Real-time transcription**: Real-time speech to text allows you to transcribe audio streams to text. You can use real-time transcription for presentations, demos, or any other scenario where a person is speaking.

In order for real-time transcription to work, your application needs to be listening for incoming audio from a microphone, or other audio input source such as an audio file. Your application code streams the audio to the service, which returns the transcribed text.

**Batch transcription**: Not all speech to text scenarios are real time.  You might have audio recordings stored on a file share, a remote server, or even on Azure storage. You can point to audio files with a shared access signature (SAS) URI and asynchronously receive transcription results.

Batch transcription should be run in an asynchronous manner because the batch jobs are scheduled on a *best-effort basis*. Normally a job starts executing within minutes of the request but there's no estimate for when a job changes into the running state.

## Text to speech

The text to speech API enables you to convert text input to audible speech, which can either be played directly through a computer speaker or written to an audio file.

**Speech synthesis voices**: When you use the text to speech API, you can specify the voice to be used to vocalize the text. This capability offers you the flexibility to personalize your speech synthesis solution and give it a specific character.

The service includes multiple pre-defined voices with support for multiple languages and regional pronunciation, including *neural* voices that leverage *neural networks* to overcome common limitations in speech synthesis with regard to intonation, resulting in a more natural sounding voice. You can also develop custom voices and use them with the text to speech API.

## Speech translation

Azure Speech Translation is a feature of the Azure AI Speech service. Azure Speech Translation enables real-time translation of spoken language by taking inputs of audio streams and returning text in a specificed language. It works by first converting speech to text using automatic speech recognition (ASR), then translating the recognized text into one or more target languages using machine translation. The service supports a wide range of source and target languages and can deliver translations as text or synthesized speech. Developers can integrate this functionality into applications using REST APIs or SDKs, making it ideal for scenarios like multilingual meetings, live event captioning, or global customer support. 