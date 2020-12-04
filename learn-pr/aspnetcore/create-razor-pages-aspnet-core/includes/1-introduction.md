Imagine your company offers product data through a web API. You want to create a web UI that allows your team to manage the data exposed by the web API. You also want to structure the app in a way that you can expand and build upon. The app should be built in such a way that the view and data model concerns are separated.

In this module, you'll build a cross-platform ASP.NET Core Razor Pages web app with .NET and C#. The web app will consume an existing ASP.NET Core web API, which supports **Create**, **Read**, **Update**, and **Delete** (CRUD) operations on product data.

This module uses the [.NET CLI](https://docs.microsoft.com/dotnet/core/tools/) to demonstrate ASP.NET Core Razor Pages development. After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or Visual Studio Code (Windows, Linux, and macOS).

## Learning objectives

In this module, you will:

* Understand when and why to use Razor Pages for your ASP.NET Core app.
* Use the .NET CLI to create a Razor page and its accompanying C# PageModel class.
* Create a form that supports the app's product data management requirements.
* Add built-in, client-side form input validation using Razor's Input Tag Helper.
* Add built-in, server-side model validation using data annotations.
* Add a reference to a Data Transfer Object (DTO).
* Consume a RESTful service from your PageModel.
* Examine the life cycle of a sample HTTP request.
* Deploy and test the web app.

At the end of this module, there are links to content providing deeper dives for each feature area introduced.

## Prerequisites

* Experience writing C# at the beginner level.
* Familiarity with RESTful service concepts and HTTP action verbs, such as GET, POST, PUT, and DELETE.
* Ability to write HTML at an intermediate level.
