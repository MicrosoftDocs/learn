In today's rapidly evolving technological landscape, understanding AI is crucial for expanding the capabilities of applications and staying competitive. Azure SQL Database plays a pivotal role in this transformation by providing a robust platform for integrating AI into your applications. With features like Microsoft Copilot, natural language to SQL conversion, and advanced data management tools, Azure SQL Database empowers developers to harness the power of AI, streamline database management, and enhance application performance. With the help of those tools, you can create intelligent, responsive, and efficient applications that meet the demands of modern users.

## Use Copilot in Azure SQL Database (preview)

[Microsoft Copilot](/azure/azure-sql/copilot/copilot-azure-sql-overview) in Azure is integrated with Azure SQL Database, enhancing SQL management and troubleshooting. It boosts productivity in the Azure portal by offering natural language to SQL conversion and self-help for database administration.

Copilot simplifies database management by leveraging database context, documentation, dynamic management views, Query Store, and other knowledge sources. For example, database administrators can independently manage databases and resolve issues, while developers can generate T-SQL queries by asking questions in natural language.

Also, developers can manage databases and resolve issues independently, reducing the need for constant support from database administrators.

:::image type="content" source="../media/6-copilot.png" alt-text="Screenshot of Copilot for Azure SQL Database.":::

The current preview includes two experiences:

- [**Microsoft Copilot in Azure**](/azure/azure-sql/copilot/copilot-azure-sql-overview) -  Adds Azure SQL Database skills into Microsoft Copilot in Azure, empowering users with self-guided assistance to manage databases and solve issues independently.
- [**Natural language to SQL**](/azure/azure-sql/copilot/query-editor-natural-language-to-sql-copilot) -  Translates natural language queries into SQL within the Azure portal query editor, making database interactions more intuitive. This integration allows Microsoft Copilot in Azure to answer questions like:
    - Which agents have listed more than two properties for sale?
    - Tell me the rank of each agent by property sales and show name, total sales, and rank.
    - Show me a pivot summary table that displays the number of properties sold in each year from 2020 to 2023.

## Build intelligent applications with Large Language Models (LLMs)

Large language models (LLMs) enable developers to create AI-powered applications with a familiar user experience. Using LLMs in applications brings greater value and an improved user experience when the models can access the right data, at the right time, from your application's database. This process is known as Retrieval Augmented Generation (RAG), and Azure SQL Database has many features that support this new pattern, making it a great database to build intelligent applications.

Azure SQL Database offers various options to build intelligent applications, including generating embeddings for RAG with Azure OpenAI, storing and querying vectors, and using Azure AI Search to train LLMs on your data. Additionally, Copilot skills in Azure SQL Database streamline the design, operation, optimization, and health of Azure SQL Database-driven applications.

Key concepts for implementing RAG with Azure SQL Database and Azure OpenAI include:

- [**Retrieval Augmented Generation (RAG)**](/azure/ai-studio/concepts/retrieval-augmented-generation) - Enhances the LLM's ability to produce relevant responses by retrieving additional data from external sources.
- [**Prompts and Prompt Engineering**](/azure/ai-services/openai/concepts/prompt-engineering) - Creating specific text or information that serves as an instruction to an LLM.
- [**Tokens**](/azure/ai-services/openai/quotas-limits)- Tokens are smaller pieces of text created by splitting the input text into more manageable parts.
- [**Vector embeddings**](/azure/cosmos-db/gen-ai/vector-embeddings) - Vectors, or embeddings, are mathematical representations of data in a high-dimensional space, used by machine learning models to process various types of information like text, images, and audio.
- [**Vector search:**](/azure/search/vector-search-overview) Finding all vectors in a dataset that are semantically similar to a specific query vector.

Azure SQL Database supports columnstore indexes and batch mode execution, allowing for efficient storage and querying of vector embeddings. This integration minimizes the need to manage data synchronization and accelerates time-to-market for AI application development.

For more information on using Azure SQL Database with Azure OpenAI, including generating images, using OpenAI REST Endpoints, and leveraging vector search, see [Intelligent applications with Azure SQL Database](/azure/azure-sql/database/ai-artificial-intelligence-intelligent-applications).
