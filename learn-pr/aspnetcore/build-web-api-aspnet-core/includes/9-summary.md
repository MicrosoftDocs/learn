In this module, you've created an ASP.NET Core web API running on .NET. The web API creates, reads, updates, and deletes pizzas from an in-memory cache.

You've learned that creating a web API with ASP.NET Core starts by creating a new application using the *ASP.NET Core Web API* template, then creating classes which inherit from the `ControllerBase` class and contain methods that respond to HTTP requests. Since this pattern allows you to focus on a single controller action at a time, with a little practice you can create functional web APIs pretty quickly.

In this module, we used an in-memory cache. This allowed us to focus on learning web API concepts, but has some obvious limitations for real world applications - if the application is stopped or crashes, all our changes are lost! In a real world application, you'll want to store your data in a backing store like a database. You can learn how to persist and retrieve relational data using Entity Framework core in [this tutorial](/learn/modules/persist-data-ef-core/).

## Learn more with a Channel 9 video series

- [.NET 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
- [ASP.NET Core Web API 101](https://channel9.msdn.com/Series/Beginners-Series-to-Web-APIs?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
- [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)

## Learn more with docs.microsoft.com

- [Tutorial: Create a web API with ASP.NET Core](/aspnet/core/tutorials/first-web-api)
- [Create web APIs with ASP.NET Core](/aspnet/core/web-api/)
- [Controller action return types in ASP.NET Core web API](/aspnet/core/web-api/action-return-types)
