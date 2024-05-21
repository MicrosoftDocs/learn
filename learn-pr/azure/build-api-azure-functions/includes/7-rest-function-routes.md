You've created a wonderful API. It doesn't do much, but hey, it exists, and that's more than people who aren't building APIs right now can say.

## Migration to RESTful APIs

You have endpoints called CreateProduct, GetProducts, UpdateProduct, and DeleteProduct. Endpoints named that way follow a traditional API-naming pattern: Action/Resource.

The *Action/Resource* naming pattern is fine for smaller APIs. Remember, though, that in this simulation, Tailwind Traders is an internet giant. The Products API could get unwieldy in a hurry. For instance, you could imagine that you might have a method called "GetProductByIdAndQuantityAndDate." Not only are these types of method names verbose, but they make code that consumes them look cluttered. Wordy API names also make it harder for developers to figure out how to use the API in their projects.

What you need to do is make this API clean and intuitive. For that, you'll use the REST pattern.

## Azure Functions routes and HTTP request methods

In Azure Functions, by default any HTTP trigger function responds to GET and POST requests. It also sets the URL of your function to the name of that function prefixed by "/api." You'll configure Both of these to move to a move RESTful pattern.

### Enterprise applications

The HTTP definition for an API in the Azure Functions v4 programming model in this sample application is found at `./api/src/index.ts` and follows the pattern of: 

```typescript
const { app } = require('@azure/functions');

app.http('FunctionName',{
    methods: ['GET', 'POST'], 
    authLevel: 'anonymous', 
    route: 'routeName',
    handler: handlerFunction
});
```

The handler function is separated from the definition of the HTTP trigger. This allows you a lot of flexibilities in how you define your functions. You can define the handler function in a separate file and import it into the `index.ts` file. This format would be easier to maintain or generate for OpenAPI or Swagger documentation.

### Smaller applications

Smaller applications may be better served by integrating the handler code directly into the `app` call, using the app's method to specify the HTTP method. You can still separate out the handler function or integrated the code.

Use the `app.get` method to specify the HTTP method and the handler function. 

```typescript
const { app } = require('@azure/functions');

app.get('FunctionName', handlerFunction);
```

Another alternative format, ideal for Function apps with a single function, is to integrate the handler code directly into the `app` call, using the app's method to specify the HTTP method. For example:

```typescript
const { app } = require('@azure/functions');

app.get('helloWorld',{
    handler: (request: HttpRequest, context: InvocationContext) => {
        return {
            status: 200,
            body: "Hello World"
        }
    }
}
```

### Route parameters

You can also use route parameters to define a route that accepts a parameter. For example, the following code defines a route that accepts a `name` parameter:

```json
route: "products"
```

The full route definition is:

```typescript
app.http('GetProducts', {
    methods: ['GET', 'POST'],
    route: 'products',          // <- route: /api/products
    authLevel: 'anonymous',
    handler: GetProducts
});
```

Specifying a route changes everything after the *api* section of the URL. In the previous configuration file, the route to the *GetProducts* function is now `http://localhost:7071/api/products`.

You can pass parameters along with a route. Parameters take the form of *{parameterName}*. This means that to pass a parameter called `id` to the `product` endpoint, you'd specify the following route.

```json
route: "products/{id}"
```

Armed with this new knowledge of REST and how to implement it in Azure Functions, you can now make that unwieldy Products API a *RESTful* one. That's exactly what you'll do in the next exercise.
