::: zone pivot="csharp"

Each instance of the ``CosmosClient`` class has a few features that are already implemented on your behalf:

- Instances are already thread-safe
- Instances efficiently manage connections
- Instances cache addresses when operating in **direct** mode

Because of this behavior, each time you destroy and recreate and instance within a single .NET ``AppDomain``, the new instances lose the benefits of the caching and connection management.

The Azure Cosmos DB for NoSQL SDK team recommends that you use a single instance per ``AppDomain`` for the lifetime of the application. This small change to your setup allows for better SDK client-side performance and more efficient connection management.

> [!TIP]
> It's simple to use a singleton in a typical .NET console application. For ASP.NET web applications, you should review how to create a singleton instance using the dependency injection framework of your choice.

::: zone-end

::: zone pivot="python"

The `CosmosClient` in the Python SDK is lightweight, and the Azure Cosmos DB SDK for Python automatically handles connection management efficiently. However, for performance and resource efficiency, the recommendation is to reuse the same `CosmosClient` instance throughout your application.

- The Python SDK is thread-safe, so a single instance can be shared across multiple threads.
- Creating and disposing of multiple instances unnecessarily increases resource consumption.

#### Best Practices

- Create a single `CosmosClient` instance and reuse it throughout the lifetime of your application.
- In long-running applications, store the `CosmosClient` instance in a globally accessible location, such as a module-level variable or a dependency injection container.

> [!TIP]
> If you're using a framework like FastAPI or Flask, consider creating the `CosmosClient` once during app startup and reusing it across requests.

::: zone-end

::: zone pivot="node"

The `CosmosClient` class in the JavaScript SDK is designed so it can be reused across operations.

- The JavaScript SDK manages connections efficiently, but frequent instantiation can still impact performance.
- `CosmosClient` isn't inherently expensive to create, but reusing a single instance helps optimize resource usage.

#### Best Practices

- Create a single `CosmosClient` instance and reuse it across your application.
- In a Node.js environment, initialize the `CosmosClient` once and share it across modules.
- If using a web framework like Express.js, initialize the `CosmosClient` during application startup and use it across requests.

> [!TIP]
> In serverless environments like Azure Functions, consider using a static variable to persist the `CosmosClient` instance across function invocations.

::: zone-end
