When you browse to a web page, the web server communicates with your browsers using HTML, CSS, and JavaScript. If you interact with the page by doing something like submitting a login form or clicking on a buy button, the browser send the information back up to the web server.

In a similar way, web servers can communicate with a broad range of clients including browsers, mobile devices, other web servers, and more, by using web services. API clients communicate with the server over HTTP, and the two exchange information using a data format such as JSON or XML. APIs are often used in single-page applications (SPAs) that perform most of the user interface logic in a web browser, communicating with the web server primarily using web APIs.

## REST: A common pattern for building APIs with HTTP

Representational State Transfer (REST) is an architectural style for building web services. REST requests are made over HTTP using the same HTTP verbs that web browsers use to retrieve web pages and to send data to servers. The verbs are:

- **GET** – this operation is used to retrieve data from the web service.
- **POST** – this operation is used to create a new item of data on the web service.
- **PUT** – this operation is used to update an item of data on the web service.
- **PATCH** – this operation is used to update an item of data on the web service by describing a set of instructions about how the item should be modified. This verb is not used in the sample application.
- **DELETE** – this operation is used to delete an item of data on the web service.

Web service APIs that adhere to REST are called RESTful APIs, and are defined using:

- A base URI.
- HTTP methods, such as GET, POST, PUT, PATCH, or DELETE.
- A media type for the data, such as JavaScript Object Notation (JSON) or XML.

An API will often need to provide services for a few different, related things. For example, our pizza API might manage pizzas, customers, and orders. We **routing** to map URIs to logical divisions in our code, so that requests to http://localhost:5000/pizza are **routed** to a `PizzaController`, while requests to http://localhost:5000/order are routed to an `OrderController`.

## Benefits of creating APIs in ASP.NET Core

With ASP.NET you can use the same framework and patterns to build both web pages and services. This means you can reuse model classes, validation logic, and even serve both web pages and services side-by-side in the same project. There are a number of benefits to this approach.

### **Benefit**: Simple serialization

ASP.NET was designed for modern web experiences. Endpoints automatically serialize your classes to properly formatted JSON out of the box. No special configuration is required. Of course, [serialization can be customized](/aspnet/core/web-api/advanced/custom-formatters) for endpoints that have unique requirements.

### **Benefit**: Authentication and authorization

Secure API endpoints with built-in support for industry standard JSON Web Tokens (JWT). Policy-based authorization gives you the flexibility to define powerful access control rules—all in code.

### **Benefit**: Routing alongside your code

ASP.NET lets you define routes and verbs inline with your code, using attributes. Data from the request path, query string, and request body are automatically bound to method parameters.

### **Benefit**: HTTPS by default

HTTPS is an important part of modern, professional web APIs. It relies on end-to-end encryption to provide privacy and ensure your API calls aren't intercepted and altered between client and server. ASP.NET provides first class support for HTTPS out of the box. It automatically generates a test certificate and easily imports it to enable local HTTPS so you run and debug your applications securely, before you publish them.

### **Benefit**: Share code & knowledge with .NET apps

Leverage your .NET skills and ecosystem to share logic from your web API to other apps built with .NET including mobile, web, desktop, services, and more.

## Testing web APIs using the .NET HTTP REPL

When you are developing a traditional website, you will usually view and test your work in a web browser. Web APIs accept and return data rather than HTML, so a web browser isn't the best web API testing tool. One of the easiest options to use for exploring and interacting with web APIs is the **.NET HTTP REPL**. REPL stands for **R**ead-**E**val-**P**rint **L**oop. It's a simple and popular way to a build interactive command-line environments. In the next section, you will create a simple web API, then interact with it using the .NET HTTP REPL.