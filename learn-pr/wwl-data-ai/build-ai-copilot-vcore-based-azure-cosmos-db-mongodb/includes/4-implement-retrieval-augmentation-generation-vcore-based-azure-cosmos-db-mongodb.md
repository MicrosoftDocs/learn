This unit focuses on implementing Retrieval Augmented Generation (RAG) using vector indexes in vCore-based Azure Cosmos DB for MongoDB, tailored for developers using Python and Node.js. As a vCore-based Azure Cosmos DB for MongoDB developer, you explore how to utilize Azure OpenAI to enhance data retrieval and response generation capabilities within your applications.

## Configure vCore-based Azure Cosmos DB for MongoDB for vector search

The first part of a Retrieval Augmented Generation (RAG) system involves searching your data for similar items based on vector similarity. For this part, you first need to configure your vCore-based Azure Cosmos DB for MongoDB to support vector search. This process involves three main steps:

1. Create vector columns.
1. Generate embeddings from your document's text data and store them in the vector columns.
1. Create vector indexes for these vector columns.

Let's explore each step in more detail.

### Create vector columns

Start by adding vector columns to your vCore-based Azure Cosmos DB for MongoDB documents. These columns are crucial as they store high-dimensional vector data. You populate these vector columns using embeddings generated from your document's text data. Once populated, your vector indexes are then created from these vector columns.

### Generate embeddings

Before you can take advantage of vector indexes, you need to generate embeddings for some of the text fields stored in your database. For example, suppose you have a **products** collection for the *Adventure Works Bike Shop*. You can generate embeddings for the product's **category** and **description** fields. This process allows you to perform vector searches based on the similarity of these field's generated embeddings.

Vector embeddings are numerical representations of the text data, enabling AI systems to perform efficient similarity comparison between documents. For example, an embedding vector generated for your product's *description* might appear like this:

```json
[0.123, 0.234, 0.345, ...]
```

Azure OpenAI can help you generate these embeddings from your text data. You can then store those embeddings in your vector columns. To create your vector column embeddings, you can use the Azure OpenAI's Python or Node.js SDK. Here’s how you can generate your data embeddings using the SDK:

Python

```python
response = AzureOpenAIClient.embeddings.create(
    input=text,
    model=embeddings_deployment)
```

Node.js

```javascript
const response = await AzureOpenAIClient.getEmbeddings(embeddingsDeployment, text);
```

These commands call Azure OpenAI's API to generate numerical embeddings for the given text (for example the product's *category*) using a specified model (for example GPT4). Once you generated the document field's embeddings, you can store it in your vector columns using a MongoDB collection's insert or update command.

### Create vector indexes

Before we can perform vector searches, to get the results we need for our RAG system, we need to create vector indexes on these vector columns. These indexes allow you to perform efficient vector searches to retrieve similar items based on vector similarity. There are two types of vector indexes available in Azure Cosmos DB for MongoDB: *HNSW* (Hierarchical Navigable Small World) and *IVF* (Inverted File) indexes. You can choose the index type based on your application requirements.

For example, to create a vector index using the *HNSW* algorithm, you can use the following MongoDB command:

```javascript
db.command({ 
    "createIndexes": "exampleCollection",
    "indexes": [
        {
            "name": "VectorSearchIndex",
            "key": {
                "contentVector": "cosmosSearch"
            },
            "cosmosSearchOptions": { 
                "kind": "vector-hnsw", 
                "m": 16, 
                "efConstruction": 64, 
                "similarity": "COS", 
                "dimensions": 3
            } 
        } 
    ] 
});
```

You can use a similar command to create a vector index using the *IVF* algorithm. We visit that example in the module's exercise. Once you create the vector indexes, you can now use them to perform similarity searches on your vCore-based Azure Cosmos DB for MongoDB database. Your vCore-based Azure Cosmos DB for MongoDB database is now ready to perform vector searches.

## Perform vector search

Once you created the vector indexes, you can perform vector searches to retrieve similar items based on vector similarity. The search process involves two main steps:

