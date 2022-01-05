Blazor is a user interface framework for .NET that you can use to build applications.  Let's take a tour of the capabilities of Blazor along with the pros and cons of how it can be configured to help you decide if Blazor should be used in your next application.

## What is .NET?

.NET is a complete ecosystem for developing and deploying applications for desktops, mobile devices, the cloud, and IoT devices.  Developers use programming languages likes Visual Basic, C#, and F# to build with .NET.  You can use .NET tools on the command-line or embedded in applications like Visual Studio or Visual Studio Code to compile your code into a running application.

## What is Razor?

Razor is a format for generating text-based content like HTML.  Razor files have a `cshtml` or a `razor` file extension and contain a mix of C# code along with HTML.

## What is Blazor?

Blazor is a user-interface framework built on .NET and Razor.  Blazor applications can run on a server as part of an ASP.NET application or deployed to run in the browser on a user's machine similar to a single-page-application.

![Sample Blazor Application Architecture](../media/intro-architecture.jpg)

## What is Blazor Server?

Blazor Server is an implementation of the Blazor user-interface framework as part of the ASP.NET Core web development framework and deployed to a web server.  Developing an application with Blazor Server generates HTML on a web server as it is requested by web site visitors, typically using a web browser.  That HTML is then delivered to the visitor's browser and a two-way communication pipeline is maintained using ASP.NET Core SignalR and preferring a Web Sockets connection.

Users that click buttons, navigate, and other interactions with a Blazor Server application have their actions transmitted on this SignalR connection and the server responds with user-interface updates using the same connection.  The Blazor Server framework automatically updates the browser with the content generated on the web server.

## What is Blazor WebAssembly?

Blazor WebAssembly, sometimes shortened to Blazor WASM, is an implementation of the Blazor user-interface framework that runs on the HTML 5 standard WebAssembly runtime that is present in all modern browsers.  The binary output of your application, the DLL files are transmitted to the browser and run with a version of .NET that has been optimized to work with the WebAssembly runtime regardless of the underlying operating system of the device browsing to the website.

Since WebAssembly is a technology that runs entirely in the browser, it is possible to deploy this model of Blazor application using files that a web server does not parse or interact with.  This type of "static" approach reduces the requirements for a web server and shifts all processing for the application to the user's machine.

Advanced processing and logic can take place in the browser.  When the application needs data or to interact with other services they can use standard web technologies to communicate with HTTP services.

## How to build an application with Blazor

Blazor applications are written with a text editor and built with the .NET tools.  You will choose where you would like your Blazor application to run.  The application can run on the server or in the browser with WebAssembly.  Start with a template for the project type that matches where you want your application to run.  You will then write pages using Razor that can be interacted with and navigated between.  Blazor provides a bridge to allow users to build user-interface elements that interoperate with JavaScript.   Other services like a database or web services can be integrated with to provide extra business value.  You can also reference libraries or bundles of features using NuGet packages, the .NET packaging format.

Once you have completed writing the code for your application, you can build it with the .NET compiler tools and publish the resulting application to a web server for your users to access.

### What are Pages?

In Blazor, we build a *Page* with Razor that presents a screen of content in the browser.  A *Page* typically maps directly to a web address that a user would navigate to in your application.

### What are Components?

Pages would be difficult to build if we had to rewrite every line of HTML without any reuse between pages.  We can create *Components* using Razor that can be referenced and used in other components or pages.