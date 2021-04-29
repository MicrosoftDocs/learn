When you browse to a web page, the web server communicates with your browsers using HTML, CSS, and JavaScript. If you interact with the page by doing something like submitting a login form or clicking on a buy button, the browser send the information back up to the web server.

In a similar way, web servers can communicate with a broad range of clients including browsers, mobile devices, other web servers, and more, by using RESTful web services. API clients communicate with the server over HTTP, and the two exchange information using a data format such as JSON or XML. APIs are often used in single-page applications (SPAs) that perform most of the user interface logic in a web browser, communicating with the web server primarily using web APIs.

## Benefits of creating APIs in ASP.NET Core

With ASP.NET you use the same framework and patterns to build both web pages and services, side-by-side in the same project. There are a number of benefits to this approach.

### Simple serialization

ASP.NET was designed for modern web experiences. Endpoints automatically serialize your classes to properly formatted JSON out of the box. No special configuration is required. Of course, [serialization can be customized](https://docs.microsoft.com/aspnet/core/web-api/advanced/custom-formatters) for endpoints that have unique requirements.

### Authentication and authorization

Secure API endpoints with built-in support for industry standard JSON Web Tokens (JWT). Policy-based authorization gives you the flexibility to define powerful access control rules—all in code.

### Routing alongside your code

ASP.NET lets you define routes and verbs inline with your code, using attributes. Data from the request path, query string, and request body are automatically bound to method parameters.

### HTTPS by default

You don't deploy your apps without security, so why test them without security? ASP.NET provides first class support for HTTPS out of the box. Automatically generate a test certificate and easily import it to enable local HTTPS so you run, and debug, your apps the way they are intended to be... secured.

### Share code & knowledge with .NET apps

Leverage your .NET skills and ecosystem to share logic from your web API to other apps built with .NET including mobile, web, desktop, services, and more.
