Your new project is configured correctly and you're ready to begin working with Orleans. In this step, you create and configure the grains and silo of your application.

You create a grain to manage each shortened URL redirect. The grain stores essential data for this process, such as a shortened hash and the original URL to redirect to.

You also perform Orleans startup configurations and create a silo to store the grains. Grains can be retrieved from the silo using their identifying key. In this case, the shortened URL hash doubles as the grain identifier.

## Create the URL shortener grain

Orleans grains should utilize an interface to define their methods and properties. The URL shortener grain interface should define two methods to create and retrieve the shortened URL.

1. Inside of the `Program` class, add the following interface definition to the bottom of the file. Grains can implement different interfaces that define the type of key used to identify the grain. In this case, you implement the `IGrainWithStringKey` interface because strings are a logical choice for working with URL values.

    ```csharp
    public interface IUrlShortenerGrain : IGrainWithStringKey
    {
        Task SetUrl(string fullUrl);
    
        Task<string> GetUrl();
    }
    ```

1. Create a `UrlShortenerGrain` class using the following code. This class inherits from the `Grain` class provided by Orleans and implements the `IUrlShortenerGrain` interface you created. The `Grain` base class provides essential functionality for the internal behaviors of Orleans.

    ```csharp
    public sealed class UrlShortenerGrain : Grain, IUrlShortenerGrain
    {
        private KeyValuePair<string, string> _cache;

        public Task SetUrl(string fullUrl)
        {
            _cache = new(
                key: this.GetPrimaryKeyString(),
                value: fullUrl);
        
            return Task.CompletedTask;
        }
    
        public Task<string> GetUrl() =>
            Task.FromResult(_cache.Value);
    }
    ```

    The `SetUrl` method stores the shortened route segment and the full URL in the <xref:Orleans.Runtime.IPersistentState%601>. When the grain is retrieved using the shortened identifier, the `GetUrl` method then returns the full URL. The app can use the full URL to redirect the user to the desired location.

## Create and configure the silo

You defined a grain class and interface in your app. However, in order to implement the grain successfully, you still need to configure your app to use Orleans.

At the top of the `Program` class, refactor the `builder` code to use Orleans. The completed code should look like the following example:

```csharp
using Orleans.Runtime;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
});

using var app = builder.Build();
```

The code uses a <xref:Orleans.Hosting.ISiloBuilder> to create a silo that can store your grains. In this scenario, you use a localhost cluster, but in a production app you can configure more robust options. Remember, a cluster is the collection of silos for your app.

Your application is now set up to configure Orleans during startup and create a silo to store your grains. You also created a grain class to manage the data for your app. In the next step, you'll see how to put these elements to work by creating the endpoints to create and retrieve shortened URLs.
