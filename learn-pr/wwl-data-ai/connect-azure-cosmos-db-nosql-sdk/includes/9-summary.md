In this module, the developer configured the Azure Cosmos DB SDK for .NET and Python, connected with a singleton client, and tuned connectivity mode and client settings. The developer also developed locally against the emulator and diagnosed connection issues before they reach production.

## What you learned

- The SDK maps the account, database, and container to `CosmosClient`, `Database`/`DatabaseProxy`, and `Container`/`ContainerProxy`, installed from NuGet or PyPI.
- The SDK authenticates with either an account key or Microsoft Entra ID. Keys suit local tooling and the emulator. `DefaultAzureCredential` is useful during development, while a specific credential such as `ManagedIdentityCredential` makes production identity selection deterministic without a stored application secret.
- One `CosmosClient` per account in each application domain is the most important reliability practice, preserving the connection pool and address cache across requests.
- The .NET SDK defaults to direct mode, which routes over TCP (Transmission Control Protocol) for the lowest latency. Gateway mode routes through HTTPS instead. It suits network-restricted environments, and it's the only mode the Python SDK supports.
- The emulator runs the NoSQL API locally, so the SDK connects as it would to a cloud account. It differs in endpoint, key, and SSL handling, and in feature coverage. The vNext Linux emulator doesn't implement request units, and doesn't support stored procedures, triggers, or user-defined functions.
- The SDK retries 429 on any operation and 449 on writes. By default, timeouts and service-unavailable responses are retried for reads and queries, while writes with an unknown outcome require application-level handling. Python also offers opt-in `retry_write` for applications that tolerate or detect duplicate effects. Logging exposes request charges, and async code with bounded concurrency keeps the thread pool free.

## Learn more

- [Azure Cosmos DB for NoSQL .NET SDK (v3)](/azure/cosmos-db/sdk-dotnet-v3)
- [Azure Cosmos DB for NoSQL Python SDK](/azure/cosmos-db/sdk-python)
- [Best practices for Azure Cosmos DB .NET SDK](/azure/cosmos-db/best-practice-dotnet)
- [Diagnose and troubleshoot issues using the .NET SDK](/azure/cosmos-db/troubleshoot-dotnet-sdk)
- [What is the Azure Cosmos DB emulator?](/azure/cosmos-db/emulator)
- [Connect to Azure Cosmos DB for NoSQL using role-based access control and Microsoft Entra ID](/azure/cosmos-db/how-to-connect-role-based-access-control)
