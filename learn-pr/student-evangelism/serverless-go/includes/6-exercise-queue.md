In this exercise, we are looking to extend our application with a route that can trigger on a message queue message.

> [!NOTE]
> You should have downloaded the following software before carying out this exercise [download Azurite extension](https://marketplace.visualstudio.com/items?itemName=Azurite.azurite&azure-portal=true) and [download Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/?azure-portal=true) and also the needed dependencies to work with Azure Functions, that is [download Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=macos%2Ccsharp%2Cbash#v2&azure-portal=true)

## Scaffold application

For this exercise, we will start on a new Function app. Create a new directory and place yourself in it. Activate the command palette:

1. In the Menu, select View > Command Palette
1. Select **Azure Functions: Create New Project**
1. Select folder, usually you want the folder you are standing in.
1. In select a language, select **Custom Handler**
1. In Select a template for your first function, select **HttpTrigger**
1. Give it a name, **queueTrigger**
1. Select authorization level, **anonymous**. You can change that later if you want.

1. At the root, create a file _server.go_. Your project should now have the following files:

   ```output
   queueTrigger/
     function.json
   .funcignore
   .gitignore
   host.json
   local.settings.json
   proxies.json
   server.go 
   ```

1. Navigate to the file _function.json_ under the `queueTrigger` directory and locate the element `type` and change the first binding entry from:

   ```json
   {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": [
        "get",
        "post"
      ]
    }
   ```

   to this configuration:

   ```json
   {
      "name": "queueItem",
      "type": "queueTrigger",
      "direction": "in",
      "queueName" : "items",
      "connection": "AzureWebJobsStorage"
   }
   ```

   What you've done is to set the `name` property, you will refer to that one later in code. You've also changed the trigger type to `queueTrigger`, which makes it possible to listen to queue messages. The `queueName` points out a specific queue. Later when you run the emulator, you need to create a queue with such a name. Finally you pointed out a variable in _local.settings.json_ that will need to contain the connection string to the queue.

## Build app

At this point, you have an app skeleton, and you are now ready to add code that can handle incoming queue messages.

1. Open the file _server.go_ and add the following code:

   ```go
   package main

   import (
     "encoding/json",
     "fmt"
     "io/ioutil"
     "log"
     "net/http"
     "os"
   )

   func queueHandler(w http.ResponseWriter, r *http.Request) {
   }

   func main() {
     customHandlerPort, exists := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT")
     if !exists {
       customHandlerPort = "8080"
     }
     mux := http.NewServeMux()
     mux.HandleFunc("/queueTrigger", queueHandler)
     fmt.Println("Go server Listening on: ", customHandlerPort)
     log.Fatal(http.ListenAndServe(":"+customHandlerPort, mux))
   }
   ```

   What you have now is a route setup at `/queueTrigger`. At this point, you need to implement the method `queueHandler()`.

   1. Locate the import section and right under it, add the following structs:

      ```go
      type InvokeRequest struct {
        Data     map[string]json.RawMessage
        Metadata map[string]interface{}
      }
      ```

   1. Now, locate the `queueHandler()` method and add update it in the following way:

      ```go
      func queueHandler(w http.ResponseWriter, r *http.Request) {
        var invokeRequest InvokeRequest

        d := json.NewDecoder(r.Body)
        d.Decode(&invokeRequest)

        var reqData map[string]interface{}
        json.Unmarshal(invokeRequest.Data["queueItem"], &reqData)
      }
      ```

     The code first reads the body from incoming response stream and decodes it like so:

     ```go
     var invokeRequest InvokeRequest

     d := json.NewDecoder(r.Body)
     d.Decode(&invokeRequest)
     ```

     Then the message itself is dug out, with call to `Unmarshal()`, like so:

     ```go
     var parsedMessage string
     json.Unmarshal(invokeRequest.Data["queueItem"], &parsedMessage)
     ```

     At this point, you have the message. Next, let's print it out.

1. Add the following code:

   ```go
   fmt.Println(parsedMessage) // your message
   ```

   At this point, your code is all written, but you need to configure your project so you can test it out.

1. In the _host.json_ file, locate the element `defaultExecutablePath` and give it the following value **./server**

   > [!NOTE]
   > for Windows you would give it the value **.\server.exe**. 

1. Build the _server.go_ file by running `go build` at the project root:

   ```bash
   go build server.go
   ```

## Configure environment

The next step is to configure your environment. Because you are developing locally, you need to set it up so that you can talk to an emulated message queue.

1. In the file _local.settings.json_, locate an element in `Values` called `AzureWebJobsStorage` (or add it if missing) and give it the value **UseDevelopmentStorage=true**, your JSON entry should look like so:

   ```json
   "AzureWebJobsStorage" : "UseDevelopmentStorage=true"
   ```

1. Next you need to start the Azurite extension. Start it by opening the command palette **View > Command palette** and select **Azurite: Start Queue Service**.

   > [NOTE!]
   > This will create some local files in your project

1. Next start the Azure Storage Explorer program. Once opened, on the left side it should look like so:

   ![Azure storage explorer, emulator](../media/azure-storage-explorer-emulator.png)

1. Right-click the Queues node and select to create a new queue, give it the name **items**.

   > [!NOTE]
   > You can name the queue what you want. However you are about to configure your _function.json_ file so whatever you name the queue here, it needs to go into _function.json_.

1. Locate _function.json_ under the `queueTrigger` directory. Ensure the `bindings` array has an entry like so:

    ```json
    {
       "name": "queueItem",
       "type": "queueTrigger",
       "direction": "in",
       "queueName" : "items",
       "connection": "AzureWebJobsStorage"
     }
    ```

    The `queueName` property has the same name as the queue you created in Azure Storage Explorer. Furthermore, the `connection` property points to the value you set up in _local.settings.json_. Finally, the `name` property has the value **queueItem**, this value is something your Go code is using to parse out the queue message.

## Run app

At this point, everything is set up. All you need to do is to run the app and start Azure Storage Explorer and create a queue message and your code should be able to consume said message.

1. In a terminal, from the project root, run the command `func start`:

   ```bash
   func start
   ```

1. In Visual Studio Code, open up the command palette and run **Azurite: Start Queue Service**.

1. Start Azure Storage Explorer, if it's not already started.
1. In Azure Storage Explorer select **Add Message**:

   ![Add message on queue](../media/create-message.png)

   You see a dialog, enter a value **a message** and select **Ok**, to create. You now see the following list:

   ![Message list](../media/create-message-list.png)

1. In Visual Studio Code, your function should now be executing. In the terminal, you should now see **a message** printed as the last row.

   Your function was able to consume the queue message and write out its content.

Congratulations. You were able to build an Azure Function in Go, that's able to trigger on a queue message. You were able to parse that message. It's now up to you what you want to do with an incoming message. You could store it in a database or maybe send it as the payload in a web request, you decide.
