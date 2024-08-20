
**Retrieval Augmented Generation** (**RAG**) is a pattern that can improve the efficacy of **Large Language Model** (**LLM**) applications by using your own custom data.

In a RAG pattern, you receive a query (1), which you use to search (2) your database for any data or documents that are relevant to the question or task. The retrieved context is then added to the prompt (3) that you send to an LLM (4) to improve the generated response.

:::image type="content" source="../media/retrieval-augmented-retrieval.png" alt-text="Diagram of retrieval augmented generation workflow.":::

> [!Tip]
> To learn more about the technique behind RAG, you can read the academic paper from [Lewis et al. (2020)](https://arxiv.org/abs/2005.11401?azure-portal=true) by selecting **View PDF**.

The main problem that RAG solves is the **knowledge gap**. RAG makes responses more accurate and relevant.

First, let's look at when you can use RAG, and then we go over the main components and concepts in a RAG workflow.

## Understand when to use RAG

You can use RAG for chatbots, search augmentation, and content creation and summarization.

You can incorporate LLMs with RAG in chatbots to automatically derive more accurate answers. When you integrate a chatbot with your customer support solution, you can automate support. You can also integrate a chatbot with your website to answer customer questions and resolve issues quickly.

When you create your own search engine, you can make it easier for your users to find the information you need. By integrating LLMs and RAG in your search engine, you can retrieve relevant information and return that information through an LLM-generated answer.

Finally, you can facilitate the development of high-quality articles, reports, and summaries using relevant context. For example, you can generate news articles or summarize lengthy reports to make it more accessible for your readers.

## Explore the main concepts of a RAG workflow

To create a RAG-based application, you need to use embeddings, vector databases, search, and retrieval.

### Convert your documents and queries with embeddings

Firstly, you need an **embedding model** to create **vector representations** of your *documents*:

:::image type="content" source="../media/document-embedding.png" alt-text="Diagram of embeddings model converting documents to vectors.":::

And you use an embedding model to convert your *user queries* to embeddings:

:::image type="content" source="../media/query-embedding.png" alt-text="Diagram of embeddings model.":::

The embedding model transforms your documents and user questions into high-dimensional vectors, or embeddings. An embedding captures the semantic essence and allows you to find relevant information by searching for embeddings that are semantically similar.

### Store and search your embeddings with a vector store

When you work with embeddings, you can store them in a **vector store**. A vector store is specialized in storing unstructured data indexed by vectors. You can store vectors with a **vector database**, **library**, or **plugin**.

You can search stored vectors by using **similarity search** to efficiently retrieve relevant information. You can select or rank the retrieved documents before passing the information as context. When you search, you can apply **filters** pre-, in-, or post-query.

### Augment your prompt for in-context learning

The retrieved and filtered information are then used to **augment** your **prompt**. Through prompt engineering, you enhance the context provided in the prompt via injection of the data from the vector store.

Finally, you send the augmented prompt to a Large Language Model (LLM) to generate a response for the user's request. The output can include citations of the original sources, so that the user can verify the information provided.

## Explore a sample architecture

Altogether, a RAG pattern can be visualized with the following sample architecture:

:::image type="content" source="../media/sample-architecture.png" alt-text="Diagram of a sample architecture of a RAG pattern." lightbox="../media/sample-architecture.png":::

In this architecture, the following happens:

- **Document embedding**: An embeddings model converts documents to embeddings. The generated embeddings are stored in a vector store.
- **User prompt**: The user query or prompt that serves as foundation for what RAG system aims to retrieve.
- **Query embedding**: The user’s prompt is transformed into an embedding.
- **Information retrieval**: Using the prompt’s vector representation, RAG queries the vector store.
- **Context augmentation**: The most relevant pieces of information are retrieved and concatenated to the initial prompt. This enriched context provides the LLM with relevant information, which can be used to generate a more informed response.
- **Response generation**: With the augmented context, the language model processes the combined data (original prompt and retrieved information) and generates a contextually relevant response.

Some RAG implementations might include a multi-hop **feedback** mechanism. In cases where the response is deemed unsatisfactory, the system can revisit its search criteria, tweak the context, or even refine its retrieval strategy, to then generate a new answer.
