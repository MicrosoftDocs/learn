Blazor components have a well-defined lifecycle. It starts when they're first created and ends when they're destroyed. The component lifecycle is governed by a small set of events that occur in response to specific triggers, such as the component being initialized, the user interacting with the component, or the page on which the component resides being closed.

In this unit, you'll learn about the events that occur during the lifecycle of a Blazor component. You'll see how to handle these events to optimize the work performed and increase the responsiveness of a Blazor page.

## Understand the Blazor component lifecycle

Blazor components are a constituent part of any Blazor app. All views rendered by a Blazor app are created by using components. A Blazor component defines the layout and user interface logic for a view.

When a Blazor app starts running, it creates one or more components and uses those components to generate the HTML markup displayed by the browser. When the user interacts with a page in the browser, by clicking a button for example, a user interface event occurs. You can capture this event and write custom code that completes the processing required to handle it. Events can also be triggered by an external stimulus, such as a timer, or a remote service. In each case, you can determine whether the event should update the component and cause the display to be re-rendered.

When the user closes a page, perhaps by going to a different URL in the same app, the component is removed from the render tree maintained by Blazor. If your component uses unmanaged resources, you should dispose of these at this point. If the user returns to the page, a new instance of the component will be created, and the lifecycle begins again.

The diagram below illustrates the events that occur during the lifetime of a component, and the methods you can use to handle these events. Except for *SetParametersAsync*, Blazor provides synchronous and asynchronous versions of each method. All Blazor components descend from the *ComponentBase* class that defines the methods shown and provides default behavior. You handle an event by overriding the corresponding method. The following sections discuss these methods and events in more detail.

:::image type="content" source="../media/4-component-lifecycle.png" alt-text="The Blazor component lifecycle.":::


Although the diagram implies that there's a single threaded flow between lifecycle methods, the asynchronous versions of these methods enable a Blazor app to expedite the rendering process. For example, when the first `await` occurs in *SetParametersAsync*, the Blazor component will run the *OnInitialized* and *OnInitializedAsync* methods. When the awaited statement completes, the thread of execution in *SetParametersAsync* will resume. The same logic applies throughout the series of lifecycle methods. Additionally, each `await` operation that occurs during *OnInitializedAsync* and *OnParametersSetAsync* indicates that the state of the component has changed, and can trigger an immediate rendering of the page. The page might be rendered several times before initialization is fully complete. The logic in your component should take this into account. For example, the sample *FetchData.razor* component in the Blazor Server app template contains the following code that creates and populates the *forecasts* array asynchronously in the *OnInitializedAsync* method:

```razor
@code {
    private WeatherForecast[] forecasts;
    ...
    protected override async Task OnInitializedAsync()
    {
        forecasts = await ForecastService.GetForecastAsync(DateTime.Now);
    }
    ...
}
```

It's possible that the page might be rendered before the call to *GetForecastAsync* completes, and the *forecasts* array will still be null. To handle this situation, the markup near the start of the page looks like this:

```razor
@if (forecasts == null)
{
   <p><em>Loading...</em></p>
}
else
{
    ... // display a table of weather forecast data
}
```

If the *GetForecastAsync* operation has not completed, the page displays the *Loading...* message. When the *GetForecastAsync* finishes, the page is rendered again, and this time the *forecasts* array now contains data that's presented as a table.

## Understand the SetParametersAsync method

When you visit a page that contains a Blazor component, the Blazor runtime creates a new instance of the component and runs the default constructor. Once the component has been constructed, the Blazor runtime calls the *SetParametersAsync* method. If the component defines any parameters, the Blazor runtime will inject the values for these parameters from the calling environment into the component. These parameters are contained in a *ParameterView* object and are made accessible to the *SetParametersAsync* method. You call the *base.SetParametersAsync* method to populate the *Parameter* properties of your component with these values. Alternatively, if you need to handle the parameters in a different way, this is the place to do it. For example, you might need to validate any parameters passed to the component before using them. The fragment below shows an example. The component expects a parameter that contains a `DateTime` value. If this parameter isn't provided when the component is created, the *SetParametersAsync* sets a message string that's displayed by the component, and defaults the parameter to the current date and time.

