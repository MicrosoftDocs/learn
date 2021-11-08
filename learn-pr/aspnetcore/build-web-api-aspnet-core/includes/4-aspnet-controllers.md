In the previous exercise, we created a web application that provides sample weather forecast data, then interacted with it in the HTTP REPL.

Before we dive in to writing our own `PizzaController`, let's take a look at the code in the sample `WeatherController` to understand how it works. In this section, you'll see how the `WeatherController` uses the `ControllerBase` base class and a few .NET attributes to build a functional web API in a few dozen lines of code. Once we understand those concepts, we'll be ready to write our own `PizzaController`.

## Exploring the WeatherForecastController

Here's the code for the entire `WeatherController` class. Don't worry if it doesn't make sense just yet, we'll go through it step by step.

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

### The base class: ControllerBase

A controller is a public class with one or more public methods known as actions. By convention, a controller is placed in the project root's *Controllers* directory. The actions are exposed as HTTP endpoints via routing, so an HTTP GET request to https://localhost:{PORT}/weatherforecast causes the `Get()` method of the `WeatherForecastController` class to be executed.

The first thing to notice is that this class inherits from the *ControllerBase* base class. This base class provides a lot of standard functionality for handling HTTP requests, allowing you to focus on the specific business logic for your application.

> [!NOTE]
> If you have experience with Razor Pages or MVC development in ASP.NET Core, you've used the *Controller*. Don't create a web API controller by deriving from the *Controller* class. *Controller* derives from *ControllerBase* and adds support for views, so it's for handling web pages, not web API requests.

### API Controller class attributes

There two important attributes applied to the *WeatherForecastController* as shown below.

```csharp
[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
```

`[ApiController]` enables [opinionated behaviors](/aspnet/core/web-api/#apicontroller-attribute) that make it easier to build web APIs. Some behaviors include [parameter source inference](/aspnet/core/web-api/#binding-source-parameter-inference), [attribute routing as a requirement](/aspnet/core/web-api/#attribute-routing-requirement), and [model validation error handling enhancements](/aspnet/core/web-api/#automatic-http-400-responses).

`[Route]` defines the routing pattern `[controller]`. The `[controller]` token is replaced by the controller's name (case-insensitive, without the *Controller* suffix). Requests to `https://localhost:{PORT}/weatherforecast` are handled by this controller.

> [!NOTE]
> The route may contain static strings, as in `api/[controller]`. In this example, a request to `https://localhost:{PORT}/api/weatherforecast` would be handled by this controller.

### Providing Weather results with the `Get()` method

The *WeatherForecastController* includes a single controller action, designated by the `[HttpGet(Name = "GetWeatherForecast")]` attribute. This attribute routes HTTP GET requests to the `public IEnumerable<WeatherForecast> Get()` method. That's why, in the previous exercise, you saw that requests to `https://localhost:{PORT}/weatherforecast` caused the weather results to be returned. As you'll learn later in this module, there are some other common actions associated with a web API that performs *CRUD* operations (`GET`, `PUT`, `POST`, `DELETE`), but an API controller only needs to implement one controller action as seen in this example. 

In this case we are getting the full list of `WeatherForecast` returned. The `GET` operation also allows for retrieving a single item by passing in an identifier. In ASP.NET this can be achieved with the `[HttpGet("{id}")]` attributed, which we will implement in the next exercise.

Now that you've learned the fundamental components of an web API controller, you're ready to create your own `PizzaController` in the next exercise.
