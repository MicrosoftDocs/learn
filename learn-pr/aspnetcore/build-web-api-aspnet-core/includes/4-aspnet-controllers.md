A controller is a public class with one or more public methods known as actions. By convention, a controller is placed in the project root's Controllers directory. The actions are exposed as HTTP endpoints inside the web API controller.

## Exploring the WeatherForecastController

In the previous exercise, we created a web application that provides sample weather forecast data. Let's take a look at how the sample controller to understand how it works. Here's the code for the entire controller class:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace ContosoPizza.Controllers
{
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

        [HttpGet]
        public IEnumerable<WeatherForecast> Get()
        {
            var rng = new Random();
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
```

### The base class: ControllerBase

The first thing to notice is that this class inherits from the *:::no-loc text="ControllerBase":::* base class. This base class provides a lot of standard functionality for handling HTTP requests, allowing you to focus on the specific business logic for your application.

> [!NOTE]
> If you have experience with Razor Pages or MVC development in ASP.NET Core, you've used the *:::no-loc text="Controller":::*. Don't create a web API controller by deriving from the *:::no-loc text="Controller":::* class. *:::no-loc text="Controller":::* derives from *:::no-loc text="ControllerBase":::* and adds support for views, so it's for handling web pages, not web API requests.

### API Controller class attributes

There two important attributes applied to the *:::no-loc text="WeatherForecastController":::* as shown below.

```csharp
[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
```

`[ApiController]` enables [opinionated behaviors](/aspnet/core/web-api/#apicontroller-attribute) that make it easier to build web APIs. Some behaviors include [parameter source inference](/aspnet/core/web-api/#binding-source-parameter-inference), [attribute routing as a requirement](/aspnet/core/web-api/#attribute-routing-requirement), and [model validation error handling enhancements](/aspnet/core/web-api/#automatic-http-400-responses).

`[Route]` defines the routing pattern `[controller]`. The `[controller]` token is replaced by the controller's name (case-insensitive, without the *:::no-loc text="Controller":::* suffix). Requests to `http://localhost:5000/weatherforecast` are handled by this controller.

> [!NOTE]
> The route may contain static strings, as in `api/[controller]`. In this example, a request to `http://localhost:5000/api/weatherforecast` would be handled by this controller.

### Providing Weather results with the `Get()` method

The *:::no-loc text="WeatherForecastController":::* includes a single controller action, designated by the `[HttpGet]` attribute. This attribute routes HTTP GET requests to the `public IEnumerable<WeatherForecast> Get()`. That's why, in the previous exercise, you saw that requests to `http://localhost:5000/weatherforecast` caused the weather results to be returned. As you'll learn later in this module, there are some other common actions associated with a web API that performs *CRUD* operations (`GET`, `PUT`, `POST`, `DELETE`), but an API controller only needs to implement one controller action as seen in this example.

In this case we are getting the full list of `WeatherForecast` returned. The `GET` operation also allows for retrieving a single item by passing in an identifier. In ASP.NET this can be achieved with the `[HttpGet("{id}")]` attributed, which we will implement in the next exercise.

Now that you've learned the fundamental components of an web API controller, you're ready to create your own `PizzaController` in the next exercise.
