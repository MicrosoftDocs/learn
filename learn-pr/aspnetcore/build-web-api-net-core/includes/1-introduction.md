Imagine you're an employee of an online dog toy retailer named Contoso Pets. Your manager has asked you to develop a RESTful inventory management service as a prerequisite for the company's web storefront. The service has to support adding, viewing, modifying, and removing products&mdash;a standardized usage of HTTP action verbs better known as **C**reate, **R**ead, **U**pdate, **D**elete (CRUD).

This module explores creating a cross-platform RESTful service using ASP.NET Core web API with .NET Core and C#. An in-memory database will be created to persist the products data. Entity Framework (EF) Core will be used as the **O**bject-**R**elational **M**apper (O/RM) for reading and managing products data.

This module uses the [.NET Core CLI](https://docs.microsoft.com/dotnet/core/tools/) to demonstrate web API development. After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or Visual Studio Code (Windows, Linux, & macOS).

## Learning objectives

In this module, you will:

* Use the .NET Core CLI to create an ASP.NET Core web API project.
* Create an in-memory database for persisting products.
* Add CRUD action methods to the web API.
* Test the web API actions from the command shell.

## Prerequisites

* Experience writing C# at the beginner level
* Familiarity with RESTful service concepts and HTTP action verbs, such as GET, POST, PUT, and DELETE
