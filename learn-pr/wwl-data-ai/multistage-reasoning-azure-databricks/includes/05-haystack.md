**Haystack** is an open-source framework designed for multi-stage reasoning systems that include document retrieval, text generation, and summarization.

Developed by deepset, Haystack provides a modular and flexible architecture that allows you to create pipelines tailored to your specific use case.

## Explore the main components of Haystack

When you build a multi-reasoning system with Haystack, you need to be familiar with the main components:

:::image type="content" source="../media/haystack-overview.png" alt-text="Diagram of the main components of a Haystack architecture." lightbox="../media/haystack-overview.png":::

1. **Pipelines**: A directed multigraph of components.
1. **Generators**: An interface to generate text based on a prompt.
1. **Retriever**: A component that retrieves relevant documents for a query.
1. **Document stores**: A database for your documents.

Let's explore each of these components in more detail.

### Build your AI system with pipelines

**Pipelines** in Haystack are the orchestrating layers that connect the different components, like retrievers and generators, into a coherent workflow.

Pipelines define how queries are processed and how the results are generated and returned to the user. Pipelines can be simple, using just a retriever and a Large Language Model (LLM) to generate a response. Alternatively, they can be more complex, integrating multiple components.

> [!Tip]
> Learn more about [Haystack pipelines](https://docs.haystack.deepset.ai/docs/pipelines?azure-portal=true) and how to define tasks as [components](https://docs.haystack.deepset.ai/docs/components?azure-portal=true).

### Interact with LLMs through generators

**Generators** in Haystack are components responsible for using LLMs to generate responses based on input queries. You can configure generators to interact with both open-source models and privately hosted model, giving you the flexibility and control over how your data is processed.

> [!Tip]
> Explore the available [generators](https://docs.haystack.deepset.ai/docs/generators?azure-portal=true) and how to [choose the right generator](https://docs.haystack.deepset.ai/docs/choosing-the-right-generator?azure-portal=true).

### Find relevant documents with retrievers

Retrievers in Haystack are designed to identify and extract relevant documents or passages from a large corpus based on a given query.

Retrievers can be categorized into two main types:

- **Sparse** retrievers, which rely on traditional *keyword-based* methods like TF-IDF (Term Frequency-Inverse Document Frequency).
- **Dense** retrievers, which use *vector embeddings* to capture semantic similarities.

The efficiency and accuracy of retrievers in filtering out irrelevant information are key to the overall performance of your multi-stage reasoning system.

> [!Tip]
> Learn more about [retrievers](https://docs.haystack.deepset.ai/docs/retrievers?azure-portal=true).

### Store your data in document stores

**Document stores** in Haystack serve as the backbone for storing, indexing, and managing the data that the retrievers and generators interact with.

These stores can handle various types of data, including text documents, tables, and structured records.

The document store not only holds the raw data but also manages metadata and embeddings, ensuring that the system can efficiently retrieve and process information.

Haystack offers different types of document stores, so you can choose the vector database that best fits your needs.

> [!Tip]
> Learn more about [document stores](https://docs.haystack.deepset.ai/docs/document-store?azure-portal=true) and how to [choose a document store](https://docs.haystack.deepset.ai/docs/choosing-a-document-store?azure-portal=true).
