Blazor lets you create web pages or HTML portions with dynamic content via components, utilizing C# rather than JavaScript. You can also use JavaScript libraries in Blazor apps, and call JavaScript functions from .NET code.

Suppose you're working for a pizza delivery company with an existing Blazor website. You're familiar with a JavaScript library that exposes an alert component that you want to reuse in the Blazor app. In this unit, you'll learn how to call JavaScript from C# code in a Blazor page. You'll also see how to invoke C# methods from JavaScript functions.

## Understand JavaScript interoperability with Blazor

A typical Blazor component contains layout and user interface logic that's used to render HTML at runtime. You can use C# code to handle events and other dynamic aspects of a page that interact with the user and external services. In many cases, you don't need to utilize JavaScript code. Instead, you'll use Blazor, together with the .NET libraries, which provide many equivalent capabilities. However, there are occasions when you need some existing JavaScript library. For example, some open-source JavaScript libraries render components and handle user interface elements in a specialized manner. You may also have existing tried and tested JavaScript code that you want to reuse, rather than converting it into C#.

Blazor enables you to integrate JavaScript libraries into your applications using Blazor JavaScript interoperability, or *JS interop*. You use JS interop to call JavaScript functions from .NET methods, and invoke .NET methods from JavaScript functions. JS interop handles the marshaling of data and object references between Blazor and JavaScript to make the transition between them as painless as possible.

> [!WARNING]
> Blazor maintains its own representation of the Document Object Model (DOM) as a *virtual render tree*. As the page structure changes, Blazor generates a new render tree that contains the differences. When the changes are complete, Blazor iterates through these differences to update the user interface displayed by the Browser and the Browser version of the DOM used by JavaScript. If your JavaScript code modifies elements of the DOM, the Blazor representation may no longer match the current state. This can result in unexpected behavior, and possibly introduce security risks.

## Load JavaScript code in a Blazor app

JavaScript is added to a Blazor app in the same way it's added to a standard HTML web app, by using the HTML `<script>` element. To add JavaScript code to a Blazor app, you add the `<script>` tag after the existing `<script src="_framework/blazor.*.js"></script>` tag in either the *Pages/_Host.cshtml* file or the *wwwroot/index.html* file (depending on your Blazor hosting model). For more information, see [ASP.NET Core Blazor hosting models](/aspnet/core/blazor/hosting-models).

It's not generally recommended to place scripts in the `<head>` element of the page. Blazor only has control over the content in the `<body>` element of an HTML page, so JS interop can fail if the scripts depend on Blazor. Also, the page itself might become slower to display due to the time it takes to parse the JavaScript code.

The `<script>` tag operates as it does in an HTML web app. You can write code directly in the body of the tag, or you can reference an existing JavaScript file. For more information, see [ASP.NET Core Blazor JavaScript interoperability (JS interop): Location of JavaScript](/aspnet/core/blazor/javascript-interoperability#location-of-javascript).

> [!IMPORTANT]
> JavaScript files are to be placed under the *wwwroot* folder of your Blazor project.

Another option is to inject the `<script>` element that references a JavaScript file into the *Pages/_Host.cshtml* page dynamically. This approach is useful if you need to load different scripts, depending on environmental or other conditions that can only be determined at runtime. This approach can also speed up the initial loading of the app if you trigger the logic with an event that fires after a page has been rendered. For more information, see [ASP.NET Core Blazor startup](/aspnet/core/blazor/fundamentals/startup).

## Call JavaScript from .NET code

You use the <xref:Microsoft.JSInterop.IJSRuntime> to call a JavaScript function from .NET code. To make the JS interop runtime available, inject an instance of the `IJSRuntime` abstraction into a Blazor page, after the `@page` directive near the top of the file.

There are several methods exposed on the `IJSRuntime` interface to invoke JavaScript code:

- <xref:Microsoft.JSInterop.IJSRuntime.InvokeAsync%2A>
- <xref:Microsoft.JSInterop.JSRuntimeExtensions.InvokeVoidAsync%2A>

Use `InvokeAsync<TValue>` to call a JavaScript function that returns a value, otherwise, call `InvokeVoidAsync`. As the names suggest, both methods are asynchronous, so use the C# `await` operator to capture any results. The parameters to the `InvokeAsync` and `InvokeVoidAsync` methods are the name of the JavaScript function to invoke, followed by any arguments required by the function. The JavaScript function must be part of the `window` scope or a sub-scope of `window`. Arguments must be JSON-serializable.

> [!NOTE]
> JS interop is only available when the Blazor Server app has established a SignalR connection with the browser. You can't make interop calls until rendering is complete. To detect whether rendering has finished, use the <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRender%2A> (or <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRenderAsync%2A>) event in your Blazor code.

### Update the DOM with JavaScript using an `ElementReference` object

Many third-party JavaScript libraries are available to render elements on a page. These libraries can make updates to the DOM. As described earlier, Blazor maintains its own copy of the DOM, and it's important not to make changes that can cause the Blazor view of the DOM to become corrupted. The simplest way to handle this situation is to create a placeholder element in the Blazor component. Typically, you'd use an empty `<div @ref="placeHolder"></div>` element. Your Blazor code sees this content as a blank space, and the Blazor render tree doesn't attempt to track its contents. In your JavaScript code, you can freely add elements to this `<div>`, and Blazor won't attempt to change it. Your Blazor app code defines a field of type <xref:Microsoft.AspNetCore.Components.ElementReference> to hold the reference to the `<div>` element. The `@ref` attribute on the `<div>` element sets the value of the field. The `ElementReference` object is then passed to a JavaScript function. The JavaScript function can then use the reference to the `<div>` element to add content to it.

## Call .NET code from JavaScript

JavaScript code can run a .NET method defined in your Blazor code by using the `DotNet` utility class. This class is part of the JS interop library. The `DotNet` class exposes the helper functions `invokeMethod` and `invokeMethodAsync`. Use `invokeMethod` to run a method and wait for the result, and use `invokeMethodAsync` to call the method asynchronously. The `invokeMethodAsync` method returns a JavaScript `Promise`.

> [!NOTE]
> To maintain responsiveness in your applications, define the .NET method as `async`, and call it using `invokeMethodAsync` from JavaScript.

The .NET method being called must be tagged with the <xref:Microsoft.JSInterop.JSInvokableAttribute>. The method must be `public`, and any parameters must be JSON-serializable. Additionally, for an asynchronous method, the return type must be `void`, a `Task`, or a generic `Task<T>` object where `T` is a JSON-serializable type.

To call a `static` method, you provide the name of the .NET assembly containing the class, an identifier for the method, and any parameters the method accepts as arguments to the `invokeMethod` or `invokeMethodAsync` functions. By default, the method identifier is the same as the name of the method, but you can specify a different value with the `JSInvokable` attribute.

### Call a .NET instance method from JavaScript

To run an instance method, JavaScript requires an object reference that points to the instance. JS interop provides the generic <xref:Microsoft.JSInterop.DotNetObjectReference> type you can use to create an object reference in your .NET code. Your code must make this object reference available to JavaScript. The JavaScript code can then call `invokeMethodAsync` with the name of the .NET method and any parameters required by the method. To avoid memory leaks, your .NET code should dispose of the object reference when it's no longer needed.
