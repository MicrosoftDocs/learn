Your developer team needed you to implement various methods in pre-existing stubbed out services to connect their chat bot Blazor web application to Azure OpenAI's conversational interface and Azure Cosmos DB for NoSQL data storage.

Both Azure OpenAI and Azure Cosmos DB for NoSQL have .NET software development kits (SDKs) available to access their endpoints and perform common operations.

You implemented service classes using the `Microsoft.Azure.Cosmos` and `Azure.AI.OpenAI` packages on NuGet. You sent prompts to the Azure OpenAI conversational interface along with contextual prefixes and parsed the usage and body properties of the response. You also used Azure Cosmos DB for NoSQL to store the conversation sessions and messages within a single container.

With the .NET SDKs for Azure Cosmos DB for NoSQL and Azure OpenAI, you were able to add these services to your application with little friction. The services you implemented illustrate the best practices for using each SDK across various operations. The .NET SDKs for each service made it possible to add the required functionality to your Blazor web application with lightweight method implementations.

## References

- **Training modules**
  - [Guided project - Build a .NET app with Azure Cosmos DB for NoSQL](/training/modules/build-dotnet-app-azure-cosmos-db-nosql/)
  - [Get started with Azure OpenAI Service](/training/modules/get-started-openai/)
- **Quickstart**
  - [Azure Cosmos DB for NoSQL SDK for .NET](/azure/cosmos-db/nosql/quickstart-dotnet)
  - [Azure OpenAI](/azure/cognitive-services/openai/chatgpt-quickstart)
- **Developer reference**
  - [Blazor](/aspnet/core/blazor/)
  - [ChatGPT 3.5 Turbo in Azure OpenAI](/azure/cognitive-services/openai/how-to/chatgpt)