1. **Embed a Query**: Convert a plain language question into a vector using the same embedding functions you used to create the vector column embeddings. For instance, if your input a question like *What type of bikes do you sell?* you would generate the question's embedding using the same Azure OpenAI API function you used before.

1. **Search**: Use the generated embedding (also called a query vector) to search for similar items in the database. The search algorithm compares the query vector with the vector data stored in the database to find the most similar items. To perform a vector search, you can use the following **aggregate** MongoDB command:

```javascript
db.exampleCollection.aggregate([
  {
    "$search": {
        "cosmosSearch": {
            "vector": "queryVector",
            "path": "contentVector",
            "k": 2,
            "efSearch": 40
        },
    }
  }
]);
```

The vector search result returns the most similar items based on the query vector. These results are just an array of your documents with the highest similarity scores. However, you can further enhance the user experience by integrating Azure OpenAI to generate detailed responses based on the search results. This integration is the last step of our Retrieval Augmented Generation (RAG) system. Let's learn how.

## Integrate Azure OpenAI

While the vector search results provide relevant items, you can further enhance the user experience by integrating Azure OpenAI to generate detailed responses based on the search results. Azure OpenAI's advanced AI models can provide context-aware responses that complement the search results.

So what do we need to do to integrate Azure OpenAI with the vector search results? First, let's create a structured prompt that Azure OpenAI can use to generate detailed responses based on the search results. The structured prompt combines the following elements:

- **The original query you used in your vector search** - For example, *What type of bikes do you sell?*
- **User-defined system prompt** - The system prompt provides a clear job description, detailing the tasks the AI is expected to handle, for example, it could define its role as a helper at *Adventure Works Bike Shop*. It outlines how the AI should respond to questions, making sure all answers are relevant and returned in an easy-to-follow format. The system prompt could have the following components:
  - *Job description*: Who is the AI supposed to be, for example, "as a helper at Adventure Works Bike Shop, you're responsible for answering customer queries about the bikes we sell."
  - *Formatting AI Responses*: The prompt tells the AI exactly how to format its answers, like using lists with specific spacing. This formatting keeps the information clear and consistent for users to easily understand.
  - *Limiting AI Interaction responses*: The prompt could include a list of topics the AI should be able to discuss, like bike types, prices, and availability. This list ensures the AI stays on topic and provides relevant information.
  - *Handling Uncertainty*: The prompt lets the AI know how to handle situations where it might not have enough information to provide an answer. The AI could suggest phrases like "I don't know" or encourage users to conduct their own research. This section can help the AI better manage uncertainty situations.
- **The vector search results**: The search results provide the most similar items based on the query vector. Since the results returned are the whole documents themselves, you should choose the most relevant *fields* to include in the prompt, like perhaps the *category* or the *description* of the bike. The AI can use this information to generate detailed responses based on the search results. For example, if the search results return *Mountain Bikes* and *Road Bikes*, the AI can provide detailed information about these types of bikes.

There are many programmatic ways to generate the prompt. The key is to structure it in a way that provides clear instructions to the AI on how to generate responses based on the search results. We visit one such method in the module's exercise.

Once you defined your structured prompt, you can use the following code snippets to generate responses using Azure OpenAI:

Python

```python
response = AzureOpenAICompletionClient.chat.completions.create(
    model=completion_deployment, messages=structuredPrompt)
```

Node.js

```javascript
const response = await AzureOpenAICompletionClient.getChatCompletions(completionDeployment, structuredPrompt);
```

These commands call Azure OpenAI's API to generate detailed responses based on the structured prompt, using a specified model to provide context-aware information that complements the vector search results.

This setup combines vCore-based Azure Cosmos DB for MongoDB's customer data with Azure OpenAI’s AI models through a Retrieval Augmented Generation (RAG) system. By integrating vector search, it allows the AI to pull precise, relevant information from vCore-based Azure Cosmos DB for MongoDB for enhanced responses. This approach significantly improves the quality and relevance of AI-generated responses utilizing your own data.
