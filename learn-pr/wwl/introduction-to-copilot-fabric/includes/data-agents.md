Fabric data agents in Microsoft Fabric are AI-based tools that allow users to interact with organizational data stored in Fabric OneLake using natural language. They enable non-technical users to ask questions and receive context-based answers.

## Key concepts
The following fundamental concepts describe how Fabric data agents work.

**Conversational Q&A** lets users interact with data using plain English. For example, if you’re unsure how to write a SQL query to find last quarter’s sales, you can ask the agent, “What were our sales last quarter?” and receive an answer. This reduces the need for SQL knowledge.

**Data source integration** means you don’t have to worry about where your data lives. Whether your information is in lakehouses, warehouses, KQL databases, or Power BI semantic models, Fabric data agents can connect and pull insights from all these sources. If you’ve ever struggled to combine data from multiple systems, this feature streamlines the process and saves you time.

**Schema awareness** uses structure and metadata of data sources to generate context-aware responses. For instance, you can ask about “customer retention” and the agent will reference relevant tables and columns.

**Customizability** allows tailoring the agent to your organization’s terminology and needs. If your team uses specific jargon or has unique reporting requirements, you can add custom instructions and examples. This helps the agent deliver responses that reflect business context.

**Secure and contextual responses** mean you don’t have to worry about unauthorized access or irrelevant answers. The agent enforces read-only access and respects user permissions, so users only see data they’re allowed to view. This reduces the risk of sharing sensitive information and keeps responses focused on the right context.

**Integration with external systems** extends the agent’s use beyond Fabric. If you need to collaborate in Microsoft Teams or automate workflows with Copilot Studio or Azure AI Foundry, the agent can connect with these tools. This can help with sharing insights and automating tasks across your organization.

These concepts address common challenges like technical barriers, data silos, and inconsistent terminology and support data-informed decisions.

Here's an example of how you can interact with Copilot in a Fabric data agent:

> [!div class="mx-imgBorder"]
> [![Screenshot of copilot in a Fabric data agent.](../media/copilot-data-agent.png)](../media/copilot-data-agent.png#lightbox)

We’ll explore this topic in more detail in a later module.

## Benefits

Using Fabric data agents supports teams engaging with data. Key areas where they can help:

- **Accessibility**: Uses natural language interactions.  
- **Efficiency**: Simplifies data exploration without writing complex queries.  
- **Customization**: Supports tailoring to organization needs and terminology.  
- **Collaboration**: Makes insights accessible to a broad audience.  
- **Security**: Adheres to user permissions and maintains read-only access.  
