Represential State Transfer, or REST, is an architectural pattern that provides guidance on how to name and structure endpoints. It does this by using two strategies...

1. Organization by resource
1. Action defined by HTTP request method

### Organization by resource

REST involves structuring your endpoints so that they closely match the resources that they are managing. For example, if you have a service that retrieves all of the products in a database (like we do for this module), then you would call that endpoint, "products". The name matches the resource that the service manages.

```http
http://127.0.0.1:7071/api/products
```

### Action defined by HTTP request method

In the previous exercise, you learned about HTTP request methods like GET and POST. REST uses those methods to define what sort of action the endpoint should perform. The HTTP requests maps to database actions in the following way...

| HTTP Request Method | Database Action |
| ------------------- | --------------- |
| POST                | Create          |
| GET                 | Read            |
| PUT                 | Update          |
| DELETE              | Delete          |

This means that if wanted to read all of the products from the "products" endpoint, we would execute a GET request.

```http
GET http://127.0.0.1:7071/api/products
```

## Passing parameters to REST services

In a RESTful service, parameters are usually passed one of two ways...

2. In the body of the request
1. As part of the URL

### Passing parameters on the request body

When you need to pass multiple parameters to a function, the request body is usually the right place to do it. For instance, later in this module you will create a "CreateProduct" function. You'll need to send that function an entire product to be created. This includes the product name, quantity and brand name. You'll pass all of these parameters as a JSON object in the body of the request to the "CreateProduct" endpoint.

#### Passing JSON objects as parameters

Every HTTP request has a body. You can add data into that body and send that to the server where it is parsed off the body of the request. The services you are building for the products service send and receive data in JSON format. That means that for a new product, the body of the request will look just like a product would look in the database.

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

## Passing route parameters

When you are passing a single parameter to a REST service, this is usually done as part of the route. For instance, when you create the "DeleteProduct" function, you'll need to call the endpoint and pass in the id of the product to delete.

```http
DELETE http://1270.0.1:7071/api/product/1
```

In this case, the route is "product" because we are only working with one resource as we are only trying to delete one item. The id is 1, which is passed as a parameter as part of the route. It's up to Azure Functions to parse that parameter off the route. This can be done using route parameters.

### Specifying routes in Azure Functions

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

In the next exercise, you'll customize the "routes" property of the "GetProducts" function to make the function comply with a RESTful architecture and experiment with passing parameters.
