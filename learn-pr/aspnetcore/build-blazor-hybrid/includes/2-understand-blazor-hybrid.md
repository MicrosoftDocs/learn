Companies that build web apps and clients apps commonly hire developers for different roles. Some developers create back-end, server-side logic. Some build client-side web apps. Others build native client apps for mobile and desktop platforms. These developers often use different development languages and technologies.

C# and Microsoft .NET are popular choices for building server-side logic. Often client-side web apps are often built with web UI frameworks, which commonly use JavaScript. When it comes to native client apps for desktop and mobile, there are several options available including many for .NET and C#. The use of multiple languages and toolsets requires multiple sets of skills and often requires two separate teams. Also, code to transfer and represent data must be built in both languages and kept in sync. Blazor Hybrid can simplify your development team's tasks, code, and processes by allowing you to use your existing skills and code in building web applications in C# and .NET to build client applications using these same technologies.

In this unit, you'll start with an introduction to Blazor Hybrid, .NET MAUI, and Razor Components.

## What is Blazor?

Blazor apps are composed of reusable web UI components built using C#, HTML, and CSS. With Blazor, developers can build client and server code with C#. They can also share code and libraries with the front-end client code and back-end logic. Using C# for all code simplifies sharing data between the front end and back end, code reuse to accelerate development, and maintenance.

You can use Blazor to generate:

- Server-side code that handles UI interactions over a WebSocket connection.
- A client-side web app that runs directly in the browser via WebAssembly.

## What is WebAssembly?

WebAssembly (WASM) is an open binary standard. It defines a portable code format for programs designed to run in web browsers. WebAssembly is a textual assembly language with a compact binary format for fast downloads and near-native performance.

WebAssembly provides a compilation target for languages such as C, C++, and Rust. It's designed to run alongside JavaScript so that both work together. WebAssembly also can generate progressive web applications to be downloaded and run offline.

## What is Blazor WebAssembly?

With Blazor WebAssembly, developers can run .NET code in a browser. It's a single-page app framework that uses the WebAssembly open standards without requiring plug-ins or code generation.

.NET code executed via WebAssembly in a browser runs in the browser's JavaScript sandbox. The code includes all the security and protection that the sandbox provides. This inclusion helps prevent malicious actions on a client machine.

![Blazor Web Assembly diagram.](../media/blazor-webassembly.png)

Blazor uses a .NET runtime compiled to a WebAssembly module that is downloaded with an app. The module can execute .NET Standard code included in a Blazor app.

A Blazor WebAssembly app is restricted to the capabilities of the browser that executes the app. But the app can access full browser functionality via JavaScript interop.



## What is Blazor Hybrid?

Blazor Hybrid enables developers to blend desktop and mobile native client frameworks with .NET and Blazor.

In a Blazor Hybrid app, Razor components run natively on the device. Components render to an embedded Web View control through a local interop channel. Components don't run in the browser, and WebAssembly isn't involved. Razor components load and execute code quickly, and components have full access to the native capabilities of the device through the .NET platform.

![Blazor Hybrid diagram.](../media/blazor-hybrid.png)

## What is .NET MAUI?

.NET Multi-platform App UI (.NET MAUI) is a cross-platform framework for creating native mobile and desktop apps with C# and XAML. Using .NET MAUI, you can develop apps that can run on Android, iOS, macOS, and Windows from a single shared code-base. One of the key aims of .NET MAUI is to enable you to implement as much of your app logic and UI layout as possible in a single code-base. .NET MAUI unifies Android, iOS, macOS, and Windows APIs into a single API that allows a write-once run-anywhere developer experience, while additionally providing deep access to every aspect of each native platform.

![.NET MAUI architecture diagram.](../media/dotnet-maui.png)

## Blazor Hybrid apps with .NET MAUI

Blazor Hybrid support is built into the .NET MAUI framework. .NET MAUI includes the BlazorWebView control that permits rendering Razor components into an embedded Web View. By using .NET MAUI and Blazor together, you can reuse one set of web UI components across mobile, desktop, and web.

## Blazor Hybrid development requirements

You can build Blazor Hybrid apps by using the latest version of Visual Studio 2022 or Visual Studio 2022 for Mac. In this module, we'll be using Visual Studio 2022 to build our Blazor Hybrid application.

Whatever your development environment, you need to install the **.NET MAUI** workload and the "ASP.NET and web development" workload to ensure the .NET 6.0 SDK and tools are available in Visual Studio.  After installation, you'll have everything you need to start building Blazor Hybrid apps. You'll build your first Blazor Hybrid app with Visual Studio 2022 in the next exercise.
