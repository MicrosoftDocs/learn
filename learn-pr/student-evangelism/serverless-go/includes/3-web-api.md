To use a custom handler you need to author a web application. Once you've written your application and compiled it, you need to configure the Functions host in a way so it knows how to use it, more on that later. But first, how you do you build a web application in Go?

## Build a REST API in Go

To build a REST API using Go, we need to know a few things namely:

- **Libraries to use**. You will use the libraries `fmt`, `log`, and `net/http`. These libraries will help you manage routes, handle incoming request and deal with logging. You import statement should look like so:

   ```go
   import (
     "fmt",
     "log",
     "net/http"
   )    
   ```

- **Set up routing**. REST APIs consist of logical divisions, or routes. Routes are specific addresses that respond to a specific concern in the app. To set up a route, call the `HandleFunc()` method on the `http` instance and define the route to respond to requests.

   ```go
   http.HandleFunc("/", handleRoute)   
   ```

   In this case, you need to create a function `handleRoute` to match incoming requests against route "/".

- **Manage request**. You need to manage incoming requests and read things like router or query params or a posted body. Then you need to construct a response. A function handling a request can look like so:

   ```go
   func handleRequest(w: http:ResponseWriter, r: http.Request) {
      fmt.Fprintf(w, "My first REST API") 
   }
   ```

   The code ends up sending the text "My first REST API" back to a calling client. The method `Fprintf()` takes two arguments, the response stream and the string to send back.

- **Create the server**. To be able to listen to requests, you need to start the server, and in doing so, you also need to specify a part that requests can be sent to. The following code shows how to create the server:

   ```go
   http.ListenAndServe(":3000", nil)
   ```

   The server is now up and can listen to requests on port 3000.  

## Create an Azure Functions app

To develop an Azure Functions app, there are some things it's recommended that you install:

- **Visual Studio Code**. [Install Visual Studio Code](https://code.visualstudio.com/download?azure-portal=true)

   You can author Azure Function apps with any text editor or IDE. There are some extensions that are showcased in this module that makes authoring and easier.  

- **Azure Function extension**. [Install VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions&azure-portal=true)

   This extension will help you to scaffold an Azure Function app but also help you run and debug it.

- **Azure Functions Core Tools**. [Install Core Tools](https://github.com/Azure/azure-functions-core-tools#installing?azure-portal=true).  

   This installs an executable `func` that lets you run your function app among other things.

### Scaffold a function app using Visual Studio Code

Once you have all the needed dependencies installed on your system, your next step is to scaffold an application. When asked about runtime choose **Custom Handler**.

Now you have ensured the correct files will be generated. When you generate a project this way, you need to select a trigger type for your first function. Custom handlers work with all the usual trigger and bindings you are used to.

Once you are done generating the project, you should have an app with the following files:

- A _host.json_
- A _local.setting.json_
- A _proxies.json_
- A  directory with a name corresponding to what you named your first function. In the mentioned directory, you will have a file _function.json_ that you use to configure your function.

### Configure the project

Your app needs to be able to work with HTTP primitives, but there are a few things you need to configure:

- **Listen to custom handler port**. There's a specific port your app needs to listen to. The variable `FUNCTIONS_CUSTOMHANDLER_PORT`, contains the value you need.  You can look up the port value, with the following code:

   ```go
   customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
   ```

- **Configure default executable path**. Because you are building an executable file, you need to tell your Function App project where' it's located. To do so, locate the _function.json_ file at the project root and in the `customHandler` section specify `defaultExecutablePath`. Here's an example of what it can look like:

   ```json
   "customHandler": {
     "defaultExecutablePath": "mygoapp.exe"
   }
   ```

- **Enable forwarding request**. When you are dealing with a function using an HTTP trigger, you want to configure the app slightly differently than if you are dealing with another type of trigger like a queue trigger for example. You want to enable a property called `enableForwardingHttpRequest`. When this property is enabled, it changes the behavior of how the request is handled in the following ways:

  - **Copy of original request**. The HTTP request does not contain the custom handlers request payload. Instead, the Functions host invokes the handler with a copy of the original HTTP request.
  - **Same path as original request**. The Functions host invokes the handler with the same path as the original request. It means that when you define a route and a route handler you need to be specific in how you set up the routing. Say you have the following project outline:
  
     ```outline
     hello/
      function.json   
     ```

     the above files will by default be mapped to a route `/api/hello`. In your code setting up the route you therefore need to specify the full route:

     ```go
     mux.HandleFunc("/api/hello", helloHandler)
     ```

     Had this setting not been enabled, for other types of triggers and bindings, it would have sufficed to specify the router code as `"/hello"`
  
  - **Host returns copy of handlers response**. The Functions host returns a copy of the handler's HTTP response as the response to the original request.

In the above example, the file `mygoapp.exe` is pointed out as the executable. In this example, it's assumed you have a file `mygoapp.go` that you create an executable from, but you can name your Go file anything you want. On Linux or macOS, the executable would not have a file ending.

### Build the app

Building the Web App at this point is not much different from building any Web App using Go. As long as you've done the configuration described in the former section, you are good to go. Now you need to take the following steps:

1. Read the PORT
1. Instantiate an HTTP Server instance
1. Define routes and route handlers
1. Start listening on a port

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
