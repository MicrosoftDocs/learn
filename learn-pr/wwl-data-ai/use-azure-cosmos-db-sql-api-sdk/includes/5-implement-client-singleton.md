Each instance of the ``CosmosClient`` class has a few features that are already implemented on your behalf:

- Instances are already thread-safe
- Instances efficiently manage connections
- Instances cache addresses when operating in **direct** mode

Because of this behavior, each time you destroy and recreate and instance within a single .NET ``AppDomain``, the new instances lose the benefits of the caching and connection management.

The Azure Cosmos DB SQL API SDK team recommends that you use a single instance per ``AppDomain`` for the lifetime of the application. This small change to your setup allows for better SDK client-side performance and more efficient connection management.

> [!TIP]
> It's simple to use a singleton in a typical .NET console application. For ASP.NET web applications, you should review how to create a singleton instance using the dependency injection framework of your choice.
