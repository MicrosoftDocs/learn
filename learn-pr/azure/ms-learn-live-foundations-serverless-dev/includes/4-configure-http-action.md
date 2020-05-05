## 💻 Exercise - Configure the HTTP action a function reacts to

By default, any HTTP trigger function will respond to GET and POST requests. Depending on the functions use case we will want it to react to a single specific HTTP verb only.

## Objective

Change the HTTP action verb a function reacts to.

## Instructions

1. In Visual Studio Code, locate the folder `GetProduct` in the functions project and expand it
1. Open the file named `function.json`
1. Remove the verb `post` from the `methods` array.

The file's content should look like this:


```json
{
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": [
        "get"
      ],
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    }
  ],
  "scriptFile": "../dist/GetProduct/index.js"
}
```

Build and run the project and navigate to the URL shown in the output panel. You will be able to access it with your browser. You can use cURL or PostMan to try and access the same URL using a `post` action and it will fail.
