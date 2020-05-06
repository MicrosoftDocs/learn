We'll start with an introduction to Blazor and then explore Blazor WebAssembly.

## What is Blazor?

Blazor is a web technology that lets you build client web applications using C#. Blazor is a feature of the ASP.NET framework that allows developers to use .NET tools and libraries to build web apps.

Blazor apps are composed of reusable web UI components built using C#, HTML, and CSS. It enables developers to build both client and server code with  C#, allowing you to share code and libraries with both the front-end and back-end logic. This can simplify sharing data between the front-end and backend logic, enable code re-use to accelerate development and simplify maintenance. 

## What is WebAssembly?

WebAssembly (WASM) is an open binary standard that defines a portable code format for executable programs designed to run in web browsers. It is a textual assembly language with a compact binary format built for fast downloads and near-native performance. 

WebAssembly provides complication targets for languages such as C/C++ and Rust. It is designed to run alongside JavaScript, allowing both to work together.

## What is Blazor WebAssembly?

Blazor WebAssembly allows developers to build WebAssembly binaries using .NET. It's a single-page app framework and uses the WebAssembly open standards without requiring plugins or code transplication. 

.NET code executed via WebAssembly in the browser runs in the browser's JavaScript sandbox. It includes all the security and protection that the sandbox provides to help prevent malicious actions on the client machine.

Under the hood, Blazor uses a Mono-compiled version of the .NET Runtime compiled to a WebAssembly module to execute the .NET Standard code included in your Blazor application. 

Blazor WebAssembly apps are restricted to the capabilities of the browser that is executing the application but can access full browser functionality via the JavaScript interop.

### Blazor WebAssembly supported browsers

Blazor WebAssembly requires a modern desktop or mobile browser. The following browsers are currently supported:

- Microsoft Edge
- Mozilla Firefox
- Google Chrome
- Safari

## Blazor development requirements

ASP.NET Core Blazor templates

Blazor Server is supported in ASP.NET Core 3.0, to use Blazor WebAssembly you'll need ASP.NET Core 3.1 or later.