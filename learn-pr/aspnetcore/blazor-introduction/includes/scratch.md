
The following Blazor component displays a weather forecast in a table. Most of the content is standard HTML and the rendering logic is written in C#. The component uses an injected `WeatherService` instance to asynchronously get an array of weather forecast data. While the data is being loaded, the component displays _Loading..._, but once the weather data is loaded the component loops over the array to render each row of the weather forecast table.

```razor
@inject WeatherService WeatherService

<h1>Weather</h1>

@if (forecasts == null)
{
    <p><em>Loading...</em></p>
}
else
{
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Temp. (C)</th>
                <th>Summary</th>
            </tr>
        </thead>
        <tbody>
            @foreach (var forecast in forecasts)
            {
                <tr>
                    <td>@forecast.Date.ToShortDateString()</td>
                    <td>@forecast.TemperatureC</td>
                    <td>@forecast.Summary</td>
                </tr>
            }
        </tbody>
    </table>
}

@code {
    private WeatherForecast[]? forecasts;

    protected override async Task OnInitializedAsync()
    {
        forecasts = await WeatherService.GetWeather();
    }
}
```

## What is Blazor Server?

Blazor Server is an implementation of the Blazor user-interface framework as part of the ASP.NET Core web development framework, deployed to a web server. Developing an application with Blazor Server generates HTML on a web server as it is requested by web site visitors, typically using a web browser. That HTML is then delivered to the visitor's browser, and a two-way communication pipeline is maintained using ASP.NET Core SignalR and preferring a Web Sockets connection.

Users that click buttons, navigate, and perform other interactions with a Blazor Server application have their actions transmitted on this SignalR connection, and the server responds with user-interface updates using the same connection. The Blazor Server framework automatically updates the browser with the content generated on the web server.

## What is Blazor WebAssembly?

Blazor WebAssembly, sometimes shortened to Blazor WASM, is an implementation of the Blazor user-interface framework that runs on the HTML 5 standard WebAssembly runtime present in all modern browsers. The binary output of your application, the DLL files, are transmitted to the browser and run with a version of .NET that has been optimized to work with the WebAssembly runtime regardless of the underlying operating system of the device browsing to the website.

Since WebAssembly is a technology that runs entirely in the browser, it's possible to deploy this model of Blazor application using files that a web server doesn't parse or interact with. This type of "static" approach reduces the requirements for a web server and shifts all processing for the application to the user's machine.

Advanced processing and logic can take place in the browser. When the application needs data or to interact with other services, it can use standard web technologies to communicate with HTTP services.

## How to build an application with Blazor

Blazor applications are written with a text editor and built with the .NET tools. You'll choose where you'd like your Blazor application to run. The application can run on the server or in the browser with WebAssembly. Start with a template for the project type that matches where you want your application to run. You'll then write pages using Razor that users can interact with and navigate among. Blazor provides a bridge to allow users to build user-interface elements that interoperate with JavaScript. You can integrate with other services, like a database or web services, to provide extra business value. You can also reference libraries or bundles of features using NuGet packages, the .NET packaging format.

Once you've completed writing the code for your application, you can build it with the .NET compiler tools and publish the resulting application to a web server for your users to access.

### What are Pages?

In Blazor, you'll build a *Page* with Razor that presents a screen of content in the browser. A *Page* typically maps directly to a web address to which a user would navigate in your application.

### What are Components?

Pages would be difficult to build if you had to rewrite every line of HTML without any reuse between pages. You can create *Components* using Razor that can be referenced and used in other components or pages.


