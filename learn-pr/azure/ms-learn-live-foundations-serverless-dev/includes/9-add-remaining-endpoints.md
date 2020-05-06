## 💻 Exercise - Add the remaining endpoints for all of our API functions

You can now add the remaining required API endpoints and implement them as far as possible.
When done, there will be a completed API surface that can be tested in the browser or PostMan.

## Objective

- Add functions to get all products and to update an existing product
- Read input values where necessary using route parameters or body data

## Instructions

1. Using the instructions [you followed earlier when you created your first local function](3-create-function-endpoint.md), add two HTTP triggered functions named `UpdateProduct` and `GetProducts`.
1. Change the `methods` property in function.json to `get` for `GetProducts` and to `put` for `UpdateProduct`
1. Change the routes of `GetProducts` to "products" and for `UpdateProduct` to "product/{productId}"
1. Let `GetProducts` return a hardcoded array of mock product data
1. Implement `UpdateProduct` similar to `CreateProduct` by reading product data from the request body and returning the product back to the caller
1. Create a variable called `productToCreate` and assign it the HTTP request object's `body` property
1. For the `GetProduct` function you returned hardcoded JSON data. For the `CreateProduct` function, use similar code but return `productToCreate` back to the caller or an error if the request's body didn't contain valid data

To test the `UpdateProduct` function, you will need to use a [cURL](https://superuser.com/questions/149329/what-is-the-curl-command-line-syntax-to-do-a-post-request) command or a tool like [PostMan](https://www.postman.com) which allows you to construct a PUT request.
