The Azure Language MCP server connects AI agents to Azure Language services through the **Model Context Protocol (MCP)**. Before exploring the Language MCP server itself, it helps to understand what MCP is and how it enables agents to use external tools.

## What is the Model Context Protocol?

The Model Context Protocol (MCP) is an open protocol that defines how AI agents interact with external tools, data sources, and services. MCP uses a client-server architecture with the following components:

- **Host**: The application that runs the agent (such as Microsoft Foundry or a custom app).
- **Client**: A component within the host that manages connections to MCP servers and handles communication.
- **Server**: A program that exposes tools, resources, and prompts that an agent can discover and call.

When an agent connects to an MCP server, it receives a catalog of available tools along with descriptions of what each tool does. The agent can then choose the right tool based on the user's request. This approach is called *dynamic tool discovery* — the agent doesn't need hardcoded knowledge of each tool. Instead, it queries the MCP server at runtime to find out what's available.

The key advantage of MCP for AI agents is flexibility. Tools can be added, updated, or removed on the server without modifying the agent itself. The agent always has access to the latest tool definitions, which makes MCP-based solutions easier to maintain and scale.

> [!TIP]
> To learn more about MCP architecture and how to build custom MCP tool integrations, see the **[Integrate MCP Tools with Azure AI Agents](/training/modules/connect-agent-to-mcp-tools/)** module.

## Azure Language MCP server capabilities

The Azure Language MCP server exposes Azure Language NLP capabilities as tools that any MCP-compatible agent can call. The server supports the following text analysis capabilities:

| Capability | Description |
|---|---|
| **Named Entity Recognition** | Identifies and categorizes entities in text, such as people, places, organizations, dates, and quantities. |
| **Sentiment Analysis** | Determines whether text expresses positive, negative, or neutral sentiment, and can extract opinions about specific aspects. |
| **Summarization** | Generates concise summaries of longer text content. |
| **Key Phrase Extraction** | Identifies the main concepts and key phrases in text. |
| **PII Redaction** | Detects and redacts personally identifiable information such as names, addresses, and phone numbers. |
| **Language Detection** | Identifies the language in which text is written. |
| **Text Analytics for Health** | Extracts and labels medical entities (such as diagnoses, medications, and symptoms) from clinical text. |
| **Conversational Language Understanding** | Interprets user utterances to identify intents and extract entities based on a trained custom model. |
| **Custom Question Answering** | Returns curated answers to user questions from a configured knowledge base. |

When you connect the Language MCP server to an agent, the agent receives the full list of available tools. Based on the user's prompt, the agent's underlying model decides which tool (or combination of tools) to call. For example, if a user asks "Summarize this article and tell me what people are mentioned," the agent might call both the summarization tool and the named entity recognition tool in the same turn.

## How the agent selects tools

The tool selection process works as follows:

1. The user sends a prompt to the agent.
1. The agent analyzes the prompt and determines which task (or tasks) need to be performed.
1. The agent checks the available MCP tools and their descriptions to find the best match.
1. The agent calls the selected tool through the MCP server, passing the relevant input text.
1. The MCP server processes the request using the appropriate Azure Language capability and returns the results.
1. The agent combines the results into a natural language response for the user.

This means you don't need to write routing logic to direct requests to specific tools. The agent handles tool selection autonomously, based on the tool descriptions it received from the MCP server.

## MCP server endpoint

The Azure Language MCP server is available as a remote endpoint with the following URL format:

```
https://{foundry-resource-name}.cognitiveservices.azure.com/language/mcp?api-version=2025-11-15-preview
```

Replace `{foundry-resource-name}` with the name of your Foundry resource (or Azure Language resource). This endpoint is what you configure when connecting the MCP server to your agent.

> [!NOTE]
> Azure Language also provides a local MCP server that you can host in your own environment. For setup guidance, see the [Azure Language MCP Server quickstart](https://github.com/Azure-Samples/ai-language-samples) in the Azure Language samples repository.
