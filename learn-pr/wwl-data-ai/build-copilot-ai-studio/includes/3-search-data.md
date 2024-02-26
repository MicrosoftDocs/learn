When you want create a copilot that uses your own data to generate accurate answers, you need to be able to search your data efficiently. When you build a copilot with the Azure AI Studio, you can use the integration with **Azure AI Search** to retrieve the relevant context in your chat flow.

Azure AI Search is a **retriever** that you can include when building a language model application with prompt flow. Azure AI Search allows you to bring your own data, index your data, and query the index to retrieve any information you need.

### Create a search index

In Azure AI Search, a **search index** is how your content is organized to make it searchable. Imagine a library containing many books. You want to be able to search through the library and retrieve the relevant book easily and efficiently. To make the library searchable, you create a catalog that contains any relevant data about books to make any book easy to find. A library’s catalog serves as the search index.

Though there are different approaches to creating an index, the integration of Azure AI Search in the Azure AI Studio makes it easy for you to create an index that is suitable for language models. You can add your data to the Azure AI Studio, after which you can use Azure AI Search to create an index in the Azure AI Studio using an embedding model. The index asset is stored in Azure AI Search and queried by the Azure AI Studio when used in a chat flow.

:::image type="content" source="../media/create-index.png" alt-text="Screenshot of creating an index in the Azure AI Studio.":::

How you configure your search index may depend on the data you have and the context you want your language model to use. For example, **keyword search** enables you to retrieve information that exactly matches the search query. **Semantic search** already takes it one step further by retrieving information that matches the meaning of the query instead of the exact keyword, using semantic models. Currently, the most advanced technique is **vector search**, which creates embeddings to represent your data.

> [!Tip]
> Learn more about [vector search](https://learn.microsoft.com/azure/search/vector-search-overview?azure-portal=true).

### Understand embeddings

An **embedding** is a special format of data representation that a search engine can use to easily find the relevant information. More specifically, an embedding is a vector of floating-point numbers.

When your data is represented with embeddings, you can use the distance between two embeddings in a vector space to quantify the semantic similarity between two inputs in the original format. In other words, embeddings allow you to represent words and their meanings in such a way that matches can be found even when your data includes different formats (text or image) and languages.

When you want to be able to use vector search to search your data, you need to create embeddings when creating your search index. To create embeddings for your search index, you can use an Azure OpenAI embedding model available in the Azure AI Studio.

> [!Tip]
> Learn more about [embeddings in the Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/concepts/understand-embeddings?azure-portal=true).

### Understand hybrid search

When you create search index in the Azure AI Studio, it’s assumed that the index will be used in combination with a language model. When your search results are used in generative AI application, hybrid search will give the most accurate results.

Hybrid search is a combination of keyword (and full text), and vector search, to which semantic ranking is added. When you create an index that is compatible with hybrid search, the retrieved information is precise when exact matches are available, and still relevant when only conceptually similar information can be found.

> [!Tip]
> Learn more about [hybrid search](https://learn.microsoft.com/azure/search/hybrid-search-overview?azure-portal=true).

After uploading data to the Azure AI Studio and creating an index on your data using the integration with Azure AI Search, you can add RAG to your chat by designing the copilot with prompt flow.
