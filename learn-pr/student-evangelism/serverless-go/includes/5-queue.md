Message Queue is a software component used to handle messaging between processes, threads, or applications. A queue is able to store a message and _workers_ are able to fetch the message when it's a good time. In the Cloud, message queues can generate events with a payload and a service like Azure Functions can listen to such a message and run its code when a message is published.

## Work with Message Queues

For an Azure Function to be able to consume a message from a Message Queue, it needs a trigger:

- **A trigger**, the intended Azure Function needs to be set up in a such a way that it's listening to a specific queue so that its code is triggered when a new message is published on the queue.
- **Binding**. You don' strictly need a binding when consuming a message from a queue. However, if you want to write to a queue, you need an output binding. With such a binding, you get a reference to the intended queue and is able to write to it.

   > [!NOTE]
   > Currently only output bindings are supported for queues.

### Trigger

To set up a trigger, you need to provide the proper credentials so the trigger code knows how to connect to the message queue. What needs to happen is that an entry needs to be created in the _function.json_ file for the intended function listening to the queue. In the `bindings` element, you need an entry with a few properties specified, like so:

| Property   |Value  |
|------------|---------|
| name       | the value will be a name you can refer to in code |
| type       | queueTrigger |
| direction  | in |
| queueName  | What the queue is called
| connection | Points to a config variable in _local.settings.json_ |

An example entry can be defined like so:

```json
{
    "name": "myQueueItem",
    "type": "queueTrigger",
    "direction": "in",
    "queueName": "messages-incoming",
    "connection": "AzureWebJobsStorage"
  }
```

If this queue lives on a storage account, the `AzureWebJobsStorage` value would be the value of the connection string.

## Developing locally

As a developer, you want short feedback cycles and you also want to ensure that your developer experience is as close as possible to a production environment. A way to attain both these objectives is by using a Queue emulator. A queue emulator allows you to simulate real queue messages coming through that your Azure Function will be able to respond to.

To use the emulator there are two things you need to do:

1. **Install the emulator**. Search for the **Azurite** via Visual Studio Code or use this link, [download Azurite extension](https://marketplace.visualstudio.com/items?itemName=Azurite.azurite&azure-portal=true)
1. **Start emulator**. To use the emulator functionality, you start it via the command palette **Azure: Start Queue Service**. Running this command will start a listener that another application can pick up on called Microsoft Azure Storage Explorer.
1. **Get Azure Storage Explorer**. Azure Storage Explorer is a client application that lets you browse your cloud resources and using emulator functionality. To download it, use the following link [download Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/?azure-portal=true)
1. **Start Microsoft Azure Storage Explorer**. Once you've downloaded the program, start it and you will see the following as an indication that the emulator is working:

   ![Azure storage explorer, emulator](../media/azure-storage-explorer-emulator.png)

1. **Create queue**. Create a queue on the emulator. You will use this queue as part of configuring the function endpoint. By right clicking on the queue element, you can create a new queue.

1. **Configure emulator**. To ensure that your Function App uses the emulator, you need to set the connection string correctly.
   - Open _local.settings.json_, locate the **AzureWebJobsStorage** element and give it the value **"UseDevelopmentStorage=true"**

   > [!NOTE]
   > Remember to set this property differently as you move to the Cloud. It should point to an actual resource on Azure when in production.

## Build the function

At this point, you have a local emulator set up, it has a queue on it. You've also configured your project to point to the local emulator. Now you need to create a function to handle a queue trigger.

### Create a function endpoint

At this point, you are ready to create a function that's able to handle incoming queue messages. Create a folder for your function and name it, for example,  **queueTrigger** and create _function.json_ file. Give it the following content:

   ```json
   {
     "bindings": [{
       "name" "queueItem",
       "type": "queueTrigger",
       "direction": "in",
       "queueName" : "items",
       "connection": "AzureWebJobsStorage"
     }]
   }
   ```

   The value of the `name` element is important as you will refer to it later in your code to parse incoming data from the queue. It needs to be of type `queueTrigger` as well so it's triggered by the queue when there's a new message. The `queueName` element is important as it uniquely identifies which queue you are interacting with. Whatever you type here needs to match what you call the queue in the emulator or what you later call your actual queue in Azure. The `connection` element points to the value of the `AzureWebJobsStorage` element in _local.settings.json_.

## Handle queue message

To handle an incoming queue message, you need to write code that's able to parse out the message you need. At that point, you can decide what to do next. You could be starting a Web Request, put that message on another queue or send it to a database for example.

### Set up route

You need a route to handle the incoming request. Azure Function will handle requests to a queue at the root. So when you set up a route like so:

   ```go
   http.HandleFunc("/queueTrigger", handleQueueTrigger)
   ```

your request will be invoked like so: `http://localhost:<port>/queueTrigger`

### Decode request

When the queue message is sent to you, it has this shape:

```json
{
  "Data": {
    "queueItem": "your message"
  },
  "Metadata": {
    "DequeueCount": 1,
    "ExpirationTime": "2019-10-16T17:58:31+00:00",
    "Id": "800ae4b3-bdd2-4c08-badd-f08e5a34b865",
    "InsertionTime": "2019-10-09T17:58:31+00:00",
    "NextVisibleTime": "2019-10-09T18:08:32+00:00",
    "PopReceipt": "AgAAAAMAAAAAAAAAAgtnj8x+1QE=",
    "sys": {
      "MethodName": "QueueTrigger",
      "UtcNow": "2019-10-09T17:58:32.2205399Z",
      "RandGuid": "24ad4c06-24ad-4e5b-8294-3da9714877e9"
    }
  }
}
```

As part of decoding that incoming request, you need a helper struct that models the message above, looking like so:

```go
type InvokeRequest {
   Data map[string]json.RawMessage
   Metadata map[string]interface{}
}
```

So you start writing code to take that incoming request and decode it:

```go
func handleQueueTrigger(w http.ResponseWrite, r *http.Request) {
   var invokeRequest InvokeRequest
   d := json.NewDecoder(r.Body)
   d.Decode(&invokeRequest)
}
```

Great now you are at a point where the request has been decoded but you need to parse out the queue message itself next.

### Parse queue message

Once decoded, your queue message can be retrieved from the request on the `Data` property. You also need to refer to the message by the `name` property value you set up in the _function.json_ file. The code needed to retrieve the message would then be one-liner like so:

```go
invokeRequest.Data["queueItem"]
```

However, for you need to be able to read this message in clear text, you need to use a JSON library and parse it. The JSON library is going to use a method `Unmarshal()`, that takes two parameters, the message to be parsed and the variable to place the parsed message on. So your code needs to look like so:

```go
var parsedMessage string
json.Unmarshal(invokeRequest.Data["queueItem"], &parsedMessage)
```

At this point, `parsedMessage` contains your message and you can print it to the console if you want, like so:

```go
fmt.Println(parsedMessage) // your message
```

> [!NOTE]
> If your message is something more advanced than a string, then `parsedMessage` needs to have a struct that matches the shape of what `queueMessage` is pointing to.

## Trigger message

To test your application out, you can use Azure Storage Explorer.

On the right pane of the tool, there's a button that allows you to create a message on the queue.

![Add message on queue](../media/add-message.png)

If you have your function app and it's running at this point, it will trigger the binding and your code will be invoked.
