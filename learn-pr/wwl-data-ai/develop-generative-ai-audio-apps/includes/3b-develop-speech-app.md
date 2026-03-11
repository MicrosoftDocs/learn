Speech synthesis, or *text-to-speech*, is the reverse of speech-to-text. It involves submitting text to a model, which returns an audio stream of the vocalized text.

Models that support text-to-speech operations include:

- **gpt-4o-tts**
- **gpt-4o-mini-tts**

> [!NOTE]
> Model availability varies by region. Review the **[model regional availability](/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure?pivots=azure-openai#model-summary-table-and-region-availability&azure-portal=true)** table in the Microsoft Foundry documentation.

## Using a text-to-speech model

Similarly to speech-to-text models, you can use the **AzureOpenAI** client in the OpenAI SDK to connect to the endpoint for your Microsoft Foundry resource, and upload text to a text-to-speech model for speech synthesis.

```python
from openai import AzureOpenAI
from pathlib import Path

client = AzureOpenAI(
    azure_endpoint=YOUR_FOUNDRY_ENDPOINT,
    api_key=YOUR_FOUNDRY_KEY,
    api_version="2025-03-01-preview"
)

# Path for audio output file
speech_file_path = Path("output_speech.wav")

# Generate speech and save to file
with client.audio.speech.with_streaming_response.create(
            model=YOUR_MODEL_DEPLOYMENT,
            voice="alloy",
            input="This speech was AI-generated!",
            instructions="Speak in an upbeat, excited tone.",
    ) as response:
    response.stream_to_file(speech_file_path)

print(f"Speech generated and saved to {speech_file_path}")
```
