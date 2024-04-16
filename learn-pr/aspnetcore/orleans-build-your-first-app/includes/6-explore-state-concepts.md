## Persist data using grains

When working with grains, you often need to persist state to ensure your data is safe between application restarts, grain deactivations, and other situations. Orleans is designed for cloud-native applications that are durable and fault tolerant.

Grains can define named data objects to persist in state in a storage provider of your choosing. Examples of storage providers include traditional SQL databases, various Azure services such as Blob Storage, and other cloud resources such as Amazon DynamoDb. These providers are made available through various NuGet packages. Orleans also provides extensibility points to add your own storage providers.

## The grain state API

Grains implement persistent state using the <xref:Orleans.Runtime.IPersistentState%601> interface, where `TState` is the type of object you'd like to store. Most of the time you don't need to implement this interface directly, since the most common storage providers handle this implementation for you. However, it's useful to understand the underlying contract, which includes the following members:

```csharp
public interface IPersistentState<TState> where TState : new()
{
    TState State { get; set; }
    string Etag { get; }
    Task ClearStateAsync();
    Task WriteStateAsync();
    Task ReadStateAsync();
}
```

The three methods on this interface help you manage the `TState` object.

- <xref:Orleans.Core.IStorage%601.ClearStateAsync%2A>: This method clears the grain's state object in storage. The behavior can vary depending on the nature of the storage provider.
- <xref:Orleans.Core.IStorage%601.WriteStateAsync%2A>: This method is used to persist changes made to the state object. When a change is made to the properties or data of the state object, those changes aren't automatically saved until `WriteStateAsync` is called.
- <xref:Orleans.Core.IStorage%601.ReadStateAsync%2A>: The read method is called automatically when the grain is activated in order to surface state values to other components. However, this method can also be called explicitly to re-read the latest grain state.

## Work with grain state

You define the objects you want to persist in state by declaring them in the constructor of the grain and decorating them with the <xref:Orleans.Runtime.PersistentStateAttribute>. Objects decorated with this attribute have access to the API methods covered previously.

The `PersistentStateAttribute` accepts two parameters:

- **Name**: Defines the name of the state object.
- **StorageName**: Defines the storage provider the object should be saved to.

The following example demonstrates how to store a `KeyValuePair` object in grain state on the `UrlShortenerGrain` class. The `KeyValuePair` stores the shortened alias as a key and the original full URL as the value. This setup allows both items to be stored in state for whenever they're needed, and can be easily retrieved using the alias.

```csharp
public class UrlShortenerGrain : Grain, IUrlShortenerGrain
{
    private readonly IPersistentState<KeyValuePair<string, string>> _cache;

    public UrlShortenerGrain(
        [PersistentState(
            stateName: "url",
            storageName: "urls")]
            IPersistentState<KeyValuePair<string, string>> state)
    {
        _cache = state;
    }
}
```

## Configure grain state

To persist grain state objects in storage, you first must configure a silo storage provider. The essential configurations are handled on the `ISiloBuilder` within the `UseOrleans` method. The following example stores grain persistence in Azure Blob Storage, but there are plenty of other providers available. Remember, the `name` property of the storage provider must match the `storageName` parameter on the state object injected into your grain.

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
    siloBuilder.AddAzureBlobGrainStorage("urls",
        // Recommended: Connect to Blob Storage using DefaultAzureCredential
        options =>
        {
            options.ConfigureBlobServiceClient(
                new Uri("https://<your-account-name>.blob.core.windows.net"),
                new DefaultAzureCredential());
        });
        // Connect to Blob Storage using Connection strings
        // options => options.ConfigureBlobServiceClient(connectionString));
});
```

> [!NOTE]
> <xref:Azure.Identity.DefaultAzureCredential> is the recommended way of configuration connections to Azure services and should be used whenever possible. This approach offers strong security and administrative benefits that you can explore in the [Managed Identity Overview](/dotnet/azure/sdk/authentication). However, you can also configure Orleans to connect to services using connection strings. Both approaches are demonstrated in the preceding example.

A single grain can store state objects in multiple storage providers. For example, one state object could be stored in-memory while another might be stored in Azure Table Storage or SQL Server.
