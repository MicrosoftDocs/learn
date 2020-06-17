Now that you have your development environment set up, you'll explore the structure of a Blazor WebAssembly project and learn how to add new pages.

## Blazor WebAssembly project file

Blazor WebAssembly projects target Microsoft .NET Standard, which is currently version 2.0. Blazor WebAssembly apps are different from Blazor Server apps, which are .NET Core projects.

Blazor WebAssembly apps target .NET Standard because it runs directly in a browser on a WebAssembly-based .NET runtime that uses Mono. You can't install .NET directly into a browser.

## Blazor WebAssembly entry point

The entry point for the app is defined in a C# file named Program.cs. When the **Program** class is instantiated and runs, its **Main** method is called.

By default, the **Main** method configures and creates the .NET WebAssembly object. This object communicates with the WebAssembly host and loads the app's Razor components.

## What is Razor?

Razor is a markup syntax that uses HTML and C# for writing UI components of Blazor web apps.

Razor is based on ASP.NET and designed for creating web apps.

## What are Razor components?

A Razor file defines components that make up a portion of the app UI. Components in Blazor are analogous to user controls in ASP.NET Web Forms.

If you explore the project, you'll see that most files are .razor files.

At compile time, each Razor component is built into a .NET class. The class includes common UI elements like state, rendering logic, lifecycle methods, and event handlers.
