Blazor uses C# components rather than JavaScript to create web pages or HTML sections with dynamic content. But you can use Blazor JavaScript interoperability (JS interop) to call JavaScript libraries in Blazor apps and call JavaScript functions from .NET C# code.

In this unit, you learn how to call JavaScript from C# code in a Blazor page, and how to invoke C# methods from JavaScript functions. In the next unit, you use an alert component from a JavaScript library to update your Blazor pizza delivery website.

## Use Blazor JavaScript interoperability

A typical Blazor component uses layout and user interface logic to render HTML at runtime. You use C# code to handle events and other dynamic page features that interact with the user and external services. In many cases, you don't need to use JavaScript code. Instead, you can use Blazor with .NET libraries, which provide many equivalent capabilities.

However, sometimes you need to use an existing JavaScript library. For example, some open-source JavaScript libraries render components and handle user interface elements in a specialized manner. Or, you might have existing tried and tested JavaScript code that you want to reuse instead of converting it into C#.

You can integrate JavaScript libraries into your applications by using Blazor JavaScript interoperability, or *JS interop*. You use JS interop to call JavaScript functions from .NET methods and to invoke .NET methods from JavaScript functions. JS interop handles the marshaling of data and object references between Blazor and JavaScript to ease the transition between them.

## Load JavaScript code in a Blazor app

You add JavaScript to a Blazor app the same way you add it to a standard HTML web app, by using the HTML `<script>` element. You add the `<script>` tag after the existing `<script src="_framework/blazor.*.js"></script>` tag in either the *Pages/_Host.cshtml* file or the *wwwroot/index.html* file, depending on your Blazor hosting model. For more information, see [ASP.NET Core Blazor hosting models](/aspnet/core/blazor/hosting-models).

It's best not to place scripts in the `<head>` element of the page. Blazor controls only the content in the `<body>` element of an HTML page, so JS interop could fail if the scripts depend on Blazor. Also, the page might display more slowly because of the time it takes to parse the JavaScript code.

The `<script>` tag operates as it does in an HTML web app. You can write code directly in the body of the tag, or you can reference an existing JavaScript file. For more information, see [ASP.NET Core Blazor JavaScript interoperability (JS interop): Location of JavaScript](/aspnet/core/blazor/javascript-interoperability#location-of-javascript).

> [!IMPORTANT]
> Place JavaScript files under the *wwwroot* folder of your Blazor project.

Another option is to inject the `<script>` element that references a JavaScript file into the *Pages/_Host.cshtml* page dynamically. This approach is useful if you need to load different scripts depending on conditions that can be determined only at runtime. This approach can also speed up the initial loading of the app if you trigger the logic with an event that fires after a page is rendered. For more information, see [ASP.NET Core Blazor startup](/aspnet/core/blazor/fundamentals/startup).

## Call JavaScript from .NET code

You use the <xref:Microsoft.JSInterop.IJSRuntime> to call a JavaScript function from .NET code. To make the JS interop runtime available, inject an instance of the `IJSRuntime` abstraction into a Blazor page after the `@page` directive near the beginning of the file.

The `IJSRuntime` interface exposes the <xref:Microsoft.JSInterop.IJSRuntime.InvokeAsync%2A> and <xref:Microsoft.JSInterop.JSRuntimeExtensions.InvokeVoidAsync%2A> methods to invoke JavaScript code. Use `InvokeAsync<TValue>` to call a JavaScript function that returns a value. Otherwise, call `InvokeVoidAsync`. As the names suggest, both methods are asynchronous, so you use the C# `await` operator to capture results.

The parameter to the `InvokeAsync` or `InvokeVoidAsync` method is the name of the JavaScript function to invoke, followed by any arguments the function requires. The JavaScript function must be part of the `window` scope or a subscope of `window`. Arguments must be JSON-serializable.

> [!NOTE]
> JS interop is available only when the Blazor Server app has established a SignalR connection with the browser. You can't make interop calls until rendering is complete. To detect whether rendering has finished, use the <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRender%2A> or <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRenderAsync%2A> event in your Blazor code.

### Use an ElementReference object to update the DOM

Blazor maintains a representation of the Document Object Model (DOM) as a *virtual render tree*. As the page structure changes, Blazor generates a new render tree that contains the differences. When the changes are complete, Blazor iterates through the differences to update the browser display of the user interface and the browser version of the DOM that JavaScript uses.

Many third-party JavaScript libraries are available to render elements on a page, and these libraries can update the DOM. If your JavaScript code modifies elements of the DOM, the Blazor copy of the DOM might no longer match the current state. This situation can cause unexpected behavior and possibly introduce security risks. It's important not to make changes that can cause the Blazor view of the DOM to become corrupted.

The simplest way to handle this situation is to create a placeholder element in the Blazor component, usually an empty `<div @ref="placeHolder"></div>` element. Blazor code interprets this code as a blank space, and the Blazor render tree doesn't attempt to track its contents. You can freely add JavaScript code elements to this `<div>`, and Blazor doesn't attempt to change it.

Blazor app code defines a field of type <xref:Microsoft.AspNetCore.Components.ElementReference> to hold the reference to the `<div>` element. The `@ref` attribute on the `<div>` element sets the value of the field. The `ElementReference` object then passes to a JavaScript function, which can use the reference to add content to the `<div>` element.

## Call .NET code from JavaScript

JavaScript code can run a .NET method your Blazor code defines by using the `DotNet` utility class, part of the JS interop library. The `DotNet` class exposes the `invokeMethod` and `invokeMethodAsync` helper functions. Use `invokeMethod` to run a method and wait for the result, or use `invokeMethodAsync` to call the method asynchronously. The `invokeMethodAsync` method returns a JavaScript `Promise`.

> [!TIP]
> To maintain responsiveness in your applications, define the .NET method as `async`, and call it by using `invokeMethodAsync` from JavaScript.

You must tag the .NET method being called with the <xref:Microsoft.JSInterop.JSInvokableAttribute>. The method must be `public`, and any parameters must be JSON-serializable. Also, for an asynchronous method, the return type must be `void`, a `Task`, or a generic `Task<T>` object where `T` is a JSON-serializable type.

To call a `static` method, you provide the name of the .NET assembly that contains the class, an identifier for the method, and any parameters the method accepts as arguments to the `invokeMethod` or `invokeMethodAsync` functions. By default, the method identifier is the same as the name of the method, but you can specify a different value by using the `JSInvokable` attribute.

### Call a .NET instance method from JavaScript

To run an instance method, JavaScript requires an object reference that points to the instance. JS interop provides the generic <xref:Microsoft.JSInterop.DotNetObjectReference> type you can use to create an object reference in .NET code. The code must make this object reference available to JavaScript.

The JavaScript code can then call `invokeMethodAsync` with the name of the .NET method and any parameters the method requires. To avoid memory leaks, the .NET code should dispose of the object reference when it's no longer needed.
