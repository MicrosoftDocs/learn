Now that we have the UI for our application defined, let's explore how we add logic to our web app. In a Blazor WebAssembly app, you can add C# code in separate .cs files or inline in your components.

## C# Code-behind in separate files 

Code-behind is a common term for the technique of using separate code files to store application logic. In Blazor, we can add C# files directly to our app project like other .NET projects. Separate code files are a great strategy when your business logic is long or complex and is best stored in more or code files.

For simple logic, we don't always need to create new .cs files.

## C# inline in components

It's common practice to mix HTML and C# in a single razor component file. With simple components with lighter code requirements, this approach works well. To add code into a razor page, we use directives.

## What are Razor directives?

Razor directives are markup added to a component used to add C# inline with HTML. Directives allow a developer to define single statements, methods, or larger code blocks.

### Code directives

You can use `@expression()` to add a simple C# statement inline with the html. Or, if more code is required, the `@code` markup allows a developer to add multiple statements enclosed by parenthesis. Code directives be familiar to developers who have used Razor in MVC or Pages. You can also add an `@functions` section to the template to add methods and properties that are added at the top of the generated class, which can then be referenced in the document.

Here's an example of the `@code` markup. Notice, the `@code` markup is followed by a pair of code braces. 

    ```csharp
    @code 
    {
        //add C# statements here
    }
    ```

### Page directive

The `@Page` directive is a special markup added to components used to identify the component a as a page. This allows you to specify a route on this directive, which then maps to an Attribute route that’s recognized by the Blazor engine to register and access the page.

## Razor data binding 

Within Razor components, you can data bind HTML elements to C# fields, properties, or Razor expression values. Data binding enables two-way synchronization between the HTML and .NET.

Data is pushed from the HTML to .NET when the component is rendered. Since components render themselves after event handler code executes, property updates are reflected in the UI immediately after an event handler is triggered.

The `@bind` markup is used to bind a C# variable to an HTML object. You define the C# variable by name as a string in the html. You'll see an example of data binding in the following exercise.