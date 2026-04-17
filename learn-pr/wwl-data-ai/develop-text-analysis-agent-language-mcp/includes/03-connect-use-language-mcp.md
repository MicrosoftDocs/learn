After you understand the capabilities of the Azure Language MCP server, the next step is to connect it to an agent and start using it. This involves creating an agent in Microsoft Foundry, connecting the Language MCP tool, testing it in the agent playground, and optionally building a client application to interact with the agent programmatically.

## Create a Foundry project and agent

To use the Azure Language MCP server, you first need a Microsoft Foundry project with a deployed model.

1. In the [Microsoft Foundry portal](https://ai.azure.com), create a new project (or use an existing one).
1. Deploy a model (such as **gpt-4.1**) that your agent will use for reasoning and generating responses.
1. Create an agent and give it instructions that describe its purpose. For example:

    ```
    You are an AI agent that assists users by helping them analyze and summarize text.
    ```

The agent is now ready to receive tool connections.

## Connect the Azure Language MCP server

You connect the Azure Language MCP server to your agent through the **Tools** page in the Foundry portal.

1. In the navigation pane, select the **Tools** page.
1. Select **Connect a tool** and choose **Azure Language in Foundry Tools** from the catalog.
1. Configure the connection with the following settings:
    - **Foundry resource name**: The name of your Foundry resource (for example, `myproject-resource`).
    - **Authentication**: Key-based.
    - **Credential** (`Ocp-Apim-Subscription-Key`): The key for your Foundry project.

1. Wait for the connection to be created, then select **Use in an agent** and choose your agent.

:::image type="content" source="../media/azure-language-tool-catalog.png" alt-text="Screenshot of the Tools catalog in the Foundry portal showing the Azure Language in Foundry Tools connection configuration.":::

The agent now has access to all the text analysis tools exposed by the Azure Language MCP server.

> [!TIP]
> You can find the project key on the project home page in the Foundry portal.

## Update agent instructions

After connecting the Language MCP tool, update the agent's instructions to direct it to use the tool:

```
You are an AI agent that assists users by helping them analyze text. Use the Azure Language tool to perform text analysis tasks.
```

This instruction helps the agent understand that it should use the connected tool when processing text analysis requests.

## Test in the agent playground

The agent playground in the Foundry portal provides an interactive environment for testing your agent before deploying it in an application.

When you send a prompt that requires text analysis, the agent:

1. Identifies the tasks needed (for example, language detection and entity recognition).
1. Calls the appropriate Azure Language MCP tool(s).
1. Returns a combined response.

The first time the agent uses an MCP tool, you're prompted to **approve** the tool usage. You can approve the tool for a single use, or select **Always approve all Azure Language in Foundry Tools tools** to skip future approval prompts.

After the agent responds, you can review the **Logs** pane to verify which tools were used. The logs show each MCP tool call, the input that was sent, and the result that was returned.

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
            "name": "Text-Analysis-Agent",
            "type": "agent_reference"
        }
    },
)

print(response.output_text)
```

The agent processes the prompt, calls the appropriate MCP tools, and returns the result in `output_text`. You can also inspect the full response JSON (using `response.model_dump_json()`) to see which tools the agent called — for example, `extract_named_entities_from_text` or `detect_language_from_text` — along with the arguments and results for each tool call.

### Connect the MCP server in code

Instead of connecting the Azure Language MCP server through the Foundry portal, you can also define the MCP tool connection directly in code when you create an agent. Use the `MCPTool` class from the `azure-ai-projects` SDK to specify the server label, URL, and allowed tools:

```python
from azure.ai.projects.models import MCPTool

mcp_tool = MCPTool(
    server_label="azure-language",
    server_url="https://{foundry-resource-name}.cognitiveservices.azure.com/language/mcp?api-version=2025-11-15-preview",
    require_approval="always",
)
```

You then pass the `mcp_tool` when creating the agent through the SDK. This approach is useful when you want to manage tool connections as part of your application code rather than configuring them manually in the portal. You can also use the `allowed_tools` property on `MCPTool` to restrict which specific Language tools the agent can call.

## Tool selection with multi-task prompts

When a user's prompt involves multiple text analysis tasks, the agent can call multiple tools in a single turn. For example, the prompt:

> "Tell me what entities and dates are mentioned in this review, and whether it is positive or negative."

This prompt requires both entity recognition and sentiment analysis. The agent identifies both tasks, calls the appropriate tools (`extract_named_entities_from_text` and `detect_language_from_text`), and combines the results into a single response.

Each tool call goes through the MCP server independently, and the agent synthesizes the outputs into a coherent answer for the user.
