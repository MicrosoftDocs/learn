Now that we have 

## C# Code-behind in Blazor 

Code-behind is a common term for the technique of using a separate code file to that represents all of the logic for a corresponding page, view, or component. Creating a code-behind in Blazor requires a few steps, but thankfully it's supported by the framework so setup is quite simple. To complete our code-behind we'll need to create a class and then link the code-behind to our markup. Once we have the structure in place, we can move over our existing logic.

## Add C# to components using @code

You can add C# code directly into a razor file using the **@code** razor markup. The @code markup is followed by a pair of code braces.

    ```cshtml
    @code
    {

    }
    ```

## Event Handling

You can handle client-side script events and route them to functions in your code.


## Razor data binding 

Razor components can data bind HTML elements to C# fields, properties or Razor expression values. This enables two-way synchronization between the HTML and .NET.

Data is pushed from the HTML to .NET when the component is rendered. Since components render themselves after event handler code executes, property updates are usually reflected in the UI immediately after an event handler is triggered.

### @bind
