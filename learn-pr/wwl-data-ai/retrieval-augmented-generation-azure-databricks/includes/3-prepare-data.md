Before you implement Retrieval Augmented Generation (RAG), it's important to prepare your data. Proper data preparation ensures that your RAG system functions effectively and your Large Language Model (LLM) delivers accurate results. When data is prepared improperly, some potential issues are:

- **Poor quality model output**: If data is inaccurate, incomplete, or biased, the RAG system is more likely to produce misleading or incorrect responses.
- **"Lost in the middle"**: In long context, LLMs tend to overlook the documents placed in the middle. [Explore the research paper on how language models use long context](https://arxiv.org/pdf/2307.03172?azure-portal=true).
- **Inefficient retrieval**: Poorly prepared data would decrease the accuracy and precision of retrieving relevant information from knowledge base.
- **Exposing data**: Poor data governance could lead to exposing data during the retrieval process.
- **Wrong embedding model**: Wrong embedding model would decrease the quality of embeddings and retrieval accuracy.

## Explore the data prep process

A simple data prep process with Azure Databricks consists **data storage and governance** (1), **data extraction and chunking** (2), and **embedding your data** (3).

:::image type="content" source="../media/data-prep-process.png" alt-text="Diagram of the data prep process overview." lightbox="../media/data-prep-process.png":::

Let's explore each of these components in more detail.

### Store and govern your data storage

To store data, you can use **Delta Lake**, which is a unified data management layer. It's the optimized storage layer that provides the foundation for storing data and tables in Azure Databricks.

You can use Delta Lake together with **Unity Catalog**, which provides a unified governance solution for all your data and AI assets, including tables, files, notebooks, and models.

When used together, Unity Catalog and Delta Lake create a robust data management framework. Unity Catalog governs the data stored in Delta Lake, ensuring that access controls and metadata are consistently applied.

### Extract and chunk your data

When you **chunk** your data, you ingest text documents, split the documents up in chunks, and embed the chunks to make them searchable. How you chunk your data depends on your use case.

For example, you need to consider the relationship between the amount of context you want to provide to the prompt and how much context can fit into the model's token limit.

You can chunk your data in two ways:

- **Context-aware**: Divide by sentence, paragraph, or section by using special punctuation. You can also include metadata, tags, or titles.
- **Fixed-size**: Divide by a specific number of tokens. This approach is simple and computationally cheap.

To find the most optimal chunking strategy, you need to experiment with different chunk sizes and approaches.

Some chunking approaches you can experiment with are:

- **One chunk consists of one sentence**: Embeddings focus on a specific meaning.
    :::image type="content" source="../media/chunk-sentence.png" alt-text="Diagram showing a chunk representing a sentence.":::
- **One chunk includes multiple paragraphs**: Embeddings tend to capture a broader theme. For example, you can achieve the latter by splitting a document by headers.
    :::image type="content" source="../media/chunk-paragraph.png" alt-text="Diagram showing a chunk representing a paragraph.":::
- **Chunks overlap**: To ensure no contextual information is lost between chunks, you can define the amount of overlap between consecutive chunks.
    :::image type="content" source="../media/chunk-overlap.png" alt-text="Diagram showing overlapping chunks.":::
- **Windowed summarization**: Method where each chunk includes a windowed summary of previous chunks.
    :::image type="content" source="../media/chunk-window.png" alt-text="Diagram showing windowed summarization.":::

When you experiment with different chunk sizes and approaches, it also helps to know the user's query patterns. When your end-users tend to have long queries, the queries tend to have better aligned embeddings to the returned chunks, while shorter queries can be more precise.

### Embed your data

To create numerical representations of your content, you can generate **embeddings**.

There are various embedding models you can use to represent your words with vectors. To choose the most optimal model for your application, you can consider:

- **Data and text properties** like the vocabulary size, domain, and text length.
- **Model capabilities** like whether a model supports multiple languages or modalities, and the supported embedding dimensions and size.
- **Practical considerations** like privacy, cost, and licensing. Also be aware of the context window limitations as many models ignore text beyond their context window limit.

The recommended approach is to benchmark multiple models on both your queries and documents, and to choose the one that strikes the best balance.
