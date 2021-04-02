A *controller* is a public class with one or more public methods known as *actions*. By convention, a controller is placed in the project root's *:::no-loc text="Controllers":::* directory. The actions are exposed as HTTP endpoints inside the web API controller.

## Create a controller

1. Select the `Controllers` folder in Visual Studio Code and add a new File called `PizzaController.cs`. 

    An empty class file named *:::no-loc text="PizzaController.cs":::* is created in the *:::no-loc text="Controllers":::* directory. The directory name *:::no-loc text="Controllers":::* is a convention. The directory name comes from the Model-View-**Controller** architecture used by the web API.

    > [!NOTE]
    > By convention, controller class names are suffixed with *:::no-loc text="Controller":::*.

1. Add the following code to *:::no-loc text="Controllers/PizzaController.cs":::*. Save your changes.

    ```csharp
    using System.Collections.Generic;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc;
    using ContosoPizza.Models;
    using ContosoPizza.Services;

    namespace ContosoPizza.Controllers
    {
        [ApiController]
        [Route("[controller]")]
        public class PizzaController : ControllerBase
        {
            public PizzaController()
            {
            }

            // GET all action

            // GET by ID action

            // POST action

            // PUT action

            // DELETE action
        }
    }
    ```

    This class derives from `ControllerBase`, the base class for an MVC controller without web UI support. The following attributes define its behavior:

    * `[Route]` defines the routing pattern `[controller]`. The `[controller]` token is replaced by the controller's name (case-insensitive, without the *:::no-loc text="Controller":::* suffix). Requests to `http://localhost:5000/pizza` are handled by this controller.
    * `[ApiController]` enables opinionated behaviors that make it easier to build web APIs. Some behaviors include [parameter source inference](/aspnet/core/web-api/#binding-source-parameter-inference), [attribute routing as a requirement](/aspnet/core/web-api/#attribute-routing-requirement), and [model validation error handling enhancements](/aspnet/core/web-api/#automatic-http-400-responses).

    > [!NOTE]
    > The route may contain static strings, as in `api/[controller]`. In that example, a request to `http://localhost:5000/api/pizza` would be handled by this controller.

## Get all pizza

The first REST verb that we need to implement is `GET` where a client could get all pizzas from the API. We can use the built in `[HttpGet]` attribute to define a method that will return the pizzas from our service.
    
    ```csharp
    [HttpGet]
    public ActionResult<List<Pizza>> GetAll() =>
        PizzaService.GetAll();
    ```

The preceding action:

* Responds only to the HTTP GET verb, as denoted by the `[HttpGet]` attribute.
* Queries the service for all pizza and automatically returns it as `json`

## Retrieve a single pizza

The client may also want to request to get information about a specific pizza instead of the entire list. We can implement another `GET` action that requires an `Id`. We can use the built in `[HttpGet("{id}")]` attribute to define a method that will return the pizzas from our service.
    
    ```csharp
    [HttpGet("{id}")]
    public ActionResult<Pizza> Get(int id)
    {
        var pizza = PizzaService.Get(id);

        if(pizza == null)
        {
            return NotFound();
        }

        return pizza;
    }
    ```

The preceding action:

* Responds only to the HTTP GET verb, as denoted by the `[HttpGet]` attribute.
* Requires that the `id` parameter's value is included in the URL segment after `pizza/`. Remember, the `/pizza` pattern was defined by the controller-level `[Route]` attribute.
* Queries the database for a pizza matching the provided `id` parameter.

Each `ActionResult` used in the preceding action is mapped to the corresponding HTTP status code in the following table.

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`Ok` is implied              |200             |A product matching the provided `id` parameter exists in the database.<br>The product is included in the response body in the media type as defined in the `accept` HTTP request header (JSON by default).|
|`NotFound`                   |404             |A product matching the provided `id` parameter doesn't exist in the database.|

## Build and test the controller

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. Start the web API by running the following command:

    ```dotnetcli
    dotnet run
    ```

1.  Open the existing `httprepl` terminal or open new integrated terminal from Visual Studio Code by selecting **Terminal** > **new Terminal** from the main menu.

1. Connect to our web API by running the following command:
  
  ```dotnetcli
  httprepl http://localhost:5000
  ```
  Alternatively, run the following command at any time while the HttpRepl is running:

  For example:

  ```dotnetcli
  (Disconnected)> connect http://localhost:5000
  ```

1. To see our newly available pizza endpoint run the following command:

  ```dotnetcli
  ls
  ```

  The preceeding command will detect all APIs available on the connected endpoint. It should display the following:

   ```dotnetcli
    http://localhost:5000/> ls
    .                 []
    Pizza             [GET]
    WeatherForecast   [GET]
  ```

1. Navigate to the Pizza endpoint by running the following command:

  ```dotnetcli
  cd Pizza
  ```

  The preceeding command will output available APIs available for the `Pizza` endpoint:

  ```dotnetcli
  http://localhost:5000/> cd Pizza
  /Pizza    [GET]
  ```

1. Make a `GET` request in the HttpRepl by using the following command:

  ```dotnetcli
  get
  ```

  The following command will make a `GET` request similar and return a list of all pizza in `json`:

  ```dotnetcli
    http://localhost:5000/Pizza> get
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 21:55:53 GMT
    Server: Kestrel
    Transfer-Encoding: chunked

    [
        {
            "id": 1,
            "name": "Classic Italian",
            "size": 0,
            "isGlutenFree": false
        },
        {
            "id": 2,
            "name": "Veggie",
            "size": 0,
            "isGlutenFree": true
        }
    ]
  ```

1. To query for a single pizza we can make another `GET` request, but pass in a parameter by using the following command:

    ```dotnetcli
    get 1
    ```

    This will return the `Classic Italian` with the following output:

    ```dotnetcli
    http://localhost:5000/Pizza> get 1
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 21:57:57 GMT
    Server: Kestrel
    Transfer-Encoding: chunked

    {
        "id": 1,
        "name": "Classic Italian",
        "size": 0,
        "isGlutenFree": false
    }
    ```

1. Our API also handle's situations where the item does not exist. Let's call the API again, but pass in an invalid pizza `Id` with the following command.

    ```dotnetcli
    get 5
    ```

    This will return a `404 Not Found` error with the following output:

    ```dotnetcli
    http://localhost:5000/Pizza> get 5
    HTTP/1.1 404 Not Found
    Content-Type: application/problem+json; charset=utf-8
    Date: Fri, 02 Apr 2021 22:03:06 GMT
    Server: Kestrel
    Transfer-Encoding: chunked

    {
        "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
        "title": "Not Found",
        "status": 404,
        "traceId": "00-ec263e401ec554b6a2f3e216a1d1fac5-4b40b8023d56762c-00"
    }
    ```

1. Quit current HttpRepl session by using the following command:

  ```dotnetcli
  exit
  ```

1. Return to the `dotnet` terminal in the dropdown list in Visual Studio Code and shut down the web API pressing `CTRL+C` on your keyboard.

We have now finished implementing the `GET` verbs and can add more actions to `PizzaController` to support CRUD operations on our pizza data in the next unit.
