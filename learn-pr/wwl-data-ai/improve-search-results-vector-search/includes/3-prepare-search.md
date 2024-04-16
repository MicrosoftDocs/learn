You need to encode your  Azure AI Search query by sending it to an embedded model.  The response is then passed to a search engine to complete a search over the vector fields.

In order for your query to work, you need do the following tasks:

## Check your index has vector fields

You check if your search has vector fields by running an empty search, the result includes a vector field with a number array. 

You can also look for a field named **vectorSearch** of with the type **Collection(Edm.single)**.  This has an algorithm configuration and an attribute of 'dimension'.

## Convert a query input into a vector

You can only query a vector field with a query vector. Your end-users provide a text query string, which your application converts into a vector by using the embedding library you used for to create the source document embeddings.
