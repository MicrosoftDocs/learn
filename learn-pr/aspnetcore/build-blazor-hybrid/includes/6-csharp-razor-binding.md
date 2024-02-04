You've defined the UI for your web app. Now, let's explore how to add logic to the app. In a Blazor app, you can add C# code in separate .cs files or inline in your Razor components.

## C# inline in components

A common practice is to mix HTML and C# in a single Razor component file. For simple components with lighter code requirements, this approach works well. To add code into a Razor file, you'll use Razor syntax.

## What are Razor directives?

Razor directives are component markup used to add C# inline with HTML. With directives, developers can define single statements, methods, or larger code blocks.

### Code directives

Code directives should be familiar to developers who have used Razor in MVC or Pages.

You can use `@expression()` to add a C# statement inline with HTML. If you require more code, use the `@code` directive to add multiple statements enclosed by parentheses.

You can also add an `@functions` section to the template for methods and properties. They're added to the top of the generated class, where the document can reference them.

## Razor data binding

Within Razor components, you can bind HTML elements to data in C# fields, properties, and Razor expression values. Data binding allows two-way synchronization between HTML and your code.

Data is pushed from HTML to .NET when a component is rendered. Components render themselves after event-handler code executes, which is why property updates are reflected in the UI immediately after an event handler is triggered.

Use `@bind` markup to bind a C# variable to an HTML input. You'll see an example of data binding in the next exercise.
