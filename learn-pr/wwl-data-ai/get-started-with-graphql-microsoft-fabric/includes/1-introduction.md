---
ms.custom:
  - ignite-2024
---
GraphQL is an open source query language designed for APIs and a server-side runtime for executing queries using a type system defined for your data. It isn't tied to any specific database or storage engine and is instead backed by your existing code and data.

Microsoft Fabric API for GraphQL is a managed service that enables you to create a GraphQL API in seconds to access data from your data sources such as warehouses, datamarts, and SQL Databases, by providing a unified API layer for querying and mutating data from these supported data sources.

:::image type="content" source="../media/1-architecture.png" alt-text="Diagram showing how GraphQL works in Microsoft Fabric." lightbox="../media/1-architecture.png":::

The primary purpose of GraphSQL is to provide a more efficient and flexible way to query data compared to traditional SQL databases. It allows clients to specify exactly what data they need from the server and receive that data in a predictable way. This reduces the amount of data transferred over the network and minimizes the number of requests needed to fetch related data.

### Explore differences from SQL database

- **Query language:** Traditional SQL databases use SQL (Structured Query Language) to query relational data. GraphQL, on the other hand, uses a graph-based query language that allows for more complex and flexible queries.
- **Data structure:** SQL databases store data in tables with rows and columns, while GraphQL represents data as nodes (entities) and edges (relationships) in a graph structure. This makes it easier to model and query complex relationships between data points.
- **Flexibility:** GraphQL allows clients to request exactly the data they need, avoiding over-fetching or under-fetching of data. In contrast, depending on your query SQL queries might return entire rows or tables, which might include unnecessary data.
- **Performance:** GraphQL can improve performance by reducing the number of network requests and the amount of data transferred. It also allows for more efficient querying of related data, which can be beneficial for applications with complex data relationships.
