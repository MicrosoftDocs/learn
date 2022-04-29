Applications that use graph databases primarily use them to query data.

Suppose you have built your graph database in Azure Cosmos DB. Now you must write code that executes queries against that database so that you can display it to users.

## Query graph data from an application using the Gremlin API

Azure Cosmos DB supports Apache Tinkerpop's graph traversal language, Gremlin, which is an API for creating graph entities and performing graph query operations. You can use the Gremlin API to create graph entities, such as vertices and edges, and modify properties within those entities. You can also perform queries and traversals, and delete entities.

As we've added some vertices and edges and created some relationships from the previous exercise, we'll now look at writing some queries to query the graph data using the Gremlin API.
