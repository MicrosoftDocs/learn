Microsoft Foundry Agent Service is a service within Azure that you can use to create, test, and manage AI agents. It provides both a visual agent development experience in the Microsoft Foundry portal and a code-first development experience using the Microsoft Foundry SDK.

:::image type="content" source="../media/agent-playground.png" alt-text="Screenshot of the Azure AI Agent playground in the Microsoft Foundry portal.":::

## Components of an agent

Agents developed using Foundry Agent Service have the following elements:

- **Model**: A deployed generative AI model that enables the agent to reason and generate natural language responses to prompts. You can use common OpenAI models and a selection of models from the Microsoft Foundry model catalog.
- **Knowledge**: Data sources that enable the agent to ground prompts with contextual data. You can use **Foundry IQ** — a managed knowledge layer that unifies content from sources like SharePoint, OneLake, Azure Blob storage, and the web into reusable, permission-aware knowledge bases. Foundry IQ handles document chunking, embedding, and retrieval so you don't need to build custom RAG pipelines.
- **Tools**: Programmatic functions that enable the agent to automate *actions*. Built-in tools include web search, file search, code interpreter, and memory. You can also create custom tools using your own code, Azure Functions, or MCP servers.
- **Memory**: Agents can persist procedural and episodic memory across conversations, improving continuity and task success in multi-turn interactions.
- **Observability**: Built-in tracing, metrics, and automated evaluation help you monitor agent performance and diagnose issues in production.

Conversations between users and agents take place on a *thread*, which retains a history of the messages exchanged in the conversation as well as any data assets, such as files, that are generated.
