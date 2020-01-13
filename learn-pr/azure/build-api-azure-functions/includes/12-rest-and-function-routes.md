So far, you've been using the classic method of describing your service by 1) the action it performs and 2) the resource that it interacts with. In the case of getting all of the products, you called the service "GetProducts". While that name my work for now, it will become harder and harder to name your services that way as the API grows to allow more functionality. For instance, you could imagine that you might end up with an endpoint that is named "GetProductsByQuantityandBrandName".

This is a classic problem when building HTTP API's. To provide a cleaner and more useable API that we can scale out, we'll be modifying our project to comply with a RESTful architecture.

## Representational State Transfer (REST)

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

## Specifying routes in Azure Functions

Azure Functions allows you to customize the route that is used to access your function.

The `functions.json` file accepts a property called "route". This property accepts a string that sets the path. This path will be everything _after_ the "api" part of the URL.

In the next exercise, you'll customize the "routes" property of the "GetProducts" function to make the function comply with a RESTful architecture.
