You use Blazor components to define a web page or portion of HTML that includes dynamic content, which you determine by using .NET code. In Blazor, you can formulate dynamic content by using a .NET language, such as C#, instead of using JavaScript.

Suppose you're working for a pizza delivery company to create a new and modern website. You have a library of tried and tested JavaScript components that you want to reuse in your Blazor app. In this unit, you'll learn how to call JavaScript from C# code in a Blazor page. You'll also see how to invoke C# methods from JavaScript functions.

## Understand JavaScript interoperability with Blazor

A typical Blazor component contains layout and user interface logic that's used to generate an HTML page at runtime. You can use C# code to handle events and other dynamic aspects of a page that interact with the user and external services. In many cases, you don't need to utilize JavaScript code because the Blazor model, together with the .NET libraries, provides its own equivalent capabilities. However, there may be occasions when you have an existing JavaScript library that you want to incorporate into your Blazor apps. For example, there are many open-source frameworks and libraries of JavaScript components that can render and handle user interface elements in a specialized manner. You may also have existing tried and tested JavaScript code that you want to reuse, rather than converting it into C#.

Blazor enables you to integrate JavaScript libraries into your applications using Blazor JavaScript interoperability, or *JS interop*. You use JS interop to call JavaScript functions from .NET methods, and invoke .NET methods from JavaScript functions. JS interop handles the marshaling of data and object references between Blazor and JavaScript to make the transition between them as painless as possible.

> [!IMPORTANT]
> Blazor maintains its own representation of the Document Object Model (DOM) as a *virtual render tree*. As the page structure changes, Blazor generates a new render tree that contains the differences. When the changes are complete, Blazor iterates through these differences to update the user interface displayed by the Browser and the Browser version of the DOM used by JavaScript. If your JavaScript code modifies elements of the DOM, the Blazor representation may no longer match the current state. This can result in unexpected behavior, and possibly introduce security risks. The section *Update the DOM with JavaScript using an ElementReference object* later in this unit summarizes how you can address this issue.

## Load JavaScript code in a Blazor app

Use a \<script\> element to load JavaScript code, in the same way that you would use the element in an ordinary, non-Blazor HTML web application. Place the \<script\> tag at the end of the \<body\> element in the *Pages/_Host.cshtml* file, after the line that imports the script *_framework/blazor.server.js*. Don't add a script tag to a Razor (.razor) component file. Equally, don't place scripts in the \<head\> element of the page. Blazor only has control over content in the \<body\> element of an HTML page, so JS interop can fail if the scripts depend on Blazor. Also, the page itself might become slower to display due to the time it takes to parse the JavaScript code.

