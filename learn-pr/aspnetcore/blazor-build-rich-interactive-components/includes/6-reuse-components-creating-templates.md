Template components, which can be reused across multiple apps, provide a foundation of tried and tested layout and logic for customization of UI elements.

Template components enable the application of a standardized design across a web app by defining common elements in the template and applying them to all pages. This can streamline updates, as any modifications, such as those resulting from a rebranding, can be made in a central location—the template

In this unit, you'll learn how to create template components, and how you can incorporate them into a Blazor Server application.

## Understand the `RenderFragment` type

A template component supplies the layout and logic for one or more fragments of HTML markup. This HTML is rendered using the context provided by the template component. A template component uses a <xref:Microsoft.AspNetCore.Components.RenderFragment> object as a placeholder into which the markup is inserted at runtime.

> [!TIP]
> A template is just an ordinary Razor component.

To use a template, a consuming component references it as it would any other component. The `ChildContent` name is the default for a `RenderFragment` parameter. You can give the parameter a different name, but you must specify this name when the test page applies the template.

### Understand generic `RenderFragment<T>` parameters

By default, the `RenderFragment` class acts as a placeholder for a block of HTML markup. However, the generic type <xref:Microsoft.AspNetCore.Components.RenderFragment%601> is used to render other types of content by using a type parameter, then providing the logic to handle the specified type in the template component. For example, suppose you want to create a template that displays the items in a collection. You might use a C# `foreach` loop to iterate through the collection and display the items found. However, the collection might contain data of any type, so you need a generic way of rendering each item.

When writing a generic type template component, you need to specify the type parameter in the template component itself, and the consuming component of the template. The following list represents common characteristics of generic type template components.

- The type parameter in a template component is introduced using the `@typeparam` directive. A template component can have multiple type parameters if necessary.
- The template would likely define a parameter containing an enumerable collection of objects of the type specified by the type parameter.
- The template also defines a `ChildContent` parameter based on the generic `RenderFragment` type that takes the same type parameter.

For more information, see [ASP.NET Core Blazor templated components](/aspnet/core/blazor/components/templated-components).
