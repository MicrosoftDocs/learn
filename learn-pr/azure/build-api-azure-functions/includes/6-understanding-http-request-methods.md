When you load a web page in the browser, The browser makes what is called a "GET" request to the URL that you specify. The "GET" is a part of the HTTP request called the "HTTP request method". Every HTTP request is made with a method. Web browsers automatically set the request method to GET when a page is requested.

There are 9 types of HTTP request methods...

1. GET
1. HEAD
1. POST
1. PUT
1. DELETE
1. CONNECT
1. OPTIONS
1. TRACE
1. PATCH

These request methods are used differently depending on what sort of action you want the HTTP endpoint to perform. For instance, in the case of the "GetProducts" function, you are "getting" data. So it is appropriate to use the "GET" HTTP request method.

## Azure Functions and HTTP request methods

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

The `methods` property specifies with HTTP request methods this function will respond to.

## Testing other HTTP request method types with Postman

A GET request can be tested just by loading a URL in a browser. Other HTTP reqest method types require a tool that can issue requests of this type. Postman is a popular tool for composing and testing HTTP requests.

With Postman, you can change the HTTP request method type. You can also add values to the body of a request. You can then execute these requests and see the result. This tool is a crucial part of API development as it allows you to test each one of your endpoints and gives you complete control over the entire HTTP request.

In the next exercise, you'll use Postman to test the GetProducts function by issuing a POST request from Postman. You'll then modify which HTTP request methods the function will respond to, and see how that affects HTTP requests that are not using the allowed HTTP request methods.
