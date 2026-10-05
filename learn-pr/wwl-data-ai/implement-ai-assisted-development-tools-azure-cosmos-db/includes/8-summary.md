You can now reach for an AI-assisted development tool with a reason behind the choice. Contoso's shopping assistant gets built from parts that already encode the storage and retrieval patterns it needs, and the developer keeps control of the decisions those parts deliberately leave open.

## What you learned

- Azure Cosmos DB for NoSQL holds documents, vectors, and full-text content in one container, which is why these toolkits ship a storage layer rather than an integration layer.
- The two Model Context Protocol (MCP) servers serve different moments: the Azure MCP Server is the design-time surface in your editor, and the Azure Cosmos DB MCP Toolkit is the deployed run-time one. Their Azure Cosmos DB tools are read-only, and the search tools depend on indexes you configure.
- The Agent Memory Toolkit derives facts, procedural memories, episodes, and summaries from raw turns, while Agentic Retrieval trades extra passes for a grounded answer.
- The tools own the pattern; you own the data model, capacity, indexing, role scope, and any judgment about answer quality.

## Learn more

- [Azure MCP Server tools for Azure Cosmos DB](/azure/developer/azure-mcp-server/tools/azure-cosmos-db)
- [Get started with the Azure MCP Server in Visual Studio Code](/azure/developer/azure-mcp-server/get-started/tools/visual-studio-code)
- [Azure Cosmos DB MCP Toolkit](https://github.com/AzureCosmosDB/MCPToolKit)
- [Agent Memory Toolkit](https://aka.ms/AgentMemoryToolkit)
- [Agentic Retrieval Toolkit](https://aka.ms/AgenticRetrieval)
- [Microsoft Agent Framework](/agent-framework/overview)
- [Vector search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/vector-search)
- [Full-text search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/full-text-search)

