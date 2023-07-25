Blazor components have a well-defined lifecycle that starts when they're first created and ends when they're destroyed. The component lifecycle is governed by a set of events that occur in response to specific triggers. Such triggers include the component being initialized, users interacting with the component, or the page where the component resides being closed.

In this unit, you learn about the events that occur during the Blazor component lifecycle. You see how to handle these events to optimize the work done and increase the responsiveness of a Blazor page.

## The Blazor component lifecycle

Blazor components represent the views in Blazor apps, which define the layout and UI logic. The components generate HTML markup when the app runs. User interaction events can trigger custom code, and components can be updated to rerender the display. Upon page closure, Blazor removes the component and cleans up any resources. New instances are created when the user returns to the page.

The following diagram illustrates the events that occur during the lifetime of a component, and the methods you can use to handle these events. Blazor provides both synchronous and asynchronous versions of each method except for `SetParametersAsync`.

All Blazor components descend from the <xref:Microsoft.AspNetCore.Components.ComponentBase> class or the <xref:Microsoft.AspNetCore.Components.IComponent> that defines the methods shown and provides default behavior. You handle an event by overriding the corresponding method.

:::image type="content" source="../media/4-component-lifecycle.png" lightbox="../media/4-component-lifecycle.png" alt-text="The Blazor component lifecycle.":::

Although the diagram implies that there's a single-threaded flow between lifecycle methods, the asynchronous versions of these methods enable a Blazor app to expedite the rendering process. For example, when the first `await` occurs in `SetParametersAsync`, the Blazor component runs the `OnInitialized` and `OnInitializedAsync` methods. When the awaited statement completes, the execution thread in `SetParametersAsync` resumes.

The same logic applies throughout the series of lifecycle methods. Also, each `await` operation that occurs during `OnInitializedAsync` and `OnParametersSetAsync` indicates that the state of the component has changed, and can trigger an immediate rendering of the page. The page might be rendered several times before initialization is fully complete.

## Understand lifecycle methods

Each component lifecycle method has a specific purpose, and you can override the methods to add custom logic to your component. The following table lists the lifecycle methods in the order they occur, and describes their purpose.

| Order | Lifecycle method | Description |
|---|---|---|
| **1** | Component created | The component is instantiated. |
| **2** | <xref:Microsoft.AspNetCore.Components.ComponentBase.SetParametersAsync%2A> | Sets parameters from the component's parent in the render tree. |
| **3** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnInitialized%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnInitializedAsync%2A> | Occurs when the component is ready to start. |
| **4** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnParametersSet%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnParametersSetAsync%2A> | Occurs when the component has received parameters and properties have been assigned. |
| **5** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRender%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRenderAsync%2A> | Occurs after the component has rendered. |
| **6** | `Dispose` / `DisposeAsync` | If the component implements either <xref:System.IDisposable> or <xref:System.IAsyncDisposable>, the appropriate disposable occurs as part of destroying the component. |

### The SetParametersAsync method

When a user visits a page that contains a Blazor component, the Blazor runtime creates a new instance of the component and runs the default constructor. Once the component is constructed, the Blazor runtime calls the `SetParametersAsync` method.

If the component defines any parameters, the Blazor runtime injects the values for these parameters from the calling environment into the component. These parameters are contained in a `ParameterView` object and are made accessible to the `SetParametersAsync` method. You call the `base.SetParametersAsync` method to populate the `Parameter` properties of your component with these values.

Alternatively, if you need to handle the parameters differently, this method is the place to do it. For example, you might need to validate any parameters passed to the component before using them.

> [!NOTE]
> The `SetParametersAsync` method always runs when a component is being created, even if the component doesn't have any parameters.

### The OnInitialized and OnInitializedAsync methods

You can override the `OnInitialized` and `OnInitializedAsync` methods to include custom functionality. These methods run after the `SetParametersAsync` method populates the component's parameter-based properties, which are attributed with either <xref:Microsoft.AspNetCore.Components.ParameterAttribute> or <xref:Microsoft.AspNetCore.Components.CascadingParameterAttribute>. You run initialization logic in these methods.

If the `render-mode` property of the application is set to `Server`, the `OnInitialized` and `OnInitializedAsync` methods run only once for a component instance. If a parent of the component modifies the component parameters, the `SetParametersAsync` method runs again, but these methods don't. If you need to reinitialize a component when the parameters change, use the `SetParametersAsync` method. If you want to do initialization once, use these methods.

