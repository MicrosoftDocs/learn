You can now add the remaining required API endpoints and implement them as far as possible. By the end of this exercise, you'll have a completed API surface that can be tested in the browser or with PostMan.

## Objectives

- Add functions to get all products and to update an existing product.
- Read input values where necessary using route parameters or body data.

## Instructions

To add the remaining endpoints for all our API functions:

1. Using the instructions you previously followed when you created your first local function, add two HTTP-triggered functions: `UpdateProduct` and `GetProducts`.

1. Change the `methods` property in function.json to `get` for `GetProducts` and to `put` for `UpdateProduct`.

1. Change the routes of `GetProducts` to *products* and for `UpdateProduct` to *product/{productId}*.

1. Let `GetProducts` return a hardcoded array of mock product data.

1. Implement `UpdateProduct` similar to `CreateProduct` by reading product data from the request body and returning the product back to the caller.

1. Create a variable called `productToCreate` and assign it the HTTP request object's `body` property.

1. For the `GetProduct` function, you returned hardcoded JSON data. For the `CreateProduct` function, use similar code, but return either `productToCreate` to the caller or an error if the request's body didn't contain valid data.

1. To test the function, you can use a [cURL](https://superuser.com/questions/149329/what-is-the-curl-command-line-syntax-to-do-a-post-request) command, or a tool like [PostMan](https://www.postman.com), which lets you construct a PUT request.
