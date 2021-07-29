In this exercise, you'll build and run a serverless app by using Go. 

## Scaffold the app

Begin by scaffolding the app, by using the Azure Functions extension in Visual Studio Code.

1. Select **View** > **Command Palette**.
1. Select **Azure Functions: Create New Project**.
1. Select a folder, usually your current folder.
1. In **Select a language**, select **Custom Handler**.
1. In **Select a template for your first function**, select **HttpTrigger**.
1. Give the app a name, such as **hello**.
1. Select an authorization level of **anonymous**. You can change that later if you want.

Now you have a project that looks something like this:

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

The next series of steps is about creating an app that can respond to an HTTP trigger.

1. Create a file named _server.go_ at the project root.
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

   The preceding code imports all the libraries that you need to build an HTTP app and to look up environment variables.

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

   The `main()` function is invoked by itself. The first line of the code states how it will read from the `FUNCTIONS_CUSTOM_HANDLER_PORT` environment variable:

   ```go
   customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
   ```

   Next, the function checks whether the port exists. If not, the function is assigned port 8080:

   ```go
   if !exists {
     customHandlerPort = "8080"
   }
   ```

   The next code instantiates an HTTP server instance:

   ```go
   mux := http.NewServeMux()
   ```

   The last line of importance is the one that starts listening to a specific port and signals that it's ready to receive requests, with the method `ListenAndServe()`:

   ```go
   log.Fatal(http.ListenAndServe(":"+customHandlerPort, mux))
   ```
  
1. Let's add the remaining code. First, localize the following line and uncomment it:

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

   The `helloHandler()` function sets the content type to `application/json`. It responds with either "hello world" or the posted body, if any.

## Run the app

You're done authoring the code at this point, but you need to do some configuration for this scenario to work. You need to point out where your executable file is, so the Function host can find it. You also need to configure the routing and state that this app deals with HTTP triggers and no other types of bindings.

1. From a terminal, run `go build server.go` in the project root:

   ```go
   go build server.go
   ```

   This step creates an executable file that's called *server* on macOS and Linux, or *server.exe* on a Windows OS.

1. Open the _host.json_ file and find the `defaultExecutablePath` element inside the `customHandler` one. Specify `./server` on macOS and Linux, or `.\server.exe` on a Windows OS.
1. Under the `customHandler` element, add the `enableForwardingHttpRequest` element and give it the value `true`. Your `customHandler` element should now look like this:

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

1. From a terminal, run `func start` in the project root. Doing so starts your Functions app.

   ```go
   func start
   ```

   At the end of the output, you'll see an output similar to:

   ```output
   Functions:

        hello: [GET,POST] http://localhost:7071/api/hello
   ```

1. In a browser, go to `http://localhost:7071/api/hello`. You should see the output "hello world."

Congratulations! You've developed a serverless app in Go.
