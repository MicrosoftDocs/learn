The Products Manager API is about to get serious style upgrade courtesy of you, the Tailwind Traders developer. In this exercise, you'll turn all of the functions you created earlier into RESTful ones by modifying their configuration files.

## Make the GetProducts route RESTful

1. In Visual Studio Code, open the `api/src/index.ts` file.

1. In the route definition for **GetProducts**, restrict the `methods` property so that it only contains the value `GET`.

   ```json
   methods: ['GET']
   ```

1. Add the `route` property with a value of `products` for a full route of `/api/products`.


    ```json
    route: 'products',
    ```

    The full route definition is:

    ```typescript
    app.http('GetProducts', {
        methods: ['GET'],
        route: 'products',       // <- route: /api/products
        authLevel: 'anonymous',
        handler: GetProducts
    });
    ```

1. Save the file.

   > [!NOTE]
   > Saving the file will cause the Azure Functions process to terminate the debugger, and it will disconnect. Don't be alarmed. You didn't break anything. It's just that you've made fundamental changes to how the functions are served up, so you'll have to restart the project when you're done with all this REST spring cleaning.

## Make the CreateProduct function RESTful

1. Still in the `api/src/index.ts` file, restrict the allowed `methods` property to `POST`.

   ```json
   methods: ['POST']
   ```

1. Add the `route` property with a value of `products` for a full route of `/api/products`.


    ```json
    route: 'products',
    ```

    The full route definition is:

    ```typescript
    app.http('CreateProduct',{
        methods: ['POST'],
        route: 'products',
        authLevel: 'anonymous',
        handler: CreateProduct
    });
    ```

1. Save the file.

## Make the UpdateProduct function RESTful

1. Still in the `api/src/index.ts` file, restrict the allowed `methods` property to `PUT`.

   ```json
   methods: ['PUT'],
   ```

1. Add the `route` property with a value of `products` for a full route of `/api/products`.


    ```json
    route: 'products',
    ```

    The full route definition is:

    ```typescript
    app.http('UpdateProduct', {
        methods: ['PUT'],
        route: 'products',
        authLevel: 'anonymous',
        handler: UpdateProduct
    });
    ```

1. Save the file.

## Make the DeleteProduct function RESTful

1. Still in the `api/src/index.ts` file, restrict the allowed `methods` property to `DELETE`.

   ```json
    methods: ['DELETE']
   ```

1. Update the route to use the product id as a route parameter.


    ```json
    route: 'products/{id}',
    ```

    The full route definition is:

    ```typescript
    app.http('DeleteProduct', {
        methods: ['DELETE'],
        route: 'products/{id}',
        authLevel: 'anonymous',
        handler: DeleteProduct
    });
    ```

1. Save the file.

## Start the project

1. Start the Azure Functions project by pressing <kbd>F5</kbd>.

1. Notice that the URLs for your function endpoints are now different.

   :::image type="content" source="../media/restful-endpoints.png" alt-text="Screenshot of the Visual Studio Code terminal showing endpoints running on new routes." loc-scope="vs-code":::

Look at that stunning API. It's simply gorgeous. Notice how you specified the same exact same route for the CreateProduct, UpdateProduct, and DeleteProduct functions. Only the HTTP request method is different. You've turned three URLs into one, while still having three endpoints. You're a magician.
