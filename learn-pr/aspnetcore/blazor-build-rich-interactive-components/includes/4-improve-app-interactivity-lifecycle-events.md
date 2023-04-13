Blazor components have a well-defined lifecycle. It starts when they're first created and ends when they're destroyed. The component lifecycle is governed by a set of events that occur in response to specific triggers, such as the component being initialized, user interactions, or the page where the component resides being closed.

In this unit, you'll learn about the events that occur during the lifecycle of a Blazor component. You'll see how to handle these events to optimize the work performed and increase the responsiveness of a Blazor page.

## Understand the Blazor component lifecycle

Blazor components represent the views in Blazor apps, defining the layout and UI logic. They generate HTML markup when the app runs. User interaction events can trigger custom code, and components can be updated to re-render the display. Upon page closure, Blazor removes the component and any resources should be cleaned up. New instances are created when the user returns to the page.

The following diagram illustrates the events that occur during the lifetime of a component, and the methods you can use to handle these events. Except for `SetParametersAsync`, Blazor provides synchronous and asynchronous versions of each method. All Blazor components descend from the <xref:Microsoft.AspNetCore.Components.ComponentBase> class (or the <xref:Microsoft.AspNetCore.Components.IComponent>) that defines the methods shown and provides default behavior. You handle an event by overriding the corresponding method.

:::image type="content" source="../media/4-component-lifecycle.png" lightbox="../media/4-component-lifecycle.png" alt-text="The Blazor component lifecycle.":::

Although the diagram implies that there's a single-threaded flow between lifecycle methods, the asynchronous versions of these methods enable a Blazor app to expedite the rendering process. For example, when the first `await` occurs in `SetParametersAsync`, the Blazor component will run the `OnInitialized` and `OnInitializedAsync` methods. When the awaited statement completes, the thread of execution in `SetParametersAsync` will resume. The same logic applies throughout the series of lifecycle methods. Additionally, each `await` operation that occurs during `OnInitializedAsync` and `OnParametersSetAsync` indicates that the state of the component has changed, and can trigger an immediate rendering of the page. The page might be rendered several times before initialization is fully complete.

### Lifecycle methods

Each component lifecycle method has a specific purpose, and you can override them to add custom logic to your component. The following table lists the lifecycle methods in the order they occur, and describes their purpose.

| Order | Lifecycle method | Description |
|---|---|---|
| **1** | Component created | The component is instantiated. |
| **2** | <xref:Microsoft.AspNetCore.Components.ComponentBase.SetParametersAsync%2A> | Sets parameters from component's parent in the render tree. |
| **3** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnInitialized%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnInitializedAsync%2A> | Occurs when component is ready to start. |
| **4** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnParametersSet%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnParametersSetAsync%2A> | Occurs when component has received parameters and properties have been assigned. |
| **5** | <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRender%2A> / <xref:Microsoft.AspNetCore.Components.ComponentBase.OnAfterRenderAsync%2A> | Occurs after the component has been rendered |
| **6** | `Dispose` / `DisposeAsync` | If component implements either <xref:System.IDisposable> or <xref:System.IAsyncDisposable>, appropriate disposable occurs as part of destroying the component. |

When <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged%2A> is called, either from an external event or a UI trigger, the component will conditionally re-render. The following list details the order of method invocations including and following `StateHasChanged`:

- <xref:Microsoft.AspNetCore.Components.ComponentBase.StateHasChanged%2A>: The component is marked as needing to re-render.
- <xref:Microsoft.AspNetCore.Components.ComponentBase.ShouldRender%2A>: Returns a flag indicating whether the component should render.
- <xref:Microsoft.AspNetCore.Components.ComponentBase.BuildRenderTree%2A>: Renders the component.

## Understand the `SetParametersAsync` method

When you visit a page that contains a Blazor component, the Blazor runtime creates a new instance of the component and runs the default constructor. Once the component has been constructed, the Blazor runtime calls the `SetParametersAsync` method. If the component defines any parameters, the Blazor runtime will inject the values for these parameters from the calling environment into the component. These parameters are contained in a `ParameterView` object and are made accessible to the `SetParametersAsync` method. You call the `base.SetParametersAsync` method to populate the `Parameter` properties of your component with these values.

Alternatively, if you need to handle the parameters differently, this is the place to do it. For example, you might need to validate any parameters passed to the component before using them.

> [!TIP]
> The `SetParametersAsync` method always runs when a component is being created, even if the component doesn't have any parameters.

## Understand the `OnInitialized` and `OnInitializedAsync` methods

The `OnInitialized` and `OnInitializedAsync` methods can be overridden to include custom functionality. They run after the `SetParametersAsync` method has populated the component's parameter-based properties (properties attributed with either <xref:Microsoft.AspNetCore.Components.ParameterAttribute> or <xref:Microsoft.AspNetCore.Components.CascadingParameterAttribute>). You run initialization logic in these methods.

