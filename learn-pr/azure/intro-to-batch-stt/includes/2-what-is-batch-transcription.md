Batch transcription is a Speech-to-text cognitive service that uses a set of REST API operations to enable you to transcribe large amounts of audio in storage asynchronously. Batch transcription is available in over 90 languages and can be used with custom models that you create using Speech service.

## Custom speech

**Custom speech** can be used with batch transcription. Custom speech lets you evaluate and improve transcription accuracy for your applications and products by training and testing a model using your own audio files. Custom Speech can help you overcome speech recognition barriers such as industry-specific terminology or background noise to provide accurate audio transcription.

## Additional Features

**Destination container** can be used to specify a container you want to store your results in. If you don’t specify a container, your results will be automatically stored in a container managed by Microsoft.

**Diarization** also known as speaker separation, is the process of identifying speakers in your audio, and attributing the sentence to the right speaker. Batch transcription can identify two voices, and requires timestamps to be enabled to be used.

**Profanity filters** are available. This service can be used to mask the profanity with asterisks, remove the profanity completely, or be tagged with “profanity”. The default setting is to mask the profanity.

**Punctuation** allows you to decide on punctuation in your transcription. This service can be enabled for automatic—meaning the AI deals with the punctuation—or dictation mode, meaning you would explicitly state the punctuation: “how are you question mark” is transcribed as “how are you?”. You can use automatic and dictation mode together, or disable punctuation altogether.

**Timetolive** is the option to automatically delete transcriptions from Microsoft storage after they have completed the transcription. This service is useful for when you’re mass processing transcriptions, as it ensures they will be deleted without manually having to do so.

**Word Level Timestamps** can be used to identify the date and time the transcription was created, along with the time a word was spoken and how long it took you to say the word.