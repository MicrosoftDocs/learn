There are many approaches to build web applications. To build web applications that are highly interactive and fast, you usually use plenty JavaScript. 

Another approach is the use to the Blazor framework by Microsoft, which allows you to use a mixture of C# and JavaScript while compiling to WASM, web assembly. Assembly language that your browser knows how to run.

## What is Blazor

Blazor is a framework for building web pages with HTML, CSS, and C#. We can define the layout and design of the website using standard HTML and CSS. The interactive components of the web pages can then be managed with C# code that runs on a server or in the browser using a web standard technology called WebAssembly. The formatting of HTML and CSS build on what we learned in our previous sessions, using the Razor template language. Blazor allows us to define our web pages using Razor and include other Razor files as components inside those pages. This capability means we can build and reuse parts of our application easily.

## What is WebAssembly?

WebAssembly is a standard technology available in every modern browser that allows code to run, similar to JavaScript, in a browser. We can use tools to prepare our C# code for use in the browser as a web assembly application, and these tools are bundled into the .NET command-line application.

## Visual Studio feature - Instant application update with "Hot reload"

When you develop an application, you want to make sure your developer flow is fast, from change, to rebuilding the project to seeing how this change affects your application. It can be time consuming to make a change, save it, rebuild all resource and redeploy the app in the browser.

A feature in Visual Studio you can use to improve this workflow is "Hot reload". The idea is that you do a change, save said change and the application builds and relaunches in the browser.

## Blazor components

When you create apps using Blazor your app consists of many components, each with their own area of responsibility. Creating the components, you use something called Razor, so what is Razor?

Razor is an ASP.NET programming syntax, which helps you mix HTML syntax with C# code, here's an example:

```csharp
<div>@product.Name</div>

@code {
  Product product = new Product{ Name = "Blazor" }
}
```

In this example, `@product.Name` is resolved to the string "Blazor".

### The component

So we understand we're mixing C# code and HTML, what else do we need to know? Let's have a closer look at a code example from a component:

```csharp
<h3>Board</h3>
    
@code {

}
```

The top part consists of HTML markup and everything within `@code {}` contains C# code. Razor will continue interpreting C# code after the @ until it identifies a tag and then resumes to render normally.

## Styling a Blazor component

There are two approaches we look at on how you could style a Blazor component:

- **Styling a component**, using a CSS isolation. Blazor components and pages have a feature called CSS isolation that allows you to create style rules that only apply to the contents of that component or page. By creating a file with the same name as our component and adding the .css filename extension, Blazor recognizes this naming as the styles that should ONLY be applied to HTML content in the Board.razor template.

- Styling Blazor component, inline. Blazor components can define content to be added to the HTML head of the page using a special HeadContent tag.

    ```csharp
    <HeadContent>
        <style>
            ...my styles here
        </style>
    </HeadContent>
    ```

    This style tag and contents are delivered inside the head tag on the page.

## The index file, the default route component

The *Index.razor* file is a Page that can be navigated to and contains HTML, C#, and references to other Blazor components. We can identify this file as a page due to the presence of the `@page "/"` directive on the first line. This directive instructs Blazor to respond with the contents of this file when the default page at the "/" address is requested.
