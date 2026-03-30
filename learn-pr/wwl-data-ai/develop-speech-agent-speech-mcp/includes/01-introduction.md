Azure Speech in Foundry Tools provides speech-to-text and text-to-speech capabilities that you can integrate into AI applications. These capabilities let you transcribe audio to text and synthesize natural-sounding speech from text.

While you can call these capabilities directly through the Speech SDK or REST APIs, you can also make them available to an AI agent through the **Azure Speech Model Context Protocol (MCP) server**. This approach lets the agent handle speech tasks based on a user's natural language request, without you needing to write specific code for each speech operation.

For example, suppose you work for a company that needs to process customer support calls. Your team needs to transcribe recorded calls to text for analysis, and generate audio responses that can be played back to customers. Rather than building separate integrations for transcription and synthesis, you can create an AI agent that uses the Azure Speech MCP server to perform both tasks through a single tool connection.

In this module, you learn how the Azure Speech MCP server works, how to connect it to an AI agent in Microsoft Foundry, and how to build a client application that interacts with the agent programmatically.

> [!NOTE]
> The Azure Speech MCP server is currently in public preview. Details described in this module are subject to change.
