Commonly, companies building web applications hire developers for a variety of roles: some developers create the backend server-side logic, and others may build client-side web app. Often, these developers use different development languages and technologies.

C# & .NET is a popular choice for building server-side logic but client-side apps are often built using web UI frameworks, commonly using JavaScript. Using multiple languages and tool sets requires multiple skillsets, and often requires hiring two separate teams. As well, code to transfer and represent data needs to be built in both languages and kept in sync.

We'll start with an introduction to Blazor and then explore Blazor WebAssembly.

## What is Blazor?

Blazor is a web technology that lets you build client web applications using C#. Blazor is a feature of the ASP.NET Core framework that allows developers to use .NET tools and libraries to build web apps.

Blazor apps are composed of reusable web UI components built using C#, HTML, and CSS. It enables developers to build both client and server code with C#, allowing you to share code and libraries with both the front-end client code and back-end logic. Using C# for both can simplify sharing data between the front-end and backend, enable code reuse to accelerate development and simplify maintenance. 

Blazor can be used to generate server-side code where the UI is deployed from the server, or a client-side web app using Blazor WebAssembly.

## What is WebAssembly?

WebAssembly (WASM) is an open binary standard that defines a portable code format for executable programs designed to run in web browsers. It is a textual assembly language with a compact binary format built for fast downloads and near-native performance. 

WebAssembly provides complication targets for languages such as C/C++ and Rust. It is designed to run alongside JavaScript, allowing both to work together. It can also be used to generate Progressive Web Applications that can be downloaded and run offline.

## What is Blazor WebAssembly?

Blazor WebAssembly allows developers to build WebAssembly binaries using .NET. It's a single-page app framework and uses the WebAssembly open standards without requiring plugins or code generation. 

.NET code executed via WebAssembly in the browser runs in the browser's JavaScript sandbox. It includes all the security and protection that the sandbox provides to help prevent malicious actions on the client machine.

Under the hood, Blazor uses a Mono-compiled version of the .NET Runtime compiled to a WebAssembly module. The module is able execute the .NET Standard code included in your Blazor application. 

Blazor WebAssembly apps are restricted to the capabilities of the browser that is executing the application but can access full browser functionality via the JavaScript interop.

### Blazor WebAssembly supported browsers

Blazor WebAssembly requires a modern desktop or mobile browser. The following browsers are currently supported:

- Microsoft Edge
- Mozilla Firefox
- Google Chrome
- Safari

## Blazor WebAssembly development requirements

Blazor WebAssembly applications can be built using Visual Studio 2019, Visual Studio for Mac or Visual Studio Code. You'll need the latest version installed regardless of the IDE you choose. In this module, we'll be focusing on Visual Studio code.

Regardless of your development environment, you'll need to install the .NET Core 3.1 SDK. With the SDK installed, you'll be able to download the Blazor WebAssembly templates. You'll install all of the requirements to build Blazor WebAssembly app with Visual Studio Code in the next exercise.
