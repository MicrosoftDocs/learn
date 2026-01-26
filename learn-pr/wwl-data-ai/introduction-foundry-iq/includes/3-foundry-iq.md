
You now know how RAG solves the knowledge problem for AI agents. But here's the challenge: building a RAG system from scratch means configuring vector databases, implementing embedding pipelines, tuning retrieval algorithms, and maintaining search infrastructure. What if you need three different AI agents across your organization? You'd build three separate RAG systems.

There's a better approach.

## What is Foundry IQ?

Foundry IQ is a managed knowledge platform for AI agents built on Azure AI Search. It provides the retrieval capabilities you learned about in RAG, but as a shared service that multiple agents can use.

Consider a typical scenario. Your organization has product documentation stored in SharePoint, customer policies in Azure Blob Storage, and training materials in OneLake. With traditional RAG, you'd index each data source separately for each agent. With Foundry IQ, you create knowledge bases once and connect any agent to them.

This matters because it shifts your focus from building infrastructure to designing agent experiences. You spend time improving what information your agents access, not how they access it.

## How knowledge bases organize information

Knowledge bases in Foundry IQ organize information by business domain rather than technical storage location. This design reflects how people actually think about information.

Instead of agents searching "SharePoint Site A" or "Blob Container B," they search "Product Documentation" or "HR Policies." Each knowledge base brings together related information regardless of where it's stored.

For example, your Product Documentation knowledge base might include:

- Technical specifications from SharePoint
- API documentation from Azure Blob Storage  
- Usage analytics from OneLake
- Support tickets from your existing search index

To agents, this appears as one unified knowledge source. To you, it means connecting data sources to knowledge bases rather than managing separate retrieval systems.

## Connecting data sources

Foundry IQ connects to your existing storage through data source integrations. You point it at your SharePoint sites, Blob containers, or OneLake instances. Foundry IQ handles indexing, embedding generation, and search optimization automatically.

Here's what happens when you add a data source:

1. **Discovery**: Foundry IQ scans your storage location for documents
2. **Processing**: Documents are chunked and embedded for semantic search
3. **Indexing**: Content becomes searchable through the knowledge base
4. **Monitoring**: Changes to your documents trigger automatic reindexing

You configure this once per data source. Every agent connected to that knowledge base instantly benefits from updates.

## Built-in retrieval intelligence

Remember the retrieval strategies you learned about in RAG? Foundry IQ implements these automatically. When an agent queries a knowledge base, the platform:

**Analyzes the question** to understand what information the agent needs. A question like "What's our return policy for damaged items?" requires different retrieval than "List all return policies."

**Selects retrieval strategies** based on the query. Simple factual questions use keyword search. Complex questions combine semantic search with query expansion.

**Ranks results** using relevance scoring. The most contextually appropriate information surfaces first, reducing the tokens needed for agent responses.

**Provides citations** so agents can reference source documents. This builds trust and lets users verify information.

This intelligence runs without custom code. You define what knowledge bases contain. Foundry IQ determines how to retrieve from them.

## Connecting agents to knowledge

Let's see how simple it is to give an agent access to organizational knowledge. This example creates a support agent that can answer questions using product documentation:

```python
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import PromptAgentDefinition, MCPTool

project_client = AIProjectClient(endpoint=project_endpoint, credential=credential)

# Connect to the product documentation knowledge base
knowledge_tool = MCPTool(
    server_label="product-docs",
    server_url=f"{search_endpoint}/knowledgebases/product-documentation/mcp"
)

# Create an agent with knowledge access
agent = project_client.agents.create_version(
    agent_name="product-support-agent",
    definition=PromptAgentDefinition(
        model="gpt-4o-mini",
        instructions="Answer product questions using the knowledge base. Always cite your sources.",
        tools=[knowledge_tool]
    )
)
```

The agent now retrieves information from the knowledge base just like it would use any other tool. You don't write retrieval logic or manage search infrastructure.

## The shared knowledge advantage

The real value of Foundry IQ emerges when you scale beyond one agent. Imagine your organization needs:

- A support agent answering customer questions
- An employee assistant helping with HR policies  
- A developer agent explaining API usage

With traditional RAG, you'd build and maintain three retrieval systems. With Foundry IQ, you create knowledge bases that multiple agents share:

- The **Product Documentation** knowledge base serves both the support agent and developer agent
- The **HR Policies** knowledge base serves only the employee assistant
- Each agent accesses exactly the knowledge it needs

When you improve a knowledge base by adding data sources or refining content, every connected agent benefits immediately. This is how organizations build consistent, scalable AI agent systems.

> [!NOTE]
> Foundry IQ uses the Model Context Protocol (MCP) to connect agents to knowledge bases. MCP provides a standardized way for AI agents to access external tools and data sources securely.
