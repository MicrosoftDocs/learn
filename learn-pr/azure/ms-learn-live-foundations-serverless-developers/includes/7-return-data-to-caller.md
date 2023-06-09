The default return value for an HTTP-triggered function is: `HTTP 204 No Content` with an empty body.
The context object has a property called `res`, which is an object that describes the HTTP response. It contains a `status` and a `body`.

## Objective

Use the context object to return JSON data to the caller.

## Instructions

To use the context object to return JSON data to the caller:

1. Create a variable called `loadedProduct` and assign an object including the properties in the following code.

1. Assign an anonymous object to the `context.res` property.

1. Add the `status`, `header`, and `body` properties and assign values as follows.

    ```typescript
    const loadedProduct = {
        id: productId,
        name: "A product",
        description: "First product to be returned - yay!"
    };
    
    context.res = {
        status: 200,
        headers: { "Content-Type": "application/json" },
        body: {
            product: loadedProduct
        }
    };
    ```

You can run the function in the browser and see it return JSON data.
