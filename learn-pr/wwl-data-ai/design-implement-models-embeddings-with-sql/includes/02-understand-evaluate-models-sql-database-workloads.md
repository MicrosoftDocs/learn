Large language models (LLMs) enable applications to generate responses, summarize information, and reason over user input. Their usefulness increases when they can access application data stored in a database.

Azure SQL Database and Fabric SQL database support building intelligent applications by integrating AI capabilities such as embeddings, vector data types, and vector search. These features allow models to work directly with relational data, enabling common patterns like semantic search and Retrieval Augmented Generation (RAG).

Before integrating a model into a SQL-based solution, it's important to understand how different models behave and how their characteristics affect application design.

## Identify model characteristics for SQL database workloads

Models differ in their capabilities, performance characteristics, and supported input and output formats. When evaluating models for use with Azure SQL Database or Fabric SQL database, consider the following factors.

**Modalities**  
Some models process only text, while others support other inputs such as images or structured data. The required modality depends on the type of data stored in the database and the intended application scenario.

**Language support**  
Multilingual support is important when applications serve users across regions or when stored content spans multiple languages.

**Model size and capacity**  
Larger models typically provide stronger reasoning and more nuanced output, but they also consume more tokens and can introduce higher latency and cost. Smaller models might be more suitable for focused tasks such as embedding generation.

**Structured output**  
Models that can produce structured output, such as JSON, are easier to integrate into SQL-based workflows where responses must be processed programmatically.

These characteristics influence whether a model is a good fit for generating embeddings, supporting RAG patterns, or enabling conversational access to database content.

## Describe how models interact with Azure SQL data

Azure SQL Database and Fabric SQL database support intelligent application patterns by combining relational storage with AI features such as vector data types and vector functions.

A common pattern is Retrieval Augmented Generation (RAG), where relevant data is retrieved from the database and supplied to a model as context before generating a response. This step allows responses to be grounded in application data rather than relying only on a model’s pretrained knowledge.

Several concepts affect how models interact with database data:

- **Tokens**, which are the units models use to process text  
- **Embeddings**, which represent data as vectors  
- **Vector search**, which compares embeddings to identify semantic similarity

Because vectors live alongside relational data in Azure SQL Database, you can combine vector similarity search with any standard SQL capability in a single query. For example, you might narrow vector search results with a `WHERE` clause, join them to related tables, or blend vector cosine rankings with full-text BM25 scores. This combination of vector search with regular SQL operations is known as **hybrid search**. Instead of sending requests to a separate search service and reconciling the results, you query one database that handles both semantic similarity and relational filtering together.

Understanding these concepts helps you design SQL-based applications that effectively use AI capabilities while managing performance and cost.

## Explain how tokens affect cost and design

Models don't process text as raw characters. Instead, they break text into tokens. Tokens are small chunks that might be words, parts of words, or punctuation. For example, the word "hamburger" might become three tokens: "ham", "bur", and "ger", while a common word like "the" is typically a single token.

Token counts matter for two reasons. First, models have input limits. A model might accept a maximum of 8,000 or 128,000 tokens in a single request. This limit constrains how much database content you can include as context in a RAG pattern. Second, model providers typically charge based on tokens processed. More tokens mean higher costs, so efficient text handling directly affects operating expenses.

When you're designing SQL-based AI solutions, token limits influence how you chunk content for embeddings and how much context you can pass to a model during generation.

Because models impose token limits and differ in how embeddings are generated, these characteristics affect schema design, chunking strategies, and query behavior.

## Explore models with Microsoft Foundry

Microsoft Foundry Models provides a catalog of AI models that can be used with Azure services. The catalog includes models that support tasks such as text processing, embedding generation, reasoning, and multimodal input.

For SQL database workloads, Foundry helps you evaluate which models are appropriate for integration with Azure SQL Database or Fabric SQL database. Supported input types, language coverage, and deployment options all influence which model fits your scenario.

The model catalog exposes information such as model capabilities, benchmarks, version details, and lifecycle status. This information helps developers understand performance and operational constraints before connecting a model to database workflows.

Using Foundry during design helps ensure that the selected model aligns with SQL-based application requirements and can be integrated predictably with relational data.

## Select a model for your solution

Selecting a model is a design decision that affects performance, cost, and maintainability. When choosing a model for use with Azure SQL Database or Fabric SQL database, consider:

- The type and format of data stored in the database  
- Performance and scalability requirements  
- Language or modality requirements  
- Deployment and lifecycle considerations  

Understanding these trade-offs helps ensure that AI capabilities are integrated into SQL database solutions in a way that's predictable, scalable, and aligned with application goals.

## Key takeaways

Models differ in modalities, language support, size, and structured output capabilities, and these differences affect how they integrate with SQL database workloads. RAG retrieves relevant database content and supplies it to a model as context, while tokens determine how input and output text is processed. Embeddings represent data as vectors that enable semantic similarity comparisons. Microsoft Foundry Models provides a catalog for evaluating and selecting models that align with your SQL-based application requirements.
