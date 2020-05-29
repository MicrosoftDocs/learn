Companies building web applications commonly hire developers for a variety of roles. Some developers create the back-end, server-side logic, and others might build a client-side web app. These developers often use different development languages and technologies.

C# and .NET are popular choices for building server-side logic. But client-side apps are often built with web UI frameworks, which commonly use JavaScript. Using multiple languages and tool sets requires multiple skill sets and often requires hiring two separate teams. Also, code to transfer and represent data needs to be built in both languages and kept in sync.

You'll start with an introduction to Blazor and then explore Blazor WebAssembly.

## What is Blazor?

Blazor is a web technology that lets you build client web applications using C#. It's a feature of the ASP.NET Core framework. With Blazor, you can use .NET tools and libraries to build web apps.

Blazor apps are composed of reusable web UI components built using C#, HTML, and CSS. By using Blazor, you can build both client and server code with C#. This ability lets you share code and libraries with both the front-end client code and back-end logic. Using C# for both can simplify sharing data between the front end and back end, enable code reuse to accelerate development, and simplify maintenance.

You can use Blazor to generate server-side code that handles UI interactions over a WebSocket connection or a client-side web app that runs directly in the browser via WebAssembly.

## What is WebAssembly?

WebAssembly (WASM) is an open binary standard that defines a portable code format for executable programs designed to run in web browsers. It is a textual assembly language with a compact binary format built for fast downloads and near-native performance.

WebAssembly provides a compilation target for languages such as C, C++, and Rust. It's designed to run alongside JavaScript so that both work together. You can also use it to generate progressive web applications that can be downloaded and run offline.

## What is Blazor WebAssembly?

Blazor WebAssembly lets developers run .NET code in a browser. It's a single-page app framework and uses the WebAssembly open standards without requiring plug-ins or code generation.

.NET code executed via WebAssembly in the browser runs in a browser's JavaScript sandbox. The code includes all the security and protection that the sandbox provides to help prevent malicious actions on a client machine.

Blazor uses a .NET runtime compiled to a WebAssembly module that is downloaded with an app. The module can execute .NET Standard code included in your Blazor application.

A Blazor WebAssembly app is restricted to the capabilities of the browser that executes the app. But the app can access full browser functionality via JavaScript interop.

### Blazor WebAssembly supported browsers

Blazor WebAssembly requires a modern desktop or mobile browser. The following browsers are currently supported:

- Microsoft Edge
- Mozilla Firefox
- Google Chrome
- Apple Safari

## Blazor WebAssembly development requirements

You can build Blazor WebAssembly applications by using the latest version of Visual Studio 2019, Visual Studio for Mac, or Visual Studio Code. In this module, you'll use Visual Studio Code.

Regardless of your development environment, you need to install the .NET Core 3.1 SDK. After installation, you have everything you need to start building Blazor apps. You'll install all of the requirements to build a Blazor WebAssembly app with Visual Studio Code in the next exercise.
