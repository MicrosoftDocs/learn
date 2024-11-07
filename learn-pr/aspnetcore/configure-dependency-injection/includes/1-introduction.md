When an ASP.NET Core app receives an HTTP request, the code handling the request sometimes needs to access other services. For example, a Blazor component might need to access a service that fetches data from a database. ASP.NET Core uses a built-in dependency injection (DI) container to manage the services that an app uses.

## Example scenario

Suppose you're an entry-level ASP.NET Core developer at a small company. Your team is building a new web app. The requirements accessing and displaying a customer welcome message to the user on the welcome page. Your team lead asked you to configure the necessary services for accessing the data so they can be used from the web UI components.

## What will we be doing?

In this module, you use the .NET SDK to create a boilerplate ASP.NET Core web application. After ensuring it runs correctly, you'll implement an in-memory service to generate the welcome message. You'll then use the built-in dependency injection container to inject the service where needed.

## What is the main goal?

By the end of the module, you'll be able to create an ASP.NET Core web application that uses the built-in dependency injection container to manage services. You'll also be able to describe the benefits of using dependency injection in an ASP.NET Core app.
