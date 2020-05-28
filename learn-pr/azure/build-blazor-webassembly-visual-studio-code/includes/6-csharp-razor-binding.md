Now that you have defined the UI for your web app, explore how to add logic to the app. In a Blazor WebAssembly app, you can add C# code in separate .cs files or inline in your Razor components.

## C# code-behind in separate files

In Blazor, you can add C# files directly to your app project as with other .NET projects. Commonly called *code-behind*, this technique uses separate code files to store application logic. Separate code files are a great strategy when your business logic is complex, long, or requires multiple classes and is best stored in one or more code files.

For simple logic, you don't always need to create new .cs files.

## C# inline in components

It's common practice to mix HTML and C# in a single razor component file. For simple components with lighter code requirements, this approach works well. To add code into a razor file, we use directives.

## What are Razor directives?

Razor directives are component markup used to add C# inline with HTML. Directives let you define single statements, methods, or larger code blocks.

### Code directives

Code directives should be familiar to developers who have used Razor in MVC or Pages.

You can use **@expression()** to add a simple C# statement inline with the HTML. Or, if you require more code, use the **@code** directive to add multiple statements enclosed by parentheses.

You can also add an **@functions** section to the template. There you define methods and properties that are added to the top of the generated class, which can then be referenced in the document.

### Page directive

The **@Page** directive is a special directive that identifies a component as a page. Use this directive to specify a route, which maps to an attribute route that the Blazor engine recognizes for registering and accessing the page.

## Razor data binding 

Within Razor components, you can data bind HTML elements to C# fields, properties, or Razor expression values. Data binding enables two-way synchronization between the HTML and .NET.

Data is pushed from the HTML to .NET when the component is rendered. Since components render themselves after event handler code executes, property updates are reflected in the UI immediately after an event handler is triggered.

The `@bind` markup is used to bind a C# variable to an HTML object. You define the C# variable by name as a string in the html. You'll see an example of data binding in the following exercise.
