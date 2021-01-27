You've created a wonderful API. It doesn't do much, but hey, it exists, and that's more than people who aren't building APIs right now can say.

You have endpoints called CreateProduct, GetProducts, UpdateProduct, and DeleteProduct. Endpoints named that way follow a traditional API-naming pattern - Action/Resource.

The "Action/Resource" naming pattern is fine for smaller APIs. Remember, though, that in this simulation, Tailwind Traders is an internet giant. The Products API could get unwieldy in a hurry. For instance, you could imagine that you might have a method called "GetProductByIdAndQuantityAndDate". Not only are these types of method names verbose, but they make code that consumes them look cluttered. Wordy API names also make it harder for developers to figure out how to use the API in their projects.

What you need to do is make this API clean and intuitive. For that, you are going to be using the REST pattern.

### Azure Functions routes and HTTP request methods

By default, any HTTP trigger function will respond to GET and POST requests. It also sets the URL of your function to the name of that function prefixed by "/api". Both of these things are configurable.

#### Change which HTTP request method a function responds to

Each function that is created has a corresponding `function.json` file in the function folder. That file specifies which HTTP request methods a function responds to. The following `function.json` file shows the "GetProducts" function that you created in the previous exercise.

```json
{
  "bindings": [
    {
      "authLevel": "function",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": ["get", "post"]
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    }
  ],
  "scriptFile": "../dist/GetProducts/index.js"
}
```

See the `methods` property above? That array specifies which HTTP request methods this function will respond to. If a method that is not in that list is used, you'll get a 404 error.

#### Change the function route

You can change the URL, or "route," that Azure Functions listens on for a specific function by adding a "routes" parameter in the `function.json` configuration file.

```json
"route": "products"
```

```json
{
  "bindings": [
    {
      "authLevel": "function",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": ["get", "post"],
      "route": "products"
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    }
  ],
  "scriptFile": "../dist/GetProducts/index.js"
}
```

Specifying a route changes everything after the "api" section of the URL. In the previous configuration file, the route to the "GetProducts" function is now `http://localhost:7071/api/products`.

You can pass parameters along with a route. Parameters take the form of "{parameterName}". This means that to pass a parameter called "id" to the "product" endpoint, you would specify the following route.

```json
"route": "product/{id}"
```

Armed with this new knowledge of REST and how to implement it in Azure Functions, you can now make that unwieldy Products API a "RESTful" one. That's exactly what you'll do in the next exercise.
