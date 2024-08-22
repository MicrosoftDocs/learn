The construction of the HTML returned to a client for a complex request can take time and require queries to multiple microservices. This HTML or other output code is a common candidate for caching.

Imagine you work for an outdoor equipment retailer. Your new web app includes a microservice that constructs the user interface and returns HTML to browsers. You want to ensure that it performs optimally.

In this unit, you'll learn about output caching and how to implement it in a microservice by using Redis and .NET Aspire.

## What is an output cache?

Use an output cache when you want to store complete HTML pages in web apps or, in minimal APIs, smaller portions of output. You obtain optimal performance improvements by caching pages that are requested frequently, such as your app's homepage. 

## Setting up output caching in .NET Aspire

Installation and configuration steps are the same as for the distributed caching component, except that you install the output caching component in the consuming projects.

### Configure the app host

In the app host, install same Redis hosting component as you used for distributed caching:

```dotnetcli
dotnet add package Aspire.Hosting.Redis --prerelease
```

The registration code is exactly the same. You'll only need to add this code if you haven't already added it for distributed caching:

```csharp
// Register the cache
var redis = builder.AddRedis("redis");

// Initiate the consuming project and pass the cache
builder.AddProject<Projects.ConsumingProject>()
       .WithReference(redis);
```

### Configure the consuming projects

In the microservice projects, add the Redis output caching component:

```dotnetcli
dotnet add package Aspire.StackExchange.Redis.OutputCaching
```

## Using an output cache

Usually, the consuming project is the microservice that generates your app's user interface. For example, it might be an ASP.NET or Blazor web app or a minimal API. You must add the output cache to the app and then add middleware to the project like this:

```csharp
// Add the output cache
builder.AddRedisOutputCache();

// Build the app
var app = builder.Build();

// Add the middleware
app.UseOutputCache();
```

### Caching complete pages

To cache a page, you use the `OutputCache` attribute, such as in this Razor page:

```razor
@page "/"
@attribute [OutputCache(Duration = 10)]

<PageTitle>Welcome to Contoso</PageTitle>

<h1>Welcome to Contoso</h1>

This is our homepage. The time is: @DateTime.Now
```

### Caching output in a minimal API

A minimal API is a project that implements an HTTP web service quickly. It slims down the code necessary to build a RESTful API by avoiding scaffolding and unnecessary controllers. Instead, API actions and routes are declared directly.

In this example, a simple response is returned when the user requests a product's ID:

```csharp
var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/products/{ProdId}", 
    (int ProdId) => $"The product ID is {ProdId}.");

app.Run();
```

To cache this response, either call the `CacheOutput()` method, or apply the `OutputCache` attribute in the `MapGet` call:

```csharp
app.MapGet("/products/{ProdId}", (int ProdId) => $"The product ID is {ProdId}.").CacheOutput();
app.MapGet("/products/{ProdId}", [OutputCache] (int ProdId) => $"The product ID is {ProdId}.");
```

## Learn more

- [.NET Aspire StackExchange Redis output caching component](/dotnet/aspire/caching/stackexchange-redis-output-caching-component)
- [StackExchange Redis Configuration](https://stackexchange.github.io/StackExchange.Redis/Configuration.html)
