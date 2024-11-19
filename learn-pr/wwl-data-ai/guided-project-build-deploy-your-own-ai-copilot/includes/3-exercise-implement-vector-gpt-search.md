In this exercise, you implement and enhance the AI vector search functionality of your application by generating embeddings, performing vector searches, and integrating GPT-3.5 for enriched search results. You update key JavaScript functions to load and vectorize data, create vector indexes, and set up search components. By completing these steps, you can deepen your understanding of embedding generation, vector search techniques, and AI integration within a web application.

> [!IMPORTANT]
> Be sure to complete steps in the previous **Prepare for guided project** unit before beginning this exercise.

## Implement code to generate embeddings and perform a vector search

In this task, you add code that loads data into the database, generates embeddings for the documents, and creates a vector index.

1. Navigate to the file **06-guided-project/node.js/Collections/products.js**

1. Update the **generateProductEmbedding** function with the following code:

    ```js
    // Construct a string representing the product's name and category
    const productName = "Category - " + product["categoryName"] + ", Name -" + product["name"];
    
    // If the productName exists, generate an embedding for it
    if (productName) {
        // The embedding is generated using the Embeddings module's generateEmbeddings function
        // The resulting embedding is stored in the product object under the key "productVector"
        product["productVector"] = await Embeddings.generateEmbeddings(productName, embeddingsDeployment, AzureOpenAIClient);
    }

    // Return the product object with the added embedding
    return product;
    ```

    Be sure to save your changes to the file. This function selects fields to generate embeddings for, calls Azure OpenAI to generate these embeddings, and stores them in a vector column in the database.

1. Navigate to the file **./node.js/SearchComponents/embeddings.js**

1. Update the **generateEmbeddings** function with the following code:

    ```js
    // Generate embeddings from string of text.
    // This will be used to vectorize data and user input for interactions with Azure OpenAI.
    // Use the async-retry module to attempt the following code block
    // If an error occurs, it will retry up to 10 times, with an increasing timeout between each attempt
    return await retry(async bail => {
        try {
            // Call the Azure OpenAI Client's getEmbeddings function with the embeddings deployment and text
            // Await the response and store it in the response variable
            const response = await AzureOpenAIClient.embeddings.create({ input: text, model: embeddingsDeployment });

            // Extract the embeddings from the response data
            const embeddings = response.data[0].embedding;
            // Wait for 10 milliseconds to avoid rate limiting (change to 500 on AOAI for free tier)
            await new Promise(resolve => setTimeout(resolve, 10));
            // Return the embeddings
            return embeddings;
        } catch (err) {
            // If a 429 error (Too Many Requests) is received, rethrow the error to trigger a retry
            if (err.response && err.response.status === 429) {
                throw err;
            } else {
                // For any other error, stop retrying and throw the error
                bail(err);
            }
        }
    }, {
        retries: 10, // Maximum number of retries
        minTimeout: 1000, // Minimum timeout between retries (1 second)
        factor: 2, // Factor by which the timeout increases each time
        maxTimeout: 20000 // Maximum timeout between retries (20 seconds)
    });
    ```

    This function uses the Azure OpenAI embeddings function to generate embeddings for any given string. These embeddings are sent back to be stored in your vector columns or used in your vector searches.

    The process of generating embeddings for the MongoDB documents using Azure OpenAI, sets the stage for RAG by optimizing the data for both retrieval and generative analysis.

1. Navigate to the file **./node.js/Blobs/loadAndVectorize.js**

1. Locate the **loadAndVectorizeLocalBlobDataToMongoDBCluster** function. 

    This function has multiple purposes. It loops through all the local data files, extract their documents, if needed calls a function to create embeddings on those documents, and saves the documents to the database.

