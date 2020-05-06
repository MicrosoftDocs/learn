Now that we have our development environment setup, we'll explore the structure of a Blazor WebAssembly project and learn how to add new pages.

## Blazor WebAssembly project file

Blazor WebAssembly projects target .NET Standard, currently version 2.0. Note, this is different that Blazor Server apps which are .NET Core projects.

Blazor WebAssembly Apps target .NET Standard because it runs directly in the browser on a WebAssembly-baed .NET runtime using mono. It's not possible to install .NET directly into a browser.

## Blazor WebAssembly entry point 

The entry point for the application is defined in a C# file named Program.cs. The Program class is instantiated and executed at runtime, and it's Main method is called. 

By default, the Main method configures and creates the .NET WebAssembly object that communicates with the WebAssembly host and loads the app Razor components.

## What is Razor?

Razor is a markup syntax for writing UI components with HTML and C# used in Blazor web apps. Razor  

Razor is based on ASP.NET, and designed for creating web applications. 

## What are Razor components?

A .razor file defines components that make up a portion UI of the app. Components in Blazor are analogous to user controls in ASP.NET Web Forms.

If you explore the project, you'll see that most files .razor files. 

At compile time, each Razor component is built into a .NET class. The class includes common UI elements such as state, rendering logic, lifecycle methods, and event handlers. 




### @page

The @Page directive identifies this View a as a page and you can specify a route on this directive. This maps to an Attribute route that’s then recognized by the Blazor engine to access this page.



Razor Pages are made up of HTML templates mixed with C# code prefixed by @. You can use @expression() or embed full code blocks @{ <code> } just as you would expect from Razor in MVC or Pages. Additionally, you can add a @functions section to the template that allows adding of methods and properties that are added at the top of the generated class, that can then be referenced in the document.







## Blazor Navigation


