Azure Databricks integrates with Microsoft Copilot Studio to bring governed lakehouse data into conversational AI agents. The **Azure Databricks connector** enables two integration patterns: **knowledge sources** for semantic search and question answering, and **Genie spaces** as intelligent analytical tools. Both approaches preserve Unity Catalog governance, ensuring users access only authorized data.

:::image type="content" source="../media/databricks-copilot-studio.svg" alt-text="Diagram explaining the Azure Databricks integration with Copilot Studio." border="false" lightbox="../media/databricks-copilot-studio.svg":::

## Use tables as knowledge sources

Copilot Studio agents access Azure Databricks tables as **knowledge sources** to ground responses in your organization's data. Users ask questions in natural language, and the agent retrieves relevant information to provide data-driven answers.

Configure knowledge sources by connecting Copilot Studio to Azure Databricks using OAuth authentication or a service principal. Select a catalog and specific tables for your agent. The agent queries tables directly through the SQL warehouse without copying data, ensuring Unity Catalog enforces all governance controls including row-level security and column masking.

:::image type="content" source="../media/use-table-as-knowledge-sources.svg" alt-text="Screenshot of Copilot Studio, using tables as knowledge sources." border="false" lightbox="../media/use-table-as-knowledge-sources.svg":::

OAuth authentication passes each user's identity to Azure Databricks, where Unity Catalog evaluates permissions in real time. Service principal authentication runs all queries with consistent permissions, useful for uniform data access or cross-tenant scenarios.

The agent performs **semantic search** by translating natural language into SQL, retrieving relevant rows, and synthesizing conversational responses. This enables business users to explore data without writing SQL or understanding the data model.

> [!NOTE]
> Knowledge sources work best with tables that have descriptive column names and well-structured data. Consider creating curated views or aggregated tables specifically for agent consumption.

## Connect Genie spaces as tools

Copilot Studio agents can interact with **Genie spaces** as intelligent tools. Genie is Azure Databricks' AI-powered analytics interface that understands natural language questions. The integration uses **Model Context Protocol (MCP)**, enabling your agent to orchestrate between conversation management and analytical queries.

:::image type="content" source="../media/connect-genie-as-tools.svg" alt-text="Screenshot of Copilot Studio, connecting Genie as tool." border="false" lightbox="../media/connect-genie-as-tools.svg":::

To set up Genie integration, enable **Managed MCP Servers** preview in your Azure Databricks workspace, then connect Genie in Copilot Studio using the Genie Space ID. The agent can then send analytical questions to Genie and return results conversationally.

Genie differs from knowledge sources: instead of semantic search and data retrieval, Genie performs complex analytics, generates visualizations, aggregates data, and explains trends through its specialized analytics engine.

> [!IMPORTANT]
> Genie integration is currently in Public Preview and requires enabling the Managed MCP Servers preview in your workspace. Not all Azure Databricks features in preview are recommended for production workloads.

## Integration scenarios

**Customer support agents** answer questions about order history, inventory, or shipping status using Azure Databricks tables as knowledge sources. Unity Catalog ensures each representative sees only authorized orders and customers.

**Executive analytics agents** connect to Genie spaces for business insights. When asked "What drove the increase in customer churn last quarter?", the agent invokes Genie to analyze trends, identify factors, and present findings conversationally.

**Data literacy agents** help employees understand datasets by answering questions like "What tables contain customer demographic data?" or "How is revenue calculated in the sales fact table?".

**Compliance and audit agents** query Unity Catalog metadata to answer questions about data lineage, access patterns, or governance policies, helping teams respond efficiently to audit requests.

These scenarios combine conversational AI with governed data access—users interact through natural language while Unity Catalog enforces security, audit logging, and access controls.

## Considerations and limitations

The connector **doesn't support government clouds** (GCC, GCC High, China Cloud).

Agent performance depends on **table structure and data quality**. Use clear column names, consistent data types, and appropriate indexes. Consider creating dedicated views for agent consumption rather than exposing complex schemas with many joins.

The connector requires a **SQL warehouse**—serverless or pro only (classic warehouses aren't supported for Genie). Size appropriately for many small queries and configure auto-scaling and auto-stop for cost optimization.

**Genie integration** is in Public Preview. Enable Managed MCP Servers in workspace settings and consider stability requirements before production deployment.

**Service principal authentication** executes all queries with the principal's permissions, providing consistent access but preventing user-level row security. OAuth enables user-specific governance but requires users to have Azure Databricks permissions and both platforms in the same Microsoft Entra tenant.

Power Platform **throttling limits** apply: 100 API calls per 60 seconds. Design agents to batch operations and cache frequently accessed information.
