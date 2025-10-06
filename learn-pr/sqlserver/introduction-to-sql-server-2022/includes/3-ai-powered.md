SQL Server 2025 introduces native AI capabilities with [vector search](/sql/relational-databases/search/vector-search) functionality. This enables semantic search and natural language queries to find relationships in data beyond traditional full-text search capabilities.

> [!NOTE]
Model management in T-SQL allows you to work with models from [Azure OpenAI Service](/azure/ai-services/openai/overview), [Azure AI Foundry](/azure/ai-studio/concepts/model-catalog), and other providers through REST APIs. You can deploy and manage models on-premises or in the cloud using standard T-SQL syntax.

:::image type="content" source="../media/sql-2005-ai.png" alt-text="Diagram illustrating AI-powered features in SQL Server 2025." lightbox="../media/sql-2005-ai.png" border="false"::::::

The diagram highlights how SQL Server 2025 brings together advanced AI integration, vector search, and seamless model management. With these capabilities, organizations can unlock new insights, enable natural language queries, and build intelligent applications directly on their data platform.

SQL Server 2025 also introduces essential tools for building AI-powered applications, including vector embedding generation, text chunking, and fast, efficient vector indexing with DiskANN. These features support retrieval-augmented generation (RAG) and AI agent workflows, and integrate smoothly with frameworks like LangChain, Semantic Kernel, and Entity Framework Core.

## Implement AI capabilities in Sql Server 2025

> [!TIP]
Refer to the [SQL Server Machine Learning documentation](/sql/machine-learning/sql-server-machine-learning-services) for detailed implementation guides and best practices.

The following table describes key AI capabilities in SQL Server 2025:

| Capability | Description | Documentation |
|------------|-------------|---------------|
| Vector search | Create and query vector embeddings for semantic search and similarity matching | [Vector search guide](/sql/relational-databases/search/vector-search) |
| Model integration | Run machine learning models within the database engine for real-time scoring | [ML Services overview](/sql/machine-learning/sql-server-machine-learning-services) |
| T-SQL AI functions | Use built-in functions for text analysis, embedding generation, and model inference | [T-SQL AI reference](/sql/t-sql/ai-functions) |
| Azure AI connection | Connect to Azure AI services for more capabilities like computer vision and text analysis | [Azure AI integration](/sql/machine-learning/concepts/extension-azure) |

> [!TIP]
> Use the `CREATE EXTERNAL MODEL` statement to register and manage AI models in your database. This provides version control and secure access management for your models.

## Configure cloud and hybrid features

> [!IMPORTANT]
Ensure your network and security configurations allow communication between SQL Server and Azure services when implementing hybrid scenarios.

- **Managed disaster recovery**: SQL Server 2025 offers improved integration with Azure for managed disaster recovery, enabling automated backups, geo-replication, and fast failover to the cloud.
- **Real-time analytics**: Use hybrid data architectures to combine on-premises and cloud data sources, enabling near real-time analytics and reporting using Azure Synapse Analytics, Power BI, and other cloud services.
- **Advanced security and compliance**: Benefit from unified security management, advanced threat protection, and compliance monitoring by connecting SQL Server 2025 to Azure Security Center and Microsoft Purview.
- **Hybrid data virtualization**: Access and query data across on-premises, cloud, and S3-compatible object storage providers using built-in connectors and data virtualization features.

## Explore implementation scenarios

| Scenario | Components Used | Business Value |
|----------|-----------------|----------------|
| Real-time fraud detection | Vector search, T-SQL scoring | Immediate transaction verification |
| Disaster recovery | Azure SQL, geo-replication | Business continuity assurance |
| Unified analytics | Hybrid connections, Azure Synapse | Comprehensive data insights |
| Content analysis | Azure Cognitive Services | Automated data enrichment |

SQL Server 2025 empowers organizations to build intelligent, resilient, and scalable data solutions by combining the power of AI with seamless cloud connectivity.
