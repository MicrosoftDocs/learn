The Hypertext Transfer Protocol (or HTTP) is used to request resources from a web server. Many types of resources are available on the web, and HTTP defines a set of request methods for accessing these resources. In .NET Core those requests are made through an instance of the `HttpClient`. 

An `HttpClient` instance is a collection of settings that's applied to all requests executed by that instance, and each instance uses its own connection pool, which isolates its requests from others.

There are two options for implementing `HttpClient` in your app and it's recommended to choose the implementation based on the clients lifetime management needs:

* For long-lived clients, create a `static` or singleton instance using the `HttpClient` class and set `PooledConnectionLifetime`
* For short-lived clients, use clients created by `IHttpClientFactory`.

## Implement with the `HttpClient` class 

The `System.Net.Http.HttpClient` class sends HTTP requests and receives HTTP responses from a resource identified by a URI. An `HttpClient` instance is a collection of settings that's applied to all requests executed by that instance, and each instance uses its own connection pool, which isolates its requests from others. Beginning with .NET Core 2.1, the `SocketsHttpHandler` class provides the implementation, making behavior consistent across all platforms.

`HttpClient` only resolves DNS entries when a connection is created. It doesn't track time to live (TTL) durations specified by the DNS server. If DNS entries change regularly the client won't be aware those updates. To solve this issue, you can limit the lifetime of the connection by setting the `PooledConnectionLifetime` property, so that DNS lookup is repeated when the connection is replaced.

In the following example `HttpClient` is configured to reuse connections for 15 minutes. After the `TimeSpan` specified by `PooledConnectionLifetime` has elapsed, the connection is closed and a new one is created.

```csharp
var handler = new SocketsHttpHandler
{
    PooledConnectionLifetime = TimeSpan.FromMinutes(15) // Recreate every 15 minutes
};
var sharedClient = new HttpClient(handler);
```

## Implement with `IHttpClientFactory`

 The `IHttpClientFactory` serves as a factory abstraction that can create `HttpClient` instances with custom configurations. `IHttpClientFactory` was introduced in .NET Core 2.1. Common HTTP-based .NET workloads can take advantage of third-party middleware with ease.

When you call any of the [AddHttpClient](/dotnet/api/microsoft.extensions.dependencyinjection.httpclientfactoryservicecollectionextensions.addhttpclient) extension methods, you're adding the `IHttpClientFactory` and related services to the `IServiceCollection`. The IHttpClientFactory type offers the following benefits:

* Exposes the `HttpClient` class as a dependency injection-ready type.
* Provides a central location for naming and configuring logical `HttpClient` instances.
* Codifies the concept of outgoing middleware via delegating handlers in `HttpClient`.
* Provides extension methods for Polly-based middleware to take advantage of delegating handlers in `HttpClient`.
* Manages the caching and lifetime of underlying [HttpClientHandler](/dotnet/api/system.net.http.httpclienthandler) instances. Automatic management avoids common Domain Name System (DNS) problems that occur when manually managing `HttpClient` lifetimes.
*   Adds a configurable logging experience for all requests sent through clients created by the factory.

You should let `HttpClientFactory` and the framework manage the lifetimes and instantiation of `HttpClient` instances. This helps to avoid common issues such as DNS (Domain Name System) problems that can occur when manually managing `HttpClient` lifetimes.

There are several ways `IHttpClientFactory` can be used in an app:

*   [Basic usage](/dotnet/core/extensions/httpclient-factory#basic-usage)
*   [Named clients](/dotnet/core/extensions/httpclient-factory#named-clients)
*   [Typed clients](/dotnet/core/extensions/httpclient-factory#typed-clients)
*   [Generated clients](/dotnet/core/extensions/httpclient-factory#generated-clients)

The best approach depends upon the app's requirements.
