At this point, you know slightly more about what the minimal API is and why use it. But how do you build out your app and deal with things such as router parameters, posted bodies and returning more advanced data than a literal string? 

To support so called RESTful APIs, you need to support the usage of HTTP Verbs and attach those verbs to different routes. Different Verbs have different meanings and you are recommended to respect the meanings of the HTTP Verbs. 

|HTTP Verb  |Description  |
|---------|---------|
|GET     | Returns data        |
|POST     | Sends data that creates a resource        |
|PUT     | Sends data that updates a resource        |
|DELETE     | Removes a resource        |

> [!NOTE]
> A resource is piece of data like for example a product, a user, an order etc. Something that you are likely to operate on and want to manage the lifecycle of.

## HTTP Verbs in minimal API

When a client initiates a request, it does so towards a server endpoint. Imagine a request made towards "GET http://localhost:3000/products". At this point, the server verifies the request to see what HTTP Verb is used, where it's going "/products" and attempts to resolve the request by producing a response.

> [!NOTE]
> As part of a request, the server may also try to verify any authentication credentials sent by the client, but this is outside the scope of this module.

How minimal API handles routes and HTTP Verbs, is by offering convenience methods so you can map a request by HTTP Verb and route, with the route being "/products" in a request to localhost:3000/products". Here's an example of such a convenience method:

```csharp
app.MapGet("/products", () => data);
```

The above should be read as, if the client uses the GET HTTP Verb, towards route "/products", then respond with `data`.

### `GET`, fetch a resource

There are two major cases that's good to know about when it comes to routing with GET requests.

- **Just the route**. You've seen this route already, like for example:

   ```csharp
   app.MapGet("/products", () => data);
   ```

- **Using a route parameter**. The other cases are using a route parameter. A route parameter is used to find a specific resource. Where "/products" means a list of all products, "/products/1" means a specific record, where its unique identifer has the value "1". To handle such a request, we will need to use a wildcard to match it. We use "{ID}" to capture the "1", in the above example. Additionally we can map the captured value to a parameter, like so:

   ```csharp
   app.MapGet("/products/{id}", (int id) => data.SingleOrDefault(product => product.Id == id));
   ```

   In the code above, the `id` parameter has captured route parameter the client sent, the "1" in "/products/1" or the 11, in this request "/products/1". Then the `id` is used to find a specific record.

### `POST`, create a resource

You often want to create a resource as well. For creation, you would use the POST HTTP Verb. The method to use, is called `MapPost()` like so:

```csharp
app.MapPost("/products", (Product product) => /**/);
```

Note how `product` is sent into the lambda that handles the request. Imagine, the below JSON being the body that is sent by the client and that has been serialized by the framework. Imagine if the client has sent the following JSON as its body:

```json
{
  "Name" : "New product",
  "Description": "a description"
}
```

Then the above JSON would be able to map these fields to an object instance of the same shape. Here's a class `Product` that would match the above described posted body:

```csharp
public record Product(int Id, string Name); 
```

### `PUT`, update a resource

The Verb PUT means to update a resource. The framework has the method `MapPut()` for this reason. `MapPut()` is similar semantically to `MapPost()`, the idea is that you, as a client, should send a posted body with a resource containing changes and that you want these changes applied to an existing resource on the server. Here's how you would use `MapPut()`:

```csharp
app.MapPut("/products", (Product product) => /* update the data store using the `product` instance */);
```

### `DELETE`, remove a resource

To support the HTTP Verb DELETE, you can use `MapDelete()`. The idea is for the client to send across a unique identifier that would help the server identify which record to delete. A typical usage of this method could look like so:

```csharp
app.MapDelete("/products/{id}", (int id) => /* Remove the record who's unique identifier matches `id` */);
```

### Returning a response

By default, when you respond with certain types, the framework is able to recognize that these types should be serialized as JSON. Here's some cases below:

```csharp
app.MapGet("/products", () => products);
app.MapGet("/products/{id}", (int id) => products.SingleOrDefault(product => product.Id == id));
app.MapGet("/product", () => new { id = 1 });
```

For these cases you would get a JSON response looking like so:

```json
[{
  "id": 1,
  "name": "a product"
}, {
  "id": 2,
  "name": "another product"
}]

[{
  "id": 1,
  "name": "a product"
}]

{
  "id": 1,
}
```