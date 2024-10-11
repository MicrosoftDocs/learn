In most modern application projects, databases are crucial in enabling efficient data storage, retrieval, and management. Whether you're capturing inputs from a web-based front-end or integrating a database into a larger solution, coding is often necessary to create and manage these databases. 

When you create a data API, you build a consistent interface for interacting with your database. This means that different applications and systems can use the same methods to retrieve, update, and manage data, reducing complexity and ensuring uniformity. Also, by using Azure SQL Database, you can build a scalable, secure, and efficient data API that facilitates seamless interaction with your database. 

In this module, you'll learn how to create modern REST data API for Azure SQL Database. We'll delve into Data API Builder, a powerful cross-platform that simplifies the creation of endpoints for your Azure SQL Database. With features like automatic query generation, granular security controls, and seamless integration with other Azure services, the Data API Builder can effortlessly transform your database into a versatile API.

> [!TIP] 
> Make sure you have explored other modules that are part of the [Develop data-driven applications by using Azure SQL Database learning path](/training/modules/get-started-sql-database-application-development?azure-portal=true).

## Understand Data API builder

[Data API Builder (DAB)](/azure/data-api-builder/overview?azure-portal=true) is a cross-platform, open-source engine that requires zero code and a single configuration file. With Data API builder, developers interact with databases programmatically. It provides a standardized way to perform CRUD (Create, Read, Update, Delete) operations on data, enabling seamless integration between different systems and applications. Data API builder (DAB) APIs can be RESTful or GraphQL-based, offering flexibility in how data is accessed and manipulated.

- **REST:** These APIs use HTTP requests to perform CRUD operations. They're stateless and can be easily consumed by various clients, including web and mobile applications.

- **GraphQL:** These APIs allow clients to request exactly the data they need, reducing over-fetching and under-fetching of data. They provide an efficient and flexible way to interact with databases.