1. Add the following code to the end of the function:

    ```js
    // Create the vector indexes for the collection
    if (processCustomersVector && collectionName === "customers") {
        indexList = [
            ["customerTypeVectorSearchIndex", "customerTypeVector"],
            ["customerTitleVectorSearchIndex", "customerTitleVector"],
            ["customerNameVectorSearchIndex", "customerNameVector"],
            ["customerEmailAddressVectorSearchIndex", "customerEmailAddressVector"],
            ["customerPhoneNumberVectorSearchIndex", "customerPhoneNumberVector"],
            ["customerAddressesVectorSearchIndex", "customerAddressesVector"]
        ];
        await Indexes.createVectorIndexes(collection, indexList, db, collectionName);
    } else if (processProductsVector && collectionName === "products") {
        indexList = [
            ["productVectorSearchIndex", "productVector"]
        ];
        await Indexes.createVectorIndexes(collection, indexList, db, collectionName);
    } else if (processSalesOrdersVector && collectionName === "salesOrders") {
        indexList = [
            ["salesOrderDetailVectorSearchIndex", "salesOrderDetailVector"]
        ];
        await Indexes.createVectorIndexes(collection, indexList, db, collectionName);
    }
    ```

    Now you create the vector indexes for the collection based on the vector columns. In this code, you choose which vector columns and index names need to be created. Be sure to save your changes to the file.

1. Navigate to the file **./node.js/SearchComponents/indexes.js**

    Now that you know what vector columns and vector index names you want to create, let's update the function that creates the indexes themselves. There are two types of vector indexes that can be created, IVF (Inverted File index), and HNSW (Hierarchical Navigable Small World index). In this exercise, you create IVF indexes.

1. Update the **createVectorIndexes** function with the following code:

    ```js
    // Get the current indexes in the collection
    const collectionIndexes = await collection.indexInformation();

    // Iterate over each index in the indexList
    for (let [indexName, vectorColumn] of indexList) {
        // Iterate over each index in the collection
        for (let index of Object.keys(collectionIndexes)) {
            // If the index already exists in the collection, drop it
            if (index === indexName) {
                await collection.dropIndex(indexName);
                break;
            }
        }

        // Create a new IVF index in the collection
        // The index is created using the MongoDB command function
        // The command specifies the collection to create the index in, the name of the index, 
        // the key to index on, and the options for the CosmosDB search
        const commandResult = await db.command({
            'createIndexes': collectionName,
            'indexes': [
                {
                    'name': indexName,
                    'key': {
                        [vectorColumn]: "cosmosSearch"
                    },
                    'cosmosSearchOptions': {
                        'kind': 'vector-ivf',
                        'numLists': 1,
                        'similarity': 'COS',
                        'dimensions': 1536
                    }
                }
            ]
        });
    }
    ```

    Save your changes to the file. This function first drops the index if it already exists, then creates a new IVF index in the collection based on the vector column and index name provided. It creates the index using the MongoDB command function.

    Now you can perform vector searches using the generated embeddings and vector indexes. Later, you enhance the vector search results with GPT-3.5.

1. Navigate to the **./node.js/SearchComponents/searches.js** file.

    Since you created a vector index on the products' collection, let's prepare your vector search specifically for that collection.

1. Update the **runVectorSearch** function with the following code:

    ```js
    // Define the maximum number of results, the vector column, and the collection name
    const maxResults = 20;
    const vectorColumn = "productVector";
    const collectionName = "products";

    // Connect to the database and get the collection
    const db = client.db(cosmosDbMongodbDatabase);
    const collection = db.collection(collectionName);
    
    // Run the vector search and return the results
    let resultArray = [];
    const results = await VectorSearch.vectorSearch(userInput, vectorColumn, collection, embeddingsDeployment, AzureOpenAIClient, maxResults);
    for (let result of results) {
        resultArray.push(`Similarity Score: ${result.similarityScore}, category: ${result.document.categoryName}, Product: ${result.document.name}`);
    }
    return resultArray;
    ```

    Remember to save your changes. This function uses the prompt from the user input and calls a function to generate embeddings of that prompt and search the vector index for similar documents. It then displays the results to the console including a similarity score.

1. Navigate to the file **./node.js/SearchComponents/vectorSearch.js**

    Next you update the function that performs the vector search.

