Speech-to-text converts voice audio into text accurately in real-time using Artificial Intelligence. The service can be used on many platforms and with multiple programming languages to transcribe from a range of audio sources. Your applications, tools, or devices can then use this text various ways, display, and take action on this text as command input.

The service is also capable of customizable speech models. Custom models enable you to tailor your speech recognition models to understand organization-specific terminology and overcome recognition barriers, such as background noise or accents.

## Speech-to-text services

**Standard transcription** provides a real-time transcription of audio streams into text. Audio data for this service can be from microphones, audio files, or blob storage and can be transcribed from over 90 languages and dialects. This service is optimal for conversational or dictation scenarios.

**Batch transcription** is an operation that enables you to transcribe a large amount of audio in storage. With Batch Transcription, you can transcribe one or more audio files or process a whole storage container and receive your results in non-real-time.

**Custom Speech** lets you evaluate and improve speech-to-text accuracy for your applications and products by training and testing a model using your own audio files. Custom Speech can help you overcome speech recognition barriers such as industry-specific terminology or background noise to provide accurate audio transcription. You can also connect your **Microsoft 365 enterprise** account to automatically generate a **custom speech recognition model** from your organization’s data.
:::row:::
  :::column span="3":::
**Conversation transcription** combines speech-recognition, speaker identification, and sentence attribution capabilities to transcribe and identify the speakers in the transcription. This service can be done both in real-time and asynchronously.

**Automatic language detection** is used to determine what language is most likely being spoken in your audio based on a list of provided languages. Language detection can discover up to four languages per detection, enabling speech-to-text to give a more accurate transcription. This service is available in over 30 languages.
  :::column-end:::
  :::column span="2":::

> [!NOTE]
>  
> Backed by Azure infrastructure, the Speech service offers enterprise-grade security for all data stored on the cloud. Your data remains yours. Your audio input and transcription data aren’t logged during audio-to-text processing.

  :::column-end:::
:::row-end:::

**Pronunciation assessment** evaluates speech pronunciation and gives speakers feedback on the spoken audio. Through various assessment parameters based on accuracy, fluency, completeness, and pronunciation, language learners can practice their speech and get feedback from the A.I on where they need to improve.

**Continuous recognition** is used in cases when you want to control when Speech-to-text stops transcribing. Continuous recognition is helpful in **Dictation mode** for when you would like to dictate letters or reports. Dictation mode will also interpret word descriptions of sentence structures, such as punctuation. For example, if you say “how are you question mark”, the interpreted text would read as “how are you?”.

**Profanity filters** are available for batch transcription. Profanity filters can be used to mask the profanity with asterisks, be removed completely or tagged with “profanity”. The default setting is to mask the profanity.

