::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=51e24450-cc2a-4712-bb05-543633ab51c7]

::: zone-end

::: zone pivot="text"
Azure Speech in Foundry Tools provides speech-to-text and text-to-speech capabilities that you can integrate into AI applications. These capabilities let you transcribe audio to text and synthesize natural-sounding speech from text.

While you can call these capabilities directly through the Speech SDK or REST APIs, you can also make them available to an AI agent through the **Azure Speech Model Context Protocol (MCP) server**. This approach lets the agent handle speech tasks based on a user's natural language request, without you needing to write specific code for each speech operation.

For example, suppose you work for a company that needs to process customer support calls. Your team needs to transcribe recorded calls to text for analysis, and generate audio responses that can be played back to customers. Rather than building separate integrations for transcription and synthesis, you can create an AI agent that uses the Azure Speech MCP server to perform both tasks through a single tool connection.

In this module, you learn how the Azure Speech MCP server works, how to connect it to an AI agent in Microsoft Foundry, and how to build a client application that interacts with the agent programmatically.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.

> [!NOTE]
> The Azure Speech MCP server is currently in public preview. Details described in this module are subject to change.
