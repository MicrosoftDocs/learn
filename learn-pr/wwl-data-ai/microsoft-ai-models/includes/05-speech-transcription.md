::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=bfe2da15-2c51-488b-921d-87075d47917a]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Speech synthesis and transcription are common requirements for AI apps and agents. Text-to-speech models create audio from written content, while speech-to-text models transcribe recorded or live audio. Microsoft AI provides a specialized model family for each direction.

## Generate speech with MAI-Voice

The **MAI-Voice** family produces natural, expressive speech from text or a short reference clip. It supports control over pacing, tone, and emotion, and can preserve speaker consistency across long-form content.

![Screenshot of the MAI-Voice model in the playground.](../media/voice-model.png)

The family has two variants:

- **MAI-Voice** prioritizes fidelity. Use this model for audiobooks, courses, podcasts, documentaries, and voice-over work where naturalness and consistency matter most.
- **MAI-Voice-Flash** prioritizes low latency. Use this model for call-center agents, interactive voice response, and voice assistants that must respond quickly.

Both variants support multilingual generation, granular emotion control, and zero-shot voice prompting. Choose between them by testing the actual languages, voices, content lengths, and response-time requirements of your application.

> [!TIP]
> Review the [MAI-Voice model card](https://microsoft.ai/pdf/MAI-Voice-2.1-Model-Card-Memo.pdf?azure-portal=true) for current capabilities, limitations, and responsible-use guidance.

## Transcribe audio with MAI-Transcribe

**MAI-Transcribe** converts audio into text across over 50 languages. It includes automatic language detection and is designed to remain accurate across accents, background noise, and variable audio quality.

![Screenshot of the MAI-Transcribe model in the playground.](../media/transcribe-model.png)

Contextual biasing helps the model recognize specialized terms. This capability is useful in workloads that contain product names, medical terminology, industry vocabulary, or other words that a general transcription system might misrecognize. Typical scenarios include:

- Captions and accessibility workflows.
- Meeting and voicemail transcription.
- Customer-call analysis.
- Domain-specific notes and records.
- Searchable archives of recorded content.

When evaluating transcription, use recordings that reflect production conditions. Include different speakers, accents, microphones, noise levels, languages, and domain terms. Word error rate is useful, but also assess whether errors change meaning and whether timestamps, speaker separation, formatting, or downstream search meet your application's needs.

> [!TIP]
> Review the [MAI-Transcribe model card](https://microsoft.ai/pdf/MAI-Transcribe-2-Model-Card.pdf?azure-portal=true) for current capabilities, limitations, and responsible-use guidance.

## Enable interactive voice conversations with MAI-Realtime

**MAI-Realtime** is a speech-to-speech model that pairs MAI’s audio understanding and natural voice, enabling you to build steerable, responsive voice agents
through one interface.

![Screenshot of the MAI-Realtime model in the playground.](../media/realtime-model.png)

> [!TIP]
> Review the [MAI-Realtime page](https://microsoft.ai/models/mai-realtime-1?azure-portal=true) for current capabilities, limitations, and responsible-use guidance.

::: zone-end