If the `render-mode` property of the application is set to `Server*, the *OnInitialized` and `OnInitializedAsync` methods only run once for a component instance. If a parent of the component modifies the component parameters, the `SetParametersAsync` method will run again, but these methods won't. If you need to reinitialize a component should the parameters change, use the `SetParametersAsync` method. If you want to do initialization once, use these methods.

If the `render-mode` property is set to <xref:Microsoft.AspNetCore.Mvc.Rendering.RenderMode.ServerPrerendered>, the `OnInitialized` and `OnInitializedAsync` methods run twice; once during the prerender phase that generates the static output of the page, and again when the server has established a SignalR connection with the browser. If you do expensive initialization tasks such as retrieving data from a web service that you use to set the state of the Blazor component in these methods, cache the state information during the first execution, and reuse this saved state during the second execution.

Any dependencies used by the Blazor component are injected when the instance has been created but before the `OnInitialized` or `OnInitializedAsync` methods run. You can use the objects injected by these dependencies in the `OnInitialized` or `OnInitializedAsync` methods, but not before.

> [!IMPORTANT]
> Blazor components don't support constructor dependency injection. Instead, use either the `@inject` directive in the component markup or the <xref:Microsoft.AspNetCore.Components.InjectAttribute> on the property declaration.

During the prerender phase, code in a Blazor Server component can't perform actions that require a connection to the browser, such as calling JavaScript code. Place logic that depends on a connection with the browser in the `OnAfterRender` or `OnAfterRenderAsync` methods described in the following section.

## Understand the `OnParametersSet` and `OnParametersSetAsync` methods

The `OnParametersSet` and `OnParametersSetAsync` methods run either after the `OnInitialized` or `OnInitializedAsync` methods if this is the first time the component is being rendered, or after the `SetParametersAsync` method if not. Like `SetParametersAsync`, these methods are always called, even if the component has no parameters.

Use either `OnParametersSet{Async}` method to complete initialization tasks that depend on the component parameter values, such as calculating values for computed properties. Don't perform long-running operations such as these in a constructor; constructors are synchronous, and waiting for long-running operations to complete will affect the responsiveness of the page that contains the component.

## Understand the `OnAfterRender`and `OnAfterRenderAsync` methods

The `OnAfterRender`and `OnAfterRenderAsync` methods run every time the Blazor runtime needs to update the view represented by the component in the user interface. This occurs automatically when the state of the component changes (for example, when the `OnInitialized` or `OnInitializedAsync` methods, or the `OnParametersSet` and `OnParametersSetAsync` methods run) when a UI event is triggered, or if the application code calls the `StateHasChanged` method of the component.

The `StateHasChanged` method calls the `ShouldRender` method of the component. The purpose of this method is to determine whether the state change requires the component to rerender the view. By default, all state changes trigger a render operation, but you can override the `ShouldRender` method and define your decision-making logic. The `ShouldRender` method returns `true` if the view should be rendered again, or `false` otherwise.

If the component needs rendering, the `BuildRenderTree` method is used to generate a model that can be used to update the version of the DOM used by the browser to display the UI. You can use the default implementation of this method provided by the `ComponentBase` class, or you can override it with custom logic if you have specific requirements.

Next, the component view is rendered and the UI is updated. Finally, the component runs the `OnAfterRender` and `OnAfterRenderAsync` methods. At this point, the UI is fully functional and you can interact with JavaScript and any elements in the DOM. Use these methods to perform any other steps that require access to the fully rendered content, such as JavaScript code called from JS interop.

The `OnAfterRender` and `OnAfterRenderAsync` methods take a boolean parameter called `firstRender`. This parameter is `true` the first time the methods are run, but `false` thereafter. You can evaluate this parameter to do one-time operations that might be wasteful and too resource-intensive if they're repeated every time the component is rendered.

> [!NOTE]
> Don't confuse prerendering with the first render for a Blazor component. Prerendering occurs before a SignalR connection is established with the browser, and is used to generate a static version of a page. The first render occurs when the connection with the browser is fully active, and all functionality is available.

## Understand the `Dispose` and `DisposeAsync` methods

Like any .NET class, a Blazor component can use managed and unmanaged resources. Managed resources will be reclaimed automatically by the runtime. However, you should implement the `IDisposable` or `IAsyncDisposable` interfaces, and provide a `Dispose` or `DisposeAsync` method to release any unmanaged resources. This will reduce the chances of memory leaks in the server.

## Handle exceptions in lifecycle methods

If a lifecycle method for a Blazor component fails, it closes the SignalR connection to the browser that in turn will cause the Blazor app to stop functioning. Ensure that you've prepared to handle exceptions as part of the logic for the lifecycle methods to prevent this situation from arising. For more information, see [Handle errors in ASP.NET Core Blazor apps](/aspnet/core/blazor/fundamentals/handle-errors).
