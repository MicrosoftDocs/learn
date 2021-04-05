Let's continue extending our web API controller to add the ability to create(`POST`), update (`PUT`), and delete (`DELETE`) pizza from our inventory. 

## Add a pizza

To enable the endpoint to have the abilty for users to add pizza, we must implement the `POST` action using the `[HttpPost]`. By passing a `Pizza` into the method as a paramter, ASP.NET Core will automatically convert any `application/json` that is sent to the endpoint into a `Pizza` object. 

Replace the `// POST action` comment in *:::no-loc text="Controllers/PizzaController.cs":::* with the following code:

```csharp
[HttpPost]
public IActionResult Create(Pizza pizza)
{            
    PizzaService.Add(pizza);
    return CreatedAtAction(nameof(Create), new { id = pizza.Id }, pizza);
}
```

The preceding action:

* Responds only to the HTTP POST verb, as denoted by the `[HttpPost]` attribute.
* Inserts the request body's `Pizza` object into the in-memory cache.

> [!NOTE]
> Because the controller is annotated with the `[ApiController]` attribute, it's implied that the `Pizza` parameter will be found in the request body.

The first parameter in the `CreatedAtAction` method call represents an action name. The `nameof` keyword is used to avoid hard-coding the action name. `CreatedAtAction` uses the action name to generate a `location` HTTP response header with a URL to the newly created pizza.

Each `ActionResult` used in the preceding action is mapped to the corresponding HTTP status code in the following table.

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`CreatedAtAction`            |201             |The pizza was added to the in-memory cache.<br>The pizza is included in the response body in the media type as defined in the `accept` HTTP request header (JSON by default).|
|`BadRequest` is implied      |400             |The request body's `pizza` object is invalid.|

## Modify a pizza

Modifying or updating a pizza in our inventory is similar to the `POST` method we just implemented, but will use the `[HttpPut]` attribute and take in the `id` in addition to the `Pizza` object that needs to be updated.

Replace the `// PUT action` comment in *:::no-loc text="Controllers/PizzaController.cs":::* with the following code:

```csharp
[HttpPut("{id}")]
public IActionResult Update(int id, Pizza pizza)
{
    var existingPizza = PizzaService.Get(id);
    if (id != pizza.Id || existingPizza is null)
        return BadRequest();

    PizzaService.Update(pizza);           

    return NoContent();
}
```

The preceding action:

* Responds only to the HTTP PUT verb, as denoted by the `[HttpPut]` attribute.
* Requires that the `id` parameter's value is included in the URL segment after `pizza/`.
* Returns `IActionResult` because the `ActionResult` return type isn't known until runtime. The `BadRequest` and `NoContent` methods return `BadRequestResult` and `NoContentResult` types, respectively.

> [!NOTE]
> Because the controller is annotated with the `[ApiController]` attribute, it's implied that the `Pizza` parameter will be found in the request body.

Each `ActionResult` used in the preceding action is mapped to the corresponding HTTP status code in the following table.

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`NoContent`                  |204             |The pizza was updated in the in-memory cache.|
|`BadRequest`                 |400             |The request body's `Id` value doesn't match the route's `id` value.|
|`BadRequest` is implied      |400             |The request body's `Pizza` object is invalid.|

## Remove a pizza

One of the easier actions to implement is the `DELETE` action that takes in just the `id` of the pizza to remove from the in-memory cache.

Replace the `// DELETE action` comment in *:::no-loc text="Controllers/PizzaController.cs":::* with the following code:

```csharp
[HttpDelete("{id}")]
public IActionResult Delete(int id)
{
    var pizza = PizzaService.Get(id);

    if (pizza is null)
        return NotFound();
    
    PizzaService.Delete(id);

    return NoContent();
}
```

The preceding action:

* Responds only to the HTTP DELETE verb, as denoted by the `[HttpDelete]` attribute.
* Requires that `id` parameter's value is included in the URL segment after `pizza/`.
* Returns `IActionResult` because the `ActionResult` return type isn't known until runtime. The `NotFound` and `NoContent` methods return `NotFoundResult` and `NoContentResult` types, respectively.
* Queries the in-memory cache for a pizza matching the provided `id` parameter.

Each `ActionResult` used in the preceding action is mapped to the corresponding HTTP status code in the following table.

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`NoContent`                  |204             |The pizza was deleted from the in-memory cache.|
|`NotFound`                   |404             |A pizza matching the provided `id` parameter doesn't exist in the in-memory.|

## Build and run the finished web API

## Build and test the controller

1. Build and start the web API by running the following command:

    ```dotnetcli
    dotnet run
    ```

1.  Re-open the existing `httprepl` terminal or open new integrated terminal from Visual Studio Code by selecting **Terminal** > **new Terminal** from the main menu.

1. If you opened a new terminal, connect to our web API by running the following command:
  
  ```dotnetcli
  httprepl http://localhost:5000
  ```
  Alternatively, run the following command at any time while the HttpRepl is running:

  For example:

  ```dotnetcli
  (Disconnected)> connect http://localhost:5000
  ```

  Navigate to the Pizza endpoint by running the following command:

  ```dotnetcli
  cd Pizza
  ```

1. Run the following command to see the new actions on the Pizza API:

    ```dotnetcli
    ls
    ```

    The preceeding command will output available APIs available for the `Pizza` endpoint:

    ```dotnetcli
        http://localhost:5000/Pizza> ls
        .      [GET|POST]
        ..     []
        {id}   [GET|PUT|DELETE]
    ```

1. Make a `POST` request to add a new pizza in the HttpRepl by using the following command:

  ```dotnetcli
  post -c "{"name":"Hawaii", "isGlutenFree":false}"
  ```

  The following command will make a `POST` request to add the new pizza to our inventory and then will return a list of all pizza back:

  ```dotnetcli 
    HTTP/1.1 201 Created
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 23:23:09 GMT
    Location: http://localhost:5000/Pizza?id=3
    Server: Kestrel
    Transfer-Encoding: chunked

    {
        "id": 3,
        "name": "Hawaii",
        "isGlutenFree": false
    }
  ```

1. Let's update the new `Hawaii` pizza to a `Hawaiian` pizza with a `PUT` request with the following command:

    ```dotnetcli
    put 3 -c  "{"id": 3, "name":"Hawaiian", "isGlutenFree":false}"
    ```

    This will return the following output that it was successful:

    ```dotnetcli
    HTTP/1.1 204 No Content
    Date: Fri, 02 Apr 2021 23:23:55 GMT
    Server: Kestrel
    ```

    To verify that the pizza was updated, we can re-run the `GET` action with the following command:

    ```dotnetcli
    get 3
    ```

    This will return the newly updated pizza:

    ```dotnetcli
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 23:27:37 GMT
    Server: Kestrel
    Transfer-Encoding: chunked

    {
        "id": 3,
        "name": "Hawaiian",
        "isGlutenFree": false
    }
    ```

1. Our API can also delete the newly created pizza with the `DELETE` action by running the following command:

    ```dotnetcli
    delete 3
    ```

    This will return a `204 No Content` for success:

    ```dotnetcli
    HTTP/1.1 204 No Content
    Date: Fri, 02 Apr 2021 23:30:04 GMT
    Server: Kestrel
    ```

    To verify that the pizza was remove, we can re-run the `GET` action with the following command:

    ```dotnetcli
    get
    ```

    This will return our original pizzas as results:

    ```dotnetcli
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 23:31:15 GMT
    Server: Kestrel
    Transfer-Encoding: chunked

    [
        {
            "id": 1,
            "name": "Classic Italian",
            "isGlutenFree": false
        },
        {
            "id": 2,
            "name": "Veggie",
            "isGlutenFree": true
        }
    ]
    ```


We have now finished implementing and testing our newly created web API built with ASP.NET Core. Next, we will provide some best practices and additional learning modules.