1. Update the **vectorSearch** function with the following code:

    ```js
    // Generate embeddings for the query using the Embeddings module
    const queryEmbedding = await Embeddings.generateEmbeddings(query, embeddingsDeployment, AzureOpenAIClient);
    
    // Define the aggregation pipeline for the MongoDB query
    // The pipeline first performs a search using the generated embeddings and the specified vector column
    // It then projects the results to include the similarity score and the original document
    const pipeline = [
        {
            '$search': {
                "cosmosSearch": {
                    "vector": queryEmbedding,
                    "path": vectorColumn,
                    "k": numResults
                },
                "returnStoredSource": true
            }
        },
        { '$project': { 'similarityScore': { '$meta': 'searchScore' }, 'document': '$$ROOT' } }
    ];
    
    // Execute the aggregation pipeline on the collection and convert the results to an array
    const results = await collection.aggregate(pipeline).toArray();
    // Return the results
    return results;
    ```

    This function performs a vector search by generating embeddings for a user query, allowing it to find similar documents in the database. It first creates a query embedding using the `generateEmbeddings` function, which turns the query text into a vector. Next, it defines a MongoDB aggregation pipeline that uses the query embedding to find matching documents in the specified vector column, sorting by similarity. Finally, it returns the results, including each document and its similarity score, based on how closely it matches the query.

## Integrate GPT-3.5 for enhanced search results

Vector search results can be powerful, but they might require extra coding to fully interpret and utilize the results. In this task, you integrate GPT-3 to provide more detailed, human-readable insights from the vector search results.

1. Navigate to the file **./node.js/SearchComponents/searches.js**

1. Update the **runGPTSearch** function with the following code:

    ```js
    // Define the maximum number of results, the vector column, and the collection name
    const maxResults = 20;
    const vectorColumn = "productVector";
    const collectionName = "products";

    // Connect to the database and get the collection
    const db = client.db(cosmosDbMongodbDatabase);
    const collection = db.collection(collectionName);

    // Run the vector search
    const resultsForPrompt = await VectorSearch.vectorSearch(userInput, vectorColumn, collection, embeddingsDeployment, AzureOpenAIClient, maxResults);

    // Generate completions based on the vector search results
    const completionsResults = await Completion.generateCompletion(resultsForPrompt, completionDeployment, AzureOpenAIClient, userInput);
    return completionsResults.choices[0].message.content;
    ```

    Be sure to save your changes. Like the runVectorSearch function, this function asks you for your prompt to run against the vector index. After obtaining vector search results, another function processes those results with GPT-3.5 to generate more detailed, human-readable insights.

1. Navigate to the file **./node.js/SearchComponents/completion.j**

    Using GPT-3.5 to enhance search results brings our RAG process full circle. It turns basic data searches into detailed, interactive conversations, demonstrating the power of combining database technology with AI.

1. Update the **generateCompletion** function with the following code

    ```js
    // Define the system prompt that sets the context for the AI
    const systemPrompt = `
    You are an intelligent assistant for the Adventure Works Bike Shop.
    You are designed to provide helpful answers to user questions about the store inventory given the information about to be provided.
        - Only answer questions related to the information provided below, provide 3 clear suggestions in a list format.
        - Write two lines of whitespace between each answer in the list.
        - Only provide answers that have products that are part of the Adventure Works Bike Shop.
        - If you're unsure of an answer, you can say "I don't know" or "I'm not sure" and recommend users search themselves.
    `;
    
    // Initialize the messages array with the system prompt and user input
    let messages = [
        {role: "system", content: systemPrompt},
        {role: "user", content: userInput},
    ];
    
    // Add each item from the prompt to the messages array
    for (let item of prompt) {
        messages.push({role: "system", content: `${item.document.categoryName} ${item.document.name}`});
    }
    
    // Call the Azure OpenAI Completion Client's getChatCompletions function with the completion deployment and messages
    // Await the response and store it in the response variable
    const response = await AzureOpenAICompletionClient.chat.completions.create({ messages: messages, model: completionDeployment });
    
    // Return the response
    return response;
    ```

    This function has three sets of prompts. The first is a system prompt (**systemPrompt**) that sets the context for the AI, or in other words, who is the AI supposed to be, and what parameters/rules it should follow. The second is the user's input (**userInput**), which is the question or prompt we asked. The third is an array of results from the vector search (**prompt**) on that same previous question or prompt we asked. It then calls the Azure OpenAI Chat Completions function to generate completions based on those prompts.

Moving from conducting vector searches to improving results with GPT-3.5 chat highlights the RAG method, seamlessly integrating precise data search with AI-driven conversational insights.