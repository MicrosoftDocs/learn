Let's continue extending our web API controller to add the ability to create (`POST`), update (`PUT`), and delete (`DELETE`) pizza from our inventory. 

## Add a pizza

Let's enable a pizza to be added through the web API by using a `POST` method.

Replace the `// POST action` comment in *:::no-loc text="Controllers/PizzaController.cs":::* with the following code:

```csharp
[HttpPost]
public IActionResult Create(Pizza pizza)
{            
    PizzaService.Add(pizza);
    return CreatedAtAction(nameof(Get), new { id = pizza.Id }, pizza);
}
```

The preceding action:

* Responds only to the HTTP `POST` verb, as denoted by the `[HttpPost]` attribute.
* Inserts the request body's `Pizza` object into the in-memory cache.

> [!NOTE]
> Because the controller is annotated with the `[ApiController]` attribute, it's implied that the `Pizza` parameter will be found in the request body.

The first parameter in the `CreatedAtAction` method call represents an action name. The `nameof` keyword is used to avoid hard-coding the action name. `CreatedAtAction` uses the action name to generate a `location` HTTP response header with a URL to the newly created pizza, as explained in the previous unit.

## Modify a pizza

Now, let's enable a pizza to be updated through the web API by using a `PUT` method.

Replace the `// PUT action` comment in *:::no-loc text="Controllers/PizzaController.cs":::* with the following code:

```csharp
[HttpPut("{id}")]
public IActionResult Update(int id, Pizza pizza)
{
    if (id != pizza.Id)
        return BadRequest();
           
    var existingPizza = PizzaService.Get(id);
    if(existingPizza is null)
        return NotFound();
   
    PizzaService.Update(pizza);           
   
    return NoContent();
}
```

The preceding action:

* Responds only to the HTTP PUT verb, as denoted by the `[HttpPut]` attribute.
* Requires that the `id` parameter's value is included in the URL segment after `pizza/`.
* Returns `IActionResult`, because the `ActionResult` return type isn't known until runtime. The `BadRequest`, `NotFound`, and `NoContent` methods return `BadRequestResult`, `NotFoundResult`, and `NoContentResult` types, respectively.

> [!NOTE]
> Because the controller is annotated with the `[ApiController]` attribute, it's implied that the `Pizza` parameter will be found in the request body.

## Remove a pizza

Finally, let's enable a pizza to be removed through the web API by using a `DELETE` method.

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

* Responds only to the HTTP `DELETE` verb, as denoted by the `[HttpDelete]` attribute.
* Requires that the `id` parameter's value is included in the URL segment after `pizza/`.
* Returns `IActionResult` because the `ActionResult` return type isn't known until runtime. The `NotFound` and `NoContent` methods return `NotFoundResult` and `NoContentResult` types, respectively.
* Queries the in-memory cache for a pizza that matches the provided `id` parameter.

Remember to save the *Controllers/PizzaController.cs* file before proceeding,

## Build and run the finished web API

1. Build and start the web API by running the following command:

    ```dotnetcli
    dotnet run
    ```

1. Reopen the existing `httprepl` terminal, or open a new integrated terminal from Visual Studio Code by selecting **Terminal** > **New Terminal** from the main menu.

1. If you opened a new terminal, connect to the web API by running the following command:
  
    ```dotnetcli
    httprepl https://localhost:{PORT}
    ```

    Alternatively, run the following command at any time while `HttpRepl` is running:

    ```dotnetcli
    connect https://localhost:{PORT}
    ```

1. Go to the `Pizza` endpoint by running the following command:

    ```dotnetcli
    cd Pizza
    ```

1. Run the following command to see the new actions on the Pizza API:

    ```dotnetcli
    ls
    ```

    The preceding command shows an output of available APIs for the `Pizza` endpoint:

    ```output
        https://localhost:{PORT}/Pizza> ls
        .      [GET|POST]
        ..     []
        {id}   [GET|PUT|DELETE]
    ```

1. Make a `POST` request to add a new pizza in `HttpRepl` by using the following command:

    ```dotnetcli
    post -c "{"name":"Hawaii", "isGlutenFree":false}"
    ```

    The preceding command returns a list of all pizza:

    ```output
    HTTP/1.1 201 Created
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 23:23:09 GMT
    Location: https://localhost:{PORT}/Pizza?id=3
    Server: Kestrel
    Transfer-Encoding: chunked
    
    {
        "id": 3,
        "name": "Hawaii",
        "isGlutenFree": false
    }
    ```

1. Update the new `Hawaii` pizza to a `Hawaiian` pizza with a `PUT` request by using the following command:

    ```dotnetcli
    put 3 -c  "{"id": 3, "name":"Hawaiian", "isGlutenFree":false}"
    ```

    The preceding command returns the following output that indicates success:

    ```output
    HTTP/1.1 204 No Content
    Date: Fri, 02 Apr 2021 23:23:55 GMT
    Server: Kestrel
    ```

    To verify that the pizza was updated, rerun the `GET` action by using the following command:

    ```dotnetcli
    get 3
    ```

    The preceding command returns the newly updated pizza:

    ```output
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

1. Our API can also delete the newly created pizza through the `DELETE` action if you run the following command:

    ```dotnetcli
    delete 3
    ```

    The preceding command returns a `204 No Content` result for success:

    ```output
    HTTP/1.1 204 No Content
    Date: Fri, 02 Apr 2021 23:30:04 GMT
    Server: Kestrel
    ```

    To verify that the pizza was removed, rerun the `GET` action by using the following command:

    ```dotnetcli
    get
    ```

    The preceding command returns the original pizzas as results:

    ```output
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

You've now finished implementing and testing a newly created web API built with ASP.NET Core.
