Template components that you can reuse across multiple apps provide a foundation of tried and tested layout and logic for UI element customization. Template components apply a standardized design across a web app by defining common elements and applying them to all pages. Templates can streamline updates, such as rebranding, because you make modifications only at the central template location.

In this unit, you learn about template components and how you can incorporate them into a Blazor application.

## The RenderFragment type

A template component supplies the layout and logic for one or more fragments of HTML markup. The HTML renders by using the context the template component provides. The template component uses a <xref:Microsoft.AspNetCore.Components.RenderFragment> object as a placeholder into which the markup is inserted at runtime.

A template is just an ordinary Razor component. To use a template, a consuming component references it like any other component. The `ChildContent` name is the default for a `RenderFragment` parameter. You can give the parameter a different name, but you must specify this name when the test page applies the template.

## Generic RenderFragment\<T> parameters

By default, the `RenderFragment` class acts as a placeholder for a block of HTML markup. However, you can use the generic type <xref:Microsoft.AspNetCore.Components.RenderFragment%601> to render other types of content by using a type parameter and providing the logic to handle the specified type in the template component.

For example, suppose you want to create a template that displays the items in a collection. You might use a C# `foreach` loop to iterate through the collection and display the items found. However, the collection might contain data of any type, so you need a generic way to render each item.

To write a generic type template component, you need to specify the type parameter in the template component itself, and in the consuming component of the template. The following list represents common characteristics of generic type template components.

- The type parameter in a template component is introduced using the `@typeparam` directive. A template component can have multiple type parameters if necessary.
- The template probably defines a parameter containing an enumerable collection of objects of the type specified by the type parameter.
- The template also defines a `ChildContent` parameter based on the generic `RenderFragment` type that takes the same type parameter.

For more information, see [ASP.NET Core Blazor templated components](/aspnet/core/blazor/components/templated-components).
