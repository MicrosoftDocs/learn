To connect to a data source, you have to configure an *input binding*. This binding makes it possible to write minimal code to create a message. You don't have to write code for tasks such as opening a storage connection. The Azure Functions runtime and binding take care of those tasks for you.

## Input binding types

There are multiple types of input. However, not all types support both input and output. You'll use them whenever you want to ingest data of that type. Here, we'll look at the types that support input bindings and when to use them.

- **Blob storage** - Blob storage bindings allow you to read from a blob.

- **Azure Cosmos DB** - The Azure Cosmos DB input binding uses the SQL API to retrieve one or more Azure Cosmos DB documents and passes them to the input parameter of the function. The document ID or query parameters can be determined based on the trigger that invokes the function.

- **Mobile Apps** - The Mobile Apps input binding loads a record from a mobile table endpoint and passes it into your function.

- **Table storage** - You can read data and work with Azure Table storage.

A full listing of supported bindings is available: <a href="https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings?tabs=csharp#supported-bindings" data-linktype="external" target="az-portal">Here<span class="docon docon-navigate-external" aria-hidden="true"></span></a>

To create a binding as an input, you must define the `direction` as `in`. The parameters for each type of binding may vary.

## What is a binding expression?

A binding expression is specialized text in **function.json**, function parameters, or code that is evaluated when the function is invoked to yield a value. For example, if you have a Service Bus Queue binding, you could use a binding expression to get the name of the queue from App Settings.

### Types of binding expressions

- App settings
- Trigger file name
- Trigger metadata
- JSON payloads
- New GUID
- Current date and time

Most expressions are identified by wrapping them in curly braces. However, app setting binding expressions are wrapped in percent signs rather than curly braces. For example if the blob output binding path is `%Environment%/newblob.txt` and the Environment app setting value is Development, a blob will be created in the Development container.

## Summary

Input bindings allow you to connect your function to a data source. You can connect to several types of data sources, and the parameters for each vary. To resolve values from various sources, you can use binding expressions in the *function.json* file, function parameters, or code.
