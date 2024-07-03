Orleans simplifies the process of building distributed, scalable applications. There are several key concepts to understand  in order to work with Orleans effectively.

Orleans is built around the *actor model*, which is an established design pattern in use since the 1970s. Although a deep understanding of the actor model isn't required for getting started with Orleans, it helps to become familiar with this pattern as you build more complex apps. For now, you can easily complete the exercises ahead with a basic understanding of a few important concepts, such as grains and silos.

## What are Grains?

Grains are the most essential primitives and building blocks of Orleans applications. They represent actors in the Actor model and define the state data and behavior of an entity, such as shopping cart or product. Grains are each identified and tracked through user-defined keys and other grains and clients can access them.

:::image type="content" source="../media/grain-visual.png" alt-text="A diagram of the anatomy of a grain.":::

Grains are stored in silos, which you explore later. Grains that are currently active and in use by your application remain in memory, while inactive grains can be persisted in storage. A grain becomes active again when the app needs it or requests it. Grains have a managed life cycle, which means the Orleans runtime handles activating, deactivating, storing, and locating grains as needed by the application. Developers don't have to worry about managing these concerns themselves and can write code that assumes a grain is available in memory.

:::image type="content" source="../media/grain-lifecycle.png" alt-text="A diagram of the grain life cycle.":::

## How are grains implemented?

In more concrete coding terms, a grain is a class that inherits from the `Grain` base class. The `Grain` class manages various internal behaviors and integration points with the Orleans framework. Your grain classes should also implement one of the grain interface types in the following list. Each of these interfaces defines a similar contract, but marks your class with a different data type for the identifier that Orleans uses to track the grain, such as a `string` or `integer`.

- `IGrainWithGuidKey`
- `IGrainWithIntegerKey`
- `IGrainWithStringKey`
- `IGrainWithGuidCompoundKey`
- `IGrainWithIntegerCompoundKey`

The following code demonstrates a simple grain class definition that inherits from the grain base class and implements one of the identifier interfaces.

```csharp
public class UrlShortenerGrain : Grain, IGrainWithStringKey
{
    // Custom grain implementation details
}
```

A grain also usually implements an interface of your design to manage custom data and behavior. A sample grain interface for a URL shortener might look like the following code:

```csharp
public interface IUrlShortenerGrain
{
    Task SetUrl(string url);
    Task<string?> GetUrl();
}
```

To implement the `IUrlShortenerGrain` interface, consider the following `UrlShortenerGrain` class:

```csharp
public sealed class UrlShortenerGrain
    : Grain, IGrainWithStringKey, IUrlShortenerGrain
{
    public Task SetUrl(string shortenedRouteSegment, string url)
    {
        // TODO: Implementation details
    }

    public Task<string?> GetUrl()
    {
        // TODO: Implementation details
    }
}
```

## What are silos?

Silos are responsible for storing grains and are another core building block of Orleans. A silo can contain one or more grains; a group of silos is known as a cluster. The cluster coordinates work between silos, allowing communication with grains as though they were all available in a single process. You can organize your data by storing different types of grains in different silos. Your application can retrieve individual grains without having to worry about the details of how they're managed within the cluster.

:::image type="content" source="../media/silos.png" alt-text="A diagram of silo architecture.":::

Clusters and silos are configured in the *Program.cs* class of your project as part of the initial Orleans setup.

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
});
```

Orleans supports plenty of other features for more specific or advanced scenarios, such as streams and ACID transactions. These capabilities can be explored as you start to build more complex apps. Next you create a basic application and apply some basic configurations to begin use Orleans.
