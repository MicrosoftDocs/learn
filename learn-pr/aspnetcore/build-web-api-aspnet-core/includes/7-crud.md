Our pizza service supports CRUD operations for a list of pizzas. These operations are performed through HTTP verbs, which are mapped via ASP.NET Core attributes. As you've seen, the HTTP `GET` verb is used to retrieve one or more items from a service. Such an action is annotated with the `[HttpGet]` attribute.

The following table shows the mapping of the four operations that you're implementing for the pizza service:

|HTTP action verb|CRUD operation|ASP.NET Core attribute|
|----------------|--------------|----------------------|
|`GET`             |Read          |`[HttpGet]`           |
|`POST`            |Create        |`[HttpPost]`          |
|`PUT`             |Update        |`[HttpPut]`           |
|`DELETE`          |Delete        |`[HttpDelete]`        |

You've already seen how `GET` actions work. Let's learn more about `POST`, `PUT`, and `DELETE` actions.

## POST

To enable users to add a new item to the endpoint, you must implement the `POST` action by using the `[HttpPost]` attribute. When you pass the item (in this example, a pizza) into the method as a parameter, ASP.NET Core automatically converts any application/JSON that's sent to the endpoint into a populated .NET `Pizza` object.

Here's the method signature of the `Create` method that you'll implement in the next section:

```csharp
[HttpPost]
public IActionResult Create(Pizza pizza)
{            
    // This code will save the pizza and return a result
}
```

The `[HttpPost]` attribute maps HTTP `POST` requests sent to `http://localhost:5000/pizza` by using the `Create()` method. Instead of returning a list of pizzas, as we saw with the `Get()` method, this method returns an `IActionResult` response.

`IActionResult` lets the client know if the request succeeded and provides the ID of the newly created pizza. `IActionResult` uses standard HTTP status codes, so it can easily integrate with clients regardless of the language or platform they're running on.

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`CreatedAtAction`            |201             |The pizza was added to the in-memory cache.<br>The pizza is included in the response body in the media type, as defined in the `accept` HTTP request header (JSON by default).|
|`BadRequest` is implied      |400             |The request body's `pizza` object is invalid.|

Fortunately, `ControllerBase` has utility methods that create the appropriate HTTP response codes and messages for you. You'll see how those methods work in the next exercise.

## PUT

Modifying or updating a pizza in our inventory is similar to the POST method that you implemented, but it uses the `[HttpPut]` attribute and takes in the `id` parameter in addition to the `Pizza` object that needs to be updated:

```csharp
[HttpPut("{id}")]
public IActionResult Update(int id, Pizza pizza)
{
    // This code will update the pizza and return a result
}
```

Each `ActionResult` instance used in the preceding action is mapped to the corresponding HTTP status code in the following table:

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`NoContent`                  |204             |The pizza was updated in the in-memory cache.|
|`BadRequest`                 |400             |The request body's `Id` value doesn't match the route's `id` value.|
|`BadRequest` is implied      |400             |The request body's `Pizza` object is invalid.|

## DELETE

One of the easier actions to implement is the `DELETE` action, which takes in just the `id` parameter of the pizza to remove from the in-memory cache:

```csharp
[HttpDelete("{id}")]
public IActionResult Delete(int id)
{
    // This code will delete the pizza and return a result
}
```

Each `ActionResult` instance used in the preceding action is mapped to the corresponding HTTP status code in the following table:

|ASP.NET Core<br>action result|HTTP status code|Description|
|-----------------------------|----------------|-----------|
|`NoContent`                  |204             |The pizza was deleted from the in-memory cache.|
|`NotFound`                   |404             |A pizza that matches the provided `id` parameter doesn't exist in the in-memory cache.|

The exercise in the next unit demonstrates how to support each of the four actions in the web API.
