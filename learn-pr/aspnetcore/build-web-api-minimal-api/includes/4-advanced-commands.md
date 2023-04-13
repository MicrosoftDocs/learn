You now know more about what the minimal API is and why to use it. But how do you build out your app and deal with things such as route parameters, posted bodies, and returning more advanced data than a literal string?

To support so-called RESTful APIs, you need to support the use of HTTP verbs and attach those verbs to different routes. Different verbs have different meanings. Respect the meanings of the HTTP verbs.

| HTTP verb | Description                        |
|-----------|------------------------------------|
| GET       | Returns data                       |
| POST      | Sends data that creates a resource |
| PUT       | Sends data that updates a resource |
| DELETE    | Removes a resource                 |

> [!NOTE]
> A resource is a piece of data. For example, it can be a product, a user, or an order. It's something you're likely to operate on and for which you want to manage the lifecycle.

## HTTP verbs in minimal API

When a client initiates a request, it does so toward a server endpoint. Imagine a request made toward `GET http://localhost:3000/products`. The server verifies the request to see what HTTP verb is used. It also needs to know where it's going, which is indicated by "/products." The server then attempts to resolve the request by producing a response.

> [!NOTE]
> As part of a request, the server might also try to verify any authentication credentials sent by the client. This activity is outside the scope of this module.

A minimal API handles routes and HTTP verbs by offering convenience methods. You can map a request by HTTP verb and route, with the route being "/products," in a request to `localhost:3000/products`. Here's an example of such a convenience method:

```csharp
app.MapGet("/products", () => data);
```

This code should be read in the following way: If the client uses the GET HTTP verb toward the route `"/products"`, then respond with `data`.

### GET: Fetch a resource

Two major cases are good to know about when it comes to routing with GET requests:

- **Just the route:** You've seen this route already. For example:

   ```csharp
   app.MapGet("/products", () => data);
   ```

- **Use a route parameter:** A route parameter is used to find a specific resource. If "/products" means a list of all products, `/products/1` means a specific record. The unique identifier has the value *1*. To handle such a request, you use a wildcard to match it. You use "{ID}" to capture the "1" in the preceding example. You can also map the captured value to a parameter:

   ```csharp
   app.MapGet("/products/{id}", (int id) => data.SingleOrDefault(product => product.Id == id));
   ```

   In this code, the `id` parameter has captured the route parameter the client sent, which is the *1* in `/products/1`.

### POST: Create a resource

You often want to create a resource, too. For creation, you use the POST HTTP verb. The method to use is called `MapPost()`:

```csharp
app.MapPost("/products", (Product product) => /**/);
```

Note how `product` is sent into the lambda that handles the request. Imagine the following JSON being the body that's sent by the client and that's been serialized by the framework. Imagine the client has sent the following JSON as its body:

```json
{
  "Name" : "New product",
  "Description": "a description"
}
```

Then this JSON can map these fields to an object instance of the same shape. Here's a class, `Product`, that matches the described posted body:

```csharp
public record Product(int Id, string Name); 
```

### PUT: Update a resource

The verb PUT is used to update a resource. The framework has the method `MapPut()` for this reason. The `MapPut()` method is similar semantically to `MapPost()`. The idea is that you, as a client, should send a posted body with a resource that contains changes. You want these changes applied to an existing resource on the server. Here's how you use `MapPut()`:

```csharp
app.MapPut("/products", (Product product) => /* Update the data store using the `product` instance */);
```

### DELETE: Remove a resource

To support the HTTP verb DELETE, use `MapDelete()`. The idea is for the client to send across a unique identifier that helps the server identify which record to delete. Here's a typical use of this method:

```csharp
app.MapDelete("/products/{id}", (int id) => /* Remove the record whose unique identifier matches `id` */);
```

### Return a response

By default, when you respond with certain types, the framework recognizes that these types should be serialized as JSON. Here are some cases:

```csharp
app.MapGet("/products", () => products);
app.MapGet("/products/{id}", (int id) => products.SingleOrDefault(product => product.Id == id));
app.MapGet("/product", () => new { id = 1 });
```

For these cases, you get JSON responses that look like these examples:

```json
// app.MapGet("/products", () => products);
[{
  "id": 1,
  "name": "a product"
}, {
  "id": 2,
  "name": "another product"
}]

// app.MapGet("/products/{id}", (int id) => products.SingleOrDefault(product => product.Id == id));
[{
  "id": 1,
  "name": "a product"
}]

// app.MapGet("/product", () => new { id = 1 });
{
  "id": 1
}
```

In the next unit, you'll add routes to your minimal API.
