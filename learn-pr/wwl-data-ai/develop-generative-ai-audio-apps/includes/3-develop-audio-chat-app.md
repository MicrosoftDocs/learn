Speech transcription, or *speech-to-text*, involves submitting audio content to a model, which responds with a text-based transcript of the speech in the audio source.

Models that support speech-to-text operations include:

- **gpt-4o-transcribe**
- **gpt-4o-mini-transcribe**
- **gpt-4o-transcribe-diarize**

> [!NOTE]
> Model availability varies by region. Review the **[model regional availability](/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure?pivots=azure-openai#model-summary-table-and-region-availability&azure-portal=true)** table in the Microsoft Foundry documentation.

## Using a speech-to-text model

To use a speech-to-text model in your own application, you can use the **AzureOpenAI** client in the OpenAI SDK to connect to the endpoint for your Microsoft Foundry resource, and upload the contents of an audio file to the model for transcription.

```python
from openai import AzureOpenAI
from pathlib import Path

# Create an AzureOpenAI client
client = AzureOpenAI(
    azure_endpoint=YOUR_FOUNDRY_ENDPOINT,
    api_key=YOUR_FOUNDRY_KEY,
    api_version="2025-03-01-preview"
)

# Get the audio file
file_path = Path("speech.mp3")
audio_file = open(file_path, "rb")

# Use the model to transcribe the audio file
transcription = client.audio.transcriptions.create(
    model=YOUR_MODEL_DEPLOYMENT,
    file=audio_file,
    response_format="text"
)

print(transcription)
```
