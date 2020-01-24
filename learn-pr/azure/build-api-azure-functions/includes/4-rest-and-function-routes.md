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

### Azure Functions and HTTP request methods

By default, Azure Functions will respond to both GET and POST requests.

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

## Organization by resource

REST involves structuring your endpoints so that they closely match the resources that they are managing. For example, if you have a service that retrieves all of the products in a database (like we do for this module), then you would call that endpoint, "products". The name matches the resource that the service manages.

```http
http://127.0.0.1:7071/api/products
```

The fact that "products" is plural indicates that it returns multiple results. If you were getting only one product, you would call a "product" endpoint and pass an id.

```http
http://127.0.0.1/api/product/1
```

#### Passing parameters to REST services

In a RESTful service, parameters are usually passed one of two ways...

1. In the body of the request
2. As part of the URL

### Passing parameters on the request body

When you need to pass multiple parameters to a function, the request body is usually the right place to do it. For instance, later in this module you will create a "CreateProduct" function. You'll need to send that function an entire product to be created. This includes the product name, quantity and brand name. You'll pass all of these parameters as a JSON object in the body of the request to the "CreateProduct" endpoint.

### Passing parameters on the route

When you are passing one parameter to an endpoint, it is done as part of the route. For instance, when you create the "DeleteProduct" function, you'll need to call the endpoint and pass in the id of the product to delete, as well as the brand name. Since REST services are organized by resource, it makes sense to pass in the id parameter on the route.

```http
DELETE http://1270.0.1:7071/api/product/1
```

However, you'll also need the brand name. Since the brand name is text, and likely contains spaces or special characters, we'll pass that parameter on the body of the delete request.

#### Passing JSON objects to Azure Functions

Every HTTP request has a body. You can add data into that body and send that to the server where it is parsed off the body of the request. The services you are building for the products service send and receive data in JSON format. To create a product, you'll need to send the entire product to the service as a JSON object in the body like so...

```json
{
  "name": "Artificial Tree",
  "price": 250,
  "brand": {
    "name": "Home & Pro tools"
  },
  "stockUnits": 654
}
```

In order for Azure Functions to read and parse the body of the request, you'll need to "announce" that your data is in JSON format. This is done by adding a header to the request which specifies that the content type is "application/json". This is a standard HTTP header that is sent along with a request to inform the service that the payload should be read and parsed as JSON.

These parameters will appear on the `body` of the `req` object.

```typescript
const httpTrigger: AzureFunction = async function(
  context: Context,
  req: HttpRequest
): Promise<void> {

    // params contains the route parameters
    const productToCreate = req.params.body;
```

### Passing route parameters to Azure Functions

You can change the route that Azure Functions listens on for a specific function by modifying the "routes" parameter in the `function.json` configuration file.

```json
"route": "products"
```

This will change everything after the "api" section of the URL to match the route you specified.

You can pass parameters along with a route. Parameters take the form of {parameterName}. This means that to pass a parameter called "id" to the "product" endpoint, you would specify the following route...

```json
"route": "product/{id}"
```

These parameters will be parsed off the URL by Azure Functions and will show up in `params` on the `req` object.

```typescript
const httpTrigger: AzureFunction = async function(
  context: Context,
  req: HttpRequest
): Promise<void> {

    // params contains the route parameters
    const id = req.params.id;
```

In the next exercise, you'll customize the "routes" property of the GetProduct, CreateProduct, UpdateProduct and DeleteProduct endpoints so that they conform to the REST architecture.
