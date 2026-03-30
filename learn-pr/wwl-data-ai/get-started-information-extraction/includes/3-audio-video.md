::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=6d0fb943-825c-4337-9f4b-7aa06a5c934c]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Business information is increasingly found in multimedia formats such as audio and video files. For example, businesses often record calls in order to analyze them later. The growth of video conferencing means that useful information is often captured in recorded meetings. Azure Content Understanding supports both audio and video data extraction and analysis.

## Extracting structured data from audio 

You can use Azure Content Understanding to provide transcriptions, summaries, and other key insights from audio files.

Suppose you want to have AI summarize your voice mail. You might define a schema of key insights to extract from each recorded call, like this:

- Caller
- Message summary
- Requested actions
- Callback number
- Alternative contact details

Now suppose, a caller leaves you the following voice message:

```
Hi, this is Ava from Contoso.

Just calling to follow up on our meeting last week.

I wanted to let you know that I've run the numbers and I think we can meet your price expectations.

Please call me back on 555-12345 or send me an e-mail at Ava@contoso.com and we'll discuss next steps.

Thanks, bye!
```

Using Azure Content Understanding to analyze the audio recording and apply your schema produces the following results:

- **Caller**: Ava from Contoso
- **Message summary**: Ava from Contoso called to follow up on a meeting and mentioned that they can meet the price expectations. They requested a callback or an email to discuss next steps.
- **Requested actions**: Call back or send an email to discuss next steps.
- **Callback number**: 555-12345
- **Alternative contact details**: Ava@contoso.com

#### Analyzing audio in the Foundry portal 

As with document analysis, using Content Understanding in the *classic* Foundry portal is a fast way to validate that your analyzer returns the fields you expect before you automate the workflow in code. 

In the portal, you can:

- Select an audio or video analyzer and run it on a media file. 
- Review outputs such as **transcripts** (for audio) and extracted insights based on your schema. 
- View the returned **JSON results** for further processing in downstream systems. 

Let's take a look at how we can use content understanding to analyze a call recording. Rather than listen to the whole call, you can run the prebuilt audio analyzer to extract information from the audio. When the analysis is done, you can see a written transcript of the call.

:::image type="content" source="../media/audio-extraction-playground.png" alt-text="Screenshot of the classic Foundry portal with audio analyzed with Azure Content Understanding." lightbox="../media/audio-extraction-playground.png":::

In the returned results, you can see specific information from the call. As with other analyzers in content understanding, the results are in JSON format for further processing. 

:::image type="content" source="../media/audio-json-result.png" alt-text="Screenshot of the classic Foundry portal where audio is analyzed and JSON is returned." lightbox="../media/audio-json-result.png":::

## Extracting structured data from video 

Azure Content Understanding also supports video analysis. For example, you could analyze a recorded video conference to extract details of attendance, location, and other information.

Let's first look at one image from the conference room camera. Suppose you defined the following schema:

- Location
- In-person attendees
- Remote attendees
- Total attendees

You could use Azure Content Understanding to analyze an image from the conference room camera:

![Photograph of a person in a conference room on a call with three remote attendees.](../media/conference-call.jpg)

After applying the schema to the image, Azure Content Understanding returned structured data:

- **Location**: Conference room
- **In-person attendees**: 1
- **Remote attendees**: 3
- **Total attendees**: 4

Consider what you might add to the schema for a video recording of the meeting. You could include attendance counts at various time intervals, details of who spoke during the call and what they said, a summary of the discussion, and a list of assigned actions from the meeting.

## Building a client application with audio or video analyzers

To analyze audio or video programmatically, you can build a lightweight client application using the *Content Understanding API*.

Let's take a look at an example using the Python SDK. When you run the following code, it analyzes an audio file using a prebuilt analyzer. The prebuilt analyzer is identified as `prebuilt-audioSearch`. 


```python
import os
from azure.ai.contentunderstanding import ContentUnderstandingClient
from azure.core.credentials import AzureKeyCredential

# Endpoint and key for your Foundry resource
endpoint = os.environ["FOUNDRY_ENDPOINT"]  # e.g., "https://<resource>.services.ai.azure.com/"
key = os.environ["FOUNDRY_KEY"]

client = ContentUnderstandingClient(
    endpoint=endpoint,
    credential=AzureKeyCredential(key)
)

# Choose a prebuilt analyzer for audio
# (The documents module lists examples like prebuilt-audioSearch / prebuilt-videoSearch.)
analyzer_id = "prebuilt-audioSearch"

# Provide an input audio file (URL shown here; you can swap in your own accessible media URL)
inputs = [
    {"url": "https://<your-host>/samples/voicemail.wav"}
]

# Start analysis (asynchronous long-running operation)
poller = client.begin_analyze(analyzer_id=analyzer_id, inputs=inputs)

# Wait for completion (SDK polls under the hood)
result = poller.result()

# Inspect the structured output (JSON-like objects)
for content in result.contents:
    # Some analyzers may return a transcript and/or extracted fields depending on the analyzer and schema
    print("=== MARKDOWN / TRANSCRIPT (if provided) ===")
    print(getattr(content, "markdown", None))

    print("\n=== EXTRACTED FIELDS ===")
    print(getattr(content, "fields", None))
```

Audio and video analysis with content understanding in Microsoft Foundry opens up a whole range of opportunities to unlock the potential of business data in any format. Next, try out Content Understanding for yourself.

::: zone-end