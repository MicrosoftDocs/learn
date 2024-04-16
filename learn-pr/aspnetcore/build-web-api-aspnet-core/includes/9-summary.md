In this module, you created an ASP.NET Core web API running on .NET. The web API creates, reads, updates, and deletes pizzas from an in-memory cache.

You learned that creating a web API with ASP.NET Core entails:

1. Creating a new application by using the *ASP.NET Core Web API* template.
1. Creating classes that inherit from the `ControllerBase` class and that contain methods that respond to HTTP requests.

Because this pattern allows you to focus on a single controller action at a time, you can create functional web APIs fairly quickly with a little practice.

In this module, you used an in-memory cache. This approach helped you to focus on learning web API concepts, but it has some obvious limitations for real-world applications. If the application stops, all your changes are lost!

In a real-world application, you would store your data in a backing store, like a database. You can learn how to persist and retrieve relational data by using Entity Framework Core in [this tutorial](/training/modules/persist-data-ef-core/).

## Videos for learning more

- [.NET for Beginners](/shows/dotnet-for-beginners/)
- [C# for Beginners](/shows/csharp-for-beginners/)
- [All .NET Beginner Videos](https://dotnet.microsoft.com/learn/videos)

## Articles for learning more

- [Tutorial: Create a web API with ASP.NET Core](/aspnet/core/tutorials/first-web-api)
- [Create web APIs with ASP.NET Core](/aspnet/core/web-api/)
- [Controller action return types in ASP.NET Core web API](/aspnet/core/web-api/action-return-types)
