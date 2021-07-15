In this exercise, we are looking to build and run a Serverless API using Go. 

## Scaffold the app

Begin by scaffolding the app using the Azure Functions extension in Visual Studio Code. Start by opening the command palate.

1. In the Menu, select **View > Command Palette**
1. Select **Azure Functions: Create New Project**
1. Select a folder, usually your current folder.
1. In select a language, select **Custom Handler**
1. In Select a template for your first function, select **HttpTrigger**
1. Give it a name, for example **hello**
1. Select authorization level, **anonymous**. You can change that later if you want.

Congrats, now you have a project looking something like this:

```output
hello/
  function.json
.funcignore
.gitignore
host.json
local.settings.json
proxies.json
```

## Create the app

Next step is about creating an app that will be able to respond to an HTTP trigger.

1. Create a file _server.go_ at the project root
1. Give _server.go_ the following content:

   ```go
   package main

   import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "os"
   )
   ```

   The above code imports all the libraries you need to be able to build an HTTP app but also look up environment variables

1. Add the following code after the import statements:

   ```go
   func main() {
     customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
     if !exists {
       customHandlerPort = "8080"
     }
     mux := http.NewServeMux()
     // mux.HandleFunc("/api/hello", helloHandler)
     fmt.Println("Go server Listening on: ", customHandlerPort)
     log.Fatal(http.ListenAndServe(":"+customHandlerPort, mux))
   }
   ```

   The `main()` function will be invoked by itself. The first line of the code states how it will read from the environment variable `FUNCTIONS_CUSTOM_HANDLER_PORT`:

   ```go
   customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
   ```

   Next, it checks whether the port exists, if not it's assigned the port 8080:

   ```go
   if !exists {
     customHandlerPort = "8080"
   }
   ```

   The code after that instantiates an HTTP server instance:

   ```go
   mux := http.NewServeMux()
   ```

   The last line of importance is the one that starts listening to a specific port and signals that it's ready to receive requests, with the method `ListenAndServe()`:

   ```go
   log.Fatal(http.ListenAndServe(":"+customHandlerPort, mux))
   ```
  
1. Finally let's add the remaining code. First localize the following line and uncomment it:

   ```go
   // mux.HandleFunc("/api/hello", helloHandler)
   ```

1. Between the import statements and the `main()` function, add the following code:

   ```go
   func helloHandler(w http.ResponseWriter, r *http.Request) {
     w.Header().Set("Content-Type", "application/json")
     if r.Method == "GET" {
       w.Write([]byte("hello world"))
     } else {
       body, _ := ioutil.ReadAll(r.Body)
       w.Write(body)
     }
   }
   ```

   What `helloHandler()` does is to set the content type to `application/json` and either respond with "hello world" or with the posted body, if any.

## Run the app

At this point you are done authoring the code, but you need to do some configuration for this scenario to work. You need to point out where your executable is but you also need to configure the routing and state that this app deals with HTTP triggers and no other types of bindings.

1. Run `go build server.go`, in a terminal and at the project root.

   ```go
   go build server.go
   ```

   Doing so will create an executable, that's either called `server` or `server.exe` if you are on a Windows OS, Next you need to point out the executable so the Function host is able to find it.

1. Open the _host.json_ file and locate the `defaultExecutablePath` element inside of the `customHandler` one. Specify **./server** on macOS and Linux and **.\server.exe** on a Windows OS.
1. Under the `customHandler` element, add the element `enableForwardingHttpRequest` and give it the value **true**. Your `customHandler` element should now look like so:

   ```json
   "customHandler": {
    "description": {
      "defaultExecutablePath": "./server",
      "workingDirectory": "",
      "arguments": []
    },
    "enableForwardingHttpRequest" : true
   }
   ```

1. Run `func start` from a terminal in the project root, doing so will start up your function app.

   ```go
   func start
   ```

   At the end of the output you will see an output similar to:

   ```output
   Functions:

        hello: [GET,POST] http://localhost:7071/api/hello
   ```

1. In a browser, navigate to `http://localhost:7071/api/hello`, you should see the output "hello world"

Congratulations, you've managed to develop a Serverless app in Go.
