So far, the API you've created contains CreateProduct, GetProducts, UpdateProduct and DeleteProduct endpoints. The enpoints follow a traditional API naming pattern - ActionResource. This naming pattern is fine for smaller API's, but as an API grows, it becomes harder to name the endpoints. For instance, you could imagine that we might have a method called "GetProductByIdAndQuantityAndDate". Not only are these types of method names verbose, but they make it harder for developers to figure out how to use the API in their projects.

We can use an architectural pattern called "REST" to make our API much cleaner.

## What is REST?

Represential State Transfer, or REST, is an architectural pattern that provides guidance on how to name and structure endpoints. It does this using two strategies...

1. Action defined by HTTP request method
1. Organization by resource

### Action defined by HTTP request method

When you load a web page in the browser, The browser makes what is called a "GET" request to the URL that you specify. The "GET" is a part of the HTTP request called the "HTTP request method". Every HTTP request is made with a method. Web browsers automatically set the request method to GET when a page is requested.

In a REST architecture, these HTTP request methods - sometimes called "verbs" - are used to define the action that you want to take on a resource. The following HTTP request methods correspond to the following database actions...

| Database Action | HTTP Request Method |
| --------------- | ------------------- |
| Create          | POST                |
| Read            | GET                 |
| Update          | PUT                 |
| Delete          | DELETE              |

Therefore, if you wanted to query a database for records, you would call your API endpoint using a GET request method. If you wanted to delete a record, you would call the endpoint with a DELETE request method.

### Organization by resource

REST involves structuring your endpoints so that they closely match the resources that they are managing. For example, if you have a service that retrieves all of the products in a database (like we do for this module), then you would call that endpoint, "products". The name matches the resource that the service manages.

```http
http://127.0.0.1:7071/api/products
```

The fact that "products" is plural indicates that it returns multiple results. If you were getting only one product, you would call a "product" endpoint and pass an id.

```http
http://127.0.0.1/api/product/1
```

### Azure Functions routes and HTTP request methods

By default, Azure Functions will respond to both GET and POST requests. It also sets the route to your function to the name of that function. Both of these things are configurable.

#### Changing which HTTP request method a function responds to

You can configure Azure Functions to only respond to requests made with specific HTTP request methods.

Each function that is created has a corresponding `function.json` file in the folder. That file specifies which HTTP request methods a function responds to. Below is the `function.json` file for the "GetProducts" function that you created in the previous exercise.

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

See the `methods` property above? That array specifies which HTTP request methods this function will respond to. If a method that is not in that list is used, a 404 will be returned by the function.

#### Changing the function route

You can change the route that Azure Functions listens on for a specific function by modifying the "routes" parameter in the `function.json` configuration file.

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

This will change everything after the "api" section of the URL to match the route you specified. In the above configuration file, the route to the "GetProducts" function is now "http://localhost:7071/api/products".

You can pass parameters along with a route. Parameters take the form of {parameterName}. This means that to pass a parameter called "id" to the "product" endpoint, you would specify the following route...

```json
"route": "product/{id}"
```

In the next exercise, you'll customize the HTTP request methods and routes for the GetProduct, CreateProduct, UpdateProduct and DeleteProduct endpoints so that they conform to a REST architecture.
