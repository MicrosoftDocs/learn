
A **function** contains two important pieces - your code, which can be written in various languages, and some config, the *function.json* file. For compiled languages, this config file is generated automatically from annotations in your code. For scripting languages, you must provide the config file yourself.

The *function.json* file defines the function's trigger, bindings, and other configuration settings. Every function has one and only one trigger. The runtime uses this config file to determine the events to monitor and how to pass data into and return data from a function execution. Following is an example *function.json* file.

```json
{
    "disabled":false,
    "bindings":[
        // ... bindings here
        {
            "type": "bindingType",
            "direction": "in",
            "name": "myParamName",
            // ... more depending on binding
        }
    ]
}
```

The `bindings` property is where you configure both triggers and bindings. Each binding shares a few common settings and some settings that are specific to a particular type of binding. Every binding requires the following settings:

| Property | Types | Comments |
|--|--|--|
| `type` | string | Name of binding. For example, `queueTrigger`. |
| `direction` | string | Indicates whether the binding is for receiving data into the function or sending data from the function. For example, `in` or `out`. |
| `name` | string | The name that is used for the bound data in the function. For example, `myQueue`. |


## Function app

A function app provides an execution context in Azure in which your functions run. As such, it's the unit of deployment and management for your functions. A function app is composed of one or more individual functions that are managed, deployed, and scaled together. All of the functions in a function app share the same pricing plan, deployment method, and runtime version. Think of a function app as a way to organize and collectively manage your functions.

> [!NOTE]
> In Functions 2.x all functions in a function app must be authored in the same language. In previous versions of the Azure Functions runtime, this wasn't required.

## Folder structure

The code for all the functions in a specific function app is located in a root project folder that contains a host configuration file. The [host.json](/azure/azure-functions/functions-host-json) file contains runtime-specific configurations and is in the root folder of the function app. A *bin* folder contains packages and other library files that the function app requires. Specific folder structures required by the function app depend on language:

* [C# compiled (.csproj)](/azure/azure-functions/functions-dotnet-class-library#functions-class-library-project)
* [C# script (.csx)](/azure/azure-functions/functions-reference-csharp#folder-structure)
* [F# script](/azure/azure-functions/functions-reference-fsharp#folder-structure)
* [Java](/azure/azure-functions/functions-reference-java#folder-structure)
* [JavaScript](/azure/azure-functions/functions-reference-node#folder-structure)
* [Python](/azure/azure-functions/functions-reference-python#folder-structure)

## Local development environments

Functions make it easy to use your favorite code editor and development tools to create and test functions on your local computer. Your local functions can connect to live Azure services, and you can debug them on your local computer using the full Functions runtime.

The way in which you develop functions on your local computer depends on your language and tooling preferences. See [Code and test Azure Functions locally](/azure/azure-functions/functions-develop-local) for more information.

> [!WARNING]
> Do not mix local development with portal development in the same function app. When you create and publish functions from a local project, you should not try to maintain or modify project code in the portal.

