# Unit 4 – Evaluate agentic frameworks for integration with PostgreSQL

AI agents rely on orchestration frameworks to manage tasks, coordinate tools, and maintain context. These frameworks provide the structure needed to build agents that can reason, retrieve information, and interact with external systems. *Azure Database for PostgreSQL* integrates with several of these frameworks, making it easier to build applications that combine data, logic, and language models.  

## Identify key frameworks

Several open-source and Microsoft-supported frameworks help developers build and manage AI agents. For example, at Margie's Travel these frameworks play different roles in supporting guest interactions and property recommendations:

- [**Microsoft Agent Framework**](https://learn.microsoft.com/en-us/agent-framework/overview/agent-framework-overview) is a unified framework that merges the best capabilities of *AutoGen* and *Semantic Kernel*. It provides connectors for memory storage, tool calling, multi-agent orchestration, and enterprise integration. It integrates with Azure Database for PostgreSQL for storing embeddings and chat history. Margie's Travel uses Microsoft Agent Framework to manage guest conversations, coordinate tools that access booking data, and enable dynamic handoffs between specialized agents.  
- [**LangGraph**](https://github.com/langchain-ai/langgraph) enables multi-agent workflows with branching logic and memory. It works well for orchestrating agents that handle inventory, personalization, and presentation tasks. Margie's Travel uses LangGraph to coordinate agents that respond to complex guest queries involving multiple steps.  
- [**LlamaIndex**](https://www.llamaindex.ai/) offers indexing and retrieval capabilities, allowing agents to search structured and unstructured data stored in PostgreSQL. Margie's Travel uses LlamaIndex to surface relevant property descriptions and reviews from both relational tables and freeform notes.  
- [**Foundry Agent Service**](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/overview) provides a hosted orchestration layer for building and deploying agents with built-in support for Azure services. Margie's Travel uses this service to deploy agents that interact with *Azure OpenAI*, Azure Search, and other tools in production.  

## Compare framework capabilities

Although all frameworks support agent orchestration, they differ in focus:  

- **Microsoft Agent Framework** combines modularity, enterprise tool integration, production-grade support, and multi-agent collaboration in a unified framework.  
- **LangGraph** is designed for complex workflows and multi-agent coordination with branching logic.  
- **LlamaIndex** focuses on retrieval and indexing, especially for document-based agents.  
- **Foundry Agent Service** simplifies deployment and integration with Azure infrastructure.  

## Integrate frameworks with PostgreSQL

Each framework can connect to Azure Database for PostgreSQL to support agent memory, retrieval, and context management:

- **Microsoft Agent Framework** uses memory connectors to store and retrieve embeddings from PostgreSQL with the `pgvector` extension, combining capabilities from both *Semantic Kernel* and *AutoGen*. Learn more in the [Microsoft Agent Framework documentation](https://learn.microsoft.com/en-us/agent-framework/overview/agent-framework-overview).
- **LangGraph** integrates through [LangChain's PostgreSQL components](https://python.langchain.com/docs/integrations/vectorstores/pgvector) for vector storage and retrieval in multi-agent workflows.
- **LlamaIndex** provides [PostgreSQL vector store integration](https://docs.llamaindex.ai/en/stable/examples/vector_stores/postgres/) for document indexing and semantic search.
- **Foundry Agent Service** connects to PostgreSQL through custom tools and API endpoints, as demonstrated in this module's exercise.

For example, at Margie's Travel, LangGraph orchestrates multi-agent workflows, LlamaIndex handles retrieval from PostgreSQL's vector store, and Microsoft Agent Framework manages conversation memory and agent collaboration—all using the same PostgreSQL database. Foundry Agent Service deploys the agents in production, ensuring scalability and reliability.

## Summarize key takeaways

*Azure Database for PostgreSQL* pairs with any of these frameworks to support agent memory, retrieval, and context management. Developers can select the framework that best fits their application needs and connect it to PostgreSQL through native extensions, framework-specific connectors, or custom integrations.