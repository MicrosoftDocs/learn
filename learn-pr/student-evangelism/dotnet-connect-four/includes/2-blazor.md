There are many approaches to build web apps. To build web apps that are highly interactive and fast, you usually use plenty of JavaScript.

Another approach is the use to the Blazor framework by Microsoft, which allows you to use C# and .NET to handle all of your web development concerns.

## What is Blazor?

Blazor is a framework for building web pages with HTML, CSS, and C#. We can define the layout and design of the website using standard HTML and CSS. The interactive components of the web pages can then be managed with C# code that runs on a server or in the browser using a web standard technology called WebAssembly. Blazor allows us to define our web pages and components using Razor syntax, a convenient mixture of HTML and C#. You can easily reuse Blazor components inside other pages and components. This capability means we can build and reuse parts of our app easily.

## What is WebAssembly?

WebAssembly is a standard technology available in every modern browser that allows code to run, similar to JavaScript, in a browser. We can use tools to prepare our C# code for use in the browser as a WebAssembly app, and these tools are included with the .NET SDK.

## Instantly update your app with Hot Reload

When you develop an app, you want to make sure your developer flow is fast so you can see how changes affect your app. It can be time consuming to make a change, save it, rebuild all resource and redeploy the app in the browser.

You can improve this workflow using Hot Reload. With Hot Reload, you can apply a change to the running app without having to restart it.

## Blazor components

When you create apps using Blazor, your app consists of many components, each with their own area of responsibility. To create components you use Razor files with a *.razor* extension. So, what is Razor?

Razor is a programming syntax that mixes HTML syntax with C# code. Here's an example:

```razor
<div>@product.Name</div>

@code {
  Product product = new Product{ Name = "Blazor" }
}
```

In this example, `@product.Name` is resolved to the string "Blazor", which is then rendered inside of the `div` tag. The rendered output looks like this:

```html
<div>Blazor</div>
```

The top part of the Razor example consists of HTML markup that the component will render when executed. You can render the value of C# expressions using the `@` character. Razor will continue interpreting C# code after the `@` until it identifies a tag and then resumes rendering HTML. You can be explicit about when the C# expression begins and ends using parens: `@(...)`.

Everything within `@code {}` contains C# code for defining members of your generated component class. You can think of a Razor file as a convenient way to define a C# class that defines HTML rendering logic. You use the `@code` block to define C# members for your component type, like fields, properties, and methods.

## Styling a Blazor component

Blazor components render HTML, so you can style Blazor components using normal CSS stylesheets. Alternatively, Blazor components have a feature called CSS isolation that allows you to create style rules that only apply to the contents of that component. By creating a file with the same name as our component and adding the .css filename extension, Blazor recognizes this naming as the styles that should ONLY be applied to HTML content in the corresponding component.

Blazor components can also define content to be added to the HTML head of the page using a special `HeadContent` tag:

```razor
<HeadContent>
    <style>
        ...my styles here
    </style>
</HeadContent>
```

This `style` tag and contents are rendered inside the `head` tag of the page.

## Routable components

The *Home.razor* file is a component that can be navigated to from a web browser. It contains HTML, C#, and references to other Blazor components. We can identify this file as a page due to the presence of the `@page "/"` directive on the first line. This directive assigns the "/" route to the component and instructs Blazor to respond with the contents of this file when the default page at the "/" address is requested.
