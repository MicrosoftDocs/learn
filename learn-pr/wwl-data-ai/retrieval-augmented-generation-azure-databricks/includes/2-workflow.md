**Retrieval Augmented Generation (RAG)** is a technique that makes large language models more effective by connecting them to your own custom data. The RAG workflow follows a simple four-step process, as shown in the diagram: 

:::image type="content" source="../media/retrieval-augmented-retrieval.png" alt-text="Diagram of retrieval augmented generation workflow.":::

1. **User Query**: A user asks a question that the base LLM alone can't answer accurately because it doesn't have access to your specific documents, recent information, or proprietary data.

2. **Search Your Database**: The system searches through your own document collection (company policies, reports, manuals, databases) - not the LLM's training data. Your documents were previously converted into embeddings and stored in a vector database. The system finds the most relevant information from your specific documents.

3. **Add Context to Prompt**: The relevant information retrieved from your documents is combined with the user's original question to create an enhanced prompt that provides the LLM with the specific context it needs.

4. **LLM Generates Response**: The base language model processes both the original question and the retrieved context from your documents to generate an accurate, grounded response based on your specific data.

This process bridges the gap between a general-purpose LLM and your specific, private, or recent information, allowing you to get accurate answers based on your own documents without having to retrain the entire base model.

Let's look at when you can use RAG, and then review the main components and concepts in a RAG workflow.

## Understand when to use RAG

You can use RAG for chatbots, search enhancement, and content creation and summarization.

**Chatbots**: RAG helps chatbots provide more accurate answers by accessing current information. When integrated with customer support systems, RAG-powered chatbots can automate support and quickly resolve customer questions using up-to-date data.

**Search enhancement**: Instead of returning just links and snippets, RAG-powered search engines provide complete, conversational answers. Users get comprehensive responses that synthesize information from multiple sources, making it easy to find what they need.

**Content creation and summarization**: Produce high-quality, fact-based content using your own data sources. RAG enables you to generate informed articles, create summaries from lengthy documents, and develop reports that synthesize information from multiple sources.

## Explore the main concepts in a RAG workflow

The RAG workflow is built on four essential components that work together:

1. **Embeddings** - Convert text into mathematical vectors that capture meaning
2. **Vector databases** - Store and organize these vectors for fast searching
3. **Search and retrieval** - Find the most relevant information based on user queries
4. **Prompt augmentation** - Combine retrieved information with the original question

Think of these components as building blocks: embeddings translate everything into a common language, vector databases organize this information, search and retrieval find what's needed, and prompt augmentation puts it all together for the AI to use.

### Convert your documents and queries with embeddings

Before a RAG system can find relevant information, it needs to convert all text from both your documents and user queries into a format that allows for semantic comparison. This is where embeddings come in.

An embedding model is a specialized AI tool that converts text into numerical vectors (lists of numbers) that represent the meaning of the text. Think of it as a translator that turns works and sentences into a mathematical language that computers can understand and compare.

Document embedding, as shown in the diagram, is part of a preparation phase. This is done once to set up a knowledge base. Before your RAG system can work, you need to prepare your documents. An embedding model takes all your text documents and transforms them into mathematical vectors called embeddings, that capture their semantic meaning. This preprocessing step creates a searchable knowledge base. 

:::image type="content" source="../media/document-embedding.png" alt-text="Diagram of embeddings model converting documents to vectors.":::

Query embedding, shown in the diagram, happens each time a user asks a question. First, the user's question is converted into an embedding using the same embedding model that was used to process the documents. This real-time conversion prepares the query for comparison against your preprocessed document embeddings. Only after the query is embedded can the system begin searching for relevant documents.

:::image type="content" source="../media/query-embedding.png" alt-text="Diagram of embeddings model.":::

Think of document embedding as building your searchable library, and query embedding as translating each question into the same format so you can find the right books in that library. The search only begins **after** the question has been translated.

### Store and search your embeddings with a vector store

Once you've converted your documents into embeddings, you need somewhere to store them that allows for fast semantic search. A regular database would struggle with this because it can't efficiently compare the mathematical similarity between vectors.

A vector store is a specialized database designed specifically for storing and searching through embeddings (those mathematical vectors created from your documents). Unlike traditional databases that store text or numbers, vector stores are optimized for finding similar vectors quickly, even when dealing with millions of documents.  

You can implement vector storage through **vector databases**, **vector libraries**, or **database plugins**.

The vector store enables semantic search, which means it finds relevant content based on meaning rather than exact keyword matches. For example, searching for 'time off' would find documents about 'vacation policies' even though the exact words don't match.  When you search, you can apply **filters** pre-, in-, or post-query.

### Augment your prompt with retrieved content

After finding the most relevant documents, the RAG system combines this information with the user's original question to create an "augmented prompt" that gives the LLM everything it needs to provide an accurate answer.

The augmentation process looks like this:

- Start with the user's question: "What's our vacation policy?"
- Add retrieved context: Include relevant excerpts from your HR documents
- Create augmented prompt: "Based on these HR policy documents: [retrieved content], what's our vacation policy?"
The LLM now has both the user's question **and** the specific information needed to answer it accurately. This is called "in-context learning" because the LLM learns from the context provided in the prompt rather than from its original training data.

In the final step, the augmented prompt is sent to the Large Language Model (LLM), which generates a response based on both the question and the retrieved information. The LLM can include citations of the original sources, allowing users to verify where the information came from.

The key benefit of the RAG workflows is that it gives you accurate, source-backed answers without having to retrain the entire language model on your specific documents.

## RAG architecture overview
The complete RAG workflow combines all the components we've reviewed into a unified system that transforms general-purpose LLMs into knowledgeable assistants for your specific domain.

The key mechanism is **in-context learning** - instead of retraining the LLM, you provide relevant information as context in each prompt, allowing the LLM to generate informed responses without permanent modification.

Advanced implementations might include feedback loops to refine results when the initial response doesn't meet quality thresholds.