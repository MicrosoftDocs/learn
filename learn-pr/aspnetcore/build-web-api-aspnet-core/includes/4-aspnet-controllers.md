In the previous exercise, you created a web application that provides sample weather forecast data, then interacted with it in the HTTP REPL.

Before you dive in to writing your own `PizzaController` class, let's look at the code in the `WeatherController` sample to understand how it works. In this unit, you learn how `WeatherController` uses the `ControllerBase` base class and a few .NET attributes to build a functional web API in a few dozen lines of code. After you understand those concepts, you're ready to write your own `PizzaController` class.

Here's the code for the entire `WeatherController` class. Don't worry if it doesn't make sense yet. Let's go through it step by step.

```csharp
using Microsoft.AspNetCore.Mvc;

namespace ContosoPizza.Controllers;

[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    private readonly ILogger<WeatherForecastController> _logger;

    public WeatherForecastController(ILogger<WeatherForecastController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetWeatherForecast")]
    public IEnumerable<WeatherForecast> Get()
    {
        return Enumerable.Range(1, 5).Select(index => new WeatherForecast
        {
            Date = DateTime.Now.AddDays(index),
            TemperatureC = Random.Shared.Next(-20, 55),
            Summary = Summaries[Random.Shared.Next(Summaries.Length)]
        })
        .ToArray();
    }
}

```

## The base class: `ControllerBase`

A controller is a public class with one or more public methods known as *actions*. By convention, a controller is placed in the project root's *Controllers* directory. The actions are exposed as HTTP endpoints via routing. So an HTTP `GET` request to `https://localhost:{PORT}/weatherforecast` causes the `Get()` method of the `WeatherForecastController` class to be executed.

The first thing to notice is that this class inherits from the `ControllerBase` base class. This base class provides much standard functionality for handling HTTP requests, so you can focus on the specific business logic for your application.

> [!NOTE]
> If you have experience with Razor Pages or model-view-controller (MVC) architecture development in ASP.NET Core, you've used the `Controller` class. Don't create a web API controller by deriving from the `Controller` class. `Controller` derives from `ControllerBase` and adds support for views, so it's for handling webpages, not web API requests.

## API controller class attributes

Two important attributes are applied to `WeatherForecastController`, as shown in the following code:

```csharp
[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
```

`[ApiController]` enables [opinionated behaviors](/aspnet/core/web-api/) that make it easier to build web APIs. Some behaviors include *parameter source inference*, *attribute routing as a requirement*, and *model validation error-handling*enhancements*.

`[Route]` defines the routing pattern `[controller]`. The controller's name (case-insensitive, without the *Controller* suffix) replaces the `[controller]` token. This controller handles requests to `https://localhost:{PORT}/weatherforecast`.

> [!NOTE]
> The route might contain static strings, as in `api/[controller]`. In this example, this controller would handle a request to `https://localhost:{PORT}/api/weatherforecast`.

## Providing weather results with the `Get()` method

`WeatherForecastController` includes a single controller action, designated by the `[HttpGet(Name = "GetWeatherForecast")]` attribute. This attribute routes HTTP `GET` requests to the `public IEnumerable<WeatherForecast> Get()` method. As you saw in the previous exercise, requests to `https://localhost:{PORT}/weatherforecast` caused the weather results to be returned.

As you learn later in this module, other common actions are associated with a web API that performs CRUD operations (`GET`, `PUT`, `POST`, `DELETE`). But an API controller needs to implement only one controller action.

In this case, you're getting the full list of `WeatherForecast` returned. The `GET` operation also allows for retrieving a single item by passing in an identifier. In ASP.NET, you can retrieve a single item by using the `[HttpGet("{id}")]` attribute. You'll implement that attribute in the next exercise.

Now that you've learned the fundamental components of a web API controller, you're ready to create your own `PizzaController` class.
