
An embedding is type of data representation that is used by machine learning models. An embedding represents the semantic meaning of a piece of text. You can visualize an embedding as an array of numbers, and the numerical distance between two embeddings represents their semantic similarity. For example, if two texts are similar, then their representations should also be similar.

## Embedding models

How effective your search results will be is a direct corelation to the effectiveness of your embedded model.

There are models specifically created to perform a specific task well. Use **Similarity** search embeddings to capture the semantic similarity between pieces of text; a **Text** search embedding can look at the relevance of a long document to a short query; use embedding code snippets and natural language search queries using a **Code** search embedding.

Users provide input to a query for an embedding model which is converted from text into a vector using, for example, the text-embedding-ada-002 model to generate text embeddings.

The result will be any documents matching the query that are contained in your search index. The documents, with embeddings containing vector fields, must exist in the search index and the same model must be used for indexing and the query.

## Embedding space

*Embedding space* is the core of vector queries comprising all the vector fields from the same embedding model. It comprises of all the vector fields populated using the same model.

In this embedding space, similar items are located close together, and dissimilar items are located farther apart.

For example, documents that talk about hotels with a water park would be close together in the embedding space. whereas, hotels without this facility would be farther away whilst still being in the neighborhood for hotels. Dissimilar concepts such as restaurants  would be farther away still. In practice, embedding spaces are abstract and don't have well-defined meanings comprehensible be people, but the core idea stays the same.