> [!NOTE]
> The *SetParametersAsync* method always runs when a component is being created, even if the component doesn't have any parameters.

```razor
@page "/fetchdata"

...
@inject WeatherForecastService ForecastService
...

<p>@validationMsg</p>
...

@code {
    ...
    private string validationMsg;
    ...

    [Parameter]
    public DateTime DateParam { get; set; }
    
    public override async Task SetParametersAsync(ParameterView parameters)
    {
        if (parameters.TryGetValue<string>(nameof(DateParam), out var value))
        {
            if (value is null)
            {
                validationMsg = "The date should not be null. Defaulting to Now";
                DateParam = DateTime.Now; // default to current date and time if not set
            }
        }

        await base.SetParametersAsync(parameters);
    }
    ...
}
```

## Understand the OnInitialized and OnInitializedAsync methods

These methods are also inherited from the *ComponentBase* class, and you can override them to include your own functionality. They run after the *SetParametersAsync* method has populated the components *Parameter* properties. You can do extra initialization in these methods if necessary.

If the *render-mode* property of the application is set to *Server*, the *OnInitialized* and *OnInitializedAsync* methods only run once for a component instance. If a parent of the component modifies the component parameters, the *SetParametersAsync* method will run again, but these methods will not. If you need to reinitialize a component should the parameters change, use the *SetParametersAsync* method. If you want to do initialization once, use these methods. 

If the *render-mode* property is set to *ServerPrendered*, the *OnInitialized* and *OnInitializedAsync* methods run twice; once during the prerender phase that generates the static output of the page, and again when the server has established a SignalR connection with the browser. If you do expensive initialization tasks such as retrieving data from a web service that you use to set the state of the Blazor component in these methods, cache the state information during the first execution, and reuse this saved state during the second execution. For example, in the code for the *FetchData.razor* page, you could use the null-coalescing assignment operator to call the *GetForecastAsync* web method. The web method is only run if the *forecasts* variable is null:

```razor
@code {
    private WeatherForecast[] forecasts;
    ...
    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();
        forecasts ??= await ForecastService.GetForecastAsync(DateTime.Now);
    }
    ...
}
```

Any dependencies used by the Blazor component are injected when the instance has been created but before the *OnInitialized* or *OnInitializedAsync* methods run. You can use the objects injected by these dependencies in the *OnInitialized* or *OnInitializedAsync* methods, but not before.

> [!NOTE]
> Constructors for Blazor components don't support dependency injection.

Also note that during the prerender phase, code in a Blazor Server component cannot perform actions that require a connection to the browser, such as calling JavaScript code. Place logic that depends on a connection with the browser in the *OnAfterRender* or *OnAfterRenderAsync* methods described in the section below.

## Understand the OnParametersSet and OnParametersSetAsync methods

These methods run either after the *OnInitialized* or *OnInitializedAsync* methods if this is the first time the component is being rendered, or after the *SetParametersAsync* method if not. Like *SetParametersAsync*, these methods are always called, even if the component has no parameters.

Use this method to complete initialization tasks that depend on the component parameter values, such as calculating values for computed properties. Don't perform long-running operations such as these in a constructor; constructors are synchronous, and waiting for long-running operations to complete will affect the responsiveness of the page that contains the component.

## Understand the OnAfterRender and OnAfterRenderAsync methods

These methods run every time the Blazor runtime needs to update the view represented by the component in the user interface. This occurs automatically when the state of the component changes (for example, when the *OnInitialized* or *OnInitializedAsync* methods, or the *OnParametersSet* and *OnParametersSetAsync* methods run), when a UI event is triggered, or if the application code calls the *StateHasChanged* method of the component. This method is inherited from *ComponentBase*.

The *StateHasChanged* method calls the *ShouldRender* method of the component. The purpose of this method is to determine whether the change in state actually requires the component to rerender the view. By default, all state changes trigger a render operation, but you can override the *ShouldRender* method and define your own decision-making logic. The *ShouldRender* method returns `true` if the view should be rendered again, or `false` otherwise.

