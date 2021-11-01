To use a custom handler, you need to author a web application. After you've written your application and compiled it, you need to configure the Azure Functions host so it knows how to use it. We'll explore more about that later. First, how do you build a web application in Go?

## Build a REST API in Go

To build a REST API by using Go, you need to know a few things:

- **Import libraries**. You'll use the libraries `fmt`, `log`, and `net/http`. These libraries will help you manage routes, handle incoming requests, and deal with logging. Use the following import statement:

   ```go
   import (
     "fmt",
     "log",
     "net/http"
   )    
   ```

- **Set up routing**. REST APIs consist of logical divisions called *routes*. Routes are addresses that respond to a specific concern in the app. To set up a route, call the `HandleFunc()` method on the `http` instance and define the route to respond to requests:

   ```go
   http.HandleFunc("/", handleRoute)   
   ```

   In this case, you need to create a `handleRoute` function to match incoming requests against route `"/"`.

- **Manage requests**. You need to manage incoming requests and read things like router or query parameters or a posted body. Then you need to construct a response. A function that handles a request can look like this:

   ```go
   func handleRequest(w: http:ResponseWriter, r: http.Request) {
      fmt.Fprintf(w, "My first REST API") 
   }
   ```

   The code sends the text "My first REST API" back to a calling client. The method `Fprintf()` takes two arguments: the response stream and the string to send back.

- **Create the server**. To be able to listen to requests, you need to start the server. You also need to specify a part that requests can be sent to. The following code shows how to create the server:

   ```go
   http.ListenAndServe(":3000", nil)
   ```

   The server is now up and can listen to requests on port 3000.  

## Create an Azure Functions app

Before you develop an Azure Functions app, we recommend that you:

- [Install Visual Studio Code](https://code.visualstudio.com/download?azure-portal=true). You can author Azure Functions apps with any text editor or IDE. This module showcases some extensions that make authoring easier.  

- [Install the Visual Studio Code extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions&azure-portal=true). This extension will help you to scaffold a Functions app, run it, and debug it.

- [Install Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools#installing?azure-portal=true). This installation includes a `func` executable command that lets you run your Functions app, among other things.

### Scaffold a Functions app by using Visual Studio Code

After you have all the needed dependencies installed on your system, your next step is to scaffold an application. When you're asked about runtime, choose **Custom Handler**.

Now you've ensured that the correct files will be generated. When you generate a project this way, you need to select a trigger type for your first function. Custom handlers work with all the usual triggers and bindings.

After you finish generating the project, you should have an app with the following files:

- _host.json_
- _local.setting.json_
- _proxies.json_
- _function.json_ 

The _function.json_ file is in a directory whose name corresponds to what you named your first function. You'll use this file to configure your function.

### Configure the project

For your app to work with HTTP primitives, you need to configure a few things:

- **Listen to a custom handler port**. Your app needs to listen to a specific port. The variable `FUNCTIONS_CUSTOMHANDLER_PORT` contains the value that you need. You can look up the port value by using the following code:

   ```go
   customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
   ```

- **Configure the default executable path**. Because you're building an executable file, you need to tell your Functions app project where it's located. 

  Locate the _function.json_ file at the project root. In the `customHandler` section, specify `defaultExecutablePath`. Here's an example of what it can look like:

   ```json
   "customHandler": {
     "defaultExecutablePath": "mygoapp.exe"
   }
   ```

- **Enable request forwarding**. When you're dealing with a function that uses an HTTP trigger, you want to configure the app slightly differently than if you were dealing with another type of trigger (like a queue trigger). 

  Enable a property called `enableForwardingHttpRequest`. When this property is enabled, it changes the behavior of how the request is handled in the following ways:

  - **Copy of the original request**. The HTTP request does not contain the custom handler's request payload. Instead, the Functions host invokes the handler with a copy of the original HTTP request.
  - **Same path as the original request**. The Functions host invokes the handler with the same path as the original request. 
  
    When you define a route and a route handler, you need to be specific in how you set up the routing. Say you have the following project outline:
  
     ```outline
     hello/
      function.json   
     ```

     The files in the outline will be mapped to a route `/api/hello` by default. In your code for setting up the route, you need to specify the full route:

     ```go
     mux.HandleFunc("/api/hello", helloHandler)
     ```

     If you hadn't enabled this setting, for other types of triggers and bindings, specifying the router code as `"/hello"` would have been enough.
  
  - **Copy of the handler's response**. The Functions host returns a copy of the handler's HTTP response as the response to the original request.

In the preceding example, the executable file is `mygoapp.exe`. The example assumes that you're creating the executable file from a file called `mygoapp.go`, but you can name your Go file anything you want. On Linux or macOS, the executable file doesn't have an extension.

### Build the app

Building the web app at this point is not much different from building any web app by using Go. As long as you've done the configuration described in the previous section, you're all set. 

Now you need to take the following steps:

1. Read the port.
1. Instantiate an HTTP server instance.
1. Define routes and route handlers.
1. Start listening on the port.

```go
customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
if !exists {
   customHandlerPort = "8080"
} // 1)
mux := http.NewServeMux() // 2)
mux.HandleFunc("/order", orderHandler) // 3)
fmt.Println("Go server Listening on: ", customHandlerPort)
log.Fatal(http.ListenAndServe(":"+customHandlerPort, mux)) // 4)
```
