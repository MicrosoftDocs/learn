Before you implement Retrieval Augmented Generation (RAG), you need to prepare your data properly. This involves three essential steps: storing your data securely with proper governance, breaking documents into appropriately sized chunks for processing, and converting everything into a searchable format that the system can quickly access when needed.

Proper data preparation ensures that your RAG system functions effectively and your Large Language Model (LLM) delivers accurate results. When data is prepared improperly, some potential issues are: 

- **Poor quality responses**: If your data is inaccurate, incomplete, or biased, the RAG system will produce misleading or incorrect responses because it can only work with the information you provide.

- **Missing relevant information**: Poorly structured data makes it difficult for the system to find the right content when users ask questions, leading to incomplete, or irrelevant answers.

- **Security and privacy risks**: Without proper data governance, sensitive information might be exposed during the retrieval process, creating compliance and security issues.

- **Ineffective search**: Using the wrong embedding model or chunking strategy decreases the quality of semantic search, making it harder to find relevant information.

- **"Lost in the middle" problem**: In long contexts, LLMs tend to overlook documents placed in the middle, so how you organize and present information matters for accuracy.

The good news is that proper data preparation solves these problems and sets up your RAG system for success. Let's explore how to do this effectively.

## Explore the data preparation process

There are various approaches to preparing data for RAG. This module covers a methodology that works with Azure Databricks.

The diagram illustrates this workflow:
1. Data storage and governance establishes the foundation with secure data storage and proper access controls.
2. Data extraction and chunking transforms large documents into smaller, manageable pieces that are optimized for processing and search.
3. Embedding your data converts these text chunks into numerical representations that enable semantic search capabilities.

:::image type="content" source="../media/data-prep-process.png" alt-text="Diagram of the data prep process overview." lightbox="../media/data-prep-process.png":::

Let's explore each of these components in more detail.

### Store and govern your data storage

Before you can search your data, you need to store it securely and control who can access it. This foundational step ensures your RAG system only retrieves authorized data when responding to user queries, maintaining security and compliance.

To store data, you can use **Delta Lake**, which is a unified data management layer. It's the optimized storage layer that provides the foundation for storing data and tables in Azure Databricks.

You can use Delta Lake together with **Unity Catalog**, which provides a unified governance solution for all your data and AI assets, including tables, files, notebooks, and models.

When used together, Unity Catalog and Delta Lake create a robust data management framework. Unity Catalog governs the data stored in Delta Lake, ensuring that access controls and metadata are consistently applied.

### Break data into chunks

**Chunking** is the process of ingesting text documents and breaking large documents into smaller, manageable pieces that can be processed individually. This step is necessary because language models have token limits—they can only process a limited amount of text at once. When someone asks a question, your RAG system retrieves relevant chunks and includes them in the prompt sent to the language model. If your chunks are too large, you'll exceed the model's token limit and won't be able to include all the relevant information.

Language models work with tokens—basic units of text that can be words, parts of words, or punctuation. Different models have different token limits: some handle 4,000 tokens, others can process 128,000 tokens or more. The token limit includes everything in your prompt: the user's question, the retrieved chunks, and any instructions for the model.

Without proper chunking, you face two main problems, exceeding token limits or reduced precision. Large documents might exceed token limits the model can process, causing errors or truncation. Even if a document contains the right answer, if it's buried in lots of unrelated text, the model might struggle to find and use it effectively, reducing precision.

You can chunk your data using two main strategies:

- **Context-aware chunking**: Divide documents based on their natural structure, such as sentences, paragraphs, or sections. This preserves the logical flow of information but creates variable-sized chunks. You can also include metadata like titles or section headers to provide more context.

- **Fixed-size chunking**: Divide documents into chunks of a predetermined size (for example, 500 tokens each). This approach is simple and computationally efficient, but might split content at awkward places.

To find the optimal chunking strategy, experiment with different approaches and chunk sizes.

### Common chunking strategies

Here are practical approaches you can experiment with.

- **Sentence-based chunks**: Each chunk contains one or a few sentences. This creates focused embeddings that capture specific meanings, making them effective for precise question-answering. The diagram shows how a document is divided at sentence boundaries, creating small, focused chunks that each contain a complete thought or idea. 
    :::image type="content" source="../media/chunk-sentence.png" alt-text="Diagram showing a chunk representing a sentence.":::
- **Paragraph-based chunks**: Each chunk contains multiple paragraphs or sections. This captures broader themes and provides more context, which works well for complex questions requiring comprehensive explanations. The diagram illustrates how larger sections of text are kept together, preserving the logical flow and complete context of related ideas within each chunk. 
    :::image type="content" source="../media/chunk-paragraph.png" alt-text="Diagram showing a chunk representing a paragraph.":::
- **Overlapping chunks**: Adjacent chunks share some content (typically 10-20% overlap). This ensures that information spanning chunk boundaries isn't lost, though it does create some redundancy in your data. The diagram demonstrates how consecutive chunks share common text at their boundaries, ensuring that important information that might span multiple chunks isn't accidentally separated.
    :::image type="content" source="../media/chunk-overlap.png" alt-text="Diagram showing overlapping chunks.":::
- **Windowed summarization**: Each chunk includes a summary of previous chunks, providing more context. This advanced technique can improve coherence across related chunks. The diagram shows how each new chunk contains not only its own content but also a condensed summary of what came before, creating a rolling context window that helps maintain continuity across the entire document.
    :::image type="content" source="../media/chunk-window.png" alt-text="Diagram showing windowed summarization.":::

Your chunking strategy should reflect how users will interact with your system. 

Smaller chunks work well for short, specific questions because they provide focused, precise answers. Larger chunks that preserve complete explanations and context are often more effective for complex, detailed questions. Consider using overlapping chunks or multiple chunk sizes to handle a mix of specific and detailed questions. The key is to experiment with different approaches, and measure which produces the best results for your specific use case and user patterns.

### Embed your data
After chunking your data, you need to convert your text chunks into **embeddings**—numerical representations that computers can understand and compare. Embeddings are a way to translate human language into mathematical coordinates that capture the meaning and relationships between different pieces of text.

When you create embeddings, text chunks and user queries are converted into vectors. Similarity search finds the chunks whose vectors are closest to the query vector. Then relevant chunks are retrieved and send to the language model for response generation

There are various embedding models available, each with different strengths. To choose the best model for your application, consider:

- **Data and text properties**: Match the model to your content type. Some models work better with technical documents, others with conversational text. Consider your vocabulary size, domain-specific terms, and typical text length.

- **Model capabilities**: Evaluate whether you need support for multiple languages, different content types (text, images, etc.), or specific embedding dimensions. Larger models often provide better quality but require more computational resources.

- **Practical considerations**: Consider factors like privacy requirements, cost, and licensing. Also be aware of context window limitations—many models ignore text beyond their maximum input length, which could affect embedding quality for longer chunks.

Test different models on your queries and documents and measure which produces the best retrieval results for your specific use case.
