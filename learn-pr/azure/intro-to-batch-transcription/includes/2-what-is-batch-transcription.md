Batch Transcription is a Cognitive Service that allows you to transcribe large amounts of audio data from a storage container asynchronously. Batch Transcription is part of Azure’s *Speech Service*, but has its own set of extra features.

## Using audio data efficiently

Spoken word will always be our primary means of communication. We can identify ourselves, express ideas, convey sentiment, and make requests. Further, the use of audio is often required for business reasons, such as keeping records of conversations for legal purposes, whether they be in person, or over a video or audio call.

While having an audio record of a conversation is nice, searching through audio recordings for information can be time consuming and inefficient. Transcribing audio into text allows for almost instantaneous searching for key words or phrases, easier documentation, and better record keeping.

### Powerful and cost effective transcription

Manually transcribing audio into text is a labor-intensive process. It requires trained and trust-worthy staff and even then can still be prone to errors, resulting in the need for labor-intensive reviews.

Batch Transcription provides automated transcription using AI. Batch Transcription is a powerful, high-quality service that can process hundreds or thousands of audio recordings into text, acting like an in-house team of professional transcribers. It also has optional configurations not available with real-time Speech-To-Text such as profanity filters and timestamps, along with standard services like speaker separation.

## Our call-center scenario

Let’s think back to our call-center scenario. You’ve been looking into Batch Transcription and have found it might be the solution you need. It can quickly and accurately transcribe huge amounts of audio data without poor audio quality or the variety of accents and regional languages being a problem.

You’ve also found that Batch Transcription can be integrated with other Azure services to enable analysis of your audio data. This information can then be used to improve business practices in a deeper way than simple transcription is designed to achieve.

## Using Batch Transcription

The Batch Transcription service is implemented as set of REST API operations. A request can be made to transcribe audio files from an Azure storage blob through a POST operation, like so:

```HTTP request
POST https://eastus2.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions HTTP/1.1
Host: eastus2.api.cognitive.microsoft.com
Content-Type: application/json

{
  "contentContainerUrl": "<SAS URL to the Azure blob container to transcribe>",
  "properties": {
    "diarizationEnabled": false,
    "wordLevelTimestampsEnabled": false,
    "punctuationMode": "DictatedAndAutomatic",
    "profanityFilterMode": "Masked"
  },
  "locale": "en-US",
  "displayName": "Transcription using default model for en-US"
}
```

The output is saved, and can be saved to a second storage blob or retrieved with a GET operation. If the input file is in mono, a single JSON file is produced per file. For stereo audio files, the left and right channels are split and a separate JSON result file is created for each channel.
