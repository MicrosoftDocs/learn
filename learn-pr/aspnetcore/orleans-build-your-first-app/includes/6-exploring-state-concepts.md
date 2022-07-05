## Persisting data using grains

When working with grains, you'll often need to persist state to ensure your data is safe between application restarts, grain deactivations, and other situations. Orleans is designed for cloud native applications that are durable and fault tolerant.

Grains can define named data objects to persist in state in a storage provider of your choosing. Examples of storage providers include traditional SQL databases, various Azure services such as Blob Storage, and other cloud resources such as Amazon DynamoDb. These providers are made available through various NuGet packages. Orleans also provides extensibility points to add your own storage providers.

## The grain state API

Grains implement persistent state using the `IPersistentState<TState>` interface, where `TState` is the type of object you'd like to store. Most of the time you won't need to implement this interface directly, since the most common storage providers handle this implementation for you. However, it's useful to understand the underlying contract, which includes the following members:

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

* `ClearStateAsync`: This method clears the grain's state object in storage. The behavior can vary depending on the nature of the storage provider.
* `WriteStateAsync`: This method is used to persist changes made to the state object. When a change is made to the properties or data of the state object, those changes aren't automatically saved until `WriteStateAsync` is called.
* `ReadStateAsync`: The read method is called automatically when the grain is activated in order to surface state values to other components. However, this method can also be called explicitly to re-read the latest grain state.

## Working with grain state

You define the objects you want to persist in state by declaring them in the constructor of the grain and decorating them with the `PersistentStateAttribute`. Objects decorated with this attribute have access to the API methods covered previously.

The `PersistentStateAttribute` accepts two parameters:
* **Name**: Defines the name of the state object.
* **StorageName**: Defines the storage provider the object should be saved to.

The example below demonstrates how to store a `KeyValuePair` object in grain state on the `UrlShortenerGrain` class. The `KeyValuePair` stores the shortened alias as a key and the original full URL as the value. This setup allows both items to be stored in state for whenever they're needed, and can be easily retrieved using the alias.

```csharp
public class UrlShortenerGrain : Grain, IUrlShortenerGrain
{
    private readonly IPersistentState<KeyValuePair<string, string>> _state;

    public UrlShortenerGrain(
        [PersistentState(
            stateName: "url",
            storageName: "urls")]
            IPersistentState<KeyValuPair<string, string>> state,
    {
        _state = state;
    }
}
```

## Configuring grain state

To persist grain state objects in storage, you first must configure a silo storage provider. The essential configurations are handled on the `SiloBuilder` within the `UseOrleans` method. The following example stores grain persistence in Azure Blob Storage, but there are plenty of other providers available. Remember, the `name` property of the storage provider must match the `storageName` parameter on the state object injected into your grain.

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
    siloBuilder.AddAzureBlobGrainStorage("urls",
        options =>
        {
            // Recommended: Connect to Blob Storage using DefaultAzureCredential
            options.ConfigureBlobServiceClient(new Uri("https://<your-account-name>.blob.core.windows.net"),
                new DefaultAzureCredential());

            // Connect to Blob Storage using Connection strings
            // options => options.ConfigureBlobServiceClient(connectionString));
        });
});
```

> [!NOTE]
> DefaultAzureCredential is the recommended way of configuration connections to Azure services and should be used whenever possible. This approach offers strong security and administrative benefits that you can explore in the [Managed Identity Overview](/dotnet/azure/sdk/authentication). However, you can also configure Orleans to connect to services using connection strings. Both approaches are demonstrated in the preceding example.

A single grain can store state objects in multiple storage providers. For example, one state object could be stored in-memory, while another might be stored in Azure Table Storage or SQL Server.