If the `render-mode` property is set to <xref:Microsoft.AspNetCore.Mvc.Rendering.RenderMode.ServerPrerendered>, the `OnInitialized` and `OnInitializedAsync` methods run twice: once during the prerender phase that generates the static page output, and again when the server establishes a SignalR connection with the browser. You might do expensive initialization tasks in these methods, such as retrieving data from a web service that you use to set the Blazor component state. In this case, cache the state information during the first execution and reuse the saved state during the second execution.

Any dependencies the Blazor component uses are injected when the instance has been created but before the `OnInitialized` or `OnInitializedAsync` methods run. You can use the objects injected by these dependencies in the `OnInitialized` or `OnInitializedAsync` methods, but not before.

> [!IMPORTANT]
> Blazor components don't support constructor dependency injection. Instead, use either the `@inject` directive in the component markup or the <xref:Microsoft.AspNetCore.Components.InjectAttribute> on the property declaration.

During the prerender phase, code in a Blazor Server component can't perform actions that require a connection to the browser, such as calling JavaScript code. You should place logic that depends on a connection with the browser in the `OnAfterRender` or `OnAfterRenderAsync` methods.

### The OnParametersSet and OnParametersSetAsync methods

The `OnParametersSet` and `OnParametersSetAsync` methods run after the `OnInitialized` or `OnInitializedAsync` methods the first time the component renders, or after the `SetParametersAsync` method in subsequent rendering. Like `SetParametersAsync`, these methods are always called, even if the component has no parameters.

Use either method to complete initialization tasks that depend on the component parameter values, such as calculating values for computed properties. Don't do long-running operations such as these in a constructor. Constructors are synchronous, and waiting for long-running operations to complete affects the responsiveness of the page that contains the component.

### The OnAfterRender and OnAfterRenderAsync methods

The `OnAfterRender`and `OnAfterRenderAsync` methods run every time the Blazor runtime needs to update the view represented by the component in the user interface. This state occurs automatically when:

- The state of the component changes, for example when the `OnInitialized` or `OnInitializedAsync` methods or the `OnParametersSet` and `OnParametersSetAsync` methods run.
- A UI event is triggered.
- The application code calls the `StateHasChanged` method of the component.

When <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged%2A> is called, either from an external event or a UI trigger, the component conditionally rerenders. The following list details the order of method invocations including and following `StateHasChanged`:

1. <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged%2A>: The component is marked as needing to rerender.
2. <xref:Microsoft.AspNetCore.Components.ComponentBase.ShouldRender%2A>: Returns a flag indicating whether the component should render.
3. <xref:Microsoft.AspNetCore.Components.ComponentBase.BuildRenderTree%2A>: Renders the component.

The `StateHasChanged` method calls the `ShouldRender` method of the component. The purpose of this method is to determine whether the state change requires the component to rerender the view. By default, all state changes trigger a render operation, but you can override the `ShouldRender` method and define your decision-making logic. The `ShouldRender` method returns `true` if the view should be rendered again, or `false` otherwise.

If the component needs rendering, you can use the `BuildRenderTree` method to generate a model that can update the version of the DOM the browser uses to display the UI. You can use the default method implementation that the `ComponentBase` class provides, or you can override it with custom logic if you have specific requirements.

Next, the component view is rendered and the UI is updated. Finally, the component runs the `OnAfterRender` and `OnAfterRenderAsync` methods. At this point, the UI is fully functional, and you can interact with JavaScript and any elements in the DOM. Use these methods to do any other steps that require access to the fully rendered content, such as calling JavaScript code from JS interop.

The `OnAfterRender` and `OnAfterRenderAsync` methods take a boolean parameter called `firstRender`. This parameter is `true` the first time the methods are run, but `false` thereafter. You can evaluate this parameter to do one-time operations that might be wasteful and too resource intensive if they're repeated every time the component renders.

> [!NOTE]
> Don't confuse prerendering with the first render for a Blazor component. Prerendering occurs before a SignalR connection is established with the browser, and generates a static version of a page. The first render occurs when the connection with the browser is fully active and all functionality is available.

### The Dispose and DisposeAsync methods

Like any .NET class, a Blazor component can use managed and unmanaged resources. The runtime automatically reclaims managed resources. However, you should implement the `IDisposable` or `IAsyncDisposable` interfaces and provide a `Dispose` or `DisposeAsync` method to release any unmanaged resources. This practice reduces the chances of memory leaks in the server.

## Handle exceptions in lifecycle methods

If a lifecycle method for a Blazor component fails, it closes the SignalR connection to the browser, which in turn causes the Blazor app to stop functioning. To prevent this outcome, make sure you're prepared to handle exceptions as part of the logic for the lifecycle methods. For more information, see [Handle errors in ASP.NET Core Blazor apps](/aspnet/core/blazor/fundamentals/handle-errors).
