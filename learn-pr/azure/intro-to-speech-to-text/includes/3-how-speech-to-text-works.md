Using speech-to-text requires an Azure account and a Speech service subscription. Speech service has free and standard pricing tiers and provides an endpoint and subscription key for you to access the service.

Speech-to-text can run in a container, meaning you don’t have to send your data out to a server. Rather you can run your data locally, saving you bandwidth, while also increasing security.  

You can access the service through the Speech software development kit (Speech SDK), REST API, and Speech CLI. The Speech SDK provides the broadest suite of functions and is ideal for real-time and non-real-time scenarios, using local devices, files, Azure blob storage, and input and output streams. When this isn't achievable with the Speech SDK, look for a REST API alternative. Languages supported by the service are:

- C#
- C++
- Go
- Java (Android and JRE)
- JavaScript
- Objective-C / Swift
- Python

## Real-time speech-to-text

Speech-to-text by default uses the Universal language model, was trained using Microsoft-owned data, and is deployed in the cloud.

Speech-to-text is possible with multiple audio inputs. Selecting a microphone or audio device is done through the REST API by obtaining a device ID, which can then be used by the Speech SDK. Microphone usage is not available for JavaScript running in Node.js. You can also use Speech-to-text with audio files and from in-memory storage.

If you need to communicate with the online transcription via REST, use Speech-to-text REST API for short audio. The REST API for short audio is limited to 60 seconds and should only be used in cases where the Speech SDK cannot be used, such as models that employ multiple data sets. The default audio streaming format is WAV. but MP3, OGG, FLAC, ALAW, and MULAW are also supported.

The Pronunciation Assessment also works in real-time to evaluate your speech audio and give you feedback. Using a reference text, this feedback is based on configuration parameters you set, such as a 0-5 or 0-100 grading system. Further, you can set whether you want the assessment to be based on annunciation of the syllables, the full text, or just one word. Overall, resulting in a more precise evaluation and learning experience.

## Batch speech-to-text

Batch transcription is a set of REST API operations that enables you to transcribe a large amount of audio in storage. You can point to audio files using a typical URI or a shared access signature (SAS) URI to receive transcription results in non-real-time. With the v3.0 API, you can transcribe one or more audio files or process a whole storage container.

Batch transcription supports WAV, MP3, and OGG file formats, and functions across the programming languages listed above. The API is capable of many of the features mentioned for real-time transcription. Additionally, it can also automatically delete transcriptions after completing the transcription and can deploy custom speech models.

In the example below, we can see a JSON request to transcribe in English everything within an Azure blob container and provide timestamps.

JSON EXAMPLE TO BE ADDED

## Custom speech-to-text

Custom speech models can be employed to improve speech-to-text transcription accuracy. You can create a custom speech model using Speech Studio, a customization portal for the Azure Speech Service. Within the portal, you're provided with instructions on how to deploy speech recognition models using audio with human-labeled transcripts, related text, and pronunciation guidance you provide. This tool can help you overcome speech recognition barriers such as accents, specific lexicons, and background noise to provide precise transcription of your audio.

## Use 365 data

For organizations using Microsoft 365 Enterprise, Tenant Models are an opt-in service. Tenant models automatically generate a custom speech recognition model from your organization's 365 data, such as public group emails and documents. The model is optimal for technical terms, jargon, and people's names, all in a secure and compliant way. To use Tenant Models, your admin must sign in to Azure Speech services and allow organization-wide language model, along with creating a Speech resource and subscription key. To create and deploy the Tenant Model, you need to sign into Speech Studio, then opt-in and deploy Tenant Model settings.

## Phrase lists

You can also use Phrase Lists to improve transcription accuracy. You provide a list of words or phrases that have a high potential of being transcribed inaccurately, such as a person's name or industry-specific terminology. By providing this list, you can increase the likelihood that Speech-to-Text will recognize the word or phrase and give an accurate transcription, even in the middle of sentences.