## 💻 Exercise - Extract complex data from the request body

For more complex data, the URL is not suitable. In such cases restful APIs use the request’s body to transfer data from the caller.
This data can be accessed using the `HttpRequest` object.

## Objective

- Add a function that reacts to HTTP POST
- Use the context object to extract data from the request’s body

## Instructions

1. Using the instructions [you followed earlier when you created your first local function](3-create-function-endpoint.md), add another HTTP triggered function named `CreateProduct`.
1. Change the route of `CreateProduct` to "product"
1. Change the `methods` property in function.json to only accept `post`
1. Create a variable called `productToCreate` and assign it the HTTP request object's `body` property
1. For the `GetProduct` function you returned hardcoded JSON data. For the `CreateProduct` function, use similar code but return `productToCreate` back to the caller or an error if the request's body didn't contain valid data

```typescript
const productToCreate = req.body;
    
// Return a 400 (bad request) if there are issues.
if (productToCreate == null || productToCreate["id"] == null) {
    context.res = {
        status: 400,
        headers: { "Content-Type": "application/json" },
        body: "Product data must be present in request body and have the 'id' property set."
    }
    return;
}

// Return the product back to the caller and also send to CosmosDB via the out binding.
context.res = {
    status: 200,
    headers: { "Content-Type": "application/json" },
    body: { product: productToCreate }
};
```

To test the function, you will need to use a [cURL](https://superuser.com/questions/149329/what-is-the-curl-command-line-syntax-to-do-a-post-request) command or a tool like [PostMan](https://www.postman.com) which allows you to construct a POST request.
