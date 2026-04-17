After you understand the capabilities of the Azure Speech MCP server, the next step is to connect it to an agent and start using it. This involves setting up storage, creating an agent in Microsoft Foundry, connecting the Speech MCP tool, testing it in the agent playground, and optionally building a client application.

## Set up Azure Blob Storage

The Azure Speech MCP server requires an Azure Storage account to store audio files. You need to create a storage account and a blob container before connecting the tool.

1. In the [Azure portal](https://portal.azure.com), create a new **Azure Storage account** (or use an existing one).
1. In the storage account, expand **Data storage** and select **Containers**.
1. Create a new container (for example, named **files**) to store the audio files your agent generates and reads.
1. Generate a **SAS token** for the container with the following permissions: Read, Add, Create, Write, and List. Set the expiry time to the shortest practical duration.

> [!IMPORTANT]
> Copy the generated SAS URL and store it securely — you need it when connecting the Speech MCP server.

## Create a Foundry project and agent

To use the Azure Speech MCP server, you need a Microsoft Foundry project with a deployed model.

1. In the [Microsoft Foundry portal](https://ai.azure.com), create a new project (or use an existing one).
1. Deploy a model (such as **gpt-4.1**) that your agent will use for reasoning and generating responses.
1. Create an agent and give it instructions that describe its purpose. For example:

    ```
    You are an AI agent that uses the Azure AI Speech tool to transcribe and generate speech.
    ```

The agent is now ready to receive tool connections.

## Connect the Azure Speech MCP server

You connect the Azure Speech MCP server to your agent through the **Tools** page in the Foundry portal.

1. In the navigation pane, select the **Tools** page.
1. Select **Connect a tool** and choose **Azure Speech in Foundry Tools** from the catalog.
1. Configure the connection with the following settings:
    - **Foundry resource name**: The name of your Foundry resource (for example, `myproject-resource`).
    - **Bearer** (`Ocp-Apim-Subscription-Key`): The key for your Foundry project.
    - **X-Blob-Container-Url**: The SAS URL for your blob container.

1. Wait for the connection to be created, then select **Use in an agent** and choose your agent.

:::image type="content" source="../media/azure-speech-tool-config.png" alt-text="Screenshot of the Tools catalog in the Foundry portal showing the Azure Speech in Foundry Tools connection configuration.":::

The agent now has access to the speech-to-text and text-to-speech tools exposed by the Azure Speech MCP server.

> [!TIP]
> You can find the project key on the project home page in the Foundry portal.

## Test in the agent playground

The agent playground in the Foundry portal provides an interactive environment for testing your agent.

### Test text-to-speech

Enter a prompt that asks the agent to generate speech:

```
Generate "To be or not to be, that is the question." as speech
```

The first time the agent uses the Speech MCP tool, you're prompted to **approve** the tool usage. You can select **Always approve all Azure Speech MCP Server tools** to skip future approval prompts.

The response includes a link to the generated audio file saved in your blob container. Select the link to listen to the synthesized speech.

### Test speech-to-text

Enter a prompt that asks the agent to transcribe an audio file. You can use a publicly accessible URL or a SAS URL pointing to a file in your blob container:

```
Transcribe the file at https://example.com/audio/meeting-recording.wav
```

The agent calls the speech-to-text tool and returns the transcribed text.

### Customizing speech output

The Speech MCP tools support several options you can specify in your prompts:

- **Voice selection**: Specify a neural voice, such as `en-GB-SoniaNeural` or `en-US-JennyNeural`.
- **Language**: Specify the language for recognition or synthesis (for example, `es-ES` for Spanish).
- **Phrase hints**: Provide domain-specific terms to improve transcription accuracy (for example, "Azure, OpenAI, Cognitive Services").
- **Profanity filtering**: Request `masked`, `removed`, or `raw` profanity handling during transcription.

For example:

```
Synthesize "Better a witty fool, than a foolish wit!" as speech using the voice "en-GB-SoniaNeural".
```

## Build a client application

While the agent playground is useful for testing, you typically want to build a client application that uses the agent programmatically. The Microsoft Foundry SDK supports this through the OpenAI Responses API.

To build a client application, you use the `azure-ai-projects` and `azure-identity` packages. The general pattern is:

1. Create an `AIProjectClient` using your Foundry project endpoint and `DefaultAzureCredential` (which uses your Azure CLI credentials in development).
1. Get an OpenAI client from the project client by calling `get_openai_client()`.
1. Call `responses.create()` to send a user prompt to the agent.

The key part is how you reference the agent — you specify it by name in the `extra_body` parameter:

```python
response = openai_client.responses.create(
    input=[{"role": "user", "content": user_prompt}],
    extra_body={
        "agent_reference": {
            "name": "Speech-Agent",
            "type": "agent_reference"
        }
    },
)

print(response.output_text)
```

The agent processes the prompt, calls the appropriate Speech MCP tool, and returns the result in `output_text`. For text-to-speech requests, the output includes a link to the generated audio file in your blob container.

### Connect the MCP server in code

Instead of connecting the Azure Speech MCP server through the Foundry portal, you can define the MCP tool connection directly in code when you create an agent. Use the `MCPTool` class from the `azure-ai-projects` SDK:

```python
from azure.ai.projects.models import MCPTool

mcp_tool = MCPTool(
    server_label="azure-speech",
    server_url="https://{foundry-resource-name}.cognitiveservices.azure.com/speech/mcp",
    require_approval="always",
)
```

You then pass the `mcp_tool` when creating the agent through the SDK. This approach is useful when you want to manage tool connections as part of your application code rather than configuring them manually in the portal.