If the component needs rendering, the *BuildRenderTree* method is used to generate a model that can be used to update the version of the DOM used by the browser to display the UI. You can use the default implementation of this method provided by the *ComponentBase* class, or you can override it with your own custom logic if you have specific requirements.

Next, the component view is rendered and the UI updated. Finally, the component runs the *OnAfterRender* and *OnAfterRenderAsync* methods. At this point, the UI is fully functional and you can interact with JavaScript and any elements in the DOM. Use these methods to perform any other steps that require access to the fully rendered content, such as JavaScript code called from JS interop.

The *OnAfterRender* and *OnAfterRenderAsync* methods take a boolean parameter called *firstRender*. This parameter is `true` the first time the methods are run, but `false` thereafter. You can query this parameter to do one-time operations that might be wasteful and too resource-consuming if they're repeated every time the component is rendered. The example below is adapted from that shown in an earlier unit in this module. The *OnAfterRenderAsync* method does more JS interop calls to run JavaScript functions, but only for the first time the component view is rendered.

```razor
@page "/fetchdata"

...
@inject IJSRuntime JS
...

@code {
    private WeatherForecast[] forecasts;
    private DotNetObjectReference<FetchData> objRef;
    private ElementReference graphPlaceholder;

    ...

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            objRef = DotNetObjectReference.Create(this);
            await JS.InvokeVoidAsync("populateObjectRef", objRef);

            await JS.InvokeVoidAsync("changeTitle", "Weather Forecast");
            var forecastTemperatures = (from t in forecasts
                                        select t.TemperatureC).ToArray();

            await JS.InvokeVoidAsync("showGraph", TimeSpan.FromSeconds(30), graphPlaceholder, forecastTemperatures);
        }
    }
}
```

> [!NOTE]
> Don't confuse prerendering with the first render for a Blazor component. Prerendering occurs before a SignalR connection is established with the browser, and is used to generate a static version of a page. The first render occurs when the connection with the browser is fully active, and all functionality is available.  

## Understand the Dispose and DisposeAsync methods

Like any .NET class, a Blazor component can use managed and unmanaged resources.  Managed resources will be reclaimed automatically by the runtime. However, you should implement the *IDisposable* or *IAsyncDisposable* interfaces, and provide a *Dispose* or *DisposeAsync* method to release any unmanaged resources. This will reduce the chances of memory leaks in the server. The example below shows a component that uses a *Timer* object. The component uses the `@implements` directive to specify that it implements the *IDisposable* interface. The code includes a simple *Dispose* method to release the resources associated with the *Timer*:

```razor
@page "..."
@using System.Timers
@implements IDisposable

...

@code {
    private Timer timer;

    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();
        timer ??= new Timer(1000);
        ...
    }

    ...

    public void Dispose() => timer?.Dispose();
}
```

## Handle exceptions in lifecycle methods

If a lifecycle method for a Blazor component fails, it closes the SignalR connection to the browser that in turn will cause the Blazor app to stop functioning. Ensure that you've prepared catch and handle exceptions as part of the logic for the lifecycle methods to prevent this situation from arising. In the example below, if the call to the *GetForecastAsync* web method fails in the *OnInitializedAsync* method, the `catch` handler sets a flag that's used to amend the display. The reason for the error is also recorded by using error logging. The user can try the operation again by reloading the page.

```razor
@page "/fetchdata"

...
@using Microsoft.Extensions.Logging
@inject WeatherForecastService ForecastService
@inject ILogger<FetchData> Logger

<h1>Weather forecast</h1>

<p>This component demonstrates fetching data from a service.</p>

@if (loadFailed)
{
    <h1>Sorry, we could not load weather forecast data due to an error.</h1>
} 
else if (forecasts == null)
{
    <p><em>Loading...</em></p>
}
else
{
    ... // display a table of weather forecast data
}

@code {
    private WeatherForecast[] forecasts;
    private bool loadFailed = false;
    ...

    protected override async Task OnInitializedAsync()
    {
        try
        {
            await base.OnInitializedAsync();
            forecasts ??= await ForecastService.GetForecastAsync(DateTime.Now);
        }
        catch (Exception e)
        {
            loadFailed = true;
            Logger.LogWarning(e, "Failed to load weather forecast data");
        }
    }
    ...
}
```
