Microsoft Foundry Agent Service is a service within Azure that you can use to create, test, and manage AI agents. It provides both a visual agent development experience in the Microsoft Foundry portal and a code-first development experience using the Microsoft Foundry SDK.

:::image type="content" source="../media/agent-playground.png" alt-text="Screenshot of the Azure AI Agent playground in the Microsoft Foundry portal.":::

## Components of an agent

Agents developed using Foundry Agent Service have the following elements:

- **Model**: A deployed generative AI model that enables the agent to reason and generate natural language responses to prompts. You can use common OpenAI models and a selection of models from the Microsoft Foundry model catalog.
- **Knowledge**: Data sources that enable the agent to ground prompts with contextual data. Potential knowledge sources include web search results, SharePoint sites, an Azure AI Search index, Azure Blob storage, and other connected data sources.
- **Tools**: Programmatic functions that enable the agent to automate *actions*. Built-in tools include web search, file search, code interpreter, and memory. You can also create custom tools using your own code, Azure Functions, or MCP servers.

Conversations between users and agents take place on a *thread*, which retains a history of the messages exchanged in the conversation as well as any data assets, such as files, that are generated.
