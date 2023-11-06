You've defined the UI for your web app. Now, let's explore how to add logic to the app. In a Blazor app, you can add C# code in separate .cs files or inline in your Razor components.

## C# code-behind in separate files

In Blazor, you can add C# files directly to your app project, as with other .NET projects. This technique is commonly called *code-behind*, and it uses separate code files to store app logic. Separate files are a great strategy when your business logic is complex, long, or has multiple classes.

For simple logic, you don't always need to create new .cs files.

## C# inline in components

It's a common practice to mix HTML and C# in a single Razor component file. For simple components with lighter code requirements, this approach works well. To add code into a Razor file, you use directives.

## What are Razor directives?

Razor directives are component markup used to add C# inline with HTML. With directives, developers can define single statements, methods, or larger code blocks.

### Code directives

Code directives should be familiar to developers who have used Razor in MVC or Pages.

You can use `@()` to add a C# statement inline with HTML. If you require more code, use the `@code` directive to add multiple statements, enclosed by curly brackets.

You can also add an `@functions` section to the template for methods and properties. They're added to the top of the generated class, where the document can reference them.

### Page directive

The `@page` directive is special markup that identifies a component as a page. You can use this directive to specify a route. The route maps to an attribute route that the Blazor engine recognizes to register and access the page.

## Razor data binding

Within Razor components, you can data bind HTML elements to C# fields, properties, and Razor expression values. Data binding allows two-way synchronization between HTML and Microsoft .NET.

Data is pushed from HTML to .NET when a component is rendered. Components render themselves after event-handler code executes, which is why property updates are reflected in the UI immediately after an event handler is triggered.

You can use `@bind` markup to bind a C# variable to an HTML object. You define the C# variable by name as a string in the HTML. You can see an example of data binding in the following exercise.
