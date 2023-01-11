In this unit, you'll learn when and why to upgrade existing ASP.NET applications running on .NET Framework to ASP.NET Core.

ASP.NET Core provides many benefits over ASP.NET MVC running on .NET Framework. The [full listing from the ASP.NET Core documentation](/aspnet/core/fundamentals/choose-aspnet-framework) lists the following advantages:

* A unified story for building web UI and web APIs
* Architected for testability
* [Razor Pages](/aspnet/core/razor-pages) makes coding page-focused scenarios easier and more productive
* [Blazor](/aspnet/core/blazor) lets you use C# in the browser alongside JavaScript and share server-side and client-side app logic, all written with .NET
* Ability to develop and run on Windows, macOS, and Linux
* Open source and [community focused](https://live.asp.net/)
* Integration of [modern, client-side frameworks](/aspnet/core/blazor) and development workflows
* Support for hosting Remote Procedure Call (RPC) services using [gRPC](/aspnet/core/grpc)
* A cloud-ready, environment-based [configuration system](/aspnet/core/fundamentals/configuration)
* Built-in [dependency injection](/aspnet/core/fundamentals/dependency-injection)
* A lightweight, [high-performance](https://github.com/aspnet/benchmarks), and modular HTTP request pipeline
* Ability to host on the following hosts:
  * [Kestrel](/aspnet/core/fundamentals/servers/kestrel)
  * [IIS](/aspnet/core/host-and-deploy/iis)
  * [HTTP.sys](/aspnet/core/fundamentals/servers/httpsys)
  * [Nginx](/aspnet/core/host-and-deploy/linux-nginx)
  * [Apache](/aspnet/core/host-and-deploy/linux-apache)
  * [Docker](/aspnet/core/host-and-deploy/docker)
* [Side-by-side versioning](/dotnet/standard/choosing-core-framework-server#side-by-side-net-versions-per-application-level).
* Tooling that simplifies modern web development

Let's discuss some top benefits in a little more detail.

## Performance

ASP.NET Core provides significantly higher performance over .NET Framework. This performance improvement provides several potential advantages, including faster response for individual responses, higher throughput, greater server efficiency, and reduced memory usage. All of these improvements translate to cost savings by serving more responses with lower server resources.

A number of case studies have documented these performance benefits. Azure Active Directory serves 115 billion requests per day, and was able to [cut CPU costs by 50% by moving to .NET Core](https://devblogs.microsoft.com/dotnet/azure-active-directorys-gateway-service-is-on-net-core-3-1/). [Bing documented a 34% server latency improvement in migrating to .NET Core 2.1](https://devblogs.microsoft.com/dotnet/azure-active-directorys-gateway-service-is-on-net-core-3-1/). Once Bing was running on .NET Core, the team was able to take advantage of each .NET Core version update, and continued to see large improvements in each update.

## Cross-platform support

While .NET Framework is a Windows-only framework, ASP.NET Core is a cross-platform framework. ASP.NET Core can be developed and hosted on Windows, macOS, and Linux. This cross-platform support allows for flexibility in developer environments, CI/CD pipelines, and deployment. It's common to see developers and designers working on a mix of Windows and macOS environments and deploying applications to a variety of hosting environments, including Linux, Docker, Windows, and cloud-hosting platforms.

## Microservices

ASP.NET Core is designed to be a lightweight, modular, and extensible framework you can use to build microservices. You can use ASP.NET Core to build small, standalone services you can use in a variety of environments, and that you can deploy and scale separately. Microservices support provides hosting flexibility, fine-grained scalability, and the flexibility to test and deploy small units of functionality.

## Ecosystem

Updating your applications to ASP.NET Core gives you access to the newest releases of popular NuGet libraries, modern development tools, and the latest components from commercial tool vendors.

## Access to new features in .NET updates

.NET Framework continues to be supported and receive security updates, but updates do not include new features. Updating to ASP.NET Core gives you access to new features in the yearly version updates.
