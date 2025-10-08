The Voice live API enables developers to create voice-enabled applications with real-time, bidirectional communication. This unit explores its architecture, configuration, and implementation.

## Key features of the Voice Live API

The Voice live API provides real-time communication using WebSocket connections. It supports advanced features such as speech recognition, text-to-speech synthesis, avatar streaming, and audio processing.

- JSON-formatted events manage conversations, audio streams, and responses.
- Events are categorized into client events (sent from client to server) and server events (sent from server to client).

Key features include:
- Real-time audio processing with support for multiple formats like PCM16 and G.711.
- Advanced voice options, including OpenAI voices and Azure custom voices.
- Avatar integration using WebRTC for video and animation.
- Built-in noise reduction and echo cancellation.

> [!NOTE]
> Voice Live API is optimized for Azure AI Foundry resources. We recommend using Azure AI Foundry resources for full feature availability and best Azure AI Foundry integration experience.

For a table of supported models and regions, visit the [Voice Live API overview](/azure/ai-services/speech-service/voice-live#supported-models-and-regions).

## Connect to the Voice Live API

The Voice live API supports two authentication methods: Microsoft Entra (keyless) and API key. Microsoft Entra uses token-based authentication for an Azure AI Foundry resource. You apply a retrieved authentication token using a `Bearer` token with the `Authorization` header. 

For the recommended keyless authentication with Microsoft Entra ID, you need to assign the **Cognitive Services User** role to your user account or a managed identity. You generate a token using the Azure CLI or Azure SDKs. The token must be generated with the `https://ai.azure.com/.default` scope, or the legacy `https://cognitiveservices.azure.com/.default` scope. Use the token in the `Authorization` header of the WebSocket connection request, with the format `Bearer <token>`.

For key access, an API key can be provided in one of two ways. You can use an `api-key` connection header on the prehandshake connection. This option isn't available in a browser environment. Or, you can use an `api-key` query string parameter on the request URI. Query string parameters are encrypted when using https/wss.

> [!NOTE]
> The `api-key` connection header on the prehandshake connection isn't available in a browser environment.

### WebSocket endpoint

The endpoint to use varies depending on how you want to access your resources. You can access resources through a connection to the AI Foundry project (Agent), or through a connection to the model. 

- **Project connection:** The endpoint is `wss://<your-ai-foundry-resource-name>.services.ai.azure.com/voice-live/realtime?api-version=2025-10-01`
- **Model connection:** The endpoint is `wss://<your-ai-foundry-resource-name>.cognitiveservices.azure.com/voice-live/realtime?api-version=2025-10-01`. 

The endpoint is the same for all models. The only difference is the required `model` query parameter, or, when using the Agent service, the `agent_id` and `project_id` parameters.

## Voice Live API events

Client and server events facilitate communication and control within the Voice live API. Key client events include:

- `session.update`: Modify session configurations.
- `input_audio_buffer.append`: Add audio data to the buffer.
- `response.create`: Generate responses via model inference.

Server events provide feedback and status updates:

- `session.updated`: Confirm session configuration changes.
- `response.done`: Indicate response generation completion.
- `conversation.item.created`: Notify when a new conversation item is added.

For a full list of client/server events, visit [Voice live API Reference](/azure/ai-services/speech-service/voice-live-api-reference)

> [!NOTE]
> Proper handling of events ensures seamless interaction between client and server.

### Configure session settings for the Voice live API

Often, the first event sent by the caller on a newly established Voice live API session is the `session.update` event. This event controls a wide set of input and output behavior. Session settings can be updated dynamically using the `session.update` event. Developers can configure voice types, modalities, turn detection, and audio formats.

Example configuration:

```json
{
  "type": "session.update",
  "session": {
    "modalities": ["text", "audio"],
    "voice": {
      "type": "openai",
      "name": "alloy"
    },
    "instructions": "You are a helpful assistant. Be concise and friendly.",
    "input_audio_format": "pcm16",
    "output_audio_format": "pcm16",
    "input_audio_sampling_rate": 24000,
    "turn_detection": {
      "type": "azure_semantic_vad",
      "threshold": 0.5,
      "prefix_padding_ms": 300,
      "silence_duration_ms": 500
    },
    "temperature": 0.8,
    "max_response_output_tokens": "inf"
  }
}
```

> [!TIP]
> Use Azure semantic VAD for intelligent turn detection and improved conversational flow.

### Implement real-time audio processing with the Voice live API

Real-time audio processing is a core feature of the Voice live API. Developers can append, commit, and clear audio buffers using specific client events.

- **Append audio:** Add audio bytes to the input buffer.
- **Commit audio:** Process the audio buffer for transcription or response generation.
- **Clear audio:** Remove audio data from the buffer.

Noise reduction and echo cancellation can be configured to enhance audio quality. For example:

```json
{
  "type": "session.update",
  "session": {
    "input_audio_noise_reduction": {
      "type": "azure_deep_noise_suppression"
    },
    "input_audio_echo_cancellation": {
      "type": "server_echo_cancellation"
    }
  }
}
```

> [!NOTE]
> Noise reduction improves VAD accuracy and model performance by filtering input audio.

### Integrate avatar streaming using the Voice live API

The Voice live API supports WebRTC-based avatar streaming for interactive applications. Developers can configure video, animation, and blendshape settings.

- Use the `session.avatar.connect` event to provide the client's SDP offer.
- Configure video resolution, bitrate, and codec settings.
- Define animation outputs such as blendshapes and visemes.

Example configuration:

```json
{
  "type": "session.avatar.connect",
  "client_sdp": "<client_sdp>"
}
```

> [!TIP]
> Use high-resolution video settings for enhanced visual quality in avatar interactions.

