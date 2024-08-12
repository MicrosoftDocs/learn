Databases are a fundamental requirement in many advanced web applications as they provide a robust and predictable place to store and retrieve information. For example, if your web app displays a product catalog, the details of each product, its inventory level, price, and similar products come from a database. Relational databases, such as PostgreSQL and SQL Server are great choices for structured data like this. NoSQL databases, which store nonrelational data and have looser rules around data schemas are a good solution where the shape of data is flexible.

Imagine working for the Northern Mountains retailer. Your current online store, which uses .NET Aspire, stores catalog data in a local SQLite database. The app also uses an in-memory Redis instance to store customers' shopping baskets. You want to investigate using more robust and durable database technologies for storing data.

In this module, learn about the database systems that .NET Aspire can connect to using built-in components. Then see how to configure connections to, and store data in, relational and nonrelational databases.

## Learning objectives

At the end of this module, you'll be able to:

- Describe the database systems that .NET Aspire can connect to using built-in components.
- Use .NET Aspire components to read and write data to PostgreSQL, MySQL, and Microsoft SQL Server databases.
- Use .NET Aspire components to read and write data to MongoDB databases.
