Your app is configured to use Orleans and two endpoints to provide basic functionality. Next you enhance this setup by adding persistent storage for your grains. In this scenario, you use in-memory storage for simplicity. However, keep in mind that once your code is set up, switching to a more permanent store such as Azure Blob Storage is as simple as changing the connection configuration.

## Configure grain storage

You can configure how the app stores grains by modifying the `UseOrleans` method. Update the existing `siloBuilder` configuration code in your app so that it matches the following example:

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
    siloBuilder.AddMemoryGrainStorage("urls");
});
```

This code instructs Orleans to store grains in memory and names the storage `urls`. If you wanted to use other storage options such as Azure Blob Storage, you would change this method to `AddAzureBlobGrainStorage` and provide the necessary configuration parameters. The rest of your Orleans code would remain the same.

## Create an object to persist

Rather than using the `KeyValuePair`, you create a new class to store the URL details. This class is used to store the shortened route segment and the full URL. This setup allows both items to be stored in state for whenever they're needed, and can be easily retrieved using the alias.

Add a new class named `UrlDetails` to the project with the following code:

```csharp
[GenerateSerializer]
public sealed record class UrlDetails
{
    [Id(0)]
    public string FullUrl { get; set; } = "";

    [Id(1)]
    public string ShortenedRouteSegment { get; set; } = "";
}
```

## Add persistent storage to the grains

The next step is to update the `UrlShortenerGrain` to use persistent state.

1. Replace the class definition to use a primary constructor in the `UrlShortenerGrain` and delete the `_cache` field so they match the following code:

    ```csharp
    public sealed class UrlShortenerGrain(
        [PersistentState(
            stateName: "url",
            storageName: "urls")]
            IPersistentState<UrlDetails> state)
        : Grain, IUrlShortenerGrain
    {
        // Omitted for this step, but will be updated in the next step...
    }
    ```

    The `PersistentState` attribute is provided by Orleans. The attribute handles many internal tasks related to storing and retrieving state values for the grain. You simply need to provide a name for the state object and the name of the storage silo. The `storageName` should be the same as the value you provided to the `AddMemoryGrainStorage` method in the silo configuration.

1. Update the grain methods to use the new state field so that they match the following code:

    ```csharp
    public async Task SetUrl(string fullUrl)
    {
        state.State = new()
        {
            ShortenedRouteSegment = this.GetPrimaryKeyString(),
            FullUrl = fullUrl
        };

        await state.WriteStateAsync();
    }

    public Task<string> GetUrl() =>
        Task.FromResult(state.State.FullUrl);
    ```

    This code accomplishes the following tasks:

    - The `SetUrl` method assigns the URL alias and the full URL to a `UrlDetails` that is persisted in the grain state. Orleans handles managing that state and saving it to the location you configured, which in this case is in-memory. However, remember that state could also be a database or service such as Azure Blob Storage.

    - The `GetUrl` method simply returns the full URL from the `UrlDetails` stored on the grain so that the application can use it. Saving both the alias and full URL allows for flexibility in future use cases where we might need one or the other.

Your application now supports persistent state. Shortened URL redirects could also now be saved between user sessions and application restarts if you were to configure Orleans to use permanent storage instead of in-memory.
