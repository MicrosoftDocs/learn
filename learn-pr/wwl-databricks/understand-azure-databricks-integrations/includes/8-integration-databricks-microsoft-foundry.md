Azure Databricks and Microsoft Foundry serve complementary roles in modern AI and data architectures. Azure Databricks provides a platform for large-scale data engineering, transformation, and machine learning, while Microsoft Foundry offers tools for building and deploying AI agents and generative AI applications. Understanding how these platforms integrate helps you design solutions that combine enterprise data capabilities with conversational AI experiences.

The integration between Azure Databricks and Microsoft Foundry uses the **Model Context Protocol (MCP)** to connect AI agents with data insights from Azure Databricks **Genie spaces**. This connection lets AI agents in Microsoft Foundry query data managed in Azure Databricks using natural language, without requiring direct database access or custom API development.

## What is the Azure Databricks connector in Microsoft Foundry

Microsoft Foundry supports adding external tools and services to AI agents through standardized connectors. The **Azure Databricks Genie connector** appears as a tool option within Microsoft Foundry, enabling AI agents to access curated datasets and business intelligence insights from Azure Databricks.

The connector works through Genie spaces, which are conversational interfaces built on top of Azure Databricks data. Domain experts configure these spaces with specific datasets, sample queries, and business terminology. When you add a Genie space as a tool in Microsoft Foundry, your AI agents gain the ability to answer questions about that data using natural language.

With this connector, Microsoft Foundry agents don't query raw tables or write SQL directly. Instead, they interact with the preconfigured Genie space, which translates natural language questions into SQL queries and returns results. This approach provides a layer of abstraction that simplifies integration while maintaining data governance through the Genie space configuration.

The integration relies on the Model Context Protocol, an open standard that defines how AI agents communicate with external tools and data sources. Azure Databricks implements MCP through managed servers that expose Genie spaces, Unity Catalog functions, and other resources to compatible AI platforms. Microsoft Foundry acts as an MCP client, sending requests to the Azure Databricks MCP server and receiving structured responses.

## How the integration works

The architecture involves three main components working together. **Microsoft Foundry** hosts the AI agent and manages user interactions. The **Azure Databricks MCP server** exposes Genie spaces as MCP-compatible tools. **Genie spaces** contain the curated data, metadata, and business logic that enable natural language querying.

:::image type="content" source="../media/foundry-data-flow.svg" alt-text="Diagram explaining how the integration between Azure Databricks and Microsoft Foundry works." border="false" lightbox="../media/foundry-data-flow.svg":::

When you connect a Genie space to a Microsoft Foundry agent, you specify connection details including your workspace hostname, Genie space ID, and authentication method. Microsoft Foundry uses these details to establish a secure connection to the Azure Databricks MCP server endpoint. The MCP server validates permissions and provides access to the specific Genie space you've configured.

:::image type="content" source="../media/microsoft-foundry.svg" alt-text="Screenshot of Microsoft Foundry, connecting to a Genie workspace in Azure Databricks." border="false" lightbox="../media/microsoft-foundry.svg":::

During runtime, when a user asks the AI agent a question, Microsoft Foundry determines whether to route that question to the Genie tool based on the agent's configuration and the question's context. If the Genie tool is invoked, Microsoft Foundry sends the question to the Azure Databricks MCP server. The Genie space processes the question, generates a SQL query, executes it against the underlying data, and returns the results to Microsoft Foundry. The AI agent then incorporates these results into its response to the user.

Authentication occurs through **OAuth Identity Passthrough**, which means user identities flow from Microsoft Foundry to Azure Databricks. You can choose between **Managed** OAuth, which uses Microsoft Entra ID authentication, or **Custom** OAuth for other identity providers. Databricks recommends Managed OAuth for most scenarios. Each time the AI agent accesses the Genie space, Azure Databricks validates that the requesting identity has appropriate permissions to use that space.

## When to use this integration

This integration enables several practical scenarios where combining conversational AI with enterprise data creates value. You can build **AI assistants** that answer business questions using live data from your lakehouse. Users interact with these assistants through natural language, and the assistants query Databricks data through Genie spaces to provide accurate, data-driven responses.

For **self-service analytics**, business users can ask questions about data without learning SQL or understanding database schemas. The Genie space handles the complexity of translating questions into queries, while the Microsoft Foundry agent provides a conversational interface. This pattern works well when you want to extend data access beyond technical teams while maintaining governance through Genie space configuration.

You might use this integration to build **domain-specific assistants** for different parts of your organization. For example, a sales team assistant could connect to a Genie space configured with sales pipeline data, while a finance assistant connects to a different Genie space with financial metrics. Each assistant operates within its defined data scope, and you control what data each Genie space exposes.

The integration also supports **multi-tool agents** that combine Databricks data insights with other capabilities. An AI agent in Microsoft Foundry might use the Genie connector to retrieve data, use another tool to perform calculations or predictions, and use additional tools to take actions based on the results. This orchestration happens within Microsoft Foundry's agent framework, while Azure Databricks provides the data foundation.

## Key considerations

**Security and permissions** require attention at multiple levels. In Azure Databricks, you must enable the **Managed MCP Servers** preview feature in your workspace. Users who configure the connection in Microsoft Foundry need permissions to use the Genie space in Azure Databricks. The Genie space itself enforces permissions on the underlying data through Unity Catalog, so users can only access data they're authorized to see through the Genie space configuration.

**Genie space setup** directly impacts the quality of responses your AI agent can provide. Domain experts should configure Genie spaces with relevant datasets, clear column descriptions, and sample queries that reflect common questions. The better configured your Genie space, the more effectively it can translate natural language questions into accurate SQL queries. Consider this as a one-time setup cost that improves the ongoing experience for all users.

Performance depends on both Microsoft Foundry and Azure Databricks. Questions that require complex queries or access large datasets take longer to process than simple lookups. The underlying SQL warehouse or compute resources in Azure Databricks affect query execution speed. Plan your compute capacity based on expected query patterns and user concurrency.

The integration has **specific limitations** to consider. The Genie MCP server doesn't maintain conversation history when invoked as an MCP tool, so each question is processed independently. If your scenario requires multi-turn conversations with context, you might need to explore alternative integration patterns. Additionally, network access between Microsoft Foundry and your Azure Databricks workspace must be configured appropriately, considering any IP restrictions or private endpoints you've implemented.

Cost considerations include both Microsoft Foundry and Azure Databricks components. Microsoft Foundry charges for agent usage and API calls. Azure Databricks charges for serverless SQL compute when Genie spaces execute queries. Genie uses serverless SQL compute to run, and pricing follows the standard Databricks SQL serverless pricing model. Evaluate your expected query volume and complexity to estimate costs accurately.

> [!NOTE]
> The feature is currently in **Public Preview**, which means it's suitable for development and testing but may undergo changes before general availability. Plan for potential updates to configuration requirements or functionality as the feature evolves. Monitor Azure Databricks release notes for updates that affect your implementation.