The \<script\> tag operates as it does in an HTML web app. You can write code directly in the body of the tag, or you can reference an existing JavaScript file. The following code shows examples of a \<script\> tag that loads JavaScript from a file, and another \<script\> tag that defines a JavaScript function inline as part of the page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    ...
</head>
<body>
    ...

    <script src="_framework/blazor.server.js"></script>
    <script src="js/gauge.min.js"></script>
    <script>
        window.myFunc = (param1, param2) => {
            ...
    </script>
</body>
```

> [!NOTE]
> Place JavaScript files under the *wwwroot* folder of the Blazor app. In the example above, the minified gauge.js file is located in the *wwwroot/js* folder of the app.

Another option is to inject a \<script\> element that references a JavaScript file into the *Pages/_Host.cshtml* page dynamically. This approach is useful if you need to load different scripts, depending on environmental or other conditions that can only be determined at runtime. This approach can also speed up the initial loading of the app if you trigger the logic with an event that fires after a page has been rendered. To trigger this interaction, set the *autostart* attribute of the *_framework/blazor.server.js* script to *false* to defer initialization of JS interop. Then add a script that initializes JS interop manually, and chain to a promise that loads your selected script. The example below uses the DOM to add a \<script\> element that loads the *myscript.js* file to the current document. It uses the jQuery library to manipulate the DOM:

```html
<body>
    ...

    <script src="_framework/blazor.server.js" autostart="false"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      window.loadscript = async () => {
          await Blazor.start()
          $('<script/>', 
              {src: 'js/gauge.min.js'}
           ).appendTo('head');
      };
    </script>
</body>
```

### Example: Use an open-source JavaScript library to display temperature data

The following example uses the Canvas Gauges open-source JavaScript library to enhance the display generated by the default Blazor Server App template. The template creates a sample Blazor page named *FetchData.razor* that displays weather forecast data (the data is generated randomly). When you build and run the default app, and select **Fetch data**, you should see a page like this:

:::image type="content" source="../media/2-default-fetch-data-page.png" alt-text="The default Fetch Data page generated by the Blazor Server App template.":::

The Canvas Gauges library provides graphical components that enable you to display temperatures in a more appealing manner. For details about the capabilities of this library, visit the [Canvas Gauges home page](https://canvas-gauges.com/).

You can download the Canvas Gauges library as follows:

1. Open a command prompt window and go to the folder that holds the Blazor Server App project.

1. Move to the *wwwroot* folder, and create a subfolder named *js*

    ```bash
    cd wwwroot
    mkdir js
    ```

1. Move to the js folder, and use the npm utility to download the Canvas Gauges library (you need to have node.js installed to use npm):

    ```bash
    cd js
    npm install canvas-gauges
    ```

    The library, *gauge.min.js*, will be downloaded to the folder *node_modules/canvas-gauges* under the *wwwroot/js* folder in your project.

To use this library on the Fetch Data page of the Blazor Server app, perform the tasks below:

1. Edit the *Pages/_Host.cshtml* file and add a \<script\> element that loads the *gauge.min.js* file to the end of the \<body\> element, after the tag that loads the JS interop script:

    ```html
    <body>
        ...
        <script src="_framework/blazor.server.js"></script>
        <script src="js/node_modules/canvas-gauges/gauge.min.js"></script>
    </body>
    ```

1. Open the *Pages/FetchData.razor* page and add two empty columns to the table heading. You'll use these columns to display the temperatures graphically:

    ```html
    <thead>
        <tr>
            <th>Date</th>
            <th></th>
            <th>Temp. (C)</th>
            <th></th>
            <th>Temp. (F)</th>
            <th>Summary</th>
        </tr>
    </thead>
    ```

1. In the body of the table, add data cells that contain the \<canvas\> elements shown below. The *gauge.min.js* script contains functions that take the various *data-\** attributes and use them to render a thermometer on the canvas with the temperature specified by the *data-value* attribute:

    ```html
    <tr>
      <td>@forecast.Date.ToShortDateString()</td>
      <td>
          <canvas data-width="100" 
                  data-type="linear-gauge" 
                  data-units="°C" 
                  data-min-value="-20" 
                  data-max-value="60" 
                  data-major-ticks="-20, -10, 0, 10, 20, 30, 40, 50, 60"
                  data-value="@forecast.TemperatureC"
          ></canvas>
      </td>
      <td>@forecast.TemperatureC</td>
      <td>
          <canvas data-width="100" 
                  data-type="linear-gauge" 
                  data-units="°F" 
                  data-min-value="-10" 
                  data-max-value="150" 
                  data-major-ticks="-20, -10, 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 120, 130, 140, 150"
                  data-value="@forecast.TemperatureF"
          ></canvas>                    
      </td>
      <td>@forecast.TemperatureF</td>
      <td>@forecast.Summary</td>
    </tr>
    ```

When you build and run the app, and go to the Fetch Data page, the temperatures are displayed graphically using the JavaScript library:

:::image type="content" source="../media/2-fetch-data-page-gauges.png" alt-text="The Fetch Data page showing the gauges rendered using the JavaScript library.":::

### Deploy JavaScript libraries to Azure

If you add a JavaScript file as a local resource in a Blazor Server App project, you must ensure that this file is transferred correctly when you deploy the app to a web server environment, such as an Azure Web Application. If you're using Visual Studio Code, edit the project file (.csproj) for your Blazor Server App project and add an \<ItemGroup\> element similar to that shown below to the parent \<Project\> node. Replace the path and file shown in this example with the location and name of your JavaScript file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  ...

  <ItemGroup>
    <Content Include="wwwroot\js\node_modules\canvas-gauges\gauge.min.js">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
  </ItemGroup>

  ...

</Project>
```

When you publish the app, the file will be copied to the publication folder ready for deployment.

> [!NOTE]
> The process for deploying a Blazor Server App to Azure is outside the scope of this module. It's the topic of a separate module.

## Call JavaScript from .NET code

You use the JS interop runtime to call a JavaScript function from .NET code. To make the JS interop runtime available, inject an instance of the IJSRuntime abstraction into a Blazor page, after the *@page* directive at the top of the file. The example below uses the *fetchdata* page from the default Blazor Server app. This example adds a property named *JS* to the page you can use to run JS interop functions:

```razor
@page "/fetchdata"

@using MyWebApplication.Data
@inject WeatherForecastService ForecastService
@inject IJSRuntime JS

<h1>Weather forecast</h1>
...
```

JS interop provides two methods that you use to invoke JavaScript code: *InvokeAsync* and *InvokeVoidAsync*. Use *InvokeAsync* to call a JavaScript function that returns a value, otherwise run *InvokeVoidAsync*. As the names suggest, both methods are asynchronous, so use the C# `await` operator to capture any results. The parameters to the *InvokeAsync* and *InvokeVoidAsync* methods are the name of the JavaScript function to invoke, followed by any arguments required by the function. The JavaScript function must be part of the *window* scope, or a sub-scope of *window*. Arguments must be serializable as JSON.

> [!NOTE]
> JS interop is only available when the Blazor Server app has established a SignalR connection with the browser. You can't make interop calls until rendering is complete. To detect whether rendering has finished, use the *OnAfterRender* event in your Blazor code. The unit *Improve app interactivity with lifecycle events* later in this module describes this event in more detail.

### Example: Update the title in the page header.

The code in the body of a Blazor Server component doesn't have direct access to the \<head\> element of the page on which it's rendered. If you need to modify some aspect of the header, you can use JS interop to call a JavaScript function that does this work for you. For example, if you want to change the title of the page displayed by the browser to reflect the purpose of the component being displayed, you can call a JavaScript function that updates the \<title\> tag in the \<head\> element. The JavaScript function *changeTitle* below shows an example:

```javascript
window.changeTitle = async (newTitle) => {
    document.title = newTitle;
};
```

To run the *changeTitle* function from a Blazor component, call the *InvokeVoidAsync* method in the *OnAfterRenderAsync* event handler and provide the new title as a parameter. The example below is for the *FetchData.razor* component that displays weather forecast information:

```razor
@code {
    ...

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            await JS.InvokeVoidAsync("changeTitle", "Weather Forecast");
        }
    }
    ...
}
```

The new title appears in the browser tab when the user selects the *Fetch data* page:

:::image type="content" source="../media/2-fetch-data-page-new-title.png" alt-text="The Fetch Data page in the browser. The new title appears in the browser tab.":::

### Update the DOM with JavaScript using an ElementReference object

Many third-party JavaScript libraries are available to render elements on a page. These libraries make update the DOM. As described earlier, Blazor maintains its own copy of the DOM, and it's important not to make changes that can cause the Blazor view of the DOM to become corrupted. The simplest way to handle this situation is to create a placeholder element in the Blazor component. Typically, you might use a \<div\> element. Your Blazor code simply sees this content as a blank space, and the Blazor render tree doesn't attempt to track its contents. In your JavaScript code, you can freely add elements to this \<div\>, and Blazor won't attempt to change it.

You pass a reference to an element from Blazor to JavaScript by creating an *ElementReference* object. The fragment below shows a \<div\> element added to the *Fetch data* page used in the previous examples. This \<div\> will be used to display a line graph showing how the temperature fluctuates over the period covered by the weather forecast. The JavaScript code will use an open-source graphics library named Plotly to generate the graph. For more information about Plotly visit [Plotly JavaScript Open Source Graphing Library](https://plotly.com/javascript/). You create an element reference with the *@ref* attribute, and declare an *ElementReference* field in your Blazor code with the same name. You can then pass this element reference to a JavaScript function using JS interop, as shown here. In this example, the JavaScript function is named *showGraph*. The reference to the \<div\> element, and an array holding the forecast temperatures in degrees Celsius, are provided as arguments:

```razor
@page "/fetchdata"
...
@inject IJSRuntime JS

<h1>Weather forecast</h1>

...
    <table class="table">
        ...
    </table>

    <div @ref=graphPlaceholder></div>
}

@code {
    ...
    private ElementReference graphPlaceholder;
    
    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            ...
            var forecastTemperatures = (from t in forecasts
                                        select t.TemperatureC).ToArray();

            await JS.InvokeVoidAsync("showGraph", graphPlaceholder, forecastTemperatures);
        }
    }

    ...
}
```

In this example, the *@Page/_Host.cshtml* file includes the following script elements. The first script loads the Plotly library. The second script creates the *showGraph* function. The *showGraph* function uses the Plotly library to draw a line graph in the specified \<div\> element:

```html
<body>
    ...
    <script src="https://cdn.plot.ly/plotly-2.3.1.min.js"></script>
    <script>
      window.showGraph = (graphDiv, data) => {
          var plotData = {y: data, type: 'lines'};
          Plotly.newPlot(graphDiv, [plotData], {title: 'Celsius Temperatures by Day'});
      }
    </script>
</body>
```

When the app runs and displays the *Fetch Data* page, the graph appears below the table:

:::image type="content" source="../media/2-fetch-data-page-graph.png" alt-text="The Fetch Data page, showing the graph generated by calling a JavaScript function.":::

### Make JS interop robust

Remember that Blazor server running your Blazor app, and the browser running the JavaScript code that you call from Blazor, are running on different processes. These processes communicate using SignalR across a network connection. Networks are prone to loss of connectivity that can result in exceptions in your code. If an exception occurs when calling the *InvokeAsync* or *InvokeVoidAsync* methods, either as a result of a network issue or because of some application error, JS interop throws a *JSException* exception. You should be prepared to catch and handle this exception in your Blazor code.

By default, JS interop will wait for up to one minute for a network call to succeed before timing out with an exception. You can change this timeout, either globally across your entire Blazor Server app, or on a call-by-call basis. To set a global timeout, configure the circuit options in the Program.cs file's "Add Services to the container" section. For example, to increase the timeout period to 120 seconds, use the code shown below:

```csharp
// Add services to the container.
...
builder.Services.AddServerSideBlazor(options => options.JSInteropDefaultCallTimeout = TimeSpan.FromSeconds(120));
...
```

To specify the timeout for a particular call, provide the timeout period as the second parameter to the *InvokeAsync* or *InvokeVoidAsync* methods (these methods are overloaded). For example:

```csharp
await JS.InvokeVoidAsync("showGraph", TimeSpan.FromSeconds(30), graphPlaceholder, forecastTemperatures);

```

The timeout period specified for a function call overrides any global timeout previously configured.

## Call .NET code from JavaScript

JavaScript code can run a .NET method defined in your Blazor code by using the *DotNet* utility class. This class is part of the JS interop library. The *DotNet* class exposes the helper functions *invokeMethod* and *invokeMethodAsync*. Use *invokeMethod* to run a method and wait for the result, and use *invokeMethodAsync* to call the method asynchronously. The *invokeMethodAsync* method returns a JavaScript `Promise`.

> [!NOTE]
> To maintain responsiveness in your applications, define the .NET method as `async`, and call it using *invokeMethodAsync* from JavaScript.

The .NET method being called must be tagged with the *JSInvokable* attribute. The method must be public, and any parameters must be serializable as JSON. Additionally, for an asynchronous method, the return type must be `void`, a `Task`, or a generic `Task<T>` object where *T* is a JSON serializable type.

In .NET, a method either belongs to a class (a static method), or to an object (an instance method). To call a static method, you provide the name of the .NET assembly containing the class, an identifier for the method, and any parameters the method accepts as arguments to the *invokeMethod* or *invokeMethodAsync* functions. By default, the method identifier is the same as the name of the method, but you can specify a different value with the *JsInvokable* attribute.

### Example: Call a static .NET method from a JavaScript event handler

The following code shows an example based on the weather forecast data in the FetchData.razor page from the Blazor Server App template. The *CalculateAverageAsync* method computes the average for the Fahrenheit and Centigrade temperatures in the *forecasts* array.

> [!NOTE]
> In this example, the *forecasts* array has been changed to `static` to make it directly accessible from a static method. However, this change introduces a bug that only becomes apparent when the Blazor Server App is deployed to a server environment and is run concurrently by multiple users. You'll see how to fix this bug shortly.

```razor
@code {
    private static WeatherForecast[] forecasts; // NOTE CHANGE TO STATIC - CAUSES A BUG

    ...

    [JSInvokable]
    public static async Task<decimal[]> CalculateAveragesAsync()
    {
        var forecastTemperatures = from f in forecasts
                                   select (f.TemperatureF, f.TemperatureC);

        var avgF = await Task.FromResult(forecastTemperatures.Average(t => t.TemperatureF));
        var avgC = await Task.FromResult(forecastTemperatures.Average(t => t.TemperatureC));

        return new[] { (decimal)avgF, (decimal)avgC };
    }
}
```

To illustrate this method in action, add the following footer to the \<table\> on the FetchData.razor page:

```html
...
<table class="table">
    <thead>
        ...
    </thead>
    <tbody>
        ...
    </tbody>
    <tfoot>
        <tr>
            <td><button onclick="calculateAverages()">Averages</button></td>
            <td></td>
            <td id="avgC"></td>
            <td></td>
            <td id="avgF"></td>
            <td></td>
            <td></td>
        </tr>
    </tfoot>
</table>
...
```

This footer contains a button that runs the *calculateAverages* JavaScript function (shown next) when it's clicked. The footer also includes a pair of fields named *avgC* and *avgF* that will be used to display the average temperatures.

You can add the JavaScript function *calculateAverages* shown below to the \<script\> element on the *Pages/_Host.cshtml* file. Replace *WebApplicationAssemblyName* in the call to *DotNet.invokeMethodAsync* with the name of your Blazor application (this should be the same as the name of the assembly containing your Blazor code):

```html
<script>
    ...

    window.calculateAverages = async () => {
        var averages = await DotNet.invokeMethodAsync('WebApplicationAssemblyName', 'CalculateAveragesAsync');
        $('#avgF').html(averages[0]);
        $('#avgC').html(averages[1]);
    };
</script>
```

The *calculateAverages* function runs the *CalculateAveragesAsync* and captures the result in an array named *averages*. The subsequent statements display the values in this array in the *avgF* and *avgC* fields. If you run the application and go to the Fetch Data page, you can click the Averages button, and the results should be displayed in the table footer:

:::image type="content" source="../media/2-fetch-data-page-averages.png" alt-text="The Fetch Data page showing the temperature averages in the table footer.":::

### Call a .NET instance method from JavaScript

To run an instance method, JavaScript requires an object reference that points to the instance. JS interop provides the generic *DotNetReference* type you can use to create an object reference in your .NET code. Your code must make this object reference available to JavaScript. The JavaScript code can then call *invokeMethodAsync* with the name of the .NET method and any parameters required by the method. To avoid memory leaks, your .NET code should dispose of the object reference when it's no longer needed.

### Example: Call a .NET instance method from JavaScript

In the previous example, the JavaScript code ran a static method, which calculated the average values for a static set of data. Making everything static is not a scalable approach in a multi-user system. All users will end up working with the same shared data, possibly corrupting the results. The solution is to switch back to instance data, which is only accessible via an instance method or an object reference from a static method. To achieve this, you must provide an object reference to the current instance of the **FetchData** object to your JavaScript code. In the JavaScript code on the *Pages/_Host.cshtml* page, add the variable and function shown below:

```html
<script>
    ...
    var objectRef;
    
    window.populateObjectRef = (ref) => {
        objectRef = ref;
    };

    ...
</script>
```

The *populateObjectRef* function takes an object reference and caches it in the *objectRef* variable. You can then modify the calculateAverages function to call the .NET CalculateAverages method using this object reference, as shown below:

```html
<script>
    ...
    window.calculateAverages = async () => {
        var averages = await objectRef.invokeMethodAsync('CalculateAveragesAsync');
        $('#avgF').html(averages[0]);
        $('#avgC').html(averages[1]);
    };
</script>
```

The final step is to create the object reference in the .NET code and pass it to JavaScript. Use the *JS.InvokeVoidAsync* method of JS interop to do this. You should also ensure that the object reference is disposed when the *FetchData* object is removed from memory by implementing the *IDisposable* interface and adding the *Dispose* method. The following code highlights the additions to the *FetchData* code on the *FetchData.razor* page. The component uses the *OnAfterRender* event to create the object reference and call the *populateObjectRef* function. As described earlier, timing is important. If you perform these operations before rendering has completed, JS interop will not yet be available:

```razor
...
@implements IDisposable

<h1>Weather forecast</h1>
...

@code {
    ...
    private DotNetObjectReference<FetchData> objRef;
    
    ...

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            objRef = DotNetObjectReference.Create(this);
            await JS.InvokeVoidAsync("populateObjectRef", objRef);
        }
    }

    ...

    public void Dispose()
    {
        objRef?.Dispose();
    }
}
```
