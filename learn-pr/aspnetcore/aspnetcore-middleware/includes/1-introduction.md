When an ASP.NET Core app receives an HTTP request, it passes through a series of components that are responsible for processing the request and generating a response. These components are called middleware. ASP.NET Core includes a set of built-in middleware, and you can also create custom middleware to handle specialized requirements.

## Example scenario

Suppose you're an entry-level ASP.NET Core developer at a small company. Your team is building a new web app. The requirements include URL redirection, and real-time console output for monitoring purposes. Your team lead asked you to with implement the built-in middleware for URL redirection, and create a custom middleware component to log the request details.

## What will we be doing?

In this module, you use the .NET SDK to create a boilerplate ASP.NET Core web application. After ensuring it runs correctly, you'll implement the built-in `UrlRewriter` middleware to rewrite URLs in the app. You'll then create a custom middleware component to log request details to the console.

## What is the main goal?

By the end of this module, you'll be able to implement built-in and custom middleware in an ASP.NET Core app. You'll also understand how middleware components work together to process HTTP requests and generate responses.
