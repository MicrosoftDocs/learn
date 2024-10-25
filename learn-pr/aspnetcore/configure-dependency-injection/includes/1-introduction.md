When an ASP.NET Core app receives an HTTP request, the code handling the request sometimes needs to access other services. For example, a Blazor component might need to access a service that fetches data from a database. ASP.NET Core uses a built-in dependency injection (DI) container to manage the services that an app uses.

## Example scenario

Suppose you're an entry-level ASP.NET Core developer at a small company. Your team is building a new web app. The requirements include URL redirection, and real-time console output for monitoring purposes. Your team lead asked you to with implement the built-in middleware for URL redirection, and create a custom middleware component to log the request details.

## What will we be doing?

In this module, you use the .NET SDK to create a boilerplate ASP.NET Core web application. After ensuring it runs correctly, you'll implement a simple in-memory service ticket service. You'll then use the built-in dependency injection container to inject the service where needed.

## What is the main goal?

By the end of the module, you'll be able to create a simple ASP.NET Core web application that uses the built-in dependency injection container to manage services. You'll also be able to describe the benefits of using dependency injection in an ASP.NET Core app.
