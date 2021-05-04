Companies that build web apps commonly hire developers for different roles. Some developers create back-end, server-side logic. Others build client-side web apps. These developers often use different development languages and technologies.

C# and Microsoft .NET are popular choices for building server-side logic. But client-side apps are often built with web UI frameworks, which commonly use JavaScript. The use of multiple languages and toolsets requires multiple sets of skills and often requires two separate teams. Also, code to transfer and represent data must be built in both languages and kept in sync.

In this unit, you'll start with an introduction to Blazor and then explore Blazor WebAssembly.

## What is Blazor?

Blazor apps are composed of reusable web UI components built using C#, HTML, and CSS. With Blazor, developers can build client and server code with C#. They can also share code and libraries with the front-end client code and back-end logic. Using C# for all code simplifies sharing data between the front end and back end, code reuse to accelerate development, and maintenance.

You can use Blazor to generate:

- Server-side code that handles UI interactions over a WebSocket connection.
- A client-side web app that runs directly in the browser via WebAssembly.

## What is WebAssembly?

WebAssembly (WASM) is an open binary standard. It defines a portable code format for programs designed to run in web browsers. WebAssembly is a textual assembly language with a compact binary format for fast downloads and near-native performance.

WebAssembly provides a compilation target for languages such as C, C++, and Rust. It's designed to run alongside JavaScript so that both work together. WebAssembly also can generate progressive web applications to be downloaded and run offline.

## What is Blazor WebAssembly?

With Blazor WebAssembly, developers can run .NET code in a browser. It's a single-page app framework and uses the WebAssembly open standards without requiring plug-ins or code generation.

.NET code executed via WebAssembly in a browser runs in the browser's JavaScript sandbox. The code includes all the security and protection that the sandbox provides. This inclusion helps prevent malicious actions on a client machine.

Blazor uses a .NET runtime compiled to a WebAssembly module that is downloaded with an app. The module can execute .NET Standard code included in a Blazor app.

A Blazor WebAssembly app is restricted to the capabilities of the browser that executes the app. But the app can access full browser functionality via JavaScript interop.

### Blazor WebAssembly supported browsers

Blazor WebAssembly requires a modern desktop or mobile browser. The following browsers are currently supported:

- Microsoft Edge
- Mozilla Firefox
- Google Chrome
- Apple Safari

## Blazor WebAssembly development requirements

You can build Blazor WebAssembly apps by using the latest version of Visual Studio 2019, Visual Studio for Mac, or Visual Studio Code. In this module, you'll use Visual Studio Code.

Whatever your development environment, you need to install the .NET Core 3.1 SDK. After installation, you'll have everything you need to start building Blazor apps. You'll install all of the requirements to build a Blazor WebAssembly app with Visual Studio Code in the next exercise.
