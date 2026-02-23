*Foundry Agent Service* provides a hosted orchestration layer for building and deploying intelligent agents. These agents can interact with tools, retrieve data, and maintain context across workflows. When integrated with *Azure Database for PostgreSQL*, agents gain access to scalable vector search, persistent memory, and structured data—essential for delivering relevant, context-aware responses.  

## Explain Foundry Agent Service and PostgreSQL integration  

*Microsoft Foundry Agent* Service lets developers define agents that use tools, maintain memory, and interact with users through natural language. PostgreSQL acts as both a structured data source and a vector store, enabling agents to retrieve facts and semantic matches from enterprise content.  

For example, at Margie’s Travel, agents built with *Foundry Agent Service* answer guest questions, recommend properties, and automate support workflows. The integration allows agents to choose between vector search and SQL queries depending on the request.  

## Describe the architecture for embeddings, storage, and retrieval  

To support intelligent behavior, agents combine embeddings, vector search, and structured queries. Together, these components help agents interpret user intent, retrieve relevant data, and provide responses with context.  

- **Embedding generation**: Converts raw text into vectors using *Azure OpenAI* or the `azure_ai` extension in PostgreSQL.  
- **Vector storage and retrieval**: Stores embeddings in PostgreSQL with the `pgvector` extension and retrieves them through similarity search.  
- **Tool integration**: Connects agents to external tools such as SQL queries, APIs, or Azure Functions.  
- **Orchestration and reasoning**: Uses *Foundry Agent Service* to manage workflows, memory, and decision-making.  

## Apply steps to build PostgreSQL agents with Foundry Agent Service  

Developers follow a series of steps to set up and configure an AI agent that integrates with *Azure Database for PostgreSQL*:  

1. **Set up PostgreSQL Flexible Server**  
   - Deploy a PostgreSQL Flexible Server instance.  
   - Enable the `azure_ai` and `pgvector` extensions.  
   - Configure networking, authentication, and access controls.  

1. **Set up vector search**  
   - Generate embeddings from source data using *Azure OpenAI* or the `azure_ai` extension.  
   - Store embeddings in a vector-enabled table.  
   - Create a `DiskANN` index for fast similarity search.  

1. **Create a PostgreSQL tool**  
   - Define a tool that allows the agent to query the database using SQL and vector search.  
   - Register the tool in `Foundry Agent Service` with appropriate permissions and schema.  

1. **Run and test the agent in AI Foundry**  
   - Configure the agent’s behavior, memory, and tool usage.  
   - Deploy the agent and run test queries to validate its responses.  
   - Monitor performance and adjust the agent’s logic and data sources.  

## Analyze a scenario with Margie’s Travel  

Margie’s Travel builds an AI agent to help guests find vacation rentals. The agent uses `Foundry Agent Service` to manage its workflow and Azure Database for PostgreSQL to store and retrieve property data.  

When a guest asks, *"Show me pet-friendly apartments near the beach with great reviews,"* the agent:  

- Converts the query into an embedding.  
- Searches the vector index in PostgreSQL for similar property descriptions.  
- Applies semantic filters for "pet-friendly" and "beach proximity."  
- Rerank results based on review sentiment.  
- Returns a list of matching properties with summaries.  

This setup enables Margie’s Travel to provide personalized recommendations quickly, while ensuring security and performance at scale.  

## Summarize key takeaways  

*Foundry Agent Service* simplifies the process of building intelligent agents that integrate with *Azure Database for PostgreSQL*. By combining embeddings, vector search, and orchestration, developers can create agents that retrieve information, maintain context, and respond intelligently to user needs.  
